#!/usr/bin/env python3
"""
rebuild_report.py
Replaces every ASCII/box-art code block in Vista_Report.md
with a proper Mermaid diagram.  Run from the Report/ folder.
"""
import re
from pathlib import Path

SRC = Path(__file__).parent / "Vista_Report.md"
DST = Path(__file__).parent / "Vista_Report.md"   # overwrite in-place

TH = ('%%{init:{"theme":"base","themeVariables":{"primaryColor":"#1e3a5f",'
      '"primaryTextColor":"#ffffff","primaryBorderColor":"#0f2540",'
      '"secondaryColor":"#dbeafe","tertiaryColor":"#d1fae5",'
      '"lineColor":"#334155","fontFamily":"Times New Roman",'
      '"fontSize":"15px"}}}%%')


def block(diagram_body: str) -> str:
    """Wrap a Mermaid diagram body in fenced code markers."""
    return "```mermaid\n" + diagram_body + "\n```"


# Each entry: (unique snippet found in original ASCII block) -> new Mermaid block
DIAGRAMS: dict[str, str] = {}

# ── Fig 1.1  Hardware lifecycle ───────────────────────────────────────────────
DIAGRAMS["HARDWARE DESIGN LIFECYCLE"] = block(TH + """
flowchart LR
    A([Specification]) --> B([RTL Design])
    B --> C([Simulation])
    C --> D{Bugs found?}
    D -->|Yes| B
    D -->|No| E([Formal Verification])
    E --> F{Properties pass?}
    F -->|Fail| B
    F -->|Pass| G([Sign-off and Tapeout])
    style A fill:#1e3a5f,color:#fff,stroke:#0f2540
    style G fill:#0f766e,color:#fff,stroke:#065f46
    style D fill:#dc2626,color:#fff
    style F fill:#dc2626,color:#fff
    style E fill:#7c3aed,color:#fff""")

# ── Fig 1.2  System context ───────────────────────────────────────────────────
DIAGRAMS["SYSTEM CONTEXT DIAGRAM"] = block(TH + """
flowchart TB
    VE[Verification Engineer] -->|RTL and Clock info| VISTA
    STU[Student or Researcher] -->|Web Playground| VISTA
    IND[NECOP Industry] -->|Industrial Evaluation| VISTA
    subgraph VISTA [VISTA Platform]
        WEB[Next.js Frontend]
        API[FastAPI Backend]
        LLM[LLaMA 3.1 8B + QLoRA]
        POST[Post-Processing Pipeline]
        WRAP[Dynamic RTL Wrapper]
        WEB --> API --> LLM --> POST --> WRAP
    end
    WRAP -->|SystemVerilog| YS[Yosys Elaboration]
    YS --> SBY[SymbiYosys BMC]
    SBY -->|PASS or FAIL| API
    style LLM  fill:#1e3a5f,color:#fff
    style WRAP fill:#0f766e,color:#fff
    style SBY  fill:#7c3aed,color:#fff
    style VISTA fill:#f8fafc,stroke:#1e3a5f,stroke-width:2px""")

# ── Fig 2.1  Taxonomy ─────────────────────────────────────────────────────────
DIAGRAMS["ASSERTION GENERATION APPROACH TAXONOMY"] = block(TH + """
flowchart LR
    ROOT[Assertion Generation Approaches]
    ROOT --> M[Manual Authoring\nExpert-intensive]
    ROOT --> TM[Trace Mining\nGoldMine - Texada]
    ROOT --> SA[Static RTL Analysis\nHARM]
    ROOT --> NL[LLM + NL Specification\nSpec2Assertion - AssertLLM]
    ROOT --> RL[LLM from RTL Only\nVISTA]
    M  --> OUT[Assertion Set]
    TM --> OUT
    SA --> OUT
    NL --> OUT
    RL --> OUT
    style RL  fill:#1e3a5f,color:#fff,stroke:#0f2540
    style OUT fill:#0f766e,color:#fff
    style ROOT fill:#334155,color:#fff""")

