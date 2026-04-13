# Repository layout

This document describes how the **FYP Vista** project is organized. The goal is a clear separation between **data**, **runnable entry points**, **documentation**, and **generated artifacts**.

## Top-level directories

| Path | Purpose |
|------|---------|
| `data/` | Training and preprocessing inputs: `VERT.json`, `VERT.jsonl`. Version these or use Git LFS if files are large. |
| `scripts/` | All Python programs you run directly (fine-tuning, inference, utilities). |
| `docs/` | Design and layout notes (this file). |
| `benchmark/` | Space for evaluation or benchmark assets (optional; some paths may be gitignored). |
| `vista_env/` | Local virtual environment (gitignored). Created at repo root next to `scripts/`. |
| `outputs/` | Fine-tuned adapters and checkpoints (gitignored). Default: `outputs/finetuned-assertions/`. |

Root files: `README.md`, `requirements.txt`, `.gitignore`, `setup_github.sh`.

## Pipeline (unchanged flow)

1. **Optional data prep** — `scripts/script.py` reads `data/VERT.json` and writes validated lines to `data/VERT.jsonl`.
2. **Training** — `scripts/finetune_assertions.py` loads `data/*.jsonl` (path you pass with `--data`), fine-tunes with Unsloth/LoRA, writes under `outputs/`.
3. **Inference** — `scripts/test_inference.py` resolves the latest checkpoint under `outputs/finetuned-assertions/`, loads the base model + adapter, runs the interactive CLI.

## Entry points

| Script | Role |
|--------|------|
| `scripts/finetune_assertions.py` | LoRA fine-tuning on JSONL pairs (RTL + assertion metadata). |
| `scripts/test_inference.py` | Interactive assertion generation from the trained adapter. |
| `scripts/test_unsloth.py` | Minimal Unsloth + model load smoke test. |
| `scripts/script.py` | JSON → JSONL line filter for `VERT` data. |

## Path resolution

- **`finetune_assertions.py`** changes the process working directory to the **repository root** on startup so relative paths like `outputs/finetuned-assertions` and `--data data/VERT.jsonl` behave the same no matter where you invoke the script from.
- **`test_inference.py`** resolves `vista_env` and `outputs/finetuned-assertions` relative to the **repository root** (parent of `scripts/`), not relative to the script file’s folder.
- **`script.py`** reads and writes under **`data/`** using paths derived from the repository root.

## Conventions

- Run commands from the repository root unless a script documents otherwise.
- Keep checkpoints only under `outputs/`; do not commit them.
- Add new runnable tools under `scripts/`; add static inputs under `data/`; add long-form documentation under `docs/`.
