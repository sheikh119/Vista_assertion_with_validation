#!/usr/bin/env python3
"""
Test inference script for fine-tuned assertion model.

With a trained LoRA under outputs/finetuned-assertions/:
    source vista_env/bin/activate
    vista_env/bin/python3 scripts/test_inference.py

Without checkpoints (base model only, for env/GPU smoke test):
    vista_env/bin/python3 scripts/test_inference.py --base-only
"""

import sys
import os
import re
import glob
import argparse
import subprocess
import warnings

_PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))


def _nvidia_loaded_vs_installed_version():
    """If /proc shows a different driver than modinfo on disk, kernel needs a reboot."""
    loaded = None
    try:
        with open("/proc/driver/nvidia/version", encoding="utf-8", errors="ignore") as f:
            m = re.search(r"Kernel Module for x86_64\s+([0-9.]+)", f.read())
            if m:
                loaded = m.group(1)
    except OSError:
        pass
    installed = None
    try:
        installed = subprocess.check_output(
            ["modinfo", "-F", "version", "nvidia"],
            stderr=subprocess.DEVNULL,
            text=True,
            timeout=5,
        ).strip()
    except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
        pass
    return loaded, installed

# Check if we're in the virtual environment or add it to path
venv_python = os.path.join(_PROJECT_ROOT, "vista_env", "bin", "python3")
if os.path.exists(venv_python) and sys.executable != venv_python:
    # Try to import from virtual environment
    _venv_sp = glob.glob(
        os.path.join(_PROJECT_ROOT, "vista_env", "lib", "python*", "site-packages")
    )
    venv_site_packages = _venv_sp[0] if _venv_sp else ""
    if venv_site_packages and os.path.exists(venv_site_packages):
        sys.path.insert(0, venv_site_packages)

warnings.filterwarnings(
    "ignore",
    message=r".*CUDA initialization.*",
    category=UserWarning,
    module=r"torch\.cuda",
)
import torch

# Unsloth imports unsloth_zoo, which aborts if no CUDA device is visible. Check GPU
# before importing Unsloth so we can print a clear fix instead of a stack trace.
if not torch.cuda.is_available():
    print("❌ PyTorch does not see a working NVIDIA GPU (CUDA).")
    loaded, installed = _nvidia_loaded_vs_installed_version()
    if loaded and installed and loaded != installed:
        print()
        print("   Your system upgraded the NVIDIA driver on disk, but the kernel is still")
        print(f"   running the old module in RAM (loaded {loaded} vs installed {installed}).")
        print("   That causes 'Driver/library version mismatch' and breaks CUDA.")
        print("   This is not a Python bug — the kernel must load the new nvidia module.")
        print()
        print("   Do this (pick one):")
        print("   1) sudo reboot")
        print("   2) Full power cycle: sudo systemctl poweroff — wait 10s — turn on")
        print("      (needed if hybrid sleep / fast resume kept the old module.)")
        print("   3) See all options:  bash scripts/reload_nvidia_kernel_modules.sh")
        print("   4) Still stuck after cold boot:")
        print("      sudo apt update && sudo apt install --reinstall \\")
        print("        nvidia-dkms-580-open nvidia-driver-580-open && sudo reboot")
        print()
        print("   When `nvidia-smi` works, run this script again.")
    else:
        print("   Unsloth inference needs CUDA. Common causes on Pop!_OS / Linux:")
        print("   • Driver/kernel mismatch after an update — reboot the machine.")
        print("   • nvidia-smi errors — fix or reinstall NVIDIA / system76-driver packages.")
        print("   • Laptop on integrated graphics only — use a machine with an NVIDIA GPU.")
        print("\n   After `nvidia-smi` works with no errors, run this script again.")
    sys.exit(1)

_argp = argparse.ArgumentParser(description="Interactive SystemVerilog assertion inference")
_argp.add_argument(
    "--base-only",
    action="store_true",
    help="Load only the base model (no LoRA). Use when outputs/finetuned-assertions/ does not exist yet.",
)
_argp.add_argument(
    "--model",
    type=str,
    default="unsloth/llama-3.1-8b-bnb-4bit",
    help="Base model id (used with --base-only or as fallback if no adapter_config.json).",
)
_cli_args = _argp.parse_args()

try:
    from unsloth import FastLanguageModel
except ImportError as e:
    print(f"❌ Failed to import Unsloth: {e}")
    print("\nUsually this is a venv or version mismatch (unsloth vs unsloth_zoo).")
    print("From the project root, with vista_env active:")
    print("    pip install -r requirements.txt")
    print("    # or:")
    print("    pip install --upgrade --no-cache-dir --no-deps unsloth unsloth_zoo")
    print("\nAlso ensure you use this venv's Python:")
    print("    vista_env/bin/python3 scripts/test_inference.py")
    sys.exit(1)