# ── Fig 2.3  LLM comparison ───────────────────────────────────────────────────
DIAGRAMS["LLM-ASSISTED VERIFICATION"] = block(TH + """
flowchart LR
    LLM[Large Language Model]
    LLM --> S2A["Spec2Assertion\nRequires NL spec\nNo formal check"]
    LLM --> ALM["AssertLLM\nRequires spec + waveforms\nNo formal check"]
    LLM --> AFG["AssertionForge\nKnowledge graph\nLimited scale"]
    LLM --> VST["VISTA\nRTL only - no spec\nFormal check via SBY\n20k training pairs"]
    VST --> WRAP[Dynamic RTL Wrapper]
    WRAP --> FORMAL[SymbiYosys BMC\nPASS or FAIL]
    style VST   fill:#1e3a5f,color:#fff
    style WRAP  fill:#0f766e,color:#fff
    style FORMAL fill:#7c3aed,color:#fff""")

# ── Fig 2.4  QLoRA math ───────────────────────────────────────────────────────
DIAGRAMS["QLoRA Weight Composition"] = block(TH + """
flowchart TB
    subgraph BASE [Frozen Base Model  4-bit NF4 quantized]
        W0[W0 in R d x k\nLLaMA 3.1 8B weights\napprox 4 GB VRAM]
    end
    subgraph ADAPTERS [Trainable LoRA Adapters  r=256  alpha=256]
        A[A in R r x k\ninit Gaussian]
        B[B in R d x r\ninit zeros]
    end
    W0 --> MERGE[W = W0 + alpha over r times B times A\nEffective weight during forward pass]
    A  --> MERGE
    B  --> MERGE
    MERGE --> OUT[Token logits\nnext-token prediction]
    style W0    fill:#475569,color:#fff
    style MERGE fill:#1e3a5f,color:#fff
    style OUT   fill:#0f766e,color:#fff""")

# ── Fig 2.5  Formal tool stack ────────────────────────────────────────────────
DIAGRAMS["OPEN-SOURCE FORMAL VERIFICATION STACK"] = block(TH + """
flowchart TB
    SV[SystemVerilog plus SVA\nVISTA wrapper output]
    YS[Yosys\nread_verilog -formal\nElaborate and Optimise]
    BTOR[BTOR2\ninternal format]
    SBY[SymbiYosys\nOrchestration front-end\n.sby config]
    SMT[smtbmc\nSMT-based BMC\ndefault backend]
    ABC[abc\nSAT / simulation\nalternate backend]
    RES[Result\nPASS - FAIL - TIMEOUT - ERROR]
    SV   --> YS
    YS   --> BTOR
    BTOR --> SBY
    SBY  --> SMT
    SBY  --> ABC
    SMT  --> RES
    ABC  --> RES
    style SV  fill:#0f766e,color:#fff
    style RES fill:#1e3a5f,color:#fff
    style SBY fill:#7c3aed,color:#fff""")

# ── Fig 3.1  Use Case ─────────────────────────────────────────────────────────
DIAGRAMS["UML USE CASE DIAGRAM"] = block(TH + """
flowchart LR
    VE[Verification Engineer]
    STU[Student or Researcher]
    SUP[NECOP or Supervisor]
    DEV[Developer Admin]
    SBY2[SymbiYosys\nSecondary Actor]
    subgraph SYS [VISTA System Boundary]
        UC1[UC-01\nGenerate Assertions from RTL]
        UC2[UC-02\nRun Formal Verification]
        UC3[UC-03\nView Results on Web UI]
        UC4[UC-04\nBatch Evaluate VERT dataset]
        UC5[UC-05\nFine-tune Model Admin]
        UC1 -->|includes| UC2
    end
    VE   --> UC1
    VE   --> UC3
    STU  --> UC3
    SUP  --> UC4
    DEV  --> UC5
    SBY2 --> UC2
    style UC1 fill:#1e3a5f,color:#fff
    style UC2 fill:#7c3aed,color:#fff
    style SYS fill:#f8fafc,stroke:#1e3a5f,stroke-width:2px""")

