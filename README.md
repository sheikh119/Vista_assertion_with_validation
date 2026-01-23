# FYP Vista - Hardware Verification Assertion Generation

Fine-tuning language models for automated SystemVerilog assertion generation from RTL code.

## Overview

This project fine-tunes large language models (LLMs) to generate formal hardware verification assertions from RTL (Register Transfer Level) code. The model takes Verilog code, synchronous/clock information, and generates appropriate SystemVerilog assertions.

## Features

- Fine-tuning using Unsloth for efficient LoRA-based training
- Support for 4-bit quantization to reduce memory usage
- Interactive inference script for testing generated assertions
- Automatic checkpoint management

## Project Structure

```
.
├── finetune_assertions.py    # Main fine-tuning script
├── test_inference.py         # Interactive inference/testing script
├── requirements.txt          # Python dependencies
├── VERT.jsonl               # Training dataset
└── outputs/                  # Fine-tuned model checkpoints (gitignored)
```

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

Fine-tune the model on your dataset:

```bash
python3 finetune_assertions.py \
    --model unsloth/llama-3.1-8b-bnb-4bit \
    --data VERT.jsonl \
    --output_dir outputs/finetuned-assertions \
    --epochs 3 \
    --batch_size 1 \
    --grad_accum 4 \
    --max_seq 2048
```

### Inference

Test the fine-tuned model interactively:

```bash
python3 test_inference.py
```

Or use the virtual environment's Python directly:

```bash
vista_env/bin/python3 test_inference.py
```

The script will:
- Automatically find the latest checkpoint
- Load the base model and LoRA adapter
- Enter an interactive loop for testing assertions

## Model Details

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

