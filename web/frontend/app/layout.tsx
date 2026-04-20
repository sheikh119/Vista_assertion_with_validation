import "./globals.css";
import type { Metadata } from "next";
import Header from "@/components/Header";
import Footer from "@/components/Footer";

export const metadata: Metadata = {
  title: "VISTA — LLM-Driven SystemVerilog Assertion Generation",
  description:
    "Generate and formally verify SystemVerilog Assertions directly from RTL code using a fine-tuned LLaMA 3.1 model and SymbiYosys.",
  icons: { icon: "/favicon.svg" },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className="min-h-screen antialiased">
        <div className="relative isolate">
          {/* Ambient background */}
          <div className="pointer-events-none absolute inset-x-0 top-0 -z-10 h-[620px] bg-hero-glow" />
          <div className="pointer-events-none absolute inset-0 -z-10 grid-bg [mask-image:linear-gradient(to_bottom,white,transparent_85%)]" />

          <Header />
          <main className="mx-auto w-full max-w-7xl px-4 sm:px-6 lg:px-8">
            {children}
          </main>
          <Footer />
        </div>
      </body>
    </html>
  );
}