# ── Fig 3.2  Component ────────────────────────────────────────────────────────
DIAGRAMS["UML COMPONENT DIAGRAM"] = block(TH + """
flowchart TB
    subgraph FE [Frontend Next.js 14 + Tailwind CSS]
        EDIT[Monaco RTL Code Editor]
        CTRL[Sync Toggle + Clock Input]
        DISP[Results Panel\nAssertions / Wrapper / Raw]
    end
    subgraph BE [Backend FastAPI Python]
        EP[POST /api/generate\nendpoint]
        ML[Model Loader\nsingleton on startup]
        PP[Post-Processing\nshared with eval script]
    end
    subgraph MODEL [Model Layer]
        LLAMA[LLaMA 3.1 8B\n4-bit NF4 quantized]
        QLORA[QLoRA Adapter\ncheckpoint-891\nr=256 alpha=256]
        LLAMA --- QLORA
    end
    subgraph FORMAL [Formal Layer]
        YOSYS[Yosys\nelaboration]
        SBY3[SymbiYosys\nBMC engine]
    end
    EDIT & CTRL --> EP
    EP  --> ML --> LLAMA
    ML  --> PP
    PP  --> YOSYS --> SBY3
    SBY3 --> DISP
    style LLAMA fill:#1e3a5f,color:#fff
    style SBY3  fill:#7c3aed,color:#fff
    style QLORA fill:#0f766e,color:#fff""")

# ── Fig 4.1  Package ──────────────────────────────────────────────────────────
DIAGRAMS["UML PACKAGE DIAGRAM"] = block(TH + """
flowchart TB
    subgraph ROOT [fyp_draft project root]
        subgraph DATA [data/]
            VERT[VERT.jsonl\napprox 20000 RTL-SVA pairs]
        end
        subgraph SCRIPTS [scripts/]
            FT[finetune_assertions.py]
            EVAL[evaluate_accuracy_sby.py]
            INF[test_inference.py]
        end
        subgraph OUTPUTS [outputs/]
            CKP891[checkpoint-891\nactive adapter]
            CKP500[checkpoint-500]
        end
        subgraph FV [formal_verification/]
            TPL[templates/\nprompt_v2 - .sby - wrapper.sv]
            RUNS[runs/\nmodel_eval_v7_100 etc]
        end
        subgraph WEB [web/]
            BACK[backend/\napp.py FastAPI]
            FRONT[frontend/\nNext.js + Tailwind]
        end
    end
    style ROOT   fill:#f8fafc,stroke:#1e3a5f,stroke-width:2px
    style CKP891 fill:#0f766e,color:#fff""")

# ── Fig 4.2  End-to-end pipeline ──────────────────────────────────────────────
DIAGRAMS["VISTA END-TO-END PIPELINE"] = block(TH + """
flowchart TD
    A([VERT Record\nCode, Assertion, Synchronous, Clock])
    B[Format Prompt\nTemplate v2]
    C[LLaMA 3.1 Inference\ngreedy - max_new_tokens=512]
    D[Raw Model Output]
    subgraph PP [Post-Processing Pipeline]
        P1[1. Extract Assertion Region\nsplit at Response boundary]
        P2[2. Split Property Blocks\nregex property to endproperty]
        P3[3. Sanitize Expressions\nremove ##n, fix ===, strip clock]
        P4[4. Greedy Yosys Filter\nmax valid clauses]
        P1 --> P2 --> P3 --> P4
    end
    E[Dynamic RTL Wrapper\nsignal inference, clock, _started]
    F{Yosys Parse\nsyntax OK?}
    G[SymbiYosys BMC\nsmtbmc depth 8]
    H[Record in\nevaluation_report.json]
    A --> B --> C --> D --> P1
    P4 --> E --> F
    F -->|Pass| G --> H
    F -->|Fail| P4
    style C  fill:#1e3a5f,color:#fff
    style E  fill:#0f766e,color:#fff
    style G  fill:#7c3aed,color:#fff
    style PP fill:#f8fafc,stroke:#334155""")

# ── Fig 4.4  Training data ────────────────────────────────────────────────────
DIAGRAMS["TRAINING DATA PREPARATION"] = block(TH + """
flowchart LR
    J[VERT.jsonl\napprox 20000 records]
    SPL[train_test_split\n95 percent / 5 percent  seed=42]
    TR[Training set\napprox 19000 records]
    VA[Validation set\napprox 1000 records]
    FMT[format_example\nInstruction + Response format]
    TOK[tokenize_batch\nmax_length=4096  padding=max_length]
    FT[Unsloth QLoRA Fine-Tuning\n3 epochs - BF16]
    CK[checkpoint-891\nadapter weights saved]
    J --> SPL
    SPL --> TR & VA
    TR --> FMT --> TOK --> FT --> CK
    style FT fill:#1e3a5f,color:#fff
    style CK fill:#0f766e,color:#fff""")

