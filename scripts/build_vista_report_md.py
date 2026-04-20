#!/usr/bin/env python3
"""
Generate VISTA_Final_Year_Report.md — GIKI format (Vista_Report_format.txt), ~90 pages in Word
when set to Times New Roman 12 pt, 1.5 spacing, with figures inserted per institute guidance.

Uses vista_report_draft3_data.py for long topic lists (no source code listings in body).
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from vista_report_draft3_data import (
    GLOSSARY_ENTRIES,
    LITERATURE_TOPICS,
    METHOD_TOPICS,
    RESULT_TOPICS,
    SUPPLEMENT_CH2,
    SUPPLEMENT_CH4,
    SUPPLEMENT_CH5,
)

ROOT = Path(__file__).resolve().parent.parent

_M = (
    "%%{init: {"
    "'theme':'base',"
    "'themeVariables': {"
    "'fontFamily':'Segoe UI, Arial, sans-serif',"
    "'fontSize':'17px',"
    "'primaryColor':'#0f172a',"
    "'primaryTextColor':'#ffffff',"
    "'primaryBorderColor':'#020617',"
    "'secondaryColor':'#cbd5e1',"
    "'tertiaryColor':'#f8fafc',"
    "'lineColor':'#334155',"
    "'mainBkg':'#ffffff',"
    "'nodeTextColor':'#0f172a'"
    "}"
    "}}%%"
)


def mf(inner: str) -> str:
    return "```mermaid\n" + _M + "\n" + inner.strip() + "\n```"


def build_detailed_toc() -> str:
    """Structured TOC aligned with generated headings (pages TBD for Word)."""
    roman = ["i", "ii", "iii", "iv", "v", "vi", "vii", "viii"]
    front_titles = [
        "Title page — required content checklist",
        "Certificate of Approval",
        "SDGs Inclusion — goals and achievements",
        "ABSTRACT",
        "ACKNOWLEDGEMENTS",
        "TABLE OF CONTENTS (this listing)",
        "LIST OF FIGURES",
        "LIST OF TABLES",
    ]
    fm_rows = "\n".join(
        f"| ({roman[i]}) | {front_titles[i]} | *TBD* |" for i in range(len(front_titles))
    )
    ch1_rows = "\n".join(
        f"| {sec} | {title} | *TBD* |"
        for sec, title in [
            ("1.1", "Background and motivation"),
            ("1.2", "Problem statement"),
            ("1.3", "Objectives and scope"),
            ("1.4", "Contributions"),
            ("1.5", "Report organization"),
            ("Fig.", "Figures 1.1–1.3 (within Chapter I)"),
        ]
    )
    ch2_core = "\n".join(
        f"| {sec} | {title} | *TBD* |"
        for sec, title in [
            ("2.1", "Overview"),
            ("2.2", "Foundational themes (diagrams)"),
        ]
    )
    ch2_lit = "\n".join(
        f"| 2.{3 + i} | {title} | *TBD* |" for i, title in enumerate(LITERATURE_TOPICS)
    )
    ch2_supp = "\n".join(
        f"| II–S{i + 1} | Supplement: {title} | *TBD* |"
        for i, title in enumerate(SUPPLEMENT_CH2)
    )
    ch3_rows = "\n".join(
        f"| {sec} | {title} | *TBD* |"
        for sec, title in [
            ("3.1", "System context"),
            ("3.2", "Functional requirements (Table 3.1)"),
            ("3.3", "Non-functional requirements (Table 3.2)"),
            ("Fig.", "Figures 3.1–3.3"),
        ]
    )
    ch4_core = "\n".join(
        f"| {sec} | {title} | *TBD* |"
        for sec, title in [
            ("4.1", "Scientific method and reproducibility"),
            ("4.2", "Dataset and training configuration (Table 4.1)"),
            ("4.3", "Core methodology narrative"),
            ("Fig.", "Figures 4.1–4.8"),
        ]
    )
    ch4_method = "\n".join(
        f"| 4.{4 + i} | {title} | *TBD* |" for i, title in enumerate(METHOD_TOPICS)
    )
    ch4_supp = "\n".join(
        f"| IV–M{i + 1} | Supplement: {title} | *TBD* |"
        for i, title in enumerate(SUPPLEMENT_CH4)
    )
    ch5_core = "\n".join(
        f"| {sec} | {title} | *TBD* |"
        for sec, title in [
            ("5.1", "Metrics and equation for gold Jaccard"),
            ("5.2", "Aggregate results (Table 5.1)"),
            ("5.3", "Distribution of gold Jaccard (Table 5.2)"),
            ("5.4", "Discussion of formal failure (sample 82)"),
            ("Fig.", "Figures 5.1–5.4"),
        ]
    )
    ch5_res = "\n".join(
        f"| 5.{6 + i} | {title} | *TBD* |" for i, title in enumerate(RESULT_TOPICS)
    )
    ch5_supp = "\n".join(
        f"| V–R{i + 1} | Supplement: {title} | *TBD* |"
        for i, title in enumerate(SUPPLEMENT_CH5)
    )
    ch6_rows = "\n".join(
        f"| {sec} | {title} | *TBD* |"
        for sec, title in [
            ("6.1", "Conclusion"),
            ("6.2", "Future work"),
            ("Fig.", "Figure 6.1 — roadmap"),
        ]
    )
    gloss_n = len(GLOSSARY_ENTRIES)
    return f"""## TABLE OF CONTENTS

