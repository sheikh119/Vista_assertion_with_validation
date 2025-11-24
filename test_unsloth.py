from unsloth import FastLanguageModel

# Load a small model just to verify Unsloth + GPU
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name = "unsloth/mistral-7b",  # or try meta-llama/Llama-3-8B if Olama 3.1 isn't hosted yet
    load_in_4bit = True,
)

print("✅ Model loaded successfully!")

# Test a short prompt
response = FastLanguageModel.prompt(model, tokenizer, "Hello! How are you today?")
print("Model response:", response)
