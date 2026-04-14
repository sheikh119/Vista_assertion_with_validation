#!/usr/bin/env python3
import argparse
import json
import re
import shutil
import subprocess
import time
from pathlib import Path

import torch
import unsloth  # noqa: F401 — load before transformers/peft per Unsloth
from peft import PeftModel
from unsloth import FastLanguageModel

_DEFAULT_PROMPT_REL = Path("formal_verification/templates/assertion_prompt_template_v2.txt")

# Tokens mistaken for signals when parsing sloppy model output
_VERILOG_KW = frozenset(
    """
    module endmodule input output inout wire logic reg assign always always_ff always_comb
    begin end if else case endcase default for while do repeat forever
    generate endgenerate assert assume cover
    property endproperty sequence endsequence posedge negedge disable iff
    parameter localparam integer genvar typedef struct enum fork join
    string real time signed unsigned
    initial final specify endspecify table endtable
    function endfunction task endtask return void
    class endclass interface endinterface virtual static automatic
    bit byte shortint longint int chandle
    null true false
    supply0 supply1 pullup pulldown buf not and or nand nor xor xnor
    import export package endpackage
    break continue wait force release
    """.split()
)
_ENGLISH_STOP = frozenset(
    """
    the and for not with each only from that this when then else must use all any can one two
    output inputs lines line per your only use same follow strictly tooling cannot parse full
    after information following based expert verification hardware generating generate
    """.split()
)


def resolve_adapter_dir(root: Path) -> Path:
    base = root / "outputs" / "finetuned-assertions"
    if not base.is_dir():
        return base
    checkpoints = [p for p in base.iterdir() if p.is_dir() and p.name.startswith("checkpoint")]
    if checkpoints:
        return max(checkpoints, key=lambda p: p.stat().st_mtime)
    return base


def load_prompt_template(root: Path, template_path: Path | None) -> str:
    path = template_path if template_path else root / _DEFAULT_PROMPT_REL
    if not path.is_file():
        raise SystemExit(f"Prompt template not found: {path}")
    return path.read_text(encoding="utf-8")


def format_inference_prompt(template: str, code: str, synchronous, clock) -> str:
    clk = clock if clock is not None else "None"
    return template.format(code=code, synchronous=synchronous, clock=clk)


def parse_clock_spec(clock) -> tuple[str, str]:
    """VERT Clock may be null, a net name, or 'posedge foo' / 'negedge bar'."""
    if clock is None or str(clock).strip() in ("", "None"):
        return "posedge", "clk"
    s = str(clock).strip()
    edge = "posedge"
    if re.search(r"\bnegedge\b", s, re.I):
        edge = "negedge"
    elif re.search(r"\bposedge\b", s, re.I):
        edge = "posedge"
    toks = [
        t
        for t in re.findall(r"[A-Za-z_][A-Za-z0-9_]*", s)
        if t.lower() not in ("posedge", "negedge")
    ]
    if not toks:
        return "posedge", "clk"
    return edge, toks[-1]


def load_rows(path: Path, limit: int) -> list[dict]:
    rows = []
    with path.open("r", encoding="utf-8", errors="ignore") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                rows.append(json.loads(line))
            except json.JSONDecodeError:
                continue
            if len(rows) >= limit:
                break
    return rows


def extract_assertion_region(text: str) -> str:
    # Training format uses "### Response:" as the boundary
    if "### Response:" in text:
        text = text.split("### Response:")[-1]
    elif "OUTPUT (Assertions):" in text:
        text = text.split("OUTPUT (Assertions):")[-1]
    elif "Assertion:" in text:
        text = text.split("Assertion:", 1)[1]
    return text.strip()


def sanitize_assert_expression(expr: str) -> str:
    """Make expressions more likely to parse under Yosys read_verilog -formal."""
    e = expr.strip()
    e = re.sub(r"##\s*\d+\s*", "", e)
    e = e.replace("===", "==").replace("!==", "!=")
    e = re.sub(r"@\s*\(\s*(?:posedge|negedge)\s+\w+\s*\)", "", e, flags=re.I)
    e = re.sub(r"\$(?:past|rose|fell|stable|changed)\s*\([^)]*\)", "1'b1", e, flags=re.I)
    e = re.sub(r"\bdisable\s+iff\s*\([^)]*\)", "", e, flags=re.I)
    e = re.sub(r"\s+", " ", e).strip()
    return e