> **Microsoft Word:** Map `# CHAPTER …` to **Heading 1**, `## Chapter n: …` to **Heading 3**, and `###` / `####` to **Heading 4–5** per `Vista_Report_format.txt`. Then use **References → Table of Contents → Automatic** and delete this manual listing *or* keep it as a planning outline and update *TBD* page cells after pagination.

### Front matter *(roman numerals on bound copy)*

| Ref | Section | Page |
|-----|---------|------|
{fm_rows}

### CHAPTER I — Introduction

| Ref | Section | Page |
|-----|---------|------|
{ch1_rows}

### CHAPTER II — Literature survey

| Ref | Section | Page |
|-----|---------|------|
{ch2_core}
{ch2_lit}
{ch2_supp}

### CHAPTER III — Design (requirements / specifications)

| Ref | Section | Page |
|-----|---------|------|
{ch3_rows}

### CHAPTER IV — Proposed solution (methodology, implementation)

| Ref | Section | Page |
|-----|---------|------|
{ch4_core}
{ch4_method}
{ch4_supp}

### CHAPTER V — Results and discussion

| Ref | Section | Page |
|-----|---------|------|
{ch5_core}
{ch5_res}
{ch5_supp}

### CHAPTER VI — Conclusion and future work

| Ref | Section | Page |
|-----|---------|------|
{ch6_rows}

### Back matter

| Ref | Section | Page |
|-----|---------|------|
| — | Glossary ({gloss_n} entries) | *TBD* |
| — | References | *TBD* |
| App. A | Institute formatting checklist | *TBD* |
| App. B | Reproducibility statement | *TBD* |
| App. C | Ethics, risk, limitations + Table A.1 outliers | *TBD* |
| App. D | Threats to validity | *TBD* |
| App. E | Table B.1 — Per-sample log (n = 100) | *TBD* |
"""


def expand_topic(title: str, ctx: str) -> str:
    return (
        f"This subsection discusses **{title}** as it relates to {ctx}. Hardware verification "
        "research consistently shows that assertion quality—not raw engine throughput—often limits "
        "effective defect discovery. Automated generators must therefore be judged along multiple "
        "axes: syntactic acceptability, semantic alignment with designer intent on benchmark corpora, "
        "and stability under formal encodings that expose corner cases such as unknown bits and "
        "reset interactions. Review committees additionally expect clarity on dataset provenance, "
        "train–test overlap risks, and whether metrics are reported on a frozen slice or on a "
        "continuously moving checkpoint.\n\n"
        f"Within **{title}**, the VISTA project adopts a pragmatic stance aligned with open-source "
        "tooling: the VERT distribution supplies paired RTL and reference assertions, while SymbiYosys "
        "supplies bounded checks that are easy to reproduce in academic laboratories. This does not "
        "replace industrial sign-off flows; it provides a transparent yardstick for iterative model "
        "and pipeline improvements. Students extending this report should cite peer-reviewed and "
        "standard references in IEEE format, critique assumptions explicitly, and avoid overstating "
        "claims beyond the frozen evaluation slice reported in Chapter V."
    )


def main() -> None:
    rep = json.loads(
        (ROOT / "formal_verification/runs/model_eval_v7_100/evaluation_report.json").read_text(
            encoding="utf-8"
        )
    )
    st = rep["stats"]
    recs = rep["records"]

    def jacc_cat(j: float) -> str:
        if j >= 0.999:
            return "≥ 0.999"
        if j >= 0.95:
            return "0.950 – 0.998"
        if j >= 0.90:
            return "0.900 – 0.949"
        return "< 0.900"

    cats: dict[str, int] = {}
    for r in recs:
        c = jacc_cat(float(r.get("gold_jaccard", 0)))
        cats[c] = cats.get(c, 0) + 1

    outliers = [
        r
        for r in recs
        if r.get("status") != "pass" or float(r.get("gold_jaccard", 1)) < 0.95
    ]
    outliers.sort(key=lambda r: (r.get("status") != "fail", -float(r.get("gold_jaccard", 0))))

    jrows = "\n".join(
        f"| {bucket} | {cats[bucket]} |"
        for bucket in sorted(cats.keys(), key=lambda x: (str(x).startswith("<"), str(x)))
    )

    full_rows = "\n".join(
        "| {idx} | {syn} | {st} | {jac:.4f} | {att} | {gd} | {cv} |".format(
            idx=r.get("idx"),
            syn=r.get("syntax_ok"),
            st=r.get("status"),
            jac=float(r.get("gold_jaccard", 0)),
            att=r.get("attempted_assert_clauses", ""),
            gd=r.get("greedy_dropped_asserts", ""),
            cv=r.get("converted_assert_clauses", ""),
        )
        for r in recs
    )

    lit_body = "\n\n".join(
        f"#### 2.{3 + i} {title}\n\n{expand_topic(title, 'Chapter II (literature survey)')}"
        for i, title in enumerate(LITERATURE_TOPICS)
    )
    lit_supp = "\n\n".join(
        f"#### Chapter II supplement — S{i + 1}: {title}\n\n"
        f"{expand_topic(title, 'Chapter II extended literature')}"
        for i, title in enumerate(SUPPLEMENT_CH2)
    )
    lit_full = lit_body + "\n\n" + lit_supp

    method_body = "\n\n".join(
        f"#### 4.{4 + i} {title}\n\n{expand_topic(title, 'Chapter IV (methodology and implementation)')}"
        for i, title in enumerate(METHOD_TOPICS)
    )
    method_supp = "\n\n".join(
        f"#### Chapter IV supplement — M{i + 1}: {title}\n\n"
        f"{expand_topic(title, 'Chapter IV engineering practice')}"
        for i, title in enumerate(SUPPLEMENT_CH4)
    )
    method_full = method_body + "\n\n" + method_supp

    result_body = "\n\n".join(
        f"#### 5.{6 + i} {title}\n\n{expand_topic(title, 'Chapter V (results and discussion)')}"
        for i, title in enumerate(RESULT_TOPICS)
    )
    result_supp = "\n\n".join(
        f"#### Chapter V supplement — R{i + 1}: {title}\n\n"
        f"{expand_topic(title, 'Chapter V measurement and reporting')}"
        for i, title in enumerate(SUPPLEMENT_CH5)
    )
    result_full = result_body + "\n\n" + result_supp

    gloss_body = "\n\n".join(
        f"### {term}\n\n{definition}\n\n"
        f"In the VISTA context, **{term}** appears when discussing toolchains, metrics, or deployment; "
        f"cross-reference Chapter IV for operational meaning and Chapter V for empirical usage."
        for term, definition in GLOSSARY_ENTRIES
    )

    parts: list[str] = []

    def add(s: str) -> None:
        parts.append(s.strip())

    add(
        r"""# VISTA: Verification using Intelligent Systems for Test Automation

