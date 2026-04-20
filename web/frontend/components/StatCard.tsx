import { cn } from "@/lib/utils";
import type { LucideIcon } from "lucide-react";

type Props = {
  label: string;
  value: string;
  caption?: string;
  icon: LucideIcon;
  tone?: "brand" | "violet" | "teal" | "cyan";
};

const tones: Record<NonNullable<Props["tone"]>, string> = {
  brand:  "from-brand-500/20 to-brand-500/0 text-brand-300",
  violet: "from-accent-violet/20 to-accent-violet/0 text-violet-300",
  teal:   "from-accent-teal/20 to-accent-teal/0 text-teal-300",
  cyan:   "from-accent-cyan/20 to-accent-cyan/0 text-cyan-300",
};

export default function StatCard({
  label, value, caption, icon: Icon, tone = "brand",
}: Props) {
  return (
    <div className="card card-hover group p-5">
      <div className="flex items-start justify-between gap-4">
        <div>
          <div className="label">{label}</div>
          <div className="mt-2 text-3xl font-bold tracking-tight text-white">
            {value}
          </div>
          {caption && (
            <div className="mt-1 text-xs text-gray-400">{caption}</div>
          )}
        </div>
        <div
          className={cn(
            "flex h-10 w-10 shrink-0 items-center justify-center rounded-lg",
            "bg-gradient-to-br", tones[tone],
            "border border-white/5 shadow-inner",
          )}
        >
          <Icon className="h-5 w-5" />
        </div>
      </div>
    </div>
  );
}