# ── Fig 4.5  Class QLoRA ──────────────────────────────────────────────────────
DIAGRAMS["UML CLASS DIAGRAM — QLoRA"] = block(TH + """
classDiagram
    class FastLanguageModel {
        +model_name str
        +load_in_4bit bool
        +max_seq_length int
        +use_gradient_checkpointing bool
        +from_pretrained() Model
        +get_peft_model() PeftModel
        +for_inference() void
    }
    class LlamaForCausalLM {
        +embed_tokens Embedding
        +layers List~LlamaLayer~
        +norm RMSNorm
        +lm_head Linear
    }
    class LoraConfig {
        +r int = 256
        +lora_alpha int = 256
        +lora_dropout float = 0.0
        +bias str = none
        +target_modules List~str~
    }
    class UnslothTrainer {
        +model PeftModel
        +train_dataset Dataset
        +eval_dataset Dataset
        +args TrainingArguments
        +train() void
    }
    FastLanguageModel --> LlamaForCausalLM : creates
    LlamaForCausalLM --> LoraConfig : has adapters
    UnslothTrainer --> LlamaForCausalLM : trains""")

# ── Fig 4.6  Loss curve ───────────────────────────────────────────────────────
DIAGRAMS["Training loss curve"] = block(TH + """
xychart-beta
    title "Training Loss - LLaMA 3.1 QLoRA Fine-Tuning (3 Epochs)"
    x-axis ["Start", "Step 100", "Step 200", "Step 300", "Step 400", "Step 500", "Step 600", "Step 700", "Step 891"]
    y-axis "Cross-Entropy Loss" 0 --> 3
    line [2.8, 2.1, 1.7, 1.3, 1.0, 0.85, 0.75, 0.68, 0.62]""")

# ── Fig 4.7  Sequence inference ───────────────────────────────────────────────
DIAGRAMS["UML SEQUENCE DIAGRAM — Interactive Inference"] = block(TH + """
sequenceDiagram
    participant CL as Client Browser
    participant FA as FastAPI Backend
    participant ML as ModelLoader
    participant LM as LLaMA 3.1 + QLoRA
    participant PP as PostProcessor
    participant SY as SymbiYosys
    CL->>FA: POST /api/generate code sync clock
    FA->>ML: check ready
    ML-->>FA: ready = True
    FA->>FA: format_inference_prompt()
    FA->>LM: generate tokens max_new_tokens=512
    LM-->>FA: raw_output
    FA->>PP: extract_assertions(raw_output)
    PP->>PP: sanitize + greedy_filter()
    PP->>PP: build_sv_wrapper()
    PP-->>FA: final_assertions and wrapper_sv
    FA->>SY: run sby depth=8
    SY-->>FA: PASS or FAIL
    FA-->>CL: GenerateResponse assertions verdict latency""")

# ── Fig 4.8  Post-processing ──────────────────────────────────────────────────
DIAGRAMS["POST-PROCESSING PIPELINE — DETAILED"] = block(TH + """
flowchart TD
    IN[Raw Model Output]
    subgraph EXTRACT [Stage 1 - Region Extraction]
        E1[Split at Response boundary\nRemove prompt echo]
    end
    subgraph SPLIT [Stage 2 - Assertion Extraction]
        PA[Path A: Balanced assert statements]
        PB[Path B: property to endproperty blocks]
        PB2[Path B2: Line-terminated properties]
        PC[Path C: Line-based fallback]
    end
    subgraph CONV [Stage 3 - Property to Immediate Conversion]
        C1[A or B becomes not-A or B]
        C2[Boolean bodies pass through]
    end
    subgraph SAN [Stage 4 - Expression Sanitization]
        S1[Remove ##n cycle delays]
        S2[Normalize === to ==]
        S3[Strip clock annotations]
        S4[Replace $past $rose with 1b1]
        S5[Remove disable iff reset]
        S1 --> S2 --> S3 --> S4 --> S5
    end
    subgraph GRDY [Stage 5 - Greedy Yosys Filter]
        G1[For each clause:\nbuild_wrapper + yosys_parse\nkeep if OK else drop]
        G2[Empty result - fallback to assert 1b1]
        G1 --> G2
    end
    OUT[Final assertion set\nguaranteed parseable]
    IN --> E1 --> PA & PB & PB2 & PC
    PA & PB & PB2 & PC --> C1 & C2
    C1 & C2 --> S1
    S5 --> G1
    G2 --> OUT
    style OUT fill:#0f766e,color:#fff
    style IN  fill:#1e3a5f,color:#fff""")

