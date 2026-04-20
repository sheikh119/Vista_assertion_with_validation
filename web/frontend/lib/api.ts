/**
 * Thin client for the VISTA FastAPI backend.
 * Requests are proxied through Next's rewrites (see next.config.mjs),
 * so the frontend only speaks to same-origin `/api/*`.
 */

export type GenerateRequest = {
  code: string;
  synchronous: boolean;
  clock: string | null;
  max_new_tokens?: number;
  /** SymbiYosys is disabled in the UI; always sent as false. */
  run_formal?: boolean;
};

/**
 * Kept for type compatibility with the backend response schema. The UI no
 * longer surfaces the formal verification status directly.
 */
export type FormalStatus =
  | "pass" | "fail" | "error" | "timeout" | "skipped" | "not_run";

export type PipelineStage =
  | "ok"
  | "no_assertions_extracted"
  | "all_dropped_by_filter"
  | "syntax_check_failed"
  | "formal_disabled";

export type GenerateResponse = {
  raw_output: string;
  /**
   * Native SVA property blocks exactly as the model produced them.
   * Optional for backward compat with older backend builds that don't
   * populate this field yet.
   */
  model_assertions?: string[];
  pre_greedy_assertions: string[];
  final_assertions: string[];
  greedy_dropped: number;
  wrapper_sv: string;
  syntax_ok: boolean;
  formal_status: FormalStatus;
  formal_log_tail: string;
  latency_ms: number;
  adapter_dir: string;
  is_fallback?: boolean;
  fallback_reason?: string | null;
  pipeline_stage?: PipelineStage;
};

export type HealthResponse = {
  ready: boolean;
  adapter_dir: string | null;
  has_yosys: boolean;
  has_sby: boolean;
};

export async function generateAssertions(
  req: GenerateRequest,
  signal?: AbortSignal,
): Promise<GenerateResponse> {
  const res = await fetch("/api/generate", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(req),
    signal,
  });
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`API error ${res.status}: ${text}`);
  }
  return res.json();
}

export async function getHealth(signal?: AbortSignal): Promise<HealthResponse> {
  const res = await fetch("/api/health", { signal, cache: "no-store" });
  if (!res.ok) throw new Error(`Health check failed: ${res.status}`);
  return res.json();
}
