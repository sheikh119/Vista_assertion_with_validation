#!/usr/bin/env python3
"""
Convert VISTA_Final_Year_Report.md to Word (.docx):
  1. Render ```mermaid``` blocks to PNG via @mermaid-js/mermaid-cli (mmdc).
  2. Normalize excessive blank lines outside fenced code (fixes double-spaced MD).
  3. Run pandoc to docx with embedded images.

Prerequisites (run once from repo root):
  cd scripts/report_docx_tools && npm install
  sudo apt install -y pandoc   # or ensure pandoc on PATH

Usage:
  python scripts/export_report_to_docx.py
  python scripts/export_report_to_docx.py --md path/to/report.md --out "exports/Draft 3.docx"
"""
from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
import tarfile
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TOOLS = Path(__file__).resolve().parent / "report_docx_tools"
PANDOC_CACHE = ROOT / "scripts" / "report_docx_tools" / "pandoc_bin"
PANDOC_URL = "https://github.com/jgm/pandoc/releases/download/3.6.4/pandoc-3.6.4-linux-amd64.tar.gz"


def find_pandoc() -> Path | None:
    p = shutil.which("pandoc")
    return Path(p) if p else None


def ensure_pandoc() -> Path:
    existing = find_pandoc()
    if existing:
        return existing
    pandoc_exe = PANDOC_CACHE / "pandoc-3.6.4" / "bin" / "pandoc"
    if pandoc_exe.is_file():
        return pandoc_exe
    PANDOC_CACHE.mkdir(parents=True, exist_ok=True)
    tgz = PANDOC_CACHE / "pandoc.tgz"
    print("Downloading pandoc (no apt required)...", PANDOC_URL)
    urllib.request.urlretrieve(PANDOC_URL, tgz)
    with tarfile.open(tgz, "r:gz") as tf:
        tf.extractall(PANDOC_CACHE)
    tgz.unlink(missing_ok=True)
    if not pandoc_exe.is_file():
        sys.exit(f"Pandoc not found after extract: {pandoc_exe}")
    return pandoc_exe


def mmdc_bin() -> Path:
    win = TOOLS / "node_modules" / ".bin" / "mmdc"
    if not win.is_file():
        sys.exit(
            "mmdc not found. Run:\n  cd scripts/report_docx_tools && npm install\n"
            f"Expected: {win}"
        )
    return win


def normalize_mermaid_body(raw: str) -> str:
    lines = [ln.rstrip() for ln in raw.splitlines()]
    lines = [ln for ln in lines if ln.strip() != ""]
    return "\n".join(lines) + "\n"


def reduce_blank_lines_outside_fences(text: str) -> str:
    """Collapse 3+ newlines to 2 outside ``` ... ``` fences."""
    parts = re.split(r"(```[\s\S]*?```)", text)
    out: list[str] = []
    for i, part in enumerate(parts):
        if part.startswith("```") and part.rstrip().endswith("```"):
            out.append(part)
        else:
            out.append(re.sub(r"\n{3,}", "\n\n", part))
    return "".join(out)


def add_figure_widths(md: str, width: str = "5.15in") -> str:
    """Pandoc + Word: constrain PNG width to printable body (Letter minus GIKI margins ~5.17\")."""
    return re.sub(
        r"!\[([^\]]*)\]\((figure_\d+\.png)\)(?!\{)",
        rf"![\1](\2){{width={width}}}",
        md,
    )


def render_mermaid_diagrams(md: str, media_dir: Path) -> tuple[str, list[str]]:
    media_dir.mkdir(parents=True, exist_ok=True)
    errors: list[str] = []
    puppet = TOOLS / "puppeteer-config.json"
    pattern = re.compile(r"```mermaid\s*\n(.*?)```", re.DOTALL | re.IGNORECASE)

    out_parts: list[str] = []
    last = 0
    idx = 0
    for m in pattern.finditer(md):
        out_parts.append(md[last : m.start()])
        idx += 1
        block = m.group(1)
        clean = normalize_mermaid_body(block)
        mmd = media_dir / f"_tmp_{idx}.mmd"
        png = media_dir / f"figure_{idx}.png"
        mmd.write_text(clean, encoding="utf-8")
        cmd = [
            str(mmdc_bin()),
            "-i",
            str(mmd),
            "-o",
            str(png),
            "-b",
            "white",
            "-w",
            "2400",
            "-H",
            "1600",
            "-s",
            "2",
            "-p",
            str(puppet),
        ]
        r = subprocess.run(cmd, capture_output=True, text=True, cwd=str(TOOLS))
        mmd.unlink(missing_ok=True)
        if r.returncode != 0 or not png.is_file():
            err = (r.stderr or r.stdout or "").strip()
            errors.append(f"figure_{idx}: {err}")
            out_parts.append(
                f"\n\n**[Figure {idx}: Mermaid render failed]**\n\n```\n{clean.strip()}\n```\n\n"
            )
        else:
            # Blank line + image only; caption usually appears above in source MD
            out_parts.append(f"\n\n![Figure {idx} — diagram]({png.name})\n\n")
        last = m.end()
    out_parts.append(md[last:])
    return "".join(out_parts), errors


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--md", type=Path, default=ROOT / "VISTA_Final_Year_Report.md")
    ap.add_argument("--out", type=Path, default=ROOT / "exports" / "Draft 3.docx")
    args = ap.parse_args()

    md_path: Path = args.md
    out_path: Path = args.out
    if not md_path.is_file():
        sys.exit(f"Markdown not found: {md_path}")

    build_dir = ROOT / "exports" / "report_docx_build"
    media_dir = build_dir / "media"
    if build_dir.exists():
        shutil.rmtree(build_dir)
    media_dir.mkdir(parents=True, exist_ok=True)

    raw = md_path.read_text(encoding="utf-8", errors="replace")
    raw = reduce_blank_lines_outside_fences(raw)

    print("Rendering Mermaid diagrams (high-res PNG for Word)...")
    converted, errors = render_mermaid_diagrams(raw, media_dir)
    for e in errors:
        print("WARN:", e)

    converted = add_figure_widths(converted)

    intermediate = build_dir / "report_for_pandoc.md"
    intermediate.write_text(converted, encoding="utf-8")

    pandoc = ensure_pandoc()
    out_path.parent.mkdir(parents=True, exist_ok=True)

    cmd = [
        str(pandoc),
        str(intermediate),
        "-f",
        "markdown+link_attributes",
        "-t",
        "docx",
        "-o",
        str(out_path),
        "--resource-path",
        str(media_dir),
        "-s",
    ]
    print("Running:", " ".join(cmd))
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(r.stderr or r.stdout or "pandoc failed")

    print("Wrote:", out_path)
    if errors:
        print(f"Completed with {len(errors)} diagram warning(s).")


if __name__ == "__main__":
    main()