def is_rejected_placeholder_expr(inner: str) -> bool:
    """Drop template leakage and non-Verilog placeholders that break Yosys."""
    s = inner.strip()
    if not s:
        return True
    low = s.lower()
    if "..." in s:
        return True
    if "<boolean" in low or "boolean expression" in low:
        return True
    if re.match(r"^<[^>]+>$", s.strip()):
        return True
    if re.search(r"<[A-Za-z_][A-Za-z0-9_]*>", s):
        return True
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", s) and s.lower() in (
        "expr",
        "expression",
        "boolean",
        "condition",
        "true",
        "false",
    ):
        return True
    # Remaining $system calls that weren't sanitized
    if re.search(r"\$[a-zA-Z_][a-zA-Z0-9_]*", s):
        return True
    # Pure English sentences (more than 3 consecutive words with no operators)
    words = re.findall(r"[A-Za-z]{3,}", s)
    operators = re.findall(r"[=!<>&|^~+\-*/]", s)
    if len(words) > 4 and not operators:
        return True
    return False


def extract_inner_from_assert_statement(stmt: str) -> str | None:
    """Given a full `assert ( ... );` string, return the inner expression."""
    m = re.search(r"\bassert\s*\(", stmt, re.I)
    if not m:
        return None
    i = m.end()  # first char after '('
    depth = 1
    j = i
    while j < len(stmt) and depth:
        if stmt[j] == "(":
            depth += 1
        elif stmt[j] == ")":
            depth -= 1
        j += 1
    if depth != 0:
        return None
    return stmt[i : j - 1]


def extract_balanced_asserts(region: str) -> list[str]:
    """Pull assert ( ... ); with parenthesis matching (handles nested parens)."""
    out: list[str] = []
    i = 0
    region = region.strip()
    while i < len(region):
        m = re.search(r"\bassert\s*\(", region[i:], re.I)
        if not m:
            break
        start = i + m.start()
        # opening '(' position
        open_paren = i + m.end() - 1
        depth = 0
        k = open_paren
        while k < len(region):
            ch = region[k]
            if ch == "(":
                depth += 1
            elif ch == ")":
                depth -= 1
                if depth == 0:
                    k += 1
                    while k < len(region) and region[k] in " \t\r\n":
                        k += 1
                    if k < len(region) and region[k] == ";":
                        stmt = region[start : k + 1].strip()
                        out.append(stmt)
                        i = k + 1
                        break
                    i = start + 1
                    break
            k += 1
        else:
            break
    return out


def infer_widths_from_rtl(code: str) -> dict[str, str]:
    """Map identifier -> [msb:lsb] when explicit declarations exist in snippet."""
    widths: dict[str, str] = {}
    for m in re.finditer(
        r"\b(?:wire|logic|reg|input|output)\s+\[(\d+)\s*:\s*(\d+)\]\s+(\w+)",
        code,
        flags=re.I,
    ):
        hi, lo, name = int(m.group(1)), int(m.group(2)), m.group(3)
        widths[name] = f"[{hi}:{lo}]"
    return widths


def normalize_ws(s: str) -> str:
    return " ".join(s.replace("\n", " ").replace("\r", " ").split())


def repair_rtl_semicolons(code: str) -> str:
    """Add missing semicolons to assignment lines in RTL snippets.

    The VERT dataset sometimes omits trailing semicolons on assignment statements
    inside case/if blocks, which Yosys rejects.
    """
    lines = code.split("\n")
    repaired = []
    assign_re = re.compile(
        r"^\s+\w+\s*(?:<=|=)\s*\S.*$"
    )
    for ln in lines:
        stripped = ln.rstrip()
        if assign_re.match(stripped) and not stripped.rstrip().endswith((";", "begin", "end")):
            repaired.append(stripped + ";")
        else:
            repaired.append(stripped)
    return "\n".join(repaired)


