"""Topic lists and diagram snippets for Draft 3 report (~90 pages when typeset in Word)."""

# Each title becomes a subsection with auto-expanded prose in build_vista_report_md.py
LITERATURE_TOPICS = """
Model checking and temporal logics
SAT-based and SMT-based bounded model checking
Inductive proof obligations and k-induction
SystemVerilog assertions in industrial flows
Assertion mining from simulation traces
Static analysis and invariant inference
GoldMine-style property discovery
Natural-language to assertion translation
Waveform-assisted assertion learning
Knowledge graphs and design intent alignment
AssertionBench and comparable benchmarks
The VERT corpus and fragment-level RTL
Open-source formal stacks (Yosys, SymbiYosys)
Vacuity, coverage, and meaningful formal results
Reset and initialization assumptions in BMC
Clock-domain alignment for concurrent assertions
Four-valued logic and X-propagation in formal runs
Parameter-efficient fine-tuning survey
QLoRA and memory-efficient adaptation
Instruction tuning for code and hardware domains
Evaluation contamination and benchmark hygiene
Reproducibility in ML-for-EDA research
Industrial adoption barriers for formal methods
NECOP-relevant verification productivity themes
Energy footprint of large-model training
Security of RTL when using local vs cloud inference
Documentation and traceability for student projects
Limitations of lexical similarity metrics
Counterexample-guided assertion refinement
Assume–guarantee and modular verification outlook
""".strip().splitlines()

METHOD_TOPICS = """
Dataset curation and VERT record schema
Train/validation partitioning and leakage control
Prompt design and instruction–response alignment
Tokenization effects on hardware identifiers
LoRA adapter placement and trainable blocks
Optimizer choice and learning-rate schedules
Gradient accumulation and effective batch size
Mixed precision and numerical stability
Checkpoint selection and early stopping heuristics
Greedy decoding versus sampling for verification
Assertion extraction from verbose model outputs
Syntax sanitization for formal front ends
Temporal lowering and tool dialect mismatches
Greedy subset selection under parse constraints
Signal inference from RTL and assertion text
Keyword filtering and false signal candidates
Synchronous harness construction and two-phase updates
Combinational harness construction with always_comb semantics
First-cycle gating and vacuity mitigation
SymbiYosys engine configuration and proof depth
Per-case artifacts and regression packaging
Web demonstration architecture and separation of concerns
Operational security for proprietary RTL
""".strip().splitlines()

RESULT_TOPICS = """
Reporting syntax success versus semantic proof
Interpreting SymbiYosys pass and fail verdicts
Gold Jaccard as a lexical alignment metric
Correlation between Jaccard and formal pass rate
Outlier analysis for low-Jaccard samples
Formal failure with high Jaccard: case semantics
Effect of greedy assertion filtering on yield
Clause-level counts and aggregation in the manifest
Bounded depth and completeness caveats
Threats to internal validity of the evaluation slice
Threats to external validity beyond VERT
Comparison to AssertionBench-style claims
Industrial metrics: review effort and time saved
Reproducibility checklist for independent auditors
Future statistical tests and confidence intervals
""".strip().splitlines()

SUPPLEMENT_CH2 = """
Industrial verification metrics beyond pass rate
Regression hygiene for ML-assisted flows
Cross-corpus transfer and domain shift
Replicability of OSS CAD versions
Peer review expectations for ML-for-EDA
Documentation standards for FYP repositories
Turnitin and originality checks prior to submission
Defense materials alignment with thesis claims
""".strip().splitlines()

SUPPLEMENT_CH4 = """
Logging and experiment tracking practices
Version pinning for PyTorch and CUDA drivers
Timeout policies for long-running formal jobs
Unit tests for parsing and extraction
Continuous integration for evaluation scripts
Checksum verification for datasets
""".strip().splitlines()

SUPPLEMENT_CH5 = """
Replication package structure for conferences
Archiving SymbiYosys logs for long-term audit
Redaction of proprietary RTL in appendices
""".strip().splitlines()

GLOSSARY_ENTRIES = [
    ("Assertion", "A Boolean or temporal expression checked during simulation or formal analysis."),
    ("BMC", "Bounded model checking: search for property violations up to a fixed temporal depth."),
    ("CEX", "Counterexample: a witness trace showing how a property can fail."),
    ("Clocking", "Rules that specify when signals and assertions are sampled."),
    ("Coverage", "Metrics indicating which design behaviors were exercised."),
    ("Disable iff", "SVA construct that suspends property evaluation under a condition."),
    ("Elaboration", "Compilation phase that builds a netlist-like model from RTL."),
    ("FSM", "Finite-state machine, often a target for temporal properties."),
    ("Formal", "Mathematical analysis of a model against properties."),
    ("Gold reference", "Expert or dataset-provided target output for comparison."),
    ("Harness", "Wrapper module that supplies context for fragment-level RTL."),
    ("Induction", "Proof technique generalizing from bounded unrolling."),
    ("Jaccard", "Set overlap measure; here applied to token sets of assertions."),
    ("LoRA", "Low-rank adaptation of weight updates in a subset of layers."),
    ("PEFT", "Parameter-efficient fine-tuning family including LoRA and QLoRA."),
    ("Property", "Named SVA construct grouping temporal behavior."),
    ("QLoRA", "Quantized LoRA training on a low-bit base model representation."),
    ("RTL", "Register-transfer level hardware description."),
    ("Reset", "Signal or protocol returning the design to a known state."),
    ("SMT", "Satisfiability modulo theories used by many model checkers."),
    ("SVA", "IEEE 1800 SystemVerilog Assertions language features."),
    ("SymbiYosys", "Front-end driver for Yosys-based formal proof flows."),
    ("Temporal operator", "Construct relating behavior across clock cycles."),
    ("Token", "Minimal text unit used in lexical similarity computation."),
    ("VERT", "Dataset pairing RTL fragments with reference assertions."),
    ("Vacuity", "Situation where a property holds trivially and hides bugs."),
    ("Wrapper", "Generated module enclosing dataset RTL for tools."),
    ("X-propagation", "Behavior of unknown logic values through expressions."),
    ("Yosys", "Open-source RTL synthesis and formal elaboration tool."),
    ("Adapter weights", "Trainable tensors added by LoRA/QLoRA to a frozen base."),
    ("Batch size", "Number of sequences processed per optimization step."),
    ("Epoch", "One full pass over the training split."),
    ("Greedy filter", "Iterative assertion retention subject to parse success."),
    ("Inference", "Forward pass of the model to generate new text."),
    ("Learning rate", "Step size multiplier for gradient updates."),
    ("Perplexity", "Exponentiated average negative log-likelihood on held-out text."),
    ("Quantization", "Reduced numeric precision for weights or activations."),
    ("Sequence length", "Maximum tokens per training or inference example."),
    ("Supervised fine-tuning", "Training on input–output pairs to imitate a task."),
    ("Tokenizer", "Component mapping text to model vocabulary indices."),
    ("Unsloth", "Training acceleration library used for LLaMA-family tuning."),
    ("Web client", "Browser UI used in the VISTA demonstration."),
    ("FastAPI", "Python web framework hosting inference in the demo stack."),
    ("Next.js", "React framework used for the demonstration front end."),
    ("OSS CAD Suite", "Packaged open-source digital design tools including Yosys."),
    ("SDG", "United Nations Sustainable Development Goal."),
    ("IEEE 1800", "SystemVerilog language standard."),
    ("NECOP", "Industrial collaboration program supporting this project."),
    ("GIKI", "Ghulam Ishaq Khan Institute of Engineering Sciences and Technology."),
]