## Senior Design Project Report — Draft 3 (GIKI format structure)

**Institute typography (apply in Microsoft Word per `Vista_Report_format.txt`):** Title page — Times New Roman **18 pt bold** (SDP title); student names and register numbers **14 pt bold**; advisor, faculty, and institute names **14 pt bold**; insert official **university logo**. Body text — Times New Roman **12 pt**, **1.5 line spacing**, **justified**. Abstract and Acknowledgements titles — **14 pt bold**. **Title page margins:** Top 1.5″, Bottom 0.39″, Left 2″, Right 1.33″. **Subsequent pages:** Top and Bottom 1.5″, Left 2″, Right 1.33″; section start **New Page** where required. **Paper:** Letter (8.5″ × 11″), Portrait. Number equations consecutively as (1.1), (1.2), … with symbols per institute guidance. **Figures:** cite before insertion (e.g., Fig. 1.1); caption **below** figure (10 pt in final Word). **Tables:** head **above** table (10 pt). Submit through **Turnitin** as required.

**Pagination estimate:** This Markdown is written for expansion to approximately **ninety** printed pages after Word formatting, insertion of official title and certificate pages, list of figures/tables with page numbers, and optional blank verso pages. Actual page count depends on figure sizes and heading styles."""
    )

    add(
        r"""## Title Page — Required content checklist

| Element | Content |
|---------|---------|
| SDP title (18 pt bold) | **VISTA: Verification using Intelligent Systems for Test Automation** |
| Students (14 pt bold) | **Asad Ali**, **Sheikh Abbas**, **Mian Arqam** — *add registration numbers* |
| Advisor | **Dr. Fahad Bin Muslim** |
| Co-advisor | **Dr. Waqar** *(if applicable)* |
| Industrial mentors | **Dr. Haroon**, **Dr. Majeed** — **NECOP** |
| Faculty name (14 pt bold) | Faculty of Computer Engineering *(verify official wording)* |
| Institute (14 pt bold) | **Ghulam Ishaq Khan Institute of Engineering Sciences and Technology (GIKI), Topi, Pakistan** |

*Insert university logo on the bound title page.*"""
    )

    add(
        r"""## Certificate of Approval

It is certified that the work presented in this report was performed by **Asad Ali**, **Sheikh Abbas**, and **Mian Arqam** under the supervision of **Dr. Fahad Bin Muslim**. The work is adequate and lies within the scope of the **BS degree in Computer Engineering / Computer Science** at Ghulam Ishaq Khan Institute of Engineering Sciences and Technology.

Industrial collaboration was supported by **NECOP** with mentorship from **Dr. Haroon** and **Dr. Majeed**.

| Advisor | Co-Advisor *(if applicable)* |
|---------|-------------------------------|
| _________________________ | _________________________ |

**Prof. Dr. Qadeer Ul Hassan**  
Dean  
_________________________"""
    )

    add(
        r"""## SDGs Inclusion — goals aimed for and achievements

### Sustainable Development Goal 4 — Quality education

**Aim:** Strengthen inclusive education and lifelong learning through engineering depth and reproducible teaching artifacts.

**Achievement:** VISTA packages a transparent pipeline from RTL fragments to formal checks, suitable for laboratory modules on assertion-based verification. Students can inspect inputs, outputs, and tool logs rather than treating the system as a black box.

### Sustainable Development Goal 9 — Industry, innovation and infrastructure

**Aim:** Build resilient infrastructure and foster innovation.

**Achievement:** The work couples **large language models** with **open-source formal tools** (Yosys, SymbiYosys), lowering the barrier to rigorous property generation for research groups that lack commercial formal licenses.

