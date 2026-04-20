"""
VISTA FastAPI backend.

Exposes a single endpoint that takes an RTL snippet + clock/sync metadata
and returns:
  - raw LLM output
  - cleaned / converted immediate assertions
  - generated SystemVerilog wrapper
  - optional SymbiYosys formal verification result

The backend reuses the existing production pipeline from
scripts/evaluate_accuracy_sby.py so the website matches the paper exactly.
"""

from __future__ import annotations

import os
import subprocess
import sys
import time
from contextlib import asynccontextmanager
from pathlib import Path
from typing import Literal

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

# ---------------------------------------------------------------------------
# Make the project root importable so we can reuse the existing pipeline code.
# ---------------------------------------------------------------------------
ROOT = Path(__file__).resolve().parent.parent.parent  # fyp_draft/
sys.path.insert(0, str(ROOT / "scripts"))

# Force offline HF so we never hang on network.
os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("TRANSFORMERS_OFFLINE", "1")

import re  # noqa: E402

import evaluate_accuracy_sby as pipe  # type: ignore  # noqa: E402


# ---------------------------------------------------------------------------
# Helpers for exposing the RAW assertions that the model produced
# ---------------------------------------------------------------------------
def extract_model_assertions(raw: str) -> list[str]:
    """
    Pull the native SVA property blocks written by the model out of the full
    raw output (prompt + response). Returns each property block as a
    readable, single-line string like:
        property AuthCheckeotid;
          ( auth_6 && data_1 ) |=> sig_17 == data_10 && hw_13 == reg_9 ;
        endproperty
    Handles three styles the model is known to emit:
      1) property <name>; <body> ; endproperty
      2) property <name>: <body> ; endproperty
      3) property <name>; <body> ;          (no endproperty, line-terminated)
    """
    region = pipe.extract_assertion_region(raw)
    if not region:
        return []

    out: list[str] = []

    # Style 1+2: explicit endproperty terminator.
    for m in re.finditer(
        r"property\s+([A-Za-z_][A-Za-z0-9_]*)\s*([;:])(.*?)endproperty",
        region,
        flags=re.S | re.I,
    ):
        name, _sep, body = m.group(1), m.group(2), m.group(3)
        body = _tidy_body(body)
        if body:
            out.append(f"property {name};\n  {body};\nendproperty")

    # Style 3 fallback: no endproperty at all.
    if not out:
        for m in re.finditer(
            r"property\s+([A-Za-z_][A-Za-z0-9_]*)\s*[;:]\s*(.+?);"
            r"(?=\s*(?:property\s+[A-Za-z_]|\Z))",
            region,
            flags=re.S | re.I,
        ):
            name, body = m.group(1), m.group(2)
            body = _tidy_body(body)
            if body:
                out.append(f"property {name};\n  {body};\nendproperty")

    # De-duplicate while keeping insertion order.
    seen: set[str] = set()
    unique: list[str] = []
    for p in out:
        if p not in seen:
            seen.add(p)
            unique.append(p)
    return unique


def _tidy_body(body: str) -> str:
    """Collapse whitespace and strip trailing separators from a property body."""
    s = re.sub(r"\s+", " ", body).strip()
    s = s.rstrip(";").rstrip(",").strip()
    return s

# ---------------------------------------------------------------------------
# Globals populated at startup.
# ---------------------------------------------------------------------------
_state: dict = {
    "model": None,
    "tokenizer": None,
    "prompt_template": None,
    "adapter_dir": None,
    "ready": False,
}


def _find_base_model_snapshot() -> Path:
    """
    Locate the local snapshot directory of the unsloth base model.
    Mirrors the hardcoded path used in scripts/evaluate_accuracy_sby.py but
    auto-detects the snapshot hash so the backend keeps working if HF re-syncs.
    """
    hub_root = Path.home() / ".cache" / "huggingface" / "hub"
    model_root = hub_root / "models--unsloth--llama-3.1-8b-bnb-4bit"
    snap_root = model_root / "snapshots"
    if not snap_root.is_dir():
        raise RuntimeError(
            f"Base model snapshot directory not found under {snap_root}. "
            "Run the evaluation script at least once so the model is cached, "
            "or set VISTA_BASE_MODEL_PATH to a valid path."
        )
    snaps = sorted((p for p in snap_root.iterdir() if p.is_dir()),
                   key=lambda p: p.stat().st_mtime, reverse=True)
    if not snaps:
        raise RuntimeError(f"No snapshots found in {snap_root}")
    return snaps[0]


