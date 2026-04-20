"use client";

import { useEffect, useState } from "react";
import { AlertCircle, Copy, Download, Check } from "lucide-react";
import { cn } from "@/lib/utils";
import type { GenerateResponse } from "@/lib/api";
import CodeEditor from "@/components/CodeEditor";

type Tab = "assertions" | "raw" | "wrapper";

const tabs: { id: Tab; label: string }[] = [
  { id: "assertions", label: "Assertions" },
  { id: "raw",        label: "Model Output" },
  { id: "wrapper",    label: "Wrapped RTL" },
];

export default function ResultsPanel({ result }: { result: GenerateResponse }) {
  // Defensive defaults — older backend versions may not return every field.
  const modelAssertions = result.model_assertions ?? [];
  const rawOutput       = result.raw_output       ?? "";
  const wrapperSv       = result.wrapper_sv       ?? "";
  const hasModelAsserts = modelAssertions.length > 0;

  // When the model produced no real assertions, default to the raw output tab
  // so the user can immediately see what came back from the LLM.
  const initialTab: Tab = hasModelAsserts ? "assertions" : "raw";
  const [tab, setTab] = useState<Tab>(initialTab);
  const [copied, setCopied] = useState(false);

  // Re-sync the initial tab every time a new result arrives.
  useEffect(() => {
    setTab(hasModelAsserts ? "assertions" : "raw");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [result]);

  const text =
    tab === "assertions" ? modelAssertions.join("\n\n") :
    tab === "raw"        ? rawOutput :
                           wrapperSv;

  const filename =
    tab === "wrapper"    ? "vert_formal_wrap.sv" :
    tab === "assertions" ? "model_assertions.sv" :
                           "model_output.txt";

  const copy = async () => {
    await navigator.clipboard.writeText(text);
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  };

  const download = () => {
    const blob = new Blob([text], { type: "text/plain" });
    const a = document.createElement("a");
    a.href = URL.createObjectURL(blob);
    a.download = filename;
    a.click();
    URL.revokeObjectURL(a.href);
  };

  return (
    <div className="card flex h-full flex-col">
      {/* Diagnostic banner (only when a fallback occurred) */}
      {(result.is_fallback ?? false) && result.fallback_reason && (
        <div className="flex gap-3 border-b border-amber-400/20 bg-amber-500/[0.06] px-4 py-3">
          <AlertCircle className="h-4 w-4 shrink-0 text-amber-300 mt-0.5" />
          <div className="text-xs leading-relaxed text-amber-100/90">
            <div className="mb-1 font-semibold text-amber-200">
              {result.pipeline_stage === "no_assertions_extracted"
                ? "No real assertions extracted"
                : result.pipeline_stage === "all_dropped_by_filter"
                ? "All candidate assertions rejected by syntax filter"
                : "Fallback assertion used"}
            </div>
            <p>{result.fallback_reason}</p>
            <p className="mt-1.5 text-amber-200/60">
              Tip: try one of the built-in examples (dropdown in the input
              panel) — they use the VERT training distribution and produce the
              paper&rsquo;s 99% pass rate.
            </p>
          </div>
        </div>
      )}

      {/* Header with status + metrics */}
      <div className="flex flex-wrap items-center justify-between gap-3 border-b border-white/5 p-4">
        <div className="flex flex-wrap items-center gap-2">
          {result.syntax_ok ? (
            <span className="chip text-emerald-300">Syntax OK</span>
          ) : (
            <span className="chip text-red-300">Syntax Failed</span>
          )}
          <span
            className={cn(
              "chip",
              !hasModelAsserts && "text-amber-300",
            )}
          >
            {hasModelAsserts
              ? `${modelAssertions.length} assertion${
                  modelAssertions.length === 1 ? "" : "s"
                }`
              : "no model output"}
          </span>
          {result.greedy_dropped > 0 && (
            <span className="chip text-amber-300">
              {result.greedy_dropped} filtered
            </span>
          )}
          <span className="chip">{result.latency_ms} ms</span>
        </div>

        <div className="flex items-center gap-2">
          <button onClick={copy} className="btn-ghost !px-2.5 !py-1.5" aria-label="Copy">
            {copied ? <Check className="h-3.5 w-3.5 text-emerald-400" /> : <Copy className="h-3.5 w-3.5" />}
          </button>
          <button onClick={download} className="btn-ghost !px-2.5 !py-1.5" aria-label="Download">
            <Download className="h-3.5 w-3.5" />
          </button>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex border-b border-white/5 px-2">
        {tabs.map((t) => (
          <button
            key={t.id}
            onClick={() => setTab(t.id)}
            className={cn(
              "relative px-3 py-2.5 text-xs font-medium transition-colors",
              tab === t.id
                ? "text-white"
                : "text-gray-500 hover:text-gray-300",
            )}
          >
            {t.label}
            {tab === t.id && (
              <span className="absolute inset-x-2 bottom-0 h-0.5 rounded bg-gradient-to-r from-brand-400 to-accent-violet" />
            )}
          </button>
        ))}
      </div>

      {/* Content */}
      <div className="min-h-[420px] flex-1">
        {tab === "assertions" ? (
          <AssertionsView
            assertions={modelAssertions}
            isFallback={!hasModelAsserts}
          />
        ) : (
          <div className="h-[460px]">
            <CodeEditor
              value={text}
              onChange={() => {}}
              readOnly
              language={tab === "raw" ? "plaintext" : "verilog"}
            />
          </div>
        )}
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
//  AssertionsView — shows the raw SVA property blocks the model generated,
//  one card per property, with syntax highlighting and per-card copy.
// ---------------------------------------------------------------------------
function AssertionsView({
  assertions, isFallback,
}: { assertions: string[]; isFallback: boolean }) {
  if (isFallback || !assertions.length) {
    return (
      <div className="flex h-full min-h-[300px] flex-col items-center justify-center gap-3 p-8 text-center">
        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-amber-500/10 text-amber-300">
          <AlertCircle className="h-5 w-5" />
        </div>
        <div className="text-sm font-semibold text-white">
          No assertions produced by the model
        </div>
        <p className="max-w-md text-xs leading-relaxed text-gray-400">
          The model did not emit any SVA <code className="rounded bg-white/[0.06] px-1.5 py-0.5 font-mono text-[11px] text-gray-200">property</code>{" "}
          blocks for this RTL. Switch to the{" "}
          <span className="text-white">Model Output</span> tab to see the
          raw response, or load one of the built-in examples (VERT-style
          signal names) which the model was trained on.
        </p>
      </div>
    );
  }
  return (
    <div className="flex flex-col gap-3 p-4">
      {assertions.map((a, i) => (
        <AssertionCard key={i} index={i + 1} assertion={a} />
      ))}
    </div>
  );
}

function AssertionCard({ index, assertion }: { index: number; assertion: string }) {
  const [copied, setCopied] = useState(false);

  // Extract the property name for the card header, defensively.
  const nameMatch = assertion.match(/^\s*property\s+([A-Za-z_][A-Za-z0-9_]*)/);
  const name = nameMatch ? nameMatch[1] : `property_${index}`;

  const handleCopy = async () => {
    await navigator.clipboard.writeText(assertion);
    setCopied(true);
    setTimeout(() => setCopied(false), 1200);
  };

  return (
    <div className="group relative overflow-hidden rounded-lg border border-white/5 bg-white/[0.02] transition-colors hover:border-white/10 hover:bg-white/[0.03]">
      {/* Card header */}
      <div className="flex items-center justify-between gap-2 border-b border-white/5 bg-white/[0.015] px-3 py-2">
        <div className="flex items-center gap-2 min-w-0">
          <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded bg-gradient-to-br from-brand-500/30 to-accent-violet/30 font-mono text-[10px] font-bold text-brand-200">
            {index}
          </span>
          <span className="truncate font-mono text-[12px] font-semibold text-white">
            {name}
          </span>
          <span className="chip shrink-0 !py-0 !px-1.5 !text-[9px]">SVA</span>
        </div>
        <button
          onClick={handleCopy}
          className="shrink-0 rounded-md p-1 text-gray-500 opacity-0 transition-all hover:bg-white/[0.05] hover:text-gray-200 group-hover:opacity-100"
          aria-label="Copy assertion"
        >
          {copied ? (
            <Check className="h-3.5 w-3.5 text-emerald-400" />
          ) : (
            <Copy className="h-3.5 w-3.5" />
          )}
        </button>
      </div>

      {/* Highlighted code body */}
      <pre className="m-0 overflow-x-auto p-3 font-mono text-[12.5px] leading-[1.65] text-gray-200">
        <SvaCode text={assertion} />
      </pre>
    </div>
  );
}

/**
 * Lightweight SVA syntax highlighter. Not a full tokenizer — just enough to
 * colour the obvious tokens and keep the card visually rich.
 */
function SvaCode({ text }: { text: string }) {
  const KEYWORDS = new Set([
    "property", "endproperty", "assert", "assume", "posedge", "negedge",
    "disable", "iff", "and", "or", "not",
  ]);
  const OPS = /(\|->|\|=>|##\d+|==|!=|&&|\|\||<=|>=|[=+\-*/%<>!&|^~])/g;

  // Split input into lines so we can colour each one.
  const lines = text.split("\n");
  return (
    <>
      {lines.map((line, li) => {
        const parts: React.ReactNode[] = [];
        // First pass: split by whitespace while preserving it.
        const tokens = line.split(/(\s+)/);
        tokens.forEach((tok, ti) => {
          if (!tok) return;
          if (/^\s+$/.test(tok)) {
            parts.push(tok);
            return;
          }
          // Keyword?
          if (KEYWORDS.has(tok)) {
            parts.push(
              <span key={`${li}-${ti}`} className="font-semibold text-accent-violet">{tok}</span>
            );
            return;
          }
          // Number literal (includes 1'b1, 8'hFF, 3'd7)?
          if (/^(\d+'[bhdo][0-9a-fA-FxzXZ_]+|\d+)$/.test(tok)) {
            parts.push(
              <span key={`${li}-${ti}`} className="text-teal-300">{tok}</span>
            );
            return;
          }
          // Contains temporal/Boolean operators — colour them inline.
          if (OPS.test(tok)) {
            OPS.lastIndex = 0;
            const subparts: React.ReactNode[] = [];
            let last = 0;
            let m: RegExpExecArray | null;
            while ((m = OPS.exec(tok)) !== null) {
              if (m.index > last) {
                subparts.push(
                  <span key={`${li}-${ti}-t-${last}`} className="text-gray-200">
                    {tok.slice(last, m.index)}
                  </span>
                );
              }
              const op = m[0];
              const isTemporal = op === "|->" || op === "|=>" || op.startsWith("##");
              subparts.push(
                <span
                  key={`${li}-${ti}-o-${m.index}`}
                  className={isTemporal ? "font-semibold text-accent-cyan" : "text-brand-300"}
                >
                  {op}
                </span>
              );
              last = m.index + op.length;
            }
            if (last < tok.length) {
              subparts.push(
                <span key={`${li}-${ti}-t-end`} className="text-gray-200">
                  {tok.slice(last)}
                </span>
              );
            }
            parts.push(<span key={`${li}-${ti}`}>{subparts}</span>);
            return;
          }
          // Plain identifier.
          parts.push(
            <span key={`${li}-${ti}`} className="text-gray-100">{tok}</span>
          );
        });
        return (
          <span key={li}>
            {parts}
            {li < lines.length - 1 && "\n"}
          </span>
        );
      })}
    </>
  );
}