# ── Fig 4.9  State machine ────────────────────────────────────────────────────
DIAGRAMS["UML STATE MACHINE — ASSERTION EXTRACTION"] = block(TH + """
stateDiagram-v2
    [*] --> Scanning
    Scanning --> InProperty : property keyword found
    InProperty --> CompleteBlock : endproperty found
    InProperty --> LineTerminated : semicolon and no endproperty
    InProperty --> Scanning : EOF with no match
    CompleteBlock --> Candidate : convert_property_to_immediate
    LineTerminated --> Candidate : convert_property_to_immediate
    Candidate --> Sanitizing : expression extracted
    Sanitizing --> YosysTest : sanitize_assert_expression
    YosysTest --> Accepted : Yosys parse OK
    YosysTest --> Dropped : Yosys parse failed
    Accepted --> Scanning : try next candidate
    Dropped --> Scanning : try next candidate
    Accepted --> [*] : all candidates processed
    Dropped --> [*] : all candidates processed""")

# ── Fig 4.10  Sync wrapper ────────────────────────────────────────────────────
DIAGRAMS["DYNAMIC WRAPPER — SYNCHRONOUS TEMPLATE STRUCTURE"] = block(TH + """
flowchart TB
    subgraph MOD [module vert_formal_wrap - Synchronous]
        DECL[Signal Declarations\nlogic clk rst _started\nplus all RTL and assertion identifiers]
        INIT[Initial Block\nzero-init all signals if init_rst_zero=true]
        subgraph RTL_BLK [always at posedge clk - RTL block]
            RTL[RTL Fragment\nfrom VERT Code field]
        end
        subgraph ASSERT_BLK [always at posedge clk - Assertion block]
            GATE{_started?}
            SET[_started equals 1\nfirst cycle skip check]
            CHK[assert clause_1\nassert clause_2\nand so on]
            GATE -->|No| SET
            GATE -->|Yes| CHK
        end
    end
    DECL --> INIT --> RTL_BLK
    INIT --> ASSERT_BLK
    style MOD fill:#f8fafc,stroke:#1e3a5f,stroke-width:2px
    style CHK fill:#0f766e,color:#fff""")

# ── Fig 4.11  Comb wrapper ────────────────────────────────────────────────────
DIAGRAMS["DYNAMIC WRAPPER — COMBINATIONAL TEMPLATE"] = block(TH + """
flowchart TB
    subgraph MOD2 [module vert_formal_wrap - Combinational]
        DECL2[Signal Declarations\nno clock or reset needed]
        subgraph COMB_BLK [always star - Combined RTL and assertions]
            RTL2[RTL Fragment]
            CHK2[assert clause_1\nassert clause_2\ninline no gating needed]
        end
    end
    DECL2 --> COMB_BLK
    style MOD2 fill:#f8fafc,stroke:#0f766e,stroke-width:2px
    style CHK2 fill:#0f766e,color:#fff""")

# ── Fig 4.12  Harness artifacts ───────────────────────────────────────────────
DIAGRAMS["FORMAL EVALUATION ARTEFACTS"] = block(TH + """
flowchart LR
    subgraph RUN [formal_verification/runs/model_eval_v7_100/]
        REP[evaluation_report.json\naggregated metrics]
        TPL2[prompt_template_used.txt\nsnapshot]
        subgraph C1 [case_001/]
            SV1[vert_formal_wrap.sv]
            SBY1[run.sby]
            LOG1[sby_log.txt]
        end
        subgraph C2 [case_002 to case_100/]
            SV2[same structure]
        end
    end
    SV1 & SBY1 --> LOG1
    C1 & C2 --> REP
    style REP fill:#1e3a5f,color:#fff
    style RUN fill:#f8fafc,stroke:#1e3a5f,stroke-width:2px""")