import json

# --- GPU memory safe config ---
torch.cuda.empty_cache()
torch.backends.cuda.matmul.allow_tf32 = True  # optimize matrix multiplications
os.environ["PYTORCH_CUDA_ALLOC_CONF"] = "max_split_size_mb:512"

# --- Resolve checkpoint / base model ---
base_model_dir = os.path.join(_PROJECT_ROOT, "outputs", "finetuned-assertions")
latest_checkpoint = None
base_model_name = _cli_args.model

if _cli_args.base_only:
    print("🔧 Mode: --base-only (no LoRA checkpoint)")
    print(f"📦 Base model: {base_model_name}")
else:
    if not os.path.isdir(base_model_dir):
        print(f"❌ No adapter directory: {base_model_dir}")
        print("   Train first (scripts/finetune_assertions.py) or copy your LoRA checkpoint")
        print("   into outputs/finetuned-assertions/")
        print()
        print("   Or smoke-test the base model without fine-tuning:")
        print("   vista_env/bin/python3 scripts/test_inference.py --base-only")
        sys.exit(1)

    checkpoints = [
        os.path.join(base_model_dir, d)
        for d in os.listdir(base_model_dir)
        if d.startswith("checkpoint")
    ]
    latest_checkpoint = max(checkpoints, key=os.path.getmtime) if checkpoints else base_model_dir
    print(f"🧩 Loading adapter from: {latest_checkpoint}")

    adapter_config_path = os.path.join(latest_checkpoint, "adapter_config.json")
    if not os.path.exists(adapter_config_path):
        adapter_config_path = os.path.join(base_model_dir, "adapter_config.json")

    if os.path.exists(adapter_config_path):
        with open(adapter_config_path, "r", encoding="utf-8") as f:
            adapter_config = json.load(f)
        base_model_name = adapter_config.get("base_model_name_or_path", _cli_args.model)

    print(f"📦 Base model: {base_model_name}")

# --- Load model in 4-bit ---
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name=base_model_name,
    max_seq_length=2048,
    dtype=torch.float16,
    load_in_4bit=True,
)

# --- Load LoRA (skip in --base-only) ---
if not _cli_args.base_only:
    from peft import PeftModel
    import shutil

    valid_fields = {
        "peft_type", "auto_mapping", "base_model_name_or_path", "revision",
        "task_type", "inference_mode", "r", "target_modules", "lora_alpha",
        "lora_dropout", "fan_in_fan_out", "bias", "use_rslora",
        "modules_to_save", "init_lora_weights", "layers_to_transform",
        "layers_pattern", "rank_pattern", "alpha_pattern", "megatron_config",
        "megatron_core", "loftq_config", "use_dora", "layer_replication",
        "runtime_config",
    }

    backup_config = None
    temp_config = os.path.join(latest_checkpoint, "adapter_config_temp.json")
    try:
        if os.path.exists(os.path.join(latest_checkpoint, "adapter_config.json")):
            with open(os.path.join(latest_checkpoint, "adapter_config.json"), "r", encoding="utf-8") as f:
                config = json.load(f)
            filtered_config = {k: v for k, v in config.items() if k in valid_fields}
            with open(temp_config, "w", encoding="utf-8") as f:
                json.dump(filtered_config, f)
            backup_config = os.path.join(latest_checkpoint, "adapter_config.json.bak")
            shutil.copy(os.path.join(latest_checkpoint, "adapter_config.json"), backup_config)
            shutil.copy(temp_config, os.path.join(latest_checkpoint, "adapter_config.json"))

        model = PeftModel.from_pretrained(model, latest_checkpoint)

        if backup_config and os.path.exists(backup_config):
            shutil.move(backup_config, os.path.join(latest_checkpoint, "adapter_config.json"))
        if os.path.exists(temp_config):
            os.remove(temp_config)

        print(f"✅ Loaded LoRA adapter from: {latest_checkpoint}")
    except Exception as e:
        if backup_config and os.path.exists(backup_config):
            shutil.move(backup_config, os.path.join(latest_checkpoint, "adapter_config.json"))
        if os.path.exists(temp_config):
            os.remove(temp_config)
        print(f"⚠️ Error loading adapter with PEFT: {e}")
        print("Trying alternative method...")
        try:
            model.load_adapter(latest_checkpoint)
            print("✅ Loaded LoRA adapter using load_adapter method")
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

