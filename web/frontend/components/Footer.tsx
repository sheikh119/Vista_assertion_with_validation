export default function Footer() {
  return (
    <footer className="mx-auto mt-24 w-full max-w-7xl border-t border-white/5 px-4 py-8 sm:px-6 lg:px-8">
      <div className="flex flex-col items-start justify-between gap-4 text-xs text-gray-500 sm:flex-row sm:items-center">
        <div>
          <span className="text-gray-300">VISTA</span>{" "}
          — Verification using Intelligent Systems for Test Automation
        </div>
        <div className="flex gap-4">
          <span>LLaMA 3.1 · QLoRA · SymbiYosys</span>
          <span>© {new Date().getFullYear()} GIKI</span>
        </div>
      </div>
    </footer>
  );
}