# ── Fig 4.13  Sequence formal ─────────────────────────────────────────────────
DIAGRAMS["UML SEQUENCE DIAGRAM — Formal Evaluation Run"] = block(TH + """
sequenceDiagram
    participant ES as EvalScript
    participant CD as case_NNN Directory
    participant YS as Yosys
    participant SBY as SymbiYosys
    participant SMT as smtbmc
    ES->>CD: write vert_formal_wrap.sv
    ES->>CD: write run.sby
    ES->>SBY: invoke sby run.sby
    SBY->>YS: read_verilog -formal
    YS-->>SBY: BTOR2 and properties
    SBY->>SMT: pass BTOR2
    SMT->>SMT: SMT encoding depth 8
    SMT-->>SBY: PASS or FAIL with trace
    SBY-->>ES: verdict
    ES->>CD: write sby_log.txt
    ES->>ES: update evaluation_report.json""")

# ── Fig 4.14  Class FastAPI ───────────────────────────────────────────────────
DIAGRAMS["UML CLASS DIAGRAM — FastAPI"] = block(TH + """
classDiagram
    class GenerateRequest {
        +code str
        +synchronous bool = True
        +clock str = None
        +max_new_tokens int = 512
        +run_formal bool = True
        +depth int = 8
    }
    class GenerateResponse {
        +raw_output str
        +model_assertions list
        +pre_greedy_assertions list
        +final_assertions list
        +greedy_dropped int
        +wrapper_sv str
        +syntax_ok bool
        +formal_status str
        +latency_ms int
        +adapter_dir str
        +is_fallback bool
        +pipeline_stage str
    }
    class HealthResponse {
        +ready bool
        +adapter_dir str
        +yosys_ok bool
        +sby_ok bool
    }
    class VISTAApp {
        +generate(req GenerateRequest) GenerateResponse
        +health() HealthResponse
    }
    VISTAApp --> GenerateRequest : accepts
    VISTAApp --> GenerateResponse : returns
    VISTAApp --> HealthResponse : returns""")

# ── Fig 4.15  Sequence web ────────────────────────────────────────────────────
DIAGRAMS["UML SEQUENCE DIAGRAM — Web Request Lifecycle"] = block(TH + """
sequenceDiagram
    participant BR as Browser
    participant NJ as Next.js Frontend
    participant FA as FastAPI Backend
    participant PP as Pipeline evaluate_accuracy_sby
    participant SY as SymbiYosys
    BR->>NJ: User submits RTL and options
    NJ->>FA: POST /api/generate JSON
    FA->>PP: format_prompt + LLaMA.generate
    PP-->>FA: raw_output
    FA->>PP: extract + sanitize + greedy_filter
    PP-->>FA: final_assertions and wrapper_sv
    FA->>SY: run_sby wrapper_sv depth=8
    SY-->>FA: PASS or FAIL
    FA-->>NJ: GenerateResponse JSON
    NJ-->>BR: Render tabs Assertions Wrapper Raw""")

# ── Fig 5.1  Bar metrics ──────────────────────────────────────────────────────
DIAGRAMS["Metric Results (out of 100 samples)"] = block(TH + """
xychart-beta
    title "VISTA Evaluation Outcomes - model_eval_v7_100 (n=100)"
    x-axis ["Yosys Syntax OK", "SymbiYosys PASS", "Exact Match J=1.0", "SBY FAIL"]
    y-axis "Count out of 100 samples" 0 --> 100
    bar [100, 99, 89, 1]""")

# ── Fig 5.2  Histogram Jaccard ────────────────────────────────────────────────
DIAGRAMS["Gold Jaccard Similarity Distribution (n=100)"] = block(TH + """
xychart-beta
    title "Gold Jaccard Similarity Distribution (n=100)"
    x-axis ["J = 1.0 exact", "J 0.95 to 0.999", "J 0.90 to 0.949", "J less than 0.90"]
    y-axis "Number of Samples" 0 --> 100
    bar [89, 1, 9, 1]""")

# ── Fig 5.3  Pie Jaccard ──────────────────────────────────────────────────────
DIAGRAMS["Gold Jaccard Similarity (n=100)"] = block(TH + """
pie title Gold Jaccard Similarity - VERT-100
    "Exact match J=1.0  89 percent" : 89
    "High J=0.90 to 0.949  9 percent" : 9
    "Near J=0.95 to 0.999  1 percent" : 1
    "Low J less than 0.90  1 percent" : 1""")