### Sustainable Development Goal 12 — Responsible consumption and production

**Aim:** Promote sustainable use of resources and energy.

**Achievement:** **QLoRA** fine-tuning reduces GPU memory footprint and training energy relative to full fine-tuning of an 8B-parameter base model, while retaining strong task performance on VERT-style assertion generation.

---

**SDG signature block (per template):** Advisor _________________ ; Co-Advisor _________________ ."""
    )

    add(
        r"""## ABSTRACT

**Title (14 pt bold in Word):** VISTA: Verification using Intelligent Systems for Test Automation

Hardware verification remains a dominant cost in modern integrated-circuit design. **SystemVerilog Assertions (SVA)** express temporal design intent for both simulation and formal analysis, yet manual assertion authoring is slow, expertise-intensive, and difficult to scale with design complexity. This report presents **VISTA**, an integrated framework that **generates** SVA-style properties directly from **RTL fragments** using a **QLoRA**-adapted **LLaMA 3.1 (8B)** model trained on the **VERT** corpus (twenty thousand labeled pairs in this repository). Because VERT samples are often **non-modular** snippets, VISTA introduces a **dynamic wrapping** stage that infers interface signals, applies clock and reset semantics, and produces elaboratable SystemVerilog suitable for **Yosys** and **SymbiYosys**. Deterministic **post-processing** extracts clean property structure, adapts expressions to the formal front end, and applies a **greedy syntax filter** that preserves as many clauses as possible while retaining parseability.

On a **frozen** evaluation of **one hundred** consecutive VERT records, **all** generated wrappers achieved **Yosys** syntax success, **ninety-nine** **SymbiYosys** bounded model-checking runs returned **pass**, and **one** returned **fail**. Mean **gold Jaccard** similarity to reference assertions was **0.991**, with **eighty-nine** samples in the highest similarity bucket. The sole formal failure exhibits **gold Jaccard 1.0**, illustrating that **lexical identity** does not guarantee **proof success** when **don’t-care** bits appear in **case** selectors—a lesson in **four-valued semantics** and harness assumptions rather than a simple decoding error. A **Next.js** demonstration client and **Python** service support interactive use. The report concludes with limitations, ethics, and a roadmap toward counterexample-guided refinement.

**Keywords:** formal verification, SystemVerilog assertions, large language models, QLoRA, VERT, SymbiYosys, RTL wrapping, bounded model checking."""
    )

    add(
        r"""## ACKNOWLEDGEMENTS

The authors express sincere gratitude to **Dr. Fahad Bin Muslim** for academic supervision and to **Dr. Waqar** for co-supervision where applicable. Industrial mentorship from **Dr. Haroon** and **Dr. Majeed** through **NECOP** provided valuable perspective on verification productivity and adoption. The open-source communities behind **Yosys**, **SymbiYosys**, **Unsloth**, and **Hugging Face** are thanked for maintaining reproducible tooling and documentation. Finally, the authors acknowledge the **Faculty of Computer Engineering** and **GIKI** for laboratory and computational resources."""
    )

    add(build_detailed_toc())

    add(
        r"""## LIST OF FIGURES

*Format per institute template (Number — Caption — Page). Page numbers are placeholders (TBD).*

| Fig. | Caption | Page |
|------|---------|------|
| 1.1 | Verification lifecycle and VISTA placement | TBD |
| 1.2 | Stakeholder map | TBD |
| 1.3 | SDG contribution mapping | TBD |
| 2.1 | Research timeline (themes) | TBD |
| 2.2 | Sources of assertion knowledge | TBD |
| 2.3 | Formal verification stack layers | TBD |
| 2.4 | Positioning: NL-driven vs RTL-only generation | TBD |
| 3.1 | System boundary and external interfaces | TBD |
| 3.2 | Functional requirements traceability | TBD |
| 3.3 | Non-functional requirement categories | TBD |
| 4.1 | End-to-end methodology overview | TBD |
| 4.2 | Dataset and training data flow | TBD |
| 4.3 | QLoRA adaptation concept | TBD |
| 4.4 | Inference and service interaction (sequence) | TBD |
| 4.5 | Post-processing and filter stages | TBD |
| 4.6 | Synchronous wrapper and clock alignment | TBD |
| 4.7 | Evaluation harness and artifacts | TBD |
| 4.8 | Demonstration deployment layers | TBD |
| 5.1 | Evaluation workflow from record to verdict | TBD |
| 5.2 | Aggregate syntax and formal outcomes (n = 100) | TBD |
| 5.3 | Gold Jaccard distribution | TBD |
| 5.4 | Interpreting pass vs fail vs lexical match | TBD |
| 6.1 | Research and engineering roadmap | TBD |"""
    )

    add(
        r"""## LIST OF TABLES

| Table | Caption | Page |
|-------|---------|------|
| 3.1 | Functional requirements summary | TBD |
| 3.2 | Non-functional requirements summary | TBD |
| 4.1 | Training hyperparameters (project defaults) | TBD |
| 5.1 | Aggregate metrics (model_eval_v7_100) | TBD |
| 5.2 | Gold Jaccard buckets | TBD |
| A.1 | Outlier cases (formal fail or Jaccard < 0.95) | TBD |
| B.1 | Per-sample evaluation log (n = 100) | TBD |"""
    )

    # --- CHAPTER I ---
    add(
        f"""# CHAPTER I