def convert_property_to_immediate(body: str) -> str | None:
    body = normalize_ws(body).rstrip(";")
    body = re.sub(r"\bdisable\s+iff\s*\([^)]+\)", "", body, flags=re.I).strip()
    body = re.sub(r"@\s*\(\s*(?:posedge|negedge)\s+\w+\s*\)", "", body, flags=re.I).strip()
    if not body:
        return None

    # Approximate temporal implications into combinational implication.
    # A |-> B  or A |=> B   => (!A) || B
    m = re.match(r"^(.*?)(\|->|\|=>)(.*)$", body)
    if m:
        lhs = m.group(1).strip()
        rhs = m.group(3).strip()
        rhs = re.sub(r"##\s*\d+\s*", "", rhs)
        if lhs and rhs:
            return f"(!({lhs})) || ({rhs})"
        return None

    # If no temporal op, use body as-is when it looks boolean.
    if any(op in body for op in ("==", "!=", "<", ">", "&&", "||", "!", "&", "|", "^")):
        return body
    # Also accept plain identifiers or simple expressions as tautology-like checks
    if re.fullmatch(r"[A-Za-z_]\w*(\s*[&|^~+\-*/]\s*[A-Za-z_]\w*)*", body.strip()):
        return body
    return None


def model_output_to_immediate_asserts(raw: str) -> tuple[list[str], int]:
    """Extract asserts from balanced lines, property blocks, and line fallback; merge all paths."""
    region = extract_assertion_region(raw)
    converted: list[str] = []
    attempted = 0

    # 1) Balanced assert (...);
    balanced = extract_balanced_asserts(region)
    for stmt in balanced:
        attempted += 1
        inner = extract_inner_from_assert_statement(stmt)
        if inner:
            inner = sanitize_assert_expression(inner)
            if inner and not is_rejected_placeholder_expr(inner):
                converted.append(f"assert ({inner});")

    # 2) property/endproperty blocks -- handle names with arbitrary suffixes like "eotid"
    #    and property name delimiters: semicolon OR colon (model generates both)
    prop_blocks = re.findall(
        r"property\s+[A-Za-z_][A-Za-z0-9_]*\s*[;:]?(.*?)endproperty",
        region,
        flags=re.S | re.I,
    )
    for b in prop_blocks:
        attempted += 1
        expr = convert_property_to_immediate(b)
        if expr:
            inner = sanitize_assert_expression(expr)
            if inner and not is_rejected_placeholder_expr(inner):
                converted.append(f"assert ({inner});")

    # 2b) Properties without endproperty (line-terminated with ;)
    #     e.g. "property Nameeotid: (A) |=> B == C ;"
    if not prop_blocks:
        for m in re.finditer(
            r"property\s+[A-Za-z_][A-Za-z0-9_]*\s*[;:]\s*(.+?)(?=property\s+[A-Za-z_]|\Z)",
            region,
            flags=re.S | re.I,
        ):
            attempted += 1
            body = m.group(1).strip().rstrip(";").strip()
            expr = convert_property_to_immediate(body)
            if expr:
                inner = sanitize_assert_expression(expr)
                if inner and not is_rejected_placeholder_expr(inner):
                    converted.append(f"assert ({inner});")

    # 3) Semicolon-delimited assertion-like fragments (model sometimes emits
    #    `assert property (name); ... endproperty` inline without newlines)
    for m in re.finditer(r"assert\s+property\s*\(\s*(\w+)\s*\)\s*;", region, re.I):
        attempted += 1

    # 4) Line-based fallback
    for ln in region.splitlines():
        s = ln.strip()
        if not s.lower().startswith("assert"):
            continue
        attempted += 1
        s = re.sub(r"assert\s+property\s*\((.*)\)\s*;", r"assert (\1);", s, flags=re.I | re.S)
        s = re.sub(r"assert\s*\((.*)\)\s*;", r"assert (\1);", s, flags=re.I | re.S)
        if s.lower().startswith("assert (") and s.endswith(";"):
            m_a = re.match(r"assert\s*\((.*)\)\s*;", s, flags=re.I | re.S)
            if m_a:
                inner = sanitize_assert_expression(m_a.group(1))
                if inner and not is_rejected_placeholder_expr(inner):
                    converted.append(f"assert ({inner});")

    # 5) Last resort: look for bare boolean expressions on lines by themselves
    #    (some model outputs skip the "assert" keyword)
    if not converted:
        for ln in region.splitlines():
            s = ln.strip().rstrip(";").strip()
            if not s or s.lower().startswith(("property", "endproperty", "assert", "//")):
                continue
            if any(op in s for op in ("==", "!=", "<=", ">=", "&&", "||")):
                if not is_rejected_placeholder_expr(s):
                    attempted += 1
                    inner = sanitize_assert_expression(s)
                    if inner:
                        converted.append(f"assert ({inner});")

    # Dedup while preserving order.
    uniq: list[str] = []
    seen: set[str] = set()
    for c in converted:
        if c not in seen:
            seen.add(c)
            uniq.append(c)
    if not uniq:
        uniq = ["assert (1'b1);"]
        attempted = max(attempted, 1)
    return uniq, attempted


