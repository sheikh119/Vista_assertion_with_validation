# finetune_assertions.py
import argparse
import os
import random
import torch
from datasets import load_dataset
from unsloth import FastLanguageModel, UnslothTrainer
from unsloth.trainer import UnslothTrainingArguments

# -----------------------------
# Parse arguments
# -----------------------------
parser = argparse.ArgumentParser()
parser.add_argument("--model", type=str, required=True)
parser.add_argument("--data", type=str, required=True)
parser.add_argument("--output_dir", type=str, default="outputs/finetuned-assertions")
parser.add_argument("--epochs", type=int, default=3)
parser.add_argument("--batch_size", type=int, default=1)
parser.add_argument("--grad_accum", type=int, default=4)
parser.add_argument("--save_steps", type=int, default=500)
parser.add_argument("--max_seq", type=int, default=2048)
parser.add_argument("--val_split", type=float, default=0.05)
parser.add_argument("--seed", type=int, default=42)
parser.add_argument("--resume_from", type=str, default=None)
parser.add_argument("--lora_r", type=int, default=8)
parser.add_argument("--lora_alpha", type=int, default=16)
parser.add_argument("--lora_dropout", type=float, default=0.05)
args = parser.parse_args()

# reproducibility and dirs
random.seed(args.seed)
torch.manual_seed(args.seed)
os.makedirs(args.output_dir, exist_ok=True)

print("🚀 Starting fine-tuning with config:")
for k, v in vars(args).items():
    print(f"  {k}: {v}")
print()

# -----------------------------
# Load dataset
# -----------------------------
print(f"📂 Loading dataset from: {args.data}")
dataset = load_dataset("json", data_files=args.data, split="train")

# split
split = dataset.train_test_split(test_size=args.val_split, seed=args.seed)
train_ds = split["train"]
eval_ds = split["test"]
print(f"✅ Dataset loaded. Train size: {len(train_ds)}, Eval size: {len(eval_ds)}")

# format examples into single text field
def format_example(ex):
    code = ex.get("Code", "") or ""
    assertion = ex.get("Assertion", "") or ""
    sync = ex.get("Synchronous", "") or "False"
    clk = ex.get("Clock", None)
    clk_txt = str(clk) if clk is not None else "None"
    prompt = (
        "You are a hardware verification assistant. Given the RTL code and the synchronous/clock info, "
        "produce the formal assertion(s) that verify the behaviour.\n\n"
        f"Synchronous: {sync}\n"
        f"Clock: {clk_txt}\n\n"
        "Code:\n"
        f"{code}\n\n"
        "OUTPUT (Assertions):"
    )
    return {"text": f"### Instruction:\n{prompt}\n\n### Response:\n{assertion}"}

print("Mapping dataset to training format...")
train_ds = train_ds.map(format_example, remove_columns=train_ds.column_names)
eval_ds = eval_ds.map(format_example, remove_columns=eval_ds.column_names)

# -----------------------------
# Load quantized model + tokenizer via Unsloth
# -----------------------------
print(f"\n🧠 Loading model: {args.model} (may take a minute)...")
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name=args.model,
    load_in_4bit=True,
    use_gradient_checkpointing=True,
    max_seq_length=args.max_seq,
)

# If model is quantized, skip explicit .to()
is_bnb4 = getattr(model, "is_loaded_in_4bit", False)
if is_bnb4:
    print("Model loaded in 4-bit (bitsandbytes). Skipping .to(device).")
else:
    device = "cuda" if torch.cuda.is_available() else "cpu"
    model.to(device)
    print(f"Moved model to {device}.")

# -----------------------------
# Attach LoRA adapter using Unsloth helper (raw args)
# -----------------------------
print("🔧 Attaching LoRA adapters (Unsloth helper)...")
model = FastLanguageModel.get_peft_model(
    model,
    r=int(args.lora_r),
    lora_alpha=int(args.lora_alpha),
    lora_dropout=float(args.lora_dropout),
    bias="none",
    target_modules=["q_proj", "k_proj", "v_proj", "o_proj", "gate_proj", "up_proj", "down_proj"],
)
print("✅ LoRA adapters attached.")

# -----------------------------
# Tokenize (batched) and set labels
# -----------------------------
print("✏️ Tokenizing dataset (batched)...")
def tokenize_batch(batch):
    out = tokenizer(batch["text"], truncation=True, max_length=args.max_seq, padding="max_length")
    out["labels"] = out["input_ids"].copy()
    return out

train_ds = train_ds.map(tokenize_batch, batched=True, remove_columns=["text"])
eval_ds = eval_ds.map(tokenize_batch, batched=True, remove_columns=["text"])

# -----------------------------
# Auto-detect precision flags
# -----------------------------
fp16_flag = False
bf16_flag = False
try:
    first_param = next(model.parameters())
    if first_param.dtype == torch.bfloat16:
        bf16_flag = True
    elif first_param.dtype == torch.float16:
        fp16_flag = True
    else:
        if torch.cuda.is_available():
            fp16_flag = True
except Exception:
    if torch.cuda.is_available():
        fp16_flag = True

print(f"Precision flags -> fp16: {fp16_flag}, bf16: {bf16_flag}")

# -----------------------------
# Unsloth training args
# -----------------------------
training_args = UnslothTrainingArguments(
    output_dir=args.output_dir,
    per_device_train_batch_size=args.batch_size,
    gradient_accumulation_steps=args.grad_accum,
    num_train_epochs=args.epochs,
    save_steps=args.save_steps,
    logging_steps=50,
    learning_rate=2e-4,
    lr_scheduler_type="cosine",
    fp16=fp16_flag,
    bf16=bf16_flag,
    seed=args.seed,
    save_total_limit=3,
    push_to_hub=False,
)

# -----------------------------
# Trainer
# -----------------------------
trainer = UnslothTrainer(
    model=model,
    tokenizer=tokenizer,
    train_dataset=train_ds,
    eval_dataset=eval_ds,
    args=training_args,
)

# -----------------------------
# Train (with interrupt handling)
# -----------------------------
try:
    trainer.train(resume_from_checkpoint=args.resume_from)
except KeyboardInterrupt:
    print("KeyboardInterrupt caught — saving adapter checkpoint...")
    ckpt_dir = os.path.join(args.output_dir, "checkpoint-interrupt")
    os.makedirs(ckpt_dir, exist_ok=True)
    try:
        model.save_pretrained(ckpt_dir)
        tokenizer.save_pretrained(ckpt_dir)
        print("Saved interrupt checkpoint to:", ckpt_dir)
    except Exception as e:
        print("Failed to save interrupt checkpoint:", e)
    raise

# -----------------------------
# Final save
# -----------------------------
print("Saving final adapter + tokenizer to", args.output_dir)
model.save_pretrained(args.output_dir)
tokenizer.save_pretrained(args.output_dir)
print("✅ Fine-tuning finished. Adapter saved at:", args.output_dir)

