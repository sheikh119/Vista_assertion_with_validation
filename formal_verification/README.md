# Formal verification (SymbiYosys / Yosys) — isolated from Python

This folder is **separate from** `vista_env/`. SymbiYosys (`sby`), Yosys, and solvers come from the **OSS CAD Suite** binary distribution ([installation guide](https://yosyshq.readthedocs.io/projects/sby/en/latest/install.html)), not `pip`.

## Install OSS CAD Suite (includes `sby`, `yosys`, …)

From this directory:

```bash
bash install_oss_cad_suite.sh
```

That downloads the latest **linux-x64** release from [YosysHQ/oss-cad-suite-build](https://github.com/YosysHQ/oss-cad-suite-build/releases) into `./oss-cad-suite/` and does **not** modify your Python virtual environment.

After install, **activate tools** in each shell where you run formal checks:

```bash
source "$(pwd)/oss-cad-suite/environment"
which sby yosys
```

For **stronger SystemVerilog / SVA** support, YosysHQ documents the commercial [Tabby CAD Suite](https://www.yosyshq.com/tabby-cad-datasheet); the free OSS suite is enough to start.

## VERT-style harness

- `templates/vert_formal_wrap.sv` — wrap VERT **Code** + clock / sync metadata.
- `templates/example.sby` — minimal SymbiYosys job; point `[files]` at your generated Verilog.

Copy templates, fill placeholders, then run `sby -f your_job.sby`.

## Limitations

VERT snippets are not always complete modules. You may need to **declare wires/regs**, fix **ports**, or split **combinational vs clocked** logic manually. The template is a **starting point**, not a universal semantic match for every row.
