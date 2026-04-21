import PipelineDiagram from "@/components/PipelineDiagram";
import ReflectiveCard from "@/components/ReflectiveCard";
import {
  Cpu, FileCode2, Wrench, ShieldCheck, Sparkles,
  GraduationCap, Briefcase, Code2,
} from "lucide-react";
import type { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

export default function AboutPage() {
  return (
    <article className="mx-auto flex max-w-4xl flex-col gap-12 py-16">
      {/* --------------------------------- HERO -------------------------------- */}
      <header className="animate-fade-up">
        <span className="chip mb-5">
          <Sparkles className="h-3.5 w-3.5 text-accent-violet" />
          How VISTA works
        </span>
        <h1 className="text-balance text-3xl font-bold tracking-tight text-white sm:text-4xl lg:text-5xl">
          An <span className="gradient-text">end-to-end</span> pipeline from RTL to verified assertions.
        </h1>
        <p className="mt-4 max-w-2xl text-pretty text-base leading-relaxed text-gray-400">
          A short tour of the five-stage pipeline, the fine-tuned model and the
          evaluation numbers reported in the paper.
        </p>
      </header>

      {/* ----------------------------- PIPELINE DIAG -------------------------- */}
      <div className="animate-fade-up">
        <PipelineDiagram />
      </div>

      {/* ------------------------------ SECTIONS ------------------------------ */}
      <div className="grid grid-cols-1 gap-6 animate-fade-up md:grid-cols-2">
        <Section
          title="Model"
          icon={Cpu}
          tone="brand"
          lede="Fine-tuned LLaMA 3.1 on RTL–SVA pairs."
          points={[
            <>Base: <Strong>LLaMA 3.1 (8B)</Strong> with Unsloth kernels</>,
            <><Strong>QLoRA</Strong> · rank <Code>256</Code> · 4-bit NF4</>,
            <>Trained on <Strong>19k</Strong> VERT pairs for 3 epochs</>,
            <>Runs on a single RTX 4090 at &lt;&nbsp;6&nbsp;GB VRAM</>,
          ]}
        />

        <Section
          title="Prompt alignment"
          icon={FileCode2}
          tone="violet"
          lede="Inference mirrors the training format exactly."
          points={[
            <>Uses <Code>### Instruction:</Code> → <Code>### Response:</Code></>,
            <>Assertion yield: <Strong>24% → 86%</Strong></>,
            <>Gold Jaccard: <Strong>0.04 → 0.99</Strong></>,
          ]}
        />

        <Section
          title="Post-processing"
          icon={Code2}
          tone="teal"
          lede="Raw model output becomes clean, parseable SVA."
          points={[
            <>Extract <Code>property…endproperty</Code> blocks</>,
            <>Convert <Code>|-&gt;</Code> / <Code>|=&gt;</Code> to immediate asserts</>,
            <>Strip clock qualifiers &amp; temporal ops Yosys can&apos;t parse</>,
            <>Greedy filter drops anything that fails to parse</>,
          ]}
        />

        <Section
          title="Dynamic wrapper"
          icon={Wrench}
          tone="cyan"
          lede="Turns fragments into synthesizable modules."
          points={[
            <>Infers every signal as <Code>logic&nbsp;[31:0]</Code></>,
            <>Sets up clock, reset and zero-initialized state</>,
            <>Embeds asserts in the correct <Code>always</Code> block</>,
          ]}
        />

        <Section
          title="Formal check"
          icon={ShieldCheck}
          tone="brand"
          wide
          lede={<>Wrapped module runs under <Strong>SymbiYosys</Strong> BMC (<Code>smtbmc</Code>, depth&nbsp;8).</>}
          points={[
            <>Formal pass: <Strong>99 / 100</Strong> samples</>,
            <>Exact-match with gold: <Strong>89 / 100</Strong></>,
            <>Syntactic validity: <Strong>100%</Strong></>,
            <>Typical wall-clock: <Strong>&lt;&nbsp;25&nbsp;s</Strong> per case</>,
          ]}
        />
      </div>

      {/* -------------------------- TEAM MEMBERS (IDs) ------------------------ */}
      <section className="animate-fade-up">
        <div className="mb-8">
          <div className="label mb-2">Who built it</div>
          <h2 className="text-2xl font-bold tracking-tight text-white sm:text-3xl">
            Meet the team
          </h2>
          <p className="mt-2 max-w-2xl text-sm text-gray-400">
            A final-year design project at GIKI Faculty of Computer Engineering
            (Batch&nbsp;32), co-advised by academic faculty and mentored by
            industry engineers at NECOP.
          </p>
        </div>

        <div className="grid grid-cols-1 gap-7 sm:grid-cols-2 lg:grid-cols-3">
          <div className="flex justify-center">
            <ReflectiveCard
              name="Muhammad Abbas"
              regNumber="2022317"
              tone="brand"
              photo="/images/abbas.png"
              overlayColor="rgba(10, 12, 24, 0.45)"
            />
          </div>
          <div className="flex justify-center">
            <ReflectiveCard
              name="Asad Ali"
              regNumber="2022119"
              tone="violet"
              photo="/images/asad.png"
              overlayColor="rgba(10, 12, 24, 0.45)"
            />
          </div>
          <div className="flex justify-center">
            <ReflectiveCard
              name="Mian Arqam"
              regNumber="2022294"
              tone="teal"
              photo="/images/arqam.png"
              overlayColor="rgba(10, 12, 24, 0.45)"
            />
          </div>
        </div>
      </section>

      {/* ----------------------- SUPERVISORS & MENTORS ------------------------ */}
      <section className="animate-fade-up">
        <div className="mb-6">
          <div className="label mb-2">Guidance</div>
          <h2 className="text-xl font-semibold tracking-tight text-white sm:text-2xl">
            Supervisors &amp; Industrial Mentors
          </h2>
        </div>

        <div className="grid grid-cols-1 gap-5 md:grid-cols-2">
          <TeamGroup
            icon={GraduationCap}
            tone="violet"
            title="Supervisors"
            subtitle="Faculty of Computer Engineering"
            people={[
              { name: "Dr. Fahad", role: "Primary supervisor" },
              { name: "Dr. Waqar", role: "Co-supervisor" },
            ]}
          />
          <TeamGroup
            icon={Briefcase}
            tone="teal"
            title="Industrial Mentors"
            subtitle={
              <>Industrial partner:{" "}
                <span className="font-semibold text-white">NECOP</span>
              </>
            }
            people={[
              { name: "Dr. Haroon", role: "Industry mentor" },
              { name: "Dr. Majeed", role: "Industry mentor" },
            ]}
          />
        </div>
      </section>
    </article>
  );
}

// ---------------------------------------------------------------------------
//  Tone palette
// ---------------------------------------------------------------------------
type Tone = "brand" | "violet" | "teal" | "cyan";

const toneStyles: Record<Tone, {
  ring:   string;
  icon:   string;
  badge:  string;
  accent: string;
}> = {
  brand:  {
    ring:   "ring-brand-500/25",
    icon:   "text-brand-300",
    badge:  "from-brand-500/25 to-brand-500/0",
    accent: "bg-brand-400",
  },
  violet: {
    ring:   "ring-accent-violet/25",
    icon:   "text-violet-300",
    badge:  "from-accent-violet/25 to-accent-violet/0",
    accent: "bg-violet-400",
  },
  teal:   {
    ring:   "ring-accent-teal/25",
    icon:   "text-teal-300",
    badge:  "from-accent-teal/25 to-accent-teal/0",
    accent: "bg-teal-400",
  },
  cyan:   {
    ring:   "ring-accent-cyan/25",
    icon:   "text-cyan-300",
    badge:  "from-accent-cyan/25 to-accent-cyan/0",
    accent: "bg-cyan-400",
  },
};

// ---------------------------------------------------------------------------
//  Section card — uses global .card / .card-hover glow + tone accents
// ---------------------------------------------------------------------------
function Section({
  title, icon: Icon, tone, lede, points, wide = false,
}: {
  title: string;
  icon: LucideIcon;
  tone: Tone;
  lede: React.ReactNode;
  points: React.ReactNode[];
  wide?: boolean;
}) {
  const t = toneStyles[tone];
  return (
    <section
      className={cn(
        "card card-hover flex h-full flex-col p-5",
        "ring-1", t.ring,
        wide && "md:col-span-2",
      )}
    >
      <div className="mb-3 flex items-center gap-3">
        <div
          className={cn(
            "flex h-10 w-10 items-center justify-center rounded-lg",
            "bg-gradient-to-br", t.badge,
            "border border-white/10 shadow-inner",
            t.icon,
          )}
        >
          <Icon className="h-5 w-5" />
        </div>
        <h2 className="text-base font-semibold tracking-tight text-white">
          {title}
        </h2>
      </div>

      {lede && (
        <p className="mb-3 text-sm leading-relaxed text-gray-300">{lede}</p>
      )}

      <ul
        className={cn(
          "grid list-none gap-2",
          wide ? "sm:grid-cols-2" : "grid-cols-1",
        )}
      >
        {points.map((pt, i) => (
          <li key={i} className="flex items-start gap-2.5">
            <span
              className={cn(
                "mt-1.5 inline-block h-1.5 w-1.5 shrink-0 rounded-full",
                t.accent,
              )}
            />
            <span className="text-sm leading-snug text-gray-300">{pt}</span>
          </li>
        ))}
      </ul>
    </section>
  );
}

// ---------------------------------------------------------------------------
//  Supervisors / mentors card
// ---------------------------------------------------------------------------
type Person = { name: string; role?: string };

function TeamGroup({
  icon: Icon, tone, title, subtitle, people,
}: {
  icon: LucideIcon;
  tone: Tone;
  title: string;
  subtitle: React.ReactNode;
  people: Person[];
}) {
  const t = toneStyles[tone];
  return (
    <div className={cn("card card-hover flex h-full flex-col p-5", "ring-1", t.ring)}>
      {/* Header */}
      <div className="mb-5 flex items-center gap-3">
        <div
          className={cn(
            "flex h-11 w-11 items-center justify-center rounded-xl",
            "bg-gradient-to-br", t.badge,
            "border border-white/10 shadow-inner",
            t.icon,
          )}
        >
          <Icon className="h-5 w-5" />
        </div>
        <div className="min-w-0">
          <div className="text-base font-semibold text-white">{title}</div>
          <div className="text-[11px] text-gray-400">{subtitle}</div>
        </div>
      </div>

      {/* Members */}
      <ul className="flex flex-1 flex-col gap-2.5">
        {people.map((p) => (
          <li
            key={p.name}
            className={cn(
              "group/person relative flex items-center gap-3 rounded-lg",
              "border border-white/5 bg-white/[0.02] px-3 py-2.5",
              "transition-all duration-200",
              "hover:border-white/15 hover:bg-white/[0.05] hover:-translate-y-[1px]",
            )}
          >
            <Avatar name={p.name} tone={tone} />
            <div className="flex min-w-0 flex-col leading-tight">
              <span className="truncate text-sm font-medium text-white">
                {p.name}
              </span>
              {p.role && (
                <span className="truncate text-[11px] text-gray-400">
                  {p.role}
                </span>
              )}
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}

function Avatar({ name, tone }: { name: string; tone: Tone }) {
  const t = toneStyles[tone];
  const initials = name
    .replace(/^Dr\.\s*/i, "")
    .split(/\s+/)
    .map((s) => s[0] ?? "")
    .join("")
    .slice(0, 2)
    .toUpperCase();
  return (
    <div
      className={cn(
        "relative flex h-9 w-9 shrink-0 items-center justify-center rounded-full",
        "bg-gradient-to-br", t.badge,
        "border border-white/15 font-mono text-[12px] font-bold tracking-tight",
        t.icon,
      )}
    >
      {initials}
    </div>
  );
}

// ---------------------------------------------------------------------------
//  Tiny typographic helpers used inside Section bodies
// ---------------------------------------------------------------------------
function Code({ children }: { children: React.ReactNode }) {
  return (
    <code className="rounded bg-white/[0.06] px-1.5 py-0.5 font-mono text-[12px] text-brand-200">
      {children}
    </code>
  );
}

function Strong({ children }: { children: React.ReactNode }) {
  return <strong className="font-semibold text-white">{children}</strong>;
}
