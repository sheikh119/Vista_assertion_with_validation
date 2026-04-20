import PipelineDiagram from "@/components/PipelineDiagram";
import {
  Cpu, FileCode2, Wrench, ShieldCheck, Sparkles,
  GraduationCap, Briefcase, Users,
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
      <div className="grid grid-cols-1 gap-5 animate-fade-up md:grid-cols-2">
        <Section title="Model" icon={Cpu} tone="brand">
          VISTA uses <Strong>LLaMA 3.1 (8B)</Strong> fine-tuned with{" "}
          <Strong>QLoRA</Strong> (rank <Code>256</Code>, alpha{" "}
          <Code>256</Code>, 4-bit quantization) and Unsloth kernels. Training
          ran for 3 epochs on 19,000 RTL–SVA pairs from the VERT dataset using
          an effective batch size of 64 on a single RTX 4090 (&lt;6&nbsp;GB VRAM).
        </Section>

        <Section title="Prompt alignment" icon={FileCode2} tone="violet">
          The evaluation prompt mirrors the training format exactly —{" "}
          <Code>### Instruction:</Code> … <Code>### Response:</Code> — which
          alone lifted assertion yield from{" "}
          <Strong>24% → 86%</Strong> and Jaccard from{" "}
          <Strong>0.04 → 0.99</Strong>.
        </Section>

        <Section title="Post-processing" icon={Wrench} tone="teal">
          The raw model output is parsed for{" "}
          <Code>property…endproperty</Code> blocks, temporal operators{" "}
          (<Code>|-&gt;</Code>, <Code>|=&gt;</Code>) are converted to
          Yosys-compatible immediate assertions, clock qualifiers are stripped
          and the result is greedy-filtered so anything that fails to parse is
          dropped automatically.
        </Section>

        <Section title="Dynamic wrapper" icon={Wrench} tone="cyan">
          VERT provides fragments, not modules. VISTA infers every signal,
          declares them as <Code>logic [31:0]</Code>, sets up clock/reset,
          initializes state to zero and embeds the assertions in the correct{" "}
          <Code>always</Code> block so formal tools accept them.
        </Section>

        <Section title="Formal check" icon={ShieldCheck} tone="brand" wide>
          The wrapped module is sent to <Strong>SymbiYosys</Strong> in BMC
          mode (depth 8 by default) using the <Code>smtbmc</Code> engine. On
          100 held-out VERT samples VISTA reaches{" "}
          <Strong>99/100</Strong> formal pass,{" "}
          <Strong>89/100</Strong> exact match with gold assertions and{" "}
          <Strong>100%</Strong> syntactic validity.
        </Section>
      </div>

      {/* -------------------------------- TEAM -------------------------------- */}
      <section className="animate-fade-up">
        <div className="mb-6 flex items-end justify-between">
          <div>
            <div className="label mb-2">Who built it</div>
            <h2 className="text-2xl font-bold tracking-tight text-white sm:text-3xl">
              The team
            </h2>
          </div>
        </div>

        <div className="grid grid-cols-1 gap-5 md:grid-cols-3">
          <TeamGroup
            icon={Users}
            tone="brand"
            title="Team Members"
            subtitle="Final-year project team"
            people={["Muhammad Abbas", "Mian Arqam", "Asad Ali"]}
          />
          <TeamGroup
            icon={GraduationCap}
            tone="violet"
            title="Supervisors"
            subtitle="Academic supervision"
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
              <>
                Industrial partner:{" "}
                <span className="font-semibold text-white">NECOP</span>
              </>
            }
            people={[
              { name: "Dr. Haroon" },
              { name: "Dr. Majeed" },
            ]}
          />
        </div>
      </section>
    </article>
  );
}

// ---------------------------------------------------------------------------
//  Section card — glowing gradient border + icon + themed tone
// ---------------------------------------------------------------------------
type Tone = "brand" | "violet" | "teal" | "cyan";

