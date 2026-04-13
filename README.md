# FYP Vista - Hardware Verification Assertion Generation

Published as **[Vista_assertion_with_validation](https://github.com/sheikh119/Vista_assertion_with_validation)** on GitHub.

Fine-tuning language models for automated SystemVerilog assertion generation from RTL code.

## Overview

This project fine-tunes large language models (LLMs) to generate formal hardware verification assertions from RTL (Register Transfer Level) code. The model takes Verilog code, synchronous/clock information, and generates appropriate SystemVerilog assertions.

## Features

- Fine-tuning using Unsloth for efficient LoRA-based training
- Support for 4-bit quantization to reduce memory usage
- Interactive inference script for testing generated assertions
- Automatic checkpoint management

## Project structure

```
.
├── data/                     # Dataset files (VERT.json, VERT.jsonl)
├── scripts/                  # Runnable Python entry points
│   ├── finetune_assertions.py
│   ├── test_inference.py
│   ├── test_unsloth.py
│   └── script.py             # Optional: VERT.json → VERT.jsonl filter
├── docs/
│   └── ARCHITECTURE.md       # Layout and pipeline notes
├── formal_verification/      # SymbiYosys templates, OSS CAD helpers, example runs
├── benchmark/                  # Benchmark / evaluation assets (optional)
├── requirements.txt
├── setup_github.sh
├── vista_env/                # Virtual environment (gitignored)
└── outputs/                  # Fine-tuned checkpoints (gitignored)
```

For a fuller description of folders and path behavior, see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/Fyp_Vista.git
   cd Fyp_Vista
   ```

2. **Create and activate virtual environment:**
   ```bash
   python3 -m venv vista_env
   source vista_env/bin/activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

## Usage

### Fine-tuning

Fine-tune the model on your dataset (run from the repository root):

```bash
python3 scripts/finetune_assertions.py \
    --model unsloth/llama-3.1-8b-bnb-4bit \
    --data data/VERT.jsonl \
    --output_dir outputs/finetuned-assertions
```

Defaults follow the VERT paper: LoRA **r=α=256**, **max_seq=4096**, **3 epochs**, **learning rate 1e-4**, **effective batch 64** via **`--batch_size 2` × `--grad_accum 32`** (fits ~24 GB VRAM with seq 4096; literal micro-batch 64 would OOM). **BF16** when supported; **LoRA dropout 0** for Unsloth’s fast path. If you still hit **OOM**, try `--batch_size 1 --grad_accum 64` or lower `--max_seq`.

### Inference

Test the fine-tuned model interactively:

```bash
python3 scripts/test_inference.py
```

Or use the virtual environment's Python directly:

```bash
vista_env/bin/python3 scripts/test_inference.py
```

The script will:
- Automatically find the latest checkpoint under `outputs/finetuned-assertions/`
- Load the base model and LoRA adapter
- Enter an interactive loop for testing assertions

If you have not trained yet (no `outputs/` checkpoints), smoke-test GPU + Unsloth with the base model only:

```bash
vista_env/bin/python3 scripts/test_inference.py --base-only
```

Optional: `vista_env/bin/python3 scripts/test_inference.py --base-only --model unsloth/llama-3.1-8b-bnb-4bit`

## Model details

- **Base Model:** `unsloth/llama-3.1-8b-bnb-4bit`
- **Fine-tuning Method:** LoRA (Low-Rank Adaptation)
- **Quantization:** 4-bit (bitsandbytes)
- **Training Framework:** Unsloth

## Requirements

- Python 3.10+
- CUDA-capable GPU (recommended)
- See `requirements.txt` for full dependency list

## License

[Add your license here]

## Author

[Your name/contact information]
