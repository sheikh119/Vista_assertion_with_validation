# VISTA Backend (FastAPI)

Thin HTTP layer on top of the production pipeline in
`scripts/evaluate_accuracy_sby.py`. The same model, prompt template,
post-processing, wrapper generator, and SymbiYosys integration are reused
so the website gives identical results to the paper.

## Endpoints

| Method | Path             | Description                                   |
|--------|------------------|-----------------------------------------------|
| GET    | `/api/health`    | Returns readiness, adapter path, tool status. |
| POST   | `/api/generate`  | RTL → assertions (+ optional formal check).   |

## Start

Requires the project's `vista_env` (with unsloth / torch / peft already
installed) **and** the OSS CAD Suite sourced (for `yosys` / `sby`).

```bash
# from repo root
source vista_env/bin/activate
source formal_verification/source_formal_tools.sh
pip install -r web/backend/requirements.txt

# launch (model loads once at startup, ~30s on RTX 4090)
python web/backend/app.py
# => http://localhost:8000
```

## Request example

```bash
curl -X POST http://localhost:8000/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "code": "if (a && b) begin\n  out <= a + b;\nend",
    "synchronous": true,
    "clock": "posedge clk",
    "run_formal": true
  }'
```

## Env flags

- `VISTA_SKIP_MODEL_LOAD=1` — skip model loading (UI-only dev).
- `HF_HUB_OFFLINE=1` / `TRANSFORMERS_OFFLINE=1` — set by default.