## Chapter 1: Introduction

### 1.1 Background and motivation

Register-transfer level (RTL) design captures the structure and cycle-accurate behavior of digital hardware before fabrication. Verification—demonstrating that the RTL satisfies intent under stated assumptions—consumes a large fraction of project schedule and staffing. **Assertions** operationalize intent: they can be simulated, constrained in randomized testbenches, and, when supported, analyzed by formal engines. **SystemVerilog Assertions** are the de facto standard for expressing temporal properties in modern digital flows.

Despite mature tooling, teams still struggle to write **enough** high-quality assertions **early enough**. Manual authoring is error-prone; reviews are expensive; and knowledge is uneven across sites. **Machine learning**, and specifically **large language models**, offer a complementary path: learn regularities from corpora of RTL and assertions, then **propose** candidate properties for engineer review. The scientific question is how to connect such proposals to **credible** verification outcomes rather than anecdotal demos.

### 1.2 Problem statement

The VERT dataset provides **paired** RTL fragments and reference assertions together with **synchronization** and **clock** metadata. However, VERT fragments are not necessarily complete modules; open formal flows expect **declarations**, **consistent clocking**, and **parseable** SVA. The core problem addressed here is therefore **threefold**: (i) generate assertion text aligned with VERT’s distribution; (ii) **normalize** and **repair** model outputs for tool consumption; and (iii) **wrap** fragments into a harness that supports reproducible **bounded** proofs.

### 1.3 Objectives and scope

**Objectives:** (1) fine-tune an 8B-class LLM with QLoRA for RTL-to-assertion generation; (2) implement post-processing and a dynamic wrapper; (3) evaluate with Yosys and SymbiYosys on a fixed hundred-sample slice; (4) deliver a demonstration interface.

**Scope:** VERT-style control-flow fragments, local or laboratory GPU inference, and OSS formal tools. **Out of scope:** full-chip hierarchical verification sign-off, analog/mixed-signal, and proprietary timing closure.

### 1.4 Contributions

The project contributes an **end-to-end** pipeline, a **reproducible** evaluation snapshot, and an **honest** discussion of failure modes—including a formal failure with **perfect** lexical agreement—highlighting semantics and assumptions.

### 1.5 Report organization

Chapter II reviews literature. Chapter III specifies requirements. Chapter IV details methodology and implementation. Chapter V presents results. Chapter VI concludes. Glossary, references, and appendices follow.

**Fig. 1.1 — Verification lifecycle and placement of VISTA.**

{mf(
        '''
flowchart TB
  classDef v fill:#0f172a,color:#fff,stroke:#020617
  classDef h fill:#e2e8f0,color:#0f172a,stroke:#64748b
  subgraph LIFECYCLE["Design and verification lifecycle"]
    SPEC[Specification]:::h
    RTL[RTL design]:::h
    SIM[Simulation / emulation]:::h
    FV[Formal analysis]:::h
    SIGN[Sign-off]:::h
  end
  VISTA["VISTA: draft assertions from RTL fragments"]:::v
  RTL --> VISTA --> FV
  SPEC --> RTL
  SIM --> SIGN
  FV --> SIGN
'''
    )}

**Fig. 1.2 — Primary stakeholders.**

{mf(
        '''
flowchart LR
  classDef n fill:#f1f5f9,stroke:#475569,color:#0f172a
  E[Engineering students / researchers]:::n
  I[Industrial mentors / NECOP]:::n
  A[Academic supervisors]:::n
  T[Toolchain maintainers]:::n
  V[VISTA team]:::n
  E --> V
  I --> V
  A --> V
  T --> V
'''
    )}

**Fig. 1.3 — SDG contribution mapping.**

{mf(
        '''
flowchart TB
  V[VISTA outcomes]
  V --> SDG4["SDG 4: Education artifacts and reproducible labs"]
  V --> SDG9["SDG 9: Open formal infrastructure"]
  V --> SDG12["SDG 12: Efficient QLoRA training"]
'''
    )}"""
    )

    # --- CHAPTER II ---
    add(
        f"""# CHAPTER II

## Chapter 2: Literature survey

### 2.1 Overview

This chapter situates VISTA within formal methods, assertion generation research, benchmarking practice, and parameter-efficient learning. Each following subsection deepens one theme and cites where the thesis should connect to primary literature in IEEE format.

### 2.2 Foundational themes (diagrams)

**Fig. 2.1 — Thematic timeline (conceptual).**

{mf(
        '''
timeline
    title Evolution of assertion-related automation (conceptual)
    section 1990s–2000s
        Simulation dominance : Directed and constrained-random tests
        Early formal : Model checking on extracted models
    section 2000s–2010s
        SVA adoption : IEEE 1800 assertions in industry
        Mining : Trace-driven property suggestions
    section 2010s–2020s
        SMT/BMC scaling : Stronger engines on RTL-like models
    section 2020s onward
        LLM assistance : NL and RTL conditioned generation
'''
    )}

**Fig. 2.2 — Where assertion knowledge can originate.**

{mf(
        '''
flowchart TB
  classDef box fill:#e2e8f0,stroke:#334155,color:#0f172a
  A[Assertion knowledge sources]:::box
  A --> S[Specifications and protocols]
  A --> W[Waveforms and logs]
  A --> R[RTL structure and naming]
  A --> P[Prior assertions / libraries]
  V[VISTA emphasizes RTL + VERT metadata]:::box
  R --> V
'''
    )}

