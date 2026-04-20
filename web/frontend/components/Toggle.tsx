"use client";

import { cn } from "@/lib/utils";

type Props = {
  checked: boolean;
  onChange: (v: boolean) => void;
  label?: string;
  description?: string;
};

export default function Toggle({ checked, onChange, label, description }: Props) {
  return (
    <label className="flex cursor-pointer items-start gap-3">
      <button
        type="button"
        role="switch"
        aria-checked={checked}
        onClick={() => onChange(!checked)}
        className={cn(
          "relative mt-0.5 inline-flex h-5 w-9 shrink-0 items-center rounded-full transition-colors",
          checked
            ? "bg-gradient-to-r from-brand-500 to-accent-violet"
            : "bg-white/10",
        )}
      >
        <span
          className={cn(
            "inline-block h-3.5 w-3.5 transform rounded-full bg-white shadow-sm transition-transform",
            checked ? "translate-x-5" : "translate-x-0.5",
          )}
        />
      </button>
      {(label || description) && (
        <div className="text-sm">
          {label && <div className="font-medium text-white">{label}</div>}
          {description && (
            <div className="text-xs text-gray-400">{description}</div>
          )}
        </div>
      )}
    </label>
  );
}