# ── Fig 5.4  Clause stats ─────────────────────────────────────────────────────
DIAGRAMS["Assertion Clause Statistics (VERT-100"] = block(TH + """
xychart-beta
    title "Assertion Clause Statistics - model_eval_v7_100"
    x-axis ["Total Attempted", "Total Converted", "Greedy Dropped", "Avg per Sample x10"]
    y-axis "Count" 0 --> 500
    bar [472, 472, 14, 47]""")

# ── Fig 5.5  Sample 82 decision ───────────────────────────────────────────────
DIAGRAMS["SAMPLE 82 — FAILURE ROOT CAUSE"] = block(TH + """
flowchart TD
    A([Sample 82 enters evaluation])
    B{Yosys parse?}
    C{SymbiYosys BMC?}
    D{Gold Jaccard?}
    E[Not a generation error\ninvestigate RTL construct]
    G[case with 6 bit x000x0\ndon-t-care bits X]
    H[BMC uses 2-valued semantics\nX treated as fixed 0 or 1\nMismatch with designer intent]
    ROOT[ROOT CAUSE\nFour-valued logic in case selector\nvs two-valued BMC semantics]
    FIX[FIX\nPreprocess X-bits to binary masks\nor add environment assumptions]
    A --> B
    B -->|PASS| C
    B -->|FAIL| ROOT
    C -->|PASS| D
    C -->|FAIL| D
    D -->|J = 1.0 perfect match| E
    E --> G --> H --> ROOT --> FIX
    style ROOT fill:#dc2626,color:#fff,stroke:#991b1b
    style FIX  fill:#0f766e,color:#fff
    style A    fill:#1e3a5f,color:#fff""")

# ── Fig 5.6  Run progression ──────────────────────────────────────────────────
DIAGRAMS["SBY Pass Rate Progression (selected runs)"] = block(TH + """
xychart-beta
    title "SymbiYosys Pass Rate Across Evaluation Runs"
    x-axis ["vert50", "vert50_v3", "vert50_v5", "v6_100", "v7_smoke2", "v7_100"]
    y-axis "SBY Pass Rate percent" 0 --> 100
    line [30, 55, 70, 43, 100, 99]""")

# ── Fig 6.1  Roadmap ──────────────────────────────────────────────────────────
DIAGRAMS["VISTA RESEARCH ROADMAP"] = block(TH + """
timeline
    title VISTA Research Roadmap
    section Near Term  0 to 6 months
        X-bit preprocessing   : Expand don-t-care selectors to binary masks
        Expanded evaluation   : 500 to 1000 VERT samples for stability check
        AssertionBench eval   : Out-of-distribution module generalization
    section Medium Term  6 to 18 months
        CEGAR loop            : Use SBY counterexamples to refine assertions
        NECOP pilot           : Evaluate on real industrial IP blocks
        Commercial tools      : Export to JasperGold and OneSpin format
    section Long Term  18 plus months
        Hierarchical RTL      : Multi-module assume-guarantee reasoning
        RL from formal        : Train to maximize SBY pass rate directly
        NL spec generation    : Reverse VISTA - assertions to English specs""")


# ── Replacement engine ────────────────────────────────────────────────────────

def apply_replacements(md: str) -> str:
    # Match fenced blocks (non-greedy, handles nested content)
    block_re = re.compile(r"```[^\n]*\n(.*?)```", re.S)

    def replacer(m: re.Match) -> str:
        body = m.group(1)
        # Check first 400 chars for any key
        head = body[:400]
        for key, new_block in DIAGRAMS.items():
            if key in head:
                return new_block
        return m.group(0)   # unchanged

    return block_re.sub(replacer, md)


def main() -> None:
    print(f"Reading: {SRC}")
    md  = SRC.read_text(encoding="utf-8")
    md2 = apply_replacements(md)
    DST.write_text(md2, encoding="utf-8")
    mermaid_count = md2.count("```mermaid")
    print(f"Mermaid blocks in output: {mermaid_count}")
    print(f"Written: {DST}  ({DST.stat().st_size // 1024} KB)")


if __name__ == "__main__":
    main()
