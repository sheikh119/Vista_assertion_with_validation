"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";
import { Github } from "lucide-react";

const links = [
  { href: "/",           label: "Home" },
  { href: "/playground", label: "Playground" },
  { href: "/about",      label: "About" },
];

export default function Header() {
  const pathname = usePathname();

  return (
    <header className="sticky top-0 z-40 border-b border-white/5 bg-bg/70 backdrop-blur-md">
      <div className="mx-auto flex h-14 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
        <Link href="/" className="group flex items-center gap-2.5">
          <div className="relative h-7 w-7 rounded-md bg-gradient-to-br from-brand-500 via-accent-violet to-accent-teal shadow-glow">
            <div className="absolute inset-0 flex items-center justify-center font-mono text-[10px] font-black text-white">
              V
            </div>
          </div>
          <div className="flex flex-col leading-tight">
            <span className="text-sm font-semibold tracking-tight text-white">
              VISTA
            </span>
            <span className="text-[10px] text-gray-500">RTL → Assertions</span>
          </div>
        </Link>

        <nav className="hidden items-center gap-1 sm:flex">
          {links.map((l) => (
            <Link
              key={l.href}
              href={l.href}
              className={cn(
                "rounded-md px-3 py-1.5 text-sm transition-colors",
                pathname === l.href
                  ? "bg-white/[0.06] text-white"
                  : "text-gray-400 hover:bg-white/[0.03] hover:text-gray-200",
              )}
            >
              {l.label}
            </Link>
          ))}
        </nav>

        <div className="flex items-center gap-2">
          <a
            href="https://github.com/sheikh119/Vista_assertion_with_validation"
            target="_blank"
            rel="noreferrer"
            className="btn-ghost !px-2.5 !py-1.5"
            aria-label="GitHub"
          >
            <Github className="h-4 w-4" />
          </a>
          <Link href="/playground" className="btn-primary !px-3 !py-1.5 text-xs">
            Try VISTA
          </Link>
        </div>
      </div>
    </header>
  );
}
