import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx,mdx}",
    "./components/**/*.{ts,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        bg: {
          DEFAULT: "#0a0b14",
          raised: "#12131f",
          card: "#171827",
        },
        brand: {
          50:  "#eff6ff",
          100: "#dbeafe",
          200: "#bfdbfe",
          300: "#93c5fd",
          400: "#60a5fa",
          500: "#3b82f6",
          600: "#2563eb",
          700: "#1d4ed8",
        },
        accent: {
          violet: "#8b5cf6",
          teal:   "#14b8a6",
          cyan:   "#06b6d4",
        },
      },
      fontFamily: {
        sans: [
          "ui-sans-serif", "system-ui", "-apple-system", "BlinkMacSystemFont",
          "Segoe UI", "Roboto", "Inter", "sans-serif",
        ],
        mono: [
          "ui-monospace", "SFMono-Regular", "Menlo", "Monaco", "Consolas",
          "Liberation Mono", "Courier New", "monospace",
        ],
      },
      boxShadow: {
        glow: "0 0 24px -4px rgb(59 130 246 / 0.35)",
        card: "0 1px 0 rgb(255 255 255 / 0.04) inset, 0 8px 24px -12px rgb(0 0 0 / 0.6)",
      },
      backgroundImage: {
        "grid-dim":
          "linear-gradient(rgba(255,255,255,0.04) 1px, transparent 1px)," +
          "linear-gradient(90deg, rgba(255,255,255,0.04) 1px, transparent 1px)",
        "hero-glow":
          "radial-gradient(60% 60% at 50% 0%, rgba(59,130,246,0.18) 0%, transparent 65%)," +
          "radial-gradient(40% 40% at 80% 30%, rgba(139,92,246,0.14) 0%, transparent 70%)",
      },
      animation: {
        "fade-up": "fade-up 500ms cubic-bezier(0.2, 0.8, 0.2, 1) both",
        "pulse-slow": "pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite",
      },
      keyframes: {
        "fade-up": {
          "0%":   { opacity: "0", transform: "translateY(10px)" },
          "100%": { opacity: "1", transform: "translateY(0)"    },
        },
      },
    },
  },
  plugins: [],
};

export default config;
