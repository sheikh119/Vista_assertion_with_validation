# VISTA Web

Website for the VISTA assertion-generation pipeline.

```
web/
├── backend/        FastAPI service wrapping scripts/evaluate_accuracy_sby.py
│   ├── app.py
│   ├── requirements.txt
│   └── README.md
└── frontend/       Next.js 14 app (TypeScript + Tailwind + Monaco)
    ├── app/
    │   ├── page.tsx            Landing
    │   ├── playground/         Main playground
    │   └── about/              How it works
    ├── components/             UI building blocks
    ├── lib/                    API client, utils, examples
    └── package.json
```

## Run it locally

### 1. Backend (Python, reuses existing vista_env)

```bash
# From repo root
source vista_env/bin/activate
source formal_verification/source_formal_tools.sh   # makes yosys/sby available
pip install -r web/backend/requirements.txt

python web/backend/app.py
# Listens on http://localhost:8000
# First startup loads the fine-tuned LLaMA 3.1 adapter (~30s)
```

Skip model loading during pure-UI development:

```bash
VISTA_SKIP_MODEL_LOAD=1 python web/backend/app.py
```

### 2. Frontend (Next.js)

```bash
cd web/frontend
npm install
cp .env.local.example .env.local
npm run dev
# => http://localhost:3000
```

The frontend proxies every `/api/*` request to the backend via
`next.config.mjs`, so there are no CORS headaches in development.

## Flow

1. User writes / loads an RTL fragment in Monaco and picks clock / sync.
2. Frontend POSTs `{code, synchronous, clock, run_formal}` to `/api/generate`.
3. Backend:
   - Repairs missing semicolons in the RTL.
   - Formats the prompt using the same template the model was trained on.
   - Runs LLaMA 3.1 inference (greedy, 512 max new tokens).
   - Extracts property blocks → converts to immediate assertions → sanitizes.
   - Greedy-filters assertions through Yosys.
   - Builds a wrapper module with signal inference, clock-aware `always`
     blocks, and signal initialization.
   - Optionally runs SymbiYosys BMC (depth 8) for formal verification.
4. Frontend shows assertions, raw model output, the full wrapper `.sv`, and
   the SymbiYosys log — plus latency and status chips.

## Screens

- **Home** — hero, headline metrics (99% / 0.991 / 89% / <25 s), pipeline diagram.
- **Playground** — editor, clock/sync controls, live results panel with tabs.
- **About** — short methodology write-up matching the paper.
