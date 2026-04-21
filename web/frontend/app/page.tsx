import Link from "next/link";
import { ArrowRight, CheckCircle2, Sparkles } from "lucide-react";
import PipelineDiagram from "@/components/PipelineDiagram";
import SiteBackground from "@/components/SiteBackground";

export default function HomePage() {
  return (
    <div className="flex flex-col gap-24 pb-16 pt-16 sm:pt-20">
      <SiteBackground />

      {/* ---------------------------------- HERO ---------------------------------- */}
      <section className="animate-fade-up">
        <div className="mx-auto flex max-w-3xl flex-col items-center text-center">
          <span className="chip mb-6">
            <Sparkles className="h-3.5 w-3.5 text-accent-violet" />
            Fine-tuned LLaMA 3.1 · QLoRA · SymbiYosys
          </span>

          <h1 className="text-balance text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl">
            Generate verified <span className="gradient-text">SystemVerilog</span> <br className="hidden sm:block"/>
            assertions directly from RTL.
          </h1>

          <p className="mt-6 max-w-2xl text-balance text-base leading-relaxed text-gray-400 sm:text-lg">
            VISTA turns RTL fragments into formally verified SVA using a fine-tuned
            8B LLM, a dynamic wrapping template, and the SymbiYosys formal engine —
            no specifications required.
          </p>

          <div className="mt-8 flex flex-wrap items-center justify-center gap-3">
            <Link href="/playground" className="btn-primary">
              Open Playground
              <ArrowRight className="h-4 w-4" />
            </Link>
            <Link href="/about" className="btn-ghost">
              How it works
            </Link>
          </div>

          <div className="mt-8 flex flex-wrap items-center justify-center gap-x-6 gap-y-2 text-xs text-gray-500">
            <span className="inline-flex items-center gap-1.5">
              <CheckCircle2 className="h-3.5 w-3.5 text-emerald-400" />
              100% syntactic validity
            </span>
            <span className="inline-flex items-center gap-1.5">
              <CheckCircle2 className="h-3.5 w-3.5 text-emerald-400" />
              99% formal pass rate
            </span>
            <span className="inline-flex items-center gap-1.5">
              <CheckCircle2 className="h-3.5 w-3.5 text-emerald-400" />
              0.991 token Jaccard
            </span>
          </div>
        </div>
      </section>

      {/* ------------------------------- PIPELINE -------------------------------- */}
      <section className="animate-fade-up">
        <PipelineDiagram />
      </section>

      {/* -------------------------------- FEATURES -------------------------------- */}
      <section className="animate-fade-up">
        <div className="mb-6">
          <h2 className="text-xl font-semibold tracking-tight text-white sm:text-2xl">
            What VISTA gives you
          </h2>
        </div>
        <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
          <FeatureCard
            title="No specs needed"
            body="Generate assertions directly from RTL — skip the fragile natural-language spec step."
          />
          <FeatureCard
            title="Dynamic wrapper"
            body="Conditional RTL fragments become synthesizable modules with inferred signals and clocking."
          />
          <FeatureCard
            title="Formal-grade quality"
            body="Assertions are greedy-filtered through Yosys and proven with SymbiYosys BMC."
          />
        </div>
      </section>
    </div>
  );
}

function FeatureCard({ title, body }: { title: string; body: string }) {
  return (
    <div className="card card-hover p-5">
      <div className="mb-2 text-sm font-semibold text-white">{title}</div>
      <p className="text-sm leading-relaxed text-gray-400">{body}</p>
    </div>
  );
}