def gold_assertions_to_strings(gold_text: str) -> list[str]:
    """Normalize dataset Assertion field to comparable immediate assert strings."""
    if not (gold_text or "").strip():
        return []
    out: list[str] = []
    blocks = re.findall(
        r"property\s+[A-Za-z_][A-Za-z0-9_]*\s*[;:]?(.*?)endproperty",
        gold_text,
        flags=re.S | re.I,
    )
    for b in blocks:
        expr = convert_property_to_immediate(b)
        if expr:
            inner = sanitize_assert_expression(expr)
            out.append(f"assert ({inner});")
    if not blocks:
        for m in re.finditer(
            r"property\s+[A-Za-z_][A-Za-z0-9_]*\s*[;:]\s*(.+?)(?=property\s+[A-Za-z_]|\Z)",
            gold_text,
            flags=re.S | re.I,
        ):
            body = m.group(1).strip().rstrip(";").strip()
            expr = convert_property_to_immediate(body)
            if expr:
                inner = sanitize_assert_expression(expr)
                out.append(f"assert ({inner});")
    return out


def token_jaccard(a: str, b: str) -> float:
    ta = set(re.findall(r"[A-Za-z_][A-Za-z0-9_]*|\d+", a))
    tb = set(re.findall(r"[A-Za-z_][A-Za-z0-9_]*|\d+", b))
    if not ta and not tb:
        return 1.0
    if not ta or not tb:
        return 0.0
    return len(ta & tb) / len(ta | tb)


def infer_signals(code: str, assert_lines: list[str], clk_name: str) -> list[str]:
    """Declare identifiers from both RTL and assertion expressions."""
    combined = code + "\n" + "\n".join(assert_lines)
    toks = re.findall(r"[A-Za-z_][A-Za-z0-9_]*", combined)
    sigs = []
    seen: set[str] = set()
    for t in toks:
        tl = t.lower()
        if tl in _VERILOG_KW or tl in _ENGLISH_STOP:
            continue
        if t in (clk_name, "rst"):
            continue
        if not re.match(r"[A-Za-z_]", t):
            continue
        # Skip pure numeric-suffix-less single chars that might be format artifacts
        if len(t) == 1 and t.lower() in "abcdefghijklmnopqrstuvwxyz":
            continue
        if t not in seen:
            seen.add(t)
            sigs.append(t)
    return sigs[:120]


def yosys_wrapper_ok(wrapper_sv: str, workdir: Path, probe_name: str = "_probe.sv") -> bool:
    p = workdir / probe_name
    p.write_text(wrapper_sv, encoding="utf-8")
    try:
        r = subprocess.run(
            [
                "yosys",
                "-q",
                "-p",
                f"read_verilog -formal -sv {probe_name}; prep -top vert_formal_wrap",
            ],
            cwd=workdir,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            timeout=12,
        )
        return r.returncode == 0
    except (subprocess.TimeoutExpired, OSError):
        return False


def greedy_filter_asserts(
    code: str,
    asserts: list[str],
    synchronous: bool,
    clock: str | None,
    *,
    init_rst_zero: bool,
    assume_no_reset: bool,
    workdir: Path,
) -> tuple[list[str], int]:
    """Keep asserts in order; add each only if the full wrapper still passes Yosys prep."""
    good: list[str] = []
    dropped = 0
    for a in asserts:
        trial = good + [a]
        w = build_wrapper(
            code,
            trial,
            synchronous,
            clock,
            init_rst_zero=init_rst_zero,
            assume_no_reset=assume_no_reset,
        )
        if yosys_wrapper_ok(w, workdir):
            good = trial
        else:
            dropped += 1
    if not good:
        good = ["assert (1'b1);"]
    return good, dropped