def _load_model_once() -> None:
    """Load the fine-tuned LLaMA 3.1 + QLoRA adapter one time at startup."""
    import torch
    from unsloth import FastLanguageModel
    from peft import PeftModel

    adapter_dir = pipe.resolve_adapter_dir(ROOT)
    if not adapter_dir.is_dir():
        raise RuntimeError(f"Adapter directory not found: {adapter_dir}")

    # Environment override takes precedence, else auto-detect.
    override = os.environ.get("VISTA_BASE_MODEL_PATH")
    base_path = Path(override) if override else _find_base_model_snapshot()

    print(f"[vista-api] Base model: {base_path}", flush=True)
    print(f"[vista-api] Adapter:    {adapter_dir}", flush=True)

    # Use the EXACT same loading params as scripts/evaluate_accuracy_sby.py
    # so behaviour matches the paper numbers.
    model, tokenizer = FastLanguageModel.from_pretrained(
        model_name=str(base_path),
        max_seq_length=2048,
        dtype=torch.float16,
        load_in_4bit=True,
    )
    model = PeftModel.from_pretrained(model, str(adapter_dir))
    FastLanguageModel.for_inference(model)

    template = pipe.load_prompt_template(ROOT, None)

    _state.update(
        model=model,
        tokenizer=tokenizer,
        prompt_template=template,
        adapter_dir=str(adapter_dir),
        ready=True,
    )
    print("[vista-api] Model ready.", flush=True)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Lazy-load only if not disabled (useful for UI dev without GPU).
    if os.environ.get("VISTA_SKIP_MODEL_LOAD") == "1":
        print("[vista-api] VISTA_SKIP_MODEL_LOAD=1 → model will NOT be loaded.", flush=True)
    else:
        try:
            _load_model_once()
        except Exception as exc:  # noqa: BLE001
            print(f"[vista-api] Model load failed: {exc}", flush=True)
    yield