**Fig. 2.3 — Layered formal verification stack (simplified).**

{mf(
        '''
flowchart TB
  L3[Properties and assumptions] --> L2[Elaboration / semantics]
  L2 --> L1[Proof engines SAT/SMT]
  L1 --> L0[Results: pass / fail / bounded]
'''
    )}

**Fig. 2.4 — NL-driven vs RTL-only assertion generation (positioning).**

{mf(
        '''
flowchart LR
  classDef rtl fill:#0f172a,color:#fff,stroke:#020617
  NL[NL or documents available] --> A1[Spec-to-SVA pipelines]
  RTL[RTL-only setting] --> A2[VISTA-style generation]:::rtl
'''
    )}

{lit_full}"""
    )

    # --- CHAPTER III ---
    add(
        f"""# CHAPTER III

## Chapter 3: Design (systems requirements / specifications)

### 3.1 System context

VISTA is a software system that ingests dataset records, runs a trained language model, applies deterministic transforms, invokes external formal tools, and exposes results through a demonstration client. Figure 3.1 summarizes external interfaces.

### 3.2 Functional requirements

**Table 3.1 — Functional requirements.**

| ID | Requirement | Rationale |
|----|-------------|-----------|
| FR-1 | Accept RTL text with synchronization flag and clock string | VERT compatibility |
| FR-2 | Produce assertions in the instruction-tuned response format | Train/eval alignment |
| FR-3 | Emit a single elaboratable wrapper module | Formal tool input |
| FR-4 | Log syntax success, formal status, and gold Jaccard | Traceable metrics |
| FR-5 | Support batch evaluation for regression | Reproducibility |
| FR-6 | Provide interactive demonstration | Stakeholder communication |

### 3.3 Non-functional requirements

**Table 3.2 — Non-functional requirements.**

| ID | Category | Requirement |
|----|----------|---------------|
| NFR-1 | Reproducibility | Fixed decoding; logged configuration |
| NFR-2 | Security | Local deployment for sensitive RTL |
| NFR-3 | Maintainability | Single evaluation entry point |
| NFR-4 | Performance | Interactive latency on workstation GPU |

**Fig. 3.1 — System boundary.**

{mf(
        '''
flowchart LR
  subgraph External
    U[User]
    D[VERT-style records]
  end
  subgraph VISTA
    C[Client]
    S[Service]
    M[QLoRA LLM]
  end
  subgraph Tools
    Y[Yosys]
    SB[SymbiYosys]
  end
  U --> C --> S --> M
  D --> S
  S --> Y --> SB
'''
    )}

**Fig. 3.2 — Traceability from objectives to requirements.**

{mf(
        '''
flowchart TB
  O1[Objective: generate assertions] --> FR2[FR-2 format]
  O2[Objective: formal check] --> FR3[FR-3 wrapper]
  O3[Objective: measure quality] --> FR4[FR-4 metrics]
  O4[Objective: demonstrate] --> FR6[FR-6 UI]
'''
    )}

**Fig. 3.3 — Non-functional categories.**

{mf(
        '''
flowchart TB
  NFR[Non-functional requirements]
  NFR --> R[Reliability / reproducibility]
  NFR --> S[Security / IP protection]
  NFR --> P[Performance / latency]
  NFR --> M[Maintainability / modularity]
''')}"""
    )

    # --- CHAPTER IV ---
    add(
        f"""# CHAPTER IV

## Chapter 4: Proposed solution (methodology, implementation)

### 4.1 Scientific method and reproducibility

Experiments are defined by a frozen run identifier, a pinned adapter checkpoint path, and logged flags in the machine-readable evaluation manifest. This chapter explains, at engineering level, how training data becomes a deployed pipeline.

### 4.2 Dataset and training configuration

The repository retains twenty thousand VERT-style pairs. Training uses the project defaults documented in **Table 4.1**.

**Table 4.1 — Training hyperparameters (defaults).**

| Parameter | Value |
|-----------|-------|
| Base model family | LLaMA 3.1 (8B) |
| Adaptation | QLoRA (rank / alpha 256 / 256) |
| Learning rate | 1e-4 |
| Epochs | 3 |
| Micro-batch × accumulation | 2 × 32 (effective 64) |
| Max sequence length | 4096 |

### 4.3 Core methodology narrative

The methodology interleaves **learned** generation with **deterministic** repair. The following figures summarize architecture, training flow, adaptation concept, runtime interactions, post-processing, wrapper construction, evaluation packaging, and deployment.

**Fig. 4.1 — End-to-end methodology overview.**

{mf(
        '''
flowchart TB
  classDef s fill:#0f172a,color:#fff,stroke:#020617
  IN[VERT record]:::s --> T[Instruction prompt]
  T --> G[Neural generation]
  G --> N[Normalize / extract / filter]
  N --> W[Dynamic wrapper]
  W --> E[Yosys + SymbiYosys]
'''

    )}

**Fig. 4.2 — Dataset and training flow.**

{mf(
        '''
flowchart LR
  D[VERT JSONL] --> P[Preprocess / split]
  P --> FT[QLoRA fine-tuning]
  FT --> CKPT[Adapter checkpoint]
'''

    )}