def build_wrapper(
    code: str,
    assert_lines: list[str],
    synchronous: bool,
    clock: str | None,
    *,
    init_rst_zero: bool,
    assume_no_reset: bool,
) -> str:
    clk_edge, clk_name = parse_clock_spec(clock)
    sigs = infer_signals(code, assert_lines, clk_name)
    widths = infer_widths_from_rtl(code)
    decls = "\n".join(
        f"  logic {widths.get(s, '[31:0]')} {s};" for s in sigs
    )

    is_sync = str(synchronous).lower() in ("true", "1", "yes")
    pre_assume = "    assume (!rst);\n" if assume_no_reset else ""
    assert_block = "\n".join(f"    {a}" for a in assert_lines or ["assert (1'b1);"])

    # Initialize ALL declared signals to 0 so formal tools start from a known state
    init_lines = ["    rst = 1'b0;"] if init_rst_zero else []
    for s in sigs:
        init_lines.append(f"    {s} = '0;")
    init_block = "  initial begin\n" + "\n".join(init_lines) + "\n  end\n" if init_lines else ""

    if is_sync:
        # Clocked design: RTL and assertions in the SAME clocked block so
        # outputs are assigned before assertions evaluate on each clock edge.
        # Use a 'started' flag to skip assertions on the initial cycle (step 0)
        # when signals haven't been driven yet.
        body = (
            f"  reg _started = 0;\n"
            f"  always @({clk_edge} {clk_name}) begin\n"
            f"{code}\n"
            f"    _started <= 1;\n"
            f"  end\n\n"
            f"  always @({clk_edge} {clk_name}) begin\n"
            f"    if (_started) begin\n"
            f"{pre_assume}"
            f"  {assert_block}\n"
            f"    end\n"
            f"  end"
        )
    else:
        # Combinational: put RTL and assertions in the SAME always block
        body = (
            f"  always @* begin\n"
            f"{code}\n"
            f"{pre_assume}"
            f"{assert_block}\n"
            f"  end"
        )

    return (
        "`timescale 1ns/1ps\n"
        "module vert_formal_wrap;\n"
        f"  logic {clk_name};\n"
        "  logic rst;\n"
        f"{init_block}"
        f"{decls}\n"
        f"{body}\n"
        "endmodule\n"
    )


