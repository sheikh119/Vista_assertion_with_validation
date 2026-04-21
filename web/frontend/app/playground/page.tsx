"use client";

import { useEffect, useRef, useState } from "react";
import {
  Loader2, Sparkles, RotateCcw, ChevronDown,
  ShieldCheck, Target, CheckCircle2, Gauge,
} from "lucide-react";
import CodeEditor from "@/components/CodeEditor";
import ResultsPanel from "@/components/ResultsPanel";
import Toggle from "@/components/Toggle";
import StatCard from "@/components/StatCard";
import { generateAssertions, getHealth, type GenerateResponse, type HealthResponse } from "@/lib/api";
import { examples } from "@/lib/examples";
import { cn } from "@/lib/utils";

export default function PlaygroundPage() {
  const [code,       setCode]       = useState<string>(examples[0].code);
  const [synchronous,setSync]       = useState<boolean>(examples[0].synchronous);
  const [clock,      setClock]      = useState<string>(examples[0].clock ?? "");

  const [busy,    setBusy]    = useState(false);
  const [result,  setResult]  = useState<GenerateResponse | null>(null);
  const [error,   setError]   = useState<string | null>(null);
  const [health,  setHealth]  = useState<HealthResponse | null>(null);
  const abortRef = useRef<AbortController | null>(null);

  useEffect(() => {
    getHealth().then(setHealth).catch(() => setHealth(null));
  }, []);

  const loadExample = (id: string) => {
    const ex = examples.find((e) => e.id === id);
    if (!ex) return;
    setCode(ex.code);
    setSync(ex.synchronous);
    setClock(ex.clock ?? "");
    setResult(null);
    setError(null);
  };

  const submit = async () => {
    setBusy(true);
    setError(null);
    setResult(null);
    abortRef.current?.abort();
    const ac = new AbortController();
    abortRef.current = ac;
    try {
      const res = await generateAssertions(
        {
          code,
          synchronous,
          clock: clock.trim() || null,
          run_formal: false, // SymbiYosys check disabled in the UI
        },
        ac.signal,
      );
      setResult(res);
    } catch (e: any) {
      setError(e?.message ?? "Unknown error");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="flex flex-col gap-6 pb-16 pt-10">
      {/* Page header */}
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-white sm:text-3xl">
            Playground
          </h1>
          <p className="mt-1 text-sm text-gray-400">
            Paste an RTL fragment, choose clocking, and generate SystemVerilog assertions.
          </p>
        </div>
        <HealthPill health={health} />
      </div>

      {/* Layout: inputs | outputs */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-[minmax(0,1fr)_minmax(0,1fr)]">
        {/* ------------------------------ INPUT SIDE ----------------------------- */}
        <div className="card flex h-full min-h-[560px] flex-col">
          {/* Control bar */}
          <div className="flex flex-wrap items-center justify-between gap-3 border-b border-white/5 p-4">
            <div className="flex items-center gap-2">
              <label className="label">RTL input</label>
              <span className="chip">SystemVerilog</span>
            </div>
            <div className="flex items-center gap-2">
              <ExampleDropdown onSelect={loadExample} />
              <button
                onClick={() => { setCode(""); setResult(null); setError(null); }}
                className="btn-ghost !px-2.5 !py-1.5"
                title="Clear"
              >
                <RotateCcw className="h-3.5 w-3.5" />
              </button>
            </div>
          </div>

          {/* Editor */}
          <div className="h-[360px] p-3 sm:h-[440px]">
            <CodeEditor value={code} onChange={setCode} />
          </div>

          {/* Metadata + submit */}
          <div className="grid grid-cols-1 gap-4 border-t border-white/5 p-4 sm:grid-cols-2">
            <div>
              <div className="label mb-1.5">Clock</div>
              <input
                type="text"
                value={clock}
                onChange={(e) => setClock(e.target.value)}
                placeholder="posedge clk  (or leave empty)"
                className="w-full rounded-md border border-white/10 bg-white/[0.03] px-3 py-2 font-mono text-sm text-gray-200 outline-none transition-colors focus:border-brand-400/60 focus:bg-white/[0.05]"
                disabled={!synchronous}
              />
            </div>
            <div className="flex items-end">
              <Toggle
                checked={synchronous}
                onChange={setSync}
                label="Synchronous"
                description="Clocked design"
              />
            </div>

            <div className="sm:col-span-2 flex items-center justify-end pt-2">
              <button
                onClick={submit}
                disabled={busy || !code.trim()}
                className={cn(
                  "btn-primary min-w-[170px]",
                  busy && "!bg-none !bg-white/5 !text-gray-400",
                )}
              >
                {busy ? (
                  <>
                    <Loader2 className="h-4 w-4 animate-spin" />
                    Generating…
                  </>
                ) : (
                  <>
                    <Sparkles className="h-4 w-4" />
                    Generate Assertions
                  </>
                )}
              </button>
            </div>
          </div>
        </div>

        {/* ------------------------------ OUTPUT SIDE ---------------------------- */}
        <div className="min-h-[560px]">
          {error && (
            <div className="card border-red-400/20 bg-red-500/[0.04] p-4 text-sm text-red-300">
              <div className="font-semibold">Request failed</div>
              <div className="mt-1 font-mono text-[12px] text-red-300/80">{error}</div>
            </div>
          )}

          {!error && !result && !busy && <EmptyState />}
          {!error && !result &&  busy && <BusyState />}
          {!error &&  result && <ResultsPanel result={result} />}
        </div>
      </div>

      {/* --------------------------- BENCHMARK STATS --------------------------- */}
      <section className="mt-10 animate-fade-up">
        <div className="mb-6 flex items-end justify-between">
          <div>
            <h2 className="text-xl font-semibold tracking-tight text-white sm:text-2xl">
              Benchmarked on 100 VERT samples
            </h2>
            <p className="mt-1 text-sm text-gray-400">
              Evaluated end-to-end with SymbiYosys BMC at depth 8.
            </p>
          </div>
        </div>
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
          <StatCard
            label="SBY Pass"     value="99%"
            caption="99 / 100 formal verifications"
            icon={ShieldCheck} tone="brand"
          />
          <StatCard
            label="Gold Jaccard" value="0.991"
            caption="Token-level similarity"
            icon={Target}      tone="violet"
          />
          <StatCard
            label="Exact Match"  value="89%"
            caption="Verbatim identical to gold"
            icon={CheckCircle2} tone="teal"
          />
          <StatCard
            label="Avg Latency"  value="< 25s"
            caption="Per case on RTX 4090"
            icon={Gauge}        tone="cyan"
          />
        </div>
      </section>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Sub-components
// ---------------------------------------------------------------------------
function HealthPill({ health }: { health: HealthResponse | null }) {
  if (!health) {
    return (
      <span className="chip text-gray-400">
        <span className="h-1.5 w-1.5 rounded-full bg-gray-500" />
        Backend: offline
      </span>
    );
  }
  const ok = health.ready;
  return (
    <div className="flex flex-wrap items-center gap-2">
      <span className={cn("chip", ok ? "text-emerald-300" : "text-amber-300")}>
        <span className={cn(
          "h-1.5 w-1.5 rounded-full",
          ok ? "bg-emerald-400 animate-pulse-slow" : "bg-amber-400",
        )} />
        Model: {ok ? "ready" : "loading"}
      </span>
      <span className={cn("chip", health.has_yosys ? "text-emerald-300" : "text-gray-400")}>
        Yosys: {health.has_yosys ? "ok" : "missing"}
      </span>
    </div>
  );
}

function ExampleDropdown({ onSelect }: { onSelect: (id: string) => void }) {
  const [open, setOpen] = useState(false);
  return (
    <div className="relative">
      <button
        onClick={() => setOpen((o) => !o)}
        className="btn-ghost !px-3 !py-1.5 text-xs"
      >
        Examples
        <ChevronDown className={cn("h-3.5 w-3.5 transition-transform", open && "rotate-180")} />
      </button>
      {open && (
        <div className="absolute right-0 top-full z-10 mt-1 min-w-[260px] overflow-hidden rounded-lg border border-white/10 bg-bg-raised shadow-xl">
          {examples.map((ex) => (
            <button
              key={ex.id}
              onClick={() => { onSelect(ex.id); setOpen(false); }}
              className="flex w-full flex-col items-start gap-0.5 px-3 py-2.5 text-left text-xs transition-colors hover:bg-white/[0.04]"
            >
              <span className="font-medium text-white">{ex.label}</span>
              <span className="text-[10px] text-gray-500">
                {ex.synchronous ? "Synchronous" : "Combinational"}
                {ex.clock && ` · ${ex.clock}`}
              </span>
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

function EmptyState() {
  return (
    <div className="card flex h-full min-h-[560px] flex-col items-center justify-center p-10 text-center">
      <div className="flex h-14 w-14 items-center justify-center rounded-xl bg-gradient-to-br from-brand-500/20 to-accent-violet/20 text-brand-300">
        <Sparkles className="h-6 w-6" />
      </div>
      <h3 className="mt-4 text-base font-semibold text-white">Ready when you are</h3>
      <p className="mt-1 max-w-sm text-sm text-gray-400">
        Write or load an RTL example and click{" "}
        <span className="text-white">Generate Assertions</span> to see the
        raw model output, the generated assertions and the wrapped RTL.
      </p>
    </div>
  );
}

function BusyState() {
  return (
    <div className="card flex h-full min-h-[560px] flex-col items-center justify-center p-10 text-center">
      <div className="relative h-14 w-14">
        <div className="absolute inset-0 animate-ping rounded-xl bg-brand-500/20" />
        <div className="relative flex h-14 w-14 items-center justify-center rounded-xl bg-gradient-to-br from-brand-500 to-accent-violet text-white">
          <Loader2 className="h-6 w-6 animate-spin" />
        </div>
      </div>
      <h3 className="mt-4 text-base font-semibold text-white">Working</h3>
      <p className="mt-1 max-w-sm text-sm text-gray-400">
        Running LLM inference, post-processing the raw output and building the
        wrapped SystemVerilog module. This usually takes a few seconds.
      </p>
    </div>
  );
}
