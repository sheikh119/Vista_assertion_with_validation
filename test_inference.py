#!/usr/bin/env python3
"""
Test inference script for fine-tuned assertion model.
Make sure to activate the virtual environment before running:
    source vista_env/bin/activate
Or run with: vista_env/bin/python3 test_inference.py
"""

import sys
import os

# Check if we're in the virtual environment or add it to path
venv_python = os.path.join(os.path.dirname(__file__), 'vista_env', 'bin', 'python3')
if os.path.exists(venv_python) and sys.executable != venv_python:
    # Try to import from virtual environment
    venv_site_packages = os.path.join(os.path.dirname(__file__), 'vista_env', 'lib', 'python3.10', 'site-packages')
    if os.path.exists(venv_site_packages):
        sys.path.insert(0, venv_site_packages)

try:
    from unsloth import FastLanguageModel
except ImportError:
    print("❌ Error: 'unsloth' module not found!")
    print("\nPlease activate the virtual environment first:")
    print("    source vista_env/bin/activate")
    print("\nOr run the script with:")
    print("    vista_env/bin/python3 test_inference.py")
    sys.exit(1)

import torch, re, json

# --- GPU memory safe config ---
torch.cuda.empty_cache()
torch.backends.cuda.matmul.allow_tf32 = True  # optimize matrix multiplications
os.environ["PYTORCH_CUDA_ALLOC_CONF"] = "max_split_size_mb:512"

# --- Automatically find the latest checkpoint ---
base_model_dir = "outputs/finetuned-assertions"
checkpoints = [
    os.path.join(base_model_dir, d)
    for d in os.listdir(base_model_dir)
    if d.startswith("checkpoint")
]
latest_checkpoint = max(checkpoints, key=os.path.getmtime) if checkpoints else base_model_dir
print(f"🧩 Loading adapter from: {latest_checkpoint}")

# --- Read base model name from adapter config ---
adapter_config_path = os.path.join(latest_checkpoint, "adapter_config.json")
if not os.path.exists(adapter_config_path):
    adapter_config_path = os.path.join(base_model_dir, "adapter_config.json")

if os.path.exists(adapter_config_path):
    with open(adapter_config_path, 'r') as f:
        adapter_config = json.load(f)
    base_model_name = adapter_config.get("base_model_name_or_path", "unsloth/llama-3.1-8b-bnb-4bit")
else:
    base_model_name = "unsloth/llama-3.1-8b-bnb-4bit"  # fallback

print(f"📦 Base model: {base_model_name}")

# --- Load model with adapter in 4-bit for lower GPU memory usage ---
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name=base_model_name,
    max_seq_length=2048,
    dtype=torch.float16,
    load_in_4bit=True,       # keeps memory usage low
)

# --- Load the LoRA adapter ---
# Try using Unsloth's method first, fallback to PEFT if needed
try:
    # Unsloth may have a built-in method to load adapters
    from peft import PeftModel
    # Filter out unknown config fields that might cause issues
    import shutil
    # Known valid LoraConfig fields (based on PEFT 0.12.0 - verified from LoraConfig.__init__)
    valid_fields = {
        'peft_type', 'auto_mapping', 'base_model_name_or_path', 'revision', 
        'task_type', 'inference_mode', 'r', 'target_modules', 'lora_alpha', 
        'lora_dropout', 'fan_in_fan_out', 'bias', 'use_rslora', 
        'modules_to_save', 'init_lora_weights', 'layers_to_transform', 
        'layers_pattern', 'rank_pattern', 'alpha_pattern', 'megatron_config', 
        'megatron_core', 'loftq_config', 'use_dora', 'layer_replication', 
        'runtime_config'
    }
    
    temp_config = os.path.join(latest_checkpoint, "adapter_config_temp.json")
    if os.path.exists(os.path.join(latest_checkpoint, "adapter_config.json")):
        with open(os.path.join(latest_checkpoint, "adapter_config.json"), 'r') as f:
            config = json.load(f)
        # Remove fields that are not recognized by current PEFT version
        filtered_config = {k: v for k, v in config.items() if k in valid_fields}
        with open(temp_config, 'w') as f:
            json.dump(filtered_config, f)
        # Temporarily replace the config
        backup_config = os.path.join(latest_checkpoint, "adapter_config.json.bak")
        shutil.copy(os.path.join(latest_checkpoint, "adapter_config.json"), backup_config)
        shutil.copy(temp_config, os.path.join(latest_checkpoint, "adapter_config.json"))
    
    model = PeftModel.from_pretrained(model, latest_checkpoint)
    
    # Restore original config
    if os.path.exists(backup_config):
        shutil.move(backup_config, os.path.join(latest_checkpoint, "adapter_config.json"))
    if os.path.exists(temp_config):
        os.remove(temp_config)
    
    print(f"✅ Loaded LoRA adapter from: {latest_checkpoint}")
except Exception as e:
    print(f"⚠️ Error loading adapter with PEFT: {e}")
    print("Trying alternative method...")
    # Alternative: try loading adapter weights directly
    try:
        model.load_adapter(latest_checkpoint)
        print(f"✅ Loaded LoRA adapter using load_adapter method")
    except Exception as e2:
        print(f"❌ Failed to load adapter: {e2}")
        raise

FastLanguageModel.for_inference(model)
print("\n✅ Model loaded successfully.\n")

def clean_output(text):
    """Remove weird Unicode and ensure printable characters only."""
    text = text.encode("utf-8", "ignore").decode("utf-8", "ignore")
    text = re.sub(r"[^\x09\x0A\x0D\x20-\x7E]", "", text)
    text = re.sub(r" +", " ", text)
    return text.strip()

# --- Continuous CLI Loop ---
while True:
    try:
        code = input("📝 Enter Verilog code (or 'exit' to quit): ").strip()
        if code.lower() in ["exit", "quit"]:
            print("👋 Exiting inference mode.")
            break

        synchronous = input("⏱️ Enter Synchronous (True/False): ").strip()
        clock = input("🕒 Enter Clock signal name (or leave empty if none): ").strip() or "None"

        # --- Prompt for model ---
        prompt = f"""You are a hardware verification expert.
Generate a SystemVerilog assertion based on the following information:
Code:
{code}
Synchronous: {synchronous}
Clock: {clock}
Assertion:
"""

        inputs = tokenizer(prompt, return_tensors="pt").to("cuda")

        with torch.no_grad():
            outputs = model.generate(**inputs, max_new_tokens=300)

        decoded = tokenizer.decode(outputs[0], skip_special_tokens=True)
        cleaned = clean_output(decoded)

        print("\n🧠 Model Output:\n")
        print(cleaned)
        print("\n" + "-" * 100 + "\n")

        # --- Free GPU memory after each generation ---
        torch.cuda.empty_cache()

    except RuntimeError as e:
        print(f"⚠️ RuntimeError: {e}")
        torch.cuda.empty_cache()  # free memory if something goes wrong