const toneStyles: Record<Tone, {
  glow:  string;  // gradient for the outer glow border
  ring:  string;  // fine ring colour
  icon:  string;  // icon tint
  badge: string;  // badge bg
}> = {
  brand:  {
    glow:  "from-brand-500/40 via-brand-400/10 to-transparent",
    ring:  "ring-brand-500/20",
    icon:  "text-brand-300",
    badge: "from-brand-500/25 to-brand-500/0",
  },
  violet: {
    glow:  "from-accent-violet/40 via-accent-violet/10 to-transparent",
    ring:  "ring-accent-violet/20",
    icon:  "text-violet-300",
    badge: "from-accent-violet/25 to-accent-violet/0",
  },
  teal:   {
    glow:  "from-accent-teal/40 via-accent-teal/10 to-transparent",
    ring:  "ring-accent-teal/20",
    icon:  "text-teal-300",
    badge: "from-accent-teal/25 to-accent-teal/0",
  },
  cyan:   {
    glow:  "from-accent-cyan/40 via-accent-cyan/10 to-transparent",
    ring:  "ring-accent-cyan/20",
    icon:  "text-cyan-300",
    badge: "from-accent-cyan/25 to-accent-cyan/0",
  },
};

function Section({
  title, icon: Icon, tone, children, wide = false,
}: {
  title: string;
  icon: LucideIcon;
  tone: Tone;
  children: React.ReactNode;
  wide?: boolean;
}) {
  const t = toneStyles[tone];
  return (
    <section
      className={cn(
        "group relative overflow-hidden rounded-xl",
        wide && "md:col-span-2",
      )}
    >
      {/* Glowing gradient border (blur behind the card) */}
      <div
        aria-hidden
        className={cn(
          "pointer-events-none absolute -inset-px rounded-xl opacity-60 blur-[2px]",
          "bg-gradient-to-br", t.glow,
          "transition-opacity duration-500 group-hover:opacity-100",
        )}
      />
      {/* Inner card surface */}
      <div
        className={cn(
          "relative rounded-xl border border-white/5 bg-bg-card p-5",
          "ring-1", t.ring,
          "shadow-card transition-all duration-300",
          "group-hover:border-white/10",
        )}
      >
        <div className="mb-3 flex items-center gap-3">
          <div
            className={cn(
              "flex h-9 w-9 items-center justify-center rounded-lg",
              "bg-gradient-to-br", t.badge,
              "border border-white/10 shadow-inner",
              t.icon,
            )}
          >
            <Icon className="h-4 w-4" />
          </div>
          <h2 className="text-base font-semibold tracking-tight text-white">
            {title}
          </h2>
        </div>
        <div className="text-sm leading-relaxed text-gray-300">
          {children}
        </div>
      </div>
    </section>
  );
}

// ---------------------------------------------------------------------------
//  Team group card
// ---------------------------------------------------------------------------
type Person = string | { name: string; role?: string };

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
    <div className="group relative overflow-hidden rounded-xl">
      {/* Glow border */}
      <div
        aria-hidden
        className={cn(
          "pointer-events-none absolute -inset-px rounded-xl opacity-50 blur-[2px]",
          "bg-gradient-to-br", t.glow,
          "transition-opacity duration-500 group-hover:opacity-100",
        )}
      />
      <div
        className={cn(
          "relative flex h-full flex-col rounded-xl border border-white/5 bg-bg-card p-5",
          "ring-1", t.ring, "shadow-card",
        )}
      >
        <div className="mb-4 flex items-center gap-3">
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
          <div>
            <div className="text-base font-semibold text-white">{title}</div>
            <div className="text-[11px] text-gray-400">{subtitle}</div>
          </div>
        </div>

        <ul className="flex flex-col gap-2.5">
          {people.map((p) => {
            const person = typeof p === "string" ? { name: p } : p;
            return (
              <li
                key={person.name}
                className="flex items-center gap-3 rounded-lg border border-white/5 bg-white/[0.02] px-3 py-2 transition-colors hover:border-white/10 hover:bg-white/[0.04]"
              >
                <Avatar name={person.name} tone={tone} />
                <div className="flex flex-col leading-tight">
                  <span className="text-sm font-medium text-white">
                    {person.name}
                  </span>
                  {person.role && (
                    <span className="text-[11px] text-gray-500">
                      {person.role}
                    </span>
                  )}
                </div>
              </li>
            );
          })}
        </ul>
      </div>
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
        "flex h-8 w-8 shrink-0 items-center justify-center rounded-full",
        "bg-gradient-to-br", t.badge,
        "border border-white/10 font-mono text-[11px] font-bold",
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
