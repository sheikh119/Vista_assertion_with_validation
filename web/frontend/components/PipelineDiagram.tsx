"use client";

import { Code2, Cpu, FileCog, Wrench, ShieldCheck } from "lucide-react";
import type { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

type Tone = "brand" | "violet" | "teal" | "cyan" | "amber";

type Stage = {
  icon: LucideIcon;
  label: string;
  sub: string;
  tag: string;
  tone: Tone;
};

const stages: Stage[] = [
  {
    icon: Code2,
    label: "RTL Input",
    sub: "Code + clock / sync",
    tag: "Verilog · SystemVerilog",
    tone: "brand",
  },
  {
    icon: Cpu,
    label: "LLaMA 3.1 (8B)",
    sub: "Fine-tuned QLoRA",
    tag: "4-bit NF4 · rank 256",
    tone: "violet",
  },
  {
    icon: FileCog,
    label: "Post-Processing",
    sub: "SVA → immediate",
    tag: "greedy filter",
    tone: "cyan",
  },
  {
    icon: Wrench,
    label: "Dynamic Wrapper",
    sub: "Signal inference",
    tag: "logic [31:0]",
    tone: "teal",
  },
  {
    icon: ShieldCheck,
    label: "SymbiYosys",
    sub: "Formal BMC check",
    tag: "depth 8 · smtbmc",
    tone: "amber",
  },
];

const toneColors: Record<
  Tone,
  {
    iconText: string;
    badgeBg: string;
    ring: string;
    dot: string;
    glow: string;
  }
> = {
  brand: {
    iconText: "text-brand-300",
    badgeBg: "from-brand-500/25 to-brand-500/0",
    ring: "ring-brand-500/30",
    dot: "bg-brand-400",
    glow: "shadow-[0_0_24px_-4px_rgba(59,130,246,0.6)]",
  },
  violet: {
    iconText: "text-violet-300",
    badgeBg: "from-accent-violet/30 to-accent-violet/0",
    ring: "ring-accent-violet/30",
    dot: "bg-violet-400",
    glow: "shadow-[0_0_28px_-4px_rgba(139,92,246,0.7)]",
  },
  cyan: {
    iconText: "text-cyan-300",
    badgeBg: "from-accent-cyan/30 to-accent-cyan/0",
    ring: "ring-accent-cyan/30",
    dot: "bg-cyan-400",
    glow: "shadow-[0_0_24px_-4px_rgba(34,211,238,0.55)]",
  },
  teal: {
    iconText: "text-teal-300",
    badgeBg: "from-accent-teal/30 to-accent-teal/0",
    ring: "ring-accent-teal/30",
    dot: "bg-teal-400",
    glow: "shadow-[0_0_24px_-4px_rgba(20,184,166,0.55)]",
  },
  amber: {
    iconText: "text-amber-300",
    badgeBg: "from-amber-500/30 to-amber-500/0",
    ring: "ring-amber-500/30",
    dot: "bg-amber-400",
    glow: "shadow-[0_0_28px_-4px_rgba(245,158,11,0.6)]",
  },
};

export default function PipelineDiagram() {
  return (
    <div className="card group/pipe overflow-hidden p-6 sm:p-8">
      {/* Header */}
      <div className="mb-6 flex flex-wrap items-end justify-between gap-4">
        <div>
          <div className="label">The Pipeline</div>
          <div className="mt-1 text-lg font-semibold tracking-tight text-white sm:text-xl">
            RTL to formally verified assertions in five stages
          </div>
          <div className="mt-1 text-sm text-gray-400">
            Fully automated · no specifications · open-source stack
          </div>
        </div>
        <div className="flex flex-wrap items-center gap-2 text-xs">
          <LegendDot tone="violet">Generation</LegendDot>
          <LegendDot tone="cyan">Transformation</LegendDot>
          <LegendDot tone="amber">Verification</LegendDot>
        </div>
      </div>

      {/* Pipeline — desktop */}
      <div className="relative hidden lg:block">
        {/* Animated flow line */}
        <div className="pointer-events-none absolute inset-x-0 top-[34px] z-0 mx-8 h-[2px] overflow-hidden rounded-full">
          <div className="absolute inset-0 bg-gradient-to-r from-brand-500/20 via-accent-violet/40 to-amber-500/20" />
          <div className="pipe-flow absolute inset-y-0 w-[40%] bg-gradient-to-r from-transparent via-white/80 to-transparent" />
        </div>

        <div className="relative z-10 grid grid-cols-5 gap-2">
          {stages.map((s, i) => (
            <StageNode key={s.label} stage={s} index={i} total={stages.length} />
          ))}
        </div>
      </div>

      {/* Pipeline — mobile & tablet (vertical) */}
      <div className="relative flex flex-col gap-3 lg:hidden">
        <div className="pointer-events-none absolute bottom-4 left-[22px] top-4 z-0 w-[2px] overflow-hidden rounded-full">
          <div className="absolute inset-0 bg-gradient-to-b from-brand-500/20 via-accent-violet/40 to-amber-500/20" />
          <div className="pipe-flow-v absolute inset-x-0 h-[40%] bg-gradient-to-b from-transparent via-white/80 to-transparent" />
        </div>
        {stages.map((s, i) => (
          <StageRow key={s.label} stage={s} index={i} />
        ))}
      </div>

      {/* Footer KPIs */}
      <div className="mt-8 grid grid-cols-2 gap-3 border-t border-white/5 pt-5 sm:grid-cols-4">
        <Kpi label="Syntax OK" value="100%" tone="cyan" />
        <Kpi label="Formal Pass" value="99%" tone="teal" />
        <Kpi label="Exact Match" value="89%" tone="violet" />
        <Kpi label="Latency" value="< 25s" tone="amber" />
      </div>
    </div>
  );
}

// ── Desktop: vertical column per stage ───────────────────────────────────────
function StageNode({
  stage,
  index,
  total,
}: {
  stage: Stage;
  index: number;
  total: number;
}) {
  const c = toneColors[stage.tone];
  const Icon = stage.icon;
  return (
    <div className="group/stage relative flex flex-col items-center gap-3 px-1 text-center">
      {/* Numbered icon */}
      <div className="relative">
        <div
          className={cn(
            "relative flex h-[68px] w-[68px] items-center justify-center rounded-2xl",
            "border border-white/10 bg-gradient-to-br from-bg-raised to-bg-card",
            "ring-1 transition-all duration-300",
            c.ring,
            c.glow,
            "group-hover/stage:-translate-y-0.5 group-hover/stage:scale-105",
          )}
        >
          <div
            className={cn(
              "absolute inset-2 rounded-xl bg-gradient-to-br",
              c.badgeBg,
              "opacity-80",
            )}
          />
          <Icon className={cn("relative h-7 w-7", c.iconText)} />
          {/* Stage number badge */}
          <span
            className={cn(
              "absolute -right-1.5 -top-1.5 flex h-6 w-6 items-center justify-center",
              "rounded-full border border-white/15 bg-bg-card text-[11px] font-bold text-white/90",
              "shadow-md",
            )}
          >
            {index + 1}
          </span>
        </div>
      </div>

      {/* Labels */}
      <div className="leading-tight">
        <div className="text-sm font-semibold text-white">{stage.label}</div>
        <div className="mt-0.5 text-[11px] text-gray-500">{stage.sub}</div>
      </div>

      {/* Tag chip */}
      <span
        className={cn(
          "inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/[0.03]",
          "px-2 py-0.5 font-mono text-[10.5px] tracking-tight",
          c.iconText,
        )}
      >
        <span className={cn("h-1.5 w-1.5 rounded-full", c.dot)} />
        {stage.tag}
      </span>
    </div>
  );
}

// ── Mobile row layout ────────────────────────────────────────────────────────
function StageRow({ stage, index }: { stage: Stage; index: number }) {
  const c = toneColors[stage.tone];
  const Icon = stage.icon;
  return (
    <div className="relative flex items-center gap-4 rounded-lg py-1 pl-0 pr-2">
      {/* Icon column (aligned with flow line at left:22px) */}
      <div className="relative z-10 flex h-11 w-11 shrink-0 items-center justify-center">
        <div
          className={cn(
            "relative flex h-11 w-11 items-center justify-center rounded-xl",
            "border border-white/10 bg-gradient-to-br from-bg-raised to-bg-card",
            "ring-1",
            c.ring,
            c.glow,
          )}
        >
          <div
            className={cn(
              "absolute inset-1 rounded-lg bg-gradient-to-br",
              c.badgeBg,
              "opacity-80",
            )}
          />
          <Icon className={cn("relative h-5 w-5", c.iconText)} />
        </div>
      </div>

      {/* Text */}
      <div className="flex min-w-0 flex-1 items-center justify-between gap-3">
        <div className="leading-tight">
          <div className="text-sm font-semibold text-white">
            <span className="mr-1.5 font-mono text-[11px] text-gray-500">
              {String(index + 1).padStart(2, "0")}
            </span>
            {stage.label}
          </div>
          <div className="text-[11px] text-gray-500">{stage.sub}</div>
        </div>
        <span
          className={cn(
            "hidden shrink-0 items-center gap-1.5 rounded-full border border-white/10 bg-white/[0.03]",
            "px-2 py-0.5 font-mono text-[10.5px] sm:inline-flex",
            c.iconText,
          )}
        >
          <span className={cn("h-1.5 w-1.5 rounded-full", c.dot)} />
          {stage.tag}
        </span>
      </div>
    </div>
  );
}

// ── Footer KPI ───────────────────────────────────────────────────────────────
function Kpi({
  label,
  value,
  tone,
}: {
  label: string;
  value: string;
  tone: Tone;
}) {
  const c = toneColors[tone];
  return (
    <div className="flex flex-col items-start gap-0.5">
      <div className="flex items-center gap-1.5">
        <span className={cn("h-1.5 w-1.5 rounded-full", c.dot)} />
        <span className="text-[10.5px] font-semibold uppercase tracking-wider text-gray-400">
          {label}
        </span>
      </div>
      <div className={cn("font-mono text-xl font-bold", c.iconText)}>
        {value}
      </div>
    </div>
  );
}

// ── Legend dot ───────────────────────────────────────────────────────────────
function LegendDot({
  tone,
  children,
}: {
  tone: Tone;
  children: React.ReactNode;
}) {
  const c = toneColors[tone];
  return (
    <span className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/[0.02] px-2 py-0.5 text-gray-400">
      <span className={cn("h-1.5 w-1.5 rounded-full", c.dot)} />
      {children}
    </span>
  );
}