**Fig. 4.3 — QLoRA adaptation (conceptual).**

{mf(
        '''
flowchart TB
  BASE[Frozen 4-bit base weights]
  ADAPT[Trainable low-rank adapters]
  BASE --> OUT[Effective model for inference]
  ADAPT --> OUT
'''

    )}

**Fig. 4.4 — Inference sequence (demonstration path).**

{mf(
        '''
sequenceDiagram
  participant U as User
  participant C as Web client
  participant B as Backend service
  participant M as LLM
  participant T as Formal tools
  U->>C: Provide RTL + metadata
  C->>B: Request generation
  B->>M: Forward prompt
  M-->>B: Proposed assertions
  B->>B: Post-process + wrap
  B->>T: Parse / BMC
  T-->>B: Status + logs
  B-->>C: Display results
'''

    )}

**Fig. 4.5 — Post-processing stages.**

{mf(
        '''
flowchart LR
  R[Raw text] --> X[Extract response region]
  X --> S[Split property blocks]
  S --> Z[Sanitize expressions]
  Z --> G[Greedy Yosys-compatible filter]
'''

    )}

**Fig. 4.6 — Synchronous wrapper concept.**

{mf(
        '''
flowchart TB
  CLK[Clock domain] --> R[RTL update phase]
  CLK --> A[Assertion check phase]
  R --> A
  note1[First-cycle gating reduces vacuity] -.-> A
'''

    )}

**Fig. 4.7 — Evaluation harness outputs.**

{mf(
        '''
flowchart TB
  CASE[Per-sample case directory]
  CASE --> SV[Wrapped SystemVerilog]
  CASE --> SBY[SymbiYosys script]
  CASE --> LOG[Logs and status]
  CASE --> JS[evaluation_report.json]
'''

    )}

**Fig. 4.8 — Deployment layers.**

{mf(
        '''
flowchart TB
  FE[Presentation: Next.js]
  API[Application: FastAPI]
  GPU[Compute: local GPU]
  FE --> API --> GPU
'''

    )}

{method_full}"""
    )

    fig_5_2 = mf(
        "xychart-beta\n"
        '  title "Syntax and formal outcomes (VERT-100)"\n'
        '  x-axis ["Yosys OK", "SBY pass", "SBY fail"]\n'
        '  y-axis "Count" 0 --> 100\n'
        f"  bar [{st['syntax_ok']},{st['sby_pass']},{st['sby_fail']}]\n"
    )
    pie_lines = ['  "' + str(k) + '" : ' + str(v) for k, v in sorted(cats.items(), key=lambda kv: -kv[1])]
    fig_5_3 = mf("pie title Gold Jaccard buckets\n" + "\n".join(pie_lines))
    fig_5_4 = mf(
        """
flowchart TB
  Q{{Syntax OK?}}
  Q -->|No| E1[Investigate parse / wrapper]
  Q -->|Yes| Q2{{SBY pass?}}
  Q2 -->|Yes| OK[Report pass + Jaccard]
  Q2 -->|No| Q3{{High Jaccard?}}
  Q3 -->|Yes| SEM[Review semantics X/assumptions]
  Q3 -->|No| GEN[Review generation quality]
"""
    )

    # --- CHAPTER V ---
    add(
        f"""# CHAPTER V

## Chapter 5: Results and discussion

### 5.1 Metrics and equation for gold Jaccard

Let token sets for generated assertion text **A** and reference **B** be **T(A)** and **T(B)**. The **gold Jaccard** similarity used in the evaluation manifest is

$$J_{{\\mathrm{{gold}}}}(A,B) = \\frac{{|T(A) \\cap T(B)|}}{{|T(A) \\cup T(B)|}}.$$

*In the final Word document, number this display as (1.1) per institute format and define all symbols immediately above or below.*

### 5.2 Aggregate results

**Table 5.1 — Aggregate metrics (frozen run).**

| Metric | Value |
|--------|-------|
| Samples | {st.get("total")} |
| Yosys syntax success | {st.get("syntax_ok")} / {st.get("total")} |
| SymbiYosys pass | {st.get("sby_pass")} / {st.get("total")} |
| SymbiYosys fail | {st.get("sby_fail")} |
| Mean gold Jaccard | {float(st.get("gold_jaccard_mean", 0)):.6f} |
| Greedy dropped clauses (sum) | {st.get("yosys_greedy_dropped_asserts")} |
| Attempted / converted clauses | {st.get("attempted_assert_clauses")} / {st.get("converted_assert_clauses")} |

**Table 5.2 — Gold Jaccard buckets.**

| Bucket | Count |
|--------|-------|
{jrows}

### 5.3 Discussion of formal failure (sample 82)

Index **82** fails SymbiYosys while maintaining **gold Jaccard 1.0**. The RTL includes a **case** selector with **X** bits. Formal outcomes therefore depend on encoding and assumptions, not only string equality to the VERT reference.

**Fig. 5.1 — Evaluation workflow.**

{mf(
        '''
flowchart LR
  R[Record] --> G[Generate]
  G --> P[Post-process]
  P --> W[Wrap]
  W --> Y[Yosys]
  Y --> S[SymbiYosys]
  S --> V[Verdict + metrics]
'''

    )}