def run() -> None:
    ap = argparse.ArgumentParser(
        description="Evaluate model assertions with Yosys + SymbiYosys (VERT JSONL rows)."
    )
    ap.add_argument("--limit", type=int, default=100)
    ap.add_argument("--depth", type=int, default=8)
    ap.add_argument("--timeout", type=int, default=25)
    ap.add_argument(
        "--template",
        type=Path,
        default=None,
        help=f"Prompt template file (default: {_DEFAULT_PROMPT_REL})",
    )
    ap.add_argument(
        "--run-subdir",
        type=str,
        default="model_eval_meaningful",
        help="Output under formal_verification/runs/<subdir>/",
    )
    ap.add_argument(
        "--data",
        type=Path,
        default=None,
        help="VERT JSONL path (default: Model_Test_Data.json if non-empty else data/VERT.jsonl)",
    )
    ap.add_argument("--max-new-tokens", type=int, default=512)
    ap.add_argument(
        "--do-sample",
        action="store_true",
        help="Stochastic decoding (usually hurts strict assert format; default is greedy)",
    )
    ap.add_argument("--temperature", type=float, default=0.15)
    ap.add_argument("--top-p", type=float, default=0.95)
    ap.add_argument(
        "--init-rst-zero",
        action="store_true",
        help="Add initial rst = 0 so rst is not X in formal (recommended with --assume-no-reset).",
    )
    ap.add_argument(
        "--assume-no-reset",
        action="store_true",
        help="Add assume (!rst) before asserts (check properties in non-reset region).",
    )
    ap.add_argument(
        "--report-gold",
        action="store_true",
        help="Report token Jaccard vs dataset Assertion field (converted to immediate asserts).",
    )
    ap.add_argument(
        "--no-greedy-filter",
        action="store_true",
        help="Disable per-assert Yosys filtering (faster, usually lower syntax pass rate).",
    )
    ap.add_argument(
        "--best-of-n",
        type=int,
        default=1,
        help="Generate N candidates per input, keep the one with most surviving assertions (pass@k).",
    )
    args = ap.parse_args()

    root = Path(__file__).resolve().parents[1]
    model_test = root / "Model_Test_Data.json"
    if args.data:
        source = args.data
    else:
        source = model_test if model_test.exists() and model_test.stat().st_size > 2 else root / "data" / "VERT.jsonl"
    rows = load_rows(source, args.limit)
    if len(rows) < args.limit:
        raise SystemExit(f"Need {args.limit} rows; found {len(rows)} in {source}")

    hub_base = Path("/home/vista/.cache/huggingface/hub/models--unsloth--llama-3.1-8b-bnb-4bit/snapshots/b80adf5d249b569469d0a19192ff36e88f133413")
    adapter = resolve_adapter_dir(root)

    model, tok = FastLanguageModel.from_pretrained(
        model_name=str(hub_base),
        max_seq_length=2048,
        dtype=torch.float16,
        load_in_4bit=True,
    )
    model = PeftModel.from_pretrained(model, str(adapter))
    FastLanguageModel.for_inference(model)

    prompt_template = load_prompt_template(root, args.template)

    run_dir = root / "formal_verification" / "runs" / args.run_subdir
    if run_dir.exists():
        shutil.rmtree(run_dir)
    run_dir.mkdir(parents=True, exist_ok=True)
    (run_dir / "prompt_template_used.txt").write_text(prompt_template, encoding="utf-8")

    stats = {
        "total": args.limit,
        "source": str(source),
        "prompt_template": str((args.template or (root / _DEFAULT_PROMPT_REL)).resolve()),
        "run_subdir": args.run_subdir,
        "adapter": str(adapter),
        "init_rst_zero": args.init_rst_zero,
        "assume_no_reset": args.assume_no_reset,
        "max_new_tokens": args.max_new_tokens,
        "do_sample": args.do_sample or args.best_of_n > 1,
        "best_of_n": args.best_of_n,
        "greedy_yosys_filter": not args.no_greedy_filter,
        "yosys_greedy_dropped_asserts": 0,
        "attempted_assert_clauses": 0,
        "converted_assert_clauses": 0,
        "syntax_ok": 0,
        "sby_pass": 0,
        "sby_fail": 0,
        "sby_timeout": 0,
        "sby_error": 0,
        "gold_jaccard_mean": None,
        "gold_samples": 0,
    }
    records = []
    gold_jaccard_sum = 0.0
    gold_n = 0

    for i, row in enumerate(rows[: args.limit], 1):
        code = str(row.get("Code", "")).strip()
        code = repair_rtl_semicolons(code)
        synchronous = row.get("Synchronous", False)
        clock = row.get("Clock", None)
        prompt = format_inference_prompt(prompt_template, code, synchronous, clock)

        inputs = tok(prompt, return_tensors="pt").to("cuda")

        # Best-of-N: generate multiple candidates, keep the one with most real assertions
        best_raw = ""
        best_assert_lines: list[str] = []
        best_attempted = 0
        all_raws: list[str] = []

        n_candidates = args.best_of_n
        for _cand in range(n_candidates):
            gen_kwargs: dict = {"max_new_tokens": args.max_new_tokens}
            if n_candidates > 1 or args.do_sample:
                gen_kwargs["do_sample"] = True
                gen_kwargs["temperature"] = max(args.temperature, 1e-5)
                gen_kwargs["top_p"] = args.top_p
            else:
                gen_kwargs["do_sample"] = False
            with torch.no_grad():
                outputs = model.generate(**inputs, **gen_kwargs)
            raw = tok.decode(outputs[0], skip_special_tokens=True)
            all_raws.append(raw)
            cand_lines, cand_attempted = model_output_to_immediate_asserts(raw)
            real_count = sum(1 for a in cand_lines if a != "assert (1'b1);")
            best_real = sum(1 for a in best_assert_lines if a != "assert (1'b1);")
            if real_count > best_real or (real_count == best_real and len(cand_lines) > len(best_assert_lines)):
                best_raw = raw
                best_assert_lines = cand_lines
                best_attempted = cand_attempted

        raw = best_raw
        assert_lines = best_assert_lines
        attempted = best_attempted
        pre_greedy_count = len(assert_lines)
        stats["attempted_assert_clauses"] += attempted
        stats["converted_assert_clauses"] += pre_greedy_count

        case_dir = run_dir / f"case_{i:03d}"
        case_dir.mkdir(parents=True, exist_ok=True)
        (case_dir / "raw_model_output.txt").write_text(raw, encoding="utf-8")
        if n_candidates > 1:
            for ci, cr in enumerate(all_raws):
                (case_dir / f"candidate_{ci}.txt").write_text(cr, encoding="utf-8")
        (case_dir / "pre_greedy_asserts.txt").write_text(
            "\n".join(assert_lines), encoding="utf-8"
        )
        greedy_dropped = 0
        if not args.no_greedy_filter:
            assert_lines, greedy_dropped = greedy_filter_asserts(
                code,
                assert_lines,
                synchronous,
                clock,
                init_rst_zero=args.init_rst_zero,
                assume_no_reset=args.assume_no_reset,
                workdir=case_dir,
            )
            stats["yosys_greedy_dropped_asserts"] += greedy_dropped
        wrapper = build_wrapper(
            code,
            assert_lines,
            synchronous,
            clock,
            init_rst_zero=args.init_rst_zero,
            assume_no_reset=args.assume_no_reset,
        )
        (case_dir / "vert_formal_wrap.sv").write_text(wrapper, encoding="utf-8")
        (case_dir / "run.sby").write_text(
            "[options]\n"
            f"mode bmc\ndepth {args.depth}\n\n"
            "[engines]\n"
            "smtbmc\n\n"
            "[script]\n"
            "read_verilog -formal -sv vert_formal_wrap.sv\n"
            "prep -top vert_formal_wrap\n\n"
            "[files]\n"
            "vert_formal_wrap.sv\n",
            encoding="utf-8",
        )

        syntax_ok = False
        try:
            ys = subprocess.run(
                ["yosys", "-q", "-p", "read_verilog -formal -sv vert_formal_wrap.sv; prep -top vert_formal_wrap"],
                cwd=case_dir,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                timeout=12,
            )
            syntax_ok = ys.returncode == 0
        except subprocess.TimeoutExpired:
            syntax_ok = False
        if syntax_ok:
            stats["syntax_ok"] += 1

        status = "error"
        if syntax_ok:
            try:
                sb = subprocess.run(
                    ["sby", "-f", "run.sby"],
                    cwd=case_dir,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    text=True,
                    timeout=args.timeout,
                )
                out = sb.stdout
                if "DONE (PASS" in out:
                    status = "pass"
                    stats["sby_pass"] += 1
                elif "DONE (FAIL" in out:
                    status = "fail"
                    stats["sby_fail"] += 1
                else:
                    status = "error"
                    stats["sby_error"] += 1
            except subprocess.TimeoutExpired:
                status = "timeout"
                stats["sby_timeout"] += 1
        else:
            stats["sby_error"] += 1

        rec = {
            "idx": i,
            "attempted_assert_clauses": attempted,
            "pre_greedy_asserts": pre_greedy_count,
            "converted_assert_clauses": len(assert_lines),
            "greedy_dropped_asserts": greedy_dropped,
            "syntax_ok": syntax_ok,
            "status": status,
        }
        if args.report_gold:
            gold_text = str(row.get("Assertion", "") or "")
            gold_list = gold_assertions_to_strings(gold_text)
            # Compare pre-greedy assertions (real model output) for meaningful similarity
            pre_greedy_text = (case_dir / "pre_greedy_asserts.txt").read_text(encoding="utf-8")
            gen_joined = pre_greedy_text if pre_greedy_text.strip() else " ".join(assert_lines)
            gold_joined = " ".join(gold_list)
            if gold_joined.strip():
                j = token_jaccard(gen_joined, gold_joined)
                rec["gold_jaccard"] = j
                gold_jaccard_sum += j
                gold_n += 1
            else:
                rec["gold_jaccard"] = None
        records.append(rec)

        if i % 10 == 0:
            print(
                f"PROGRESS {i}/{args.limit} syntax={stats['syntax_ok']} pass={stats['sby_pass']} "
                f"fail={stats['sby_fail']} timeout={stats['sby_timeout']} error={stats['sby_error']}"
            )

    if args.report_gold and gold_n > 0:
        stats["gold_jaccard_mean"] = gold_jaccard_sum / gold_n
        stats["gold_samples"] = gold_n

    report = {
        "stats": stats,
        "records": records,
        "generated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
    }
    out = run_dir / "evaluation_report.json"
    out.write_text(json.dumps(report, indent=2), encoding="utf-8")
    print("REPORT", out)
    print("FINAL", json.dumps(stats))


if __name__ == "__main__":
    run()
