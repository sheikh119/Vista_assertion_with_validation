import { ArrowRight, Code2, Cpu, FileCog, Shield, Wrench } from "lucide-react";

const stages = [
  { icon: Code2,  label: "RTL Input",       sub: "Code + clock/sync" },
  { icon: Cpu,    label: "LLaMA 3.1 (8B)",  sub: "Fine-tuned QLoRA" },
  { icon: FileCog,label: "Post-Processing", sub: "SVA → immediate"  },
  { icon: Wrench, label: "RTL Wrapper",    sub: "Signal inference" },
  { icon: Shield, label: "SymbiYosys",     sub: "Formal BMC check" },
];

export default function PipelineDiagram() {
  return (
    <div className="card overflow-hidden p-6">
      <div className="mb-5 flex items-center justify-between">
        <div>
          <div className="label">The Pipeline</div>
          <div className="mt-1 text-sm text-gray-400">
            RTL to formally verified assertions in five stages.
          </div>
        </div>
      </div>

      <div className="flex flex-col gap-4 sm:flex-row sm:items-stretch sm:justify-between sm:gap-2">
        {stages.map((s, i) => (
          <div key={s.label} className="flex items-center gap-2 sm:flex-1 sm:flex-col">
            <div className="flex flex-1 items-center gap-3 sm:flex-col sm:gap-2">
              <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg border border-white/10 bg-gradient-to-br from-white/[0.04] to-white/[0.01] text-brand-300">
                <s.icon className="h-5 w-5" />
              </div>
              <div className="text-left sm:text-center">
                <div className="text-sm font-medium text-white">{s.label}</div>
                <div className="text-[11px] text-gray-500">{s.sub}</div>
              </div>
            </div>
            {i < stages.length - 1 && (
              <ArrowRight className="h-4 w-4 shrink-0 text-gray-600 sm:rotate-0" />
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