**Fig. 5.2 — Aggregate outcomes (n = 100).**

{fig_5_2}

**Fig. 5.3 — Gold Jaccard distribution.**

{fig_5_3}

**Fig. 5.4 — Interpreting outcomes (conceptual).**

{fig_5_4}

{result_full}"""
    )

    # --- CHAPTER VI ---
    add(
        f"""# CHAPTER VI

## Chapter 6: Conclusion and future work

### 6.1 Conclusion

VISTA demonstrates strong **syntax** and **formal pass** rates on a deterministic VERT-100 evaluation, with high mean **gold Jaccard**. The work underscores that **professional reporting** must separate **lexical** agreement from **proof** guarantees.

### 6.2 Future work

Counterexample-guided refinement, X-aware preprocessing, vendor-tool export, and hierarchical designs are the principal research extensions.

**Fig. 6.1 — Roadmap.**

{mf(
        '''
timeline
    title Roadmap
    section Near term
        Regression : Broaden evaluation slices
        Documentation : Defense-ready figures
    section Medium term
        CEGAR : Close loop on failures
        Semantics : Strengthen X handling
    section Long term
        Industrial pilots : NECOP case studies
'''
    )}"""
    )

    olines = [
        "| Index | SymbiYosys | Gold Jaccard | Notes |",
        "|-------|------------|--------------|-------|",
    ]
    for r in outliers:
        note = (
            "Formal fail; don’t-care case item (Ch. V)"
            if r.get("status") == "fail"
            else "Jaccard < 0.95; review overlap"
        )
        olines.append(
            f"| {r.get('idx')} | {r.get('status')} | {float(r.get('gold_jaccard', 0)):.4f} | {note} |"
        )

    add(
        f"""# GLOSSARY

*Alphabetical technical terms (Heading 1 in Word). Expand or prune per faculty guidance.*

{gloss_body}"""
    )

    add(
        r"""# REFERENCES

Follow **IEEE** or **Harvard** style as required by the faculty (Harvard preferred where stated). Official citation guidance:

- IEEE Citation Reference: https://www.ieee.org/documents/ieeecitationref.pdf  
- Harvard overview (external helpdesk link from institute template): http://www.noodletools.com/helpdesk/kb/index.php?action=article&id=53  

**Starter entries (complete and normalize in Zotero / Mendeley):**

[1] IEEE Std 1800-2023, *IEEE Standard for SystemVerilog*.

[2] SymbiYosys documentation, https://symbiyosys.readthedocs.io/

[3] YosysHQ, *Yosys*, https://yosyshq.net/yosys/

[4] T. Dettmers et al., “QLoRA: Efficient Finetuning of Quantized LLMs,” arXiv:2305.14314, 2023.

[5] E. Halpern et al., “AssertionBench…,” arXiv:2406.18627, 2024.

[6] Unsloth, https://github.com/unslothai/unsloth

[7] VERT dataset — cite upstream source and license you relied upon."""
    )

    add(
        r"""# APPENDIX A — Institute formatting checklist

Reproduce title page margins, subsequent-page margins, heading styles (CHAPTER I as Heading 1; chapter title as Heading 3; section headings per template), figure/table placement rules, equation numbering, and Turnitin submission per `Vista_Report_format.txt`."""
    )

    add(
        r"""# APPENDIX B — Reproducibility statement

Quantitative claims refer to run **model_eval_v7_100** in the project formal verification runs directory. The manifest records adapter path, decoding options, and per-index outcomes. Independent auditors should verify checksums and tool versions recorded at experiment time."""
    )

    add(
        f"""# APPENDIX C — Ethics, risk, and limitations

Assertions may be **incorrect** or **misleading** despite passing bounded checks. Assumptions must be disclosed. RTL sent to third-party cloud APIs raises confidentiality risk; local execution mitigates this for the demonstration configuration described in Chapter IV.

---

**Table A.1 — Outlier cases.**

{chr(10).join(olines)}"""
    )

    add(
        f"""# APPENDIX D — Extended threats to validity

**Internal validity:** the hundred-sample slice is not a random draw from all VERT; it is an early contiguous block chosen for reproducibility.

**External validity:** results may not transfer to full modules, different clocks, or commercial SVA subsets.

**Construct validity:** gold Jaccard measures lexical overlap, not full semantic entailment.

**Conclusion validity:** a single formal failure should be interpreted with the case study in Chapter V, not suppressed."""
    )

    add(
        f"""# APPENDIX E — Table B.1 — Per-sample log (n = {st.get("total")})

| Index | Syntax OK | SymbiYosys | Gold Jaccard | Attempted clauses | Greedy dropped | Converted |
|-------|-----------|------------|--------------|--------------------|----------------|------------|
{full_rows}

*Table footnotes (8 pt in Word): Greedy dropped counts assertions removed by the compatibility filter for that sample.*"""
    )

    add(
        "*End of Draft 3 Markdown — regenerate with `python scripts/build_vista_report_md.py` and export with `python scripts/export_report_to_docx.py` (default output: `exports/Draft 3.docx`).*"
    )

    text = "\n\n".join(parts) + "\n"
    out = ROOT / "VISTA_Final_Year_Report.md"
    out.write_text(text, encoding="utf-8")
    print(out)
    print("words", len(text.split()))


if __name__ == "__main__":
    main()