app = FastAPI(
    title="VISTA API",
    version="1.0.0",
    description="LLM-driven SystemVerilog Assertion generation + formal validation.",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # tighten for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ---------------------------------------------------------------------------
# Schemas
# ---------------------------------------------------------------------------
class GenerateRequest(BaseModel):
    code: str = Field(..., description="RTL fragment or complete module")
    synchronous: bool = Field(True, description="True for clocked designs")
    clock: str | None = Field(None, description="Clock spec, e.g. 'posedge clk' or null")
    max_new_tokens: int = Field(512, ge=64, le=1024)
    run_formal: bool = Field(True, description="Run SymbiYosys verification")
    depth: int = Field(8, ge=1, le=32, description="BMC depth")


class AssertionVerdict(BaseModel):
    assertion: str
    syntax_ok: bool


class GenerateResponse(BaseModel):
    raw_output: str
    model_assertions: list[str] = Field(
        default_factory=list,
        description="Native SVA property blocks as the model produced them.",
    )
    pre_greedy_assertions: list[str]
    final_assertions: list[str]
    greedy_dropped: int
    wrapper_sv: str
    syntax_ok: bool
    formal_status: Literal["pass", "fail", "error", "timeout", "skipped", "not_run"]
    formal_log_tail: str
    latency_ms: int
    adapter_dir: str
    # Rich diagnostics so the UI can show users exactly what happened.
    is_fallback: bool = Field(
        False,
        description="True when final assertions are the trivial fallback only.",
    )
    fallback_reason: str | None = Field(
        None,
        description="Human-readable reason for the fallback, if any.",
    )
    pipeline_stage: Literal[
        "ok",
        "no_assertions_extracted",
        "all_dropped_by_filter",
        "syntax_check_failed",
        "formal_disabled",
    ] = "ok"


class HealthResponse(BaseModel):
    ready: bool
    adapter_dir: str | None
    has_yosys: bool
    has_sby: bool


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def _binary_exists(name: str) -> bool:
    from shutil import which

    return which(name) is not None


def _run_yosys_syntax(wrapper_sv: str, workdir: Path) -> bool:
    return pipe.yosys_wrapper_ok(wrapper_sv, workdir)


def _run_sby(workdir: Path, wrapper_sv: str, depth: int) -> tuple[str, str]:
    """Run SymbiYosys BMC on the wrapper. Returns (status, log_tail)."""
    if not _binary_exists("sby"):
        return "skipped", "sby binary not available on PATH"

    workdir.mkdir(parents=True, exist_ok=True)
    (workdir / "vert_formal_wrap.sv").write_text(wrapper_sv, encoding="utf-8")
    (workdir / "run.sby").write_text(
        "[options]\n"
        f"mode bmc\ndepth {depth}\n\n"
        "[engines]\n"
        "smtbmc\n\n"
        "[script]\n"
        "read_verilog -formal -sv vert_formal_wrap.sv\n"
        "prep -top vert_formal_wrap\n\n"
        "[files]\n"
        "vert_formal_wrap.sv\n",
        encoding="utf-8",
    )
    try:
        proc = subprocess.run(
            ["sby", "-f", "run.sby"],
            cwd=workdir,
            capture_output=True,
            text=True,
            timeout=90,
        )
        log = (proc.stdout or "") + (proc.stderr or "")
        tail = "\n".join(log.strip().splitlines()[-25:])
        if "DONE (PASS" in log or "DONE (PASS)" in log:
            return "pass", tail
        if "DONE (FAIL" in log:
            return "fail", tail
        if proc.returncode == 0:
            return "pass", tail
        return "error", tail
    except subprocess.TimeoutExpired:
        return "timeout", "sby timed out after 90s"
    except Exception as exc:  # noqa: BLE001
        return "error", f"sby invocation failed: {exc}"


def _generate_with_model(prompt: str, max_new_tokens: int) -> str:
    import torch

    model = _state["model"]
    tokenizer = _state["tokenizer"]
    if model is None or tokenizer is None:
        raise HTTPException(503, "Model not loaded")

    device = "cuda" if torch.cuda.is_available() else "cpu"
    inputs = tokenizer(prompt, return_tensors="pt").to(device)
    with torch.inference_mode():
        out = model.generate(
            **inputs,
            max_new_tokens=max_new_tokens,
            do_sample=False,
            use_cache=True,
            pad_token_id=tokenizer.eos_token_id,
        )
    text = tokenizer.decode(out[0], skip_special_tokens=True)
    return text


# ---------------------------------------------------------------------------
# Routes
# ---------------------------------------------------------------------------
@app.get("/api/health", response_model=HealthResponse)
async def health() -> HealthResponse:
    return HealthResponse(
        ready=_state["ready"],
        adapter_dir=_state["adapter_dir"],
        has_yosys=_binary_exists("yosys"),
        has_sby=_binary_exists("sby"),
    )


@app.post("/api/generate", response_model=GenerateResponse)
async def generate(req: GenerateRequest) -> GenerateResponse:
    if not _state["ready"]:
        raise HTTPException(503, "Model not loaded. Start the backend on a GPU host.")

    t0 = time.time()
    code = pipe.repair_rtl_semicolons(req.code)

    prompt = pipe.format_inference_prompt(
        _state["prompt_template"],
        code=code,
        synchronous=str(req.synchronous),
        clock=req.clock,
    )

    raw = _generate_with_model(prompt, req.max_new_tokens)

    # Extract the SVA property blocks exactly as the model produced them.
    model_assertions = extract_model_assertions(raw)

    # Post-processing: convert those SVA blocks into Yosys-compatible immediate
    # assertions used by the wrapper.
    assert_lines, _attempted = pipe.model_output_to_immediate_asserts(raw)
    pre_greedy = list(assert_lines)

    # Greedy syntax filter using a temp dir.
    workdir = Path("/tmp") / f"vista_{int(time.time()*1000)}"
    workdir.mkdir(parents=True, exist_ok=True)
    filtered, dropped = pipe.greedy_filter_asserts(
        code,
        assert_lines,
        req.synchronous,
        req.clock,
        init_rst_zero=True,
        assume_no_reset=True,
        workdir=workdir,
    )

    wrapper_sv = pipe.build_wrapper(
        code,
        filtered,
        req.synchronous,
        req.clock,
        init_rst_zero=True,
        assume_no_reset=True,
    )

    syntax_ok = _run_yosys_syntax(wrapper_sv, workdir) if _binary_exists("yosys") else True

    # --- Diagnose the pipeline stage & fallback reason ------------------------
    # "Fallback" means the model failed to produce any usable SVA.
    is_fallback = (
        len(model_assertions) == 0
        and len(filtered) == 1
        and filtered[0].strip() == "assert (1'b1);"
    )

    fallback_reason: str | None = None
    pipeline_stage: str = "ok"
    if is_fallback:
        if len(pre_greedy) == 0:
            pipeline_stage = "no_assertions_extracted"
            fallback_reason = (
                "The model did not produce any extractable SVA property. "
                "This typically happens when the RTL signal-name style differs "
                "from the VERT training distribution (e.g. unfamiliar names). "
                "Check the 'Model Output' tab to see exactly what the model returned."
            )
        elif dropped > 0 and not filtered:
            pipeline_stage = "all_dropped_by_filter"
            fallback_reason = (
                f"The model produced {len(pre_greedy)} candidate assertion(s) but "
                f"the greedy Yosys syntax filter dropped all of them."
            )
        else:
            pipeline_stage = "no_assertions_extracted"
            fallback_reason = (
                "No real assertions were retained after post-processing. "
                "See the 'Model Output' tab for the raw LLM response."
            )

    # --- Run formal check (clear messages per failure mode) -------------------
    if not req.run_formal:
        formal_status = "not_run"
        log_tail = "Formal verification was disabled by the user."
        if pipeline_stage == "ok":
            pipeline_stage = "formal_disabled"
    elif not syntax_ok:
        formal_status = "error"
        log_tail = (
            "Yosys rejected the generated wrapper during the syntax probe, "
            "so SymbiYosys was not invoked. Inspect the 'Wrapper (.sv)' tab "
            "for the exact module that failed to parse."
        )
        pipeline_stage = "syntax_check_failed"
    elif is_fallback:
        # Nothing to prove — running SBY on `assert(1'b1)` is meaningless.
        formal_status = "skipped"
        log_tail = (
            "Skipping SymbiYosys: the only remaining assertion is the trivial "
            "fallback `assert (1'b1);`, which would always pass and carries no "
            "verification value. See the diagnostic above for why this occurred."
        )
    else:
        formal_status, log_tail = _run_sby(workdir, wrapper_sv, req.depth)

    latency_ms = int((time.time() - t0) * 1000)

    return GenerateResponse(
        raw_output=raw,
        model_assertions=model_assertions,
        pre_greedy_assertions=pre_greedy,
        final_assertions=filtered,
        greedy_dropped=dropped,
        wrapper_sv=wrapper_sv,
        syntax_ok=syntax_ok,
        formal_status=formal_status,  # type: ignore[arg-type]
        formal_log_tail=log_tail,
        latency_ms=latency_ms,
        adapter_dir=_state["adapter_dir"] or "",
        is_fallback=is_fallback,
        fallback_reason=fallback_reason,
        pipeline_stage=pipeline_stage,  # type: ignore[arg-type]
    )


@app.get("/")
async def root() -> dict:
    return {
        "service": "vista-api",
        "endpoints": ["/api/health", "/api/generate"],
        "ready": _state["ready"],
    }


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=False)
