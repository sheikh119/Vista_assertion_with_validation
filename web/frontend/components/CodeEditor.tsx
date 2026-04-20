"use client";

import dynamic from "next/dynamic";
import type { OnMount } from "@monaco-editor/react";

/**
 * Monaco is loaded only on the client — saves a lot of bundle size on the
 * landing page and works nicely with Next's dynamic import.
 */
const MonacoEditor = dynamic(() => import("@monaco-editor/react"), {
  ssr: false,
  loading: () => (
    <div className="flex h-full items-center justify-center text-xs text-gray-500">
      Loading editor…
    </div>
  ),
});

type Props = {
  value: string;
  onChange: (v: string) => void;
  language?: string;
  height?: string | number;
  readOnly?: boolean;
};

export default function CodeEditor({
  value, onChange, language = "verilog", height = "100%", readOnly = false,
}: Props) {
  const onMount: OnMount = (_editor, monaco) => {
    // Register a lightweight Verilog/SystemVerilog highlighter.
    // Monaco ships with the language id but no tokens; we register minimal rules.
    monaco.languages.register({ id: "verilog" });
    monaco.languages.setMonarchTokensProvider("verilog", {
      tokenizer: {
        root: [
          [/\/\/.*$/, "comment"],
          [/\/\*/, { token: "comment", next: "@comment" }],
          [/[0-9]+'[bhdo][0-9a-fA-FxzXZ_]+/, "number"],
          [/\b\d+\b/, "number"],
          [/"([^"\\]|\\.)*"/, "string"],
          [
            /\b(module|endmodule|input|output|inout|wire|reg|logic|integer|parameter|localparam|always|always_ff|always_comb|always_latch|begin|end|if|else|case|endcase|default|initial|assign|posedge|negedge|property|endproperty|assert|assume|disable|iff|property|sequence|endsequence|for|while|generate|endgenerate|genvar|function|endfunction|task|endtask)\b/,
            "keyword",
          ],
          [/[A-Za-z_][A-Za-z0-9_]*/, "identifier"],
          [/[{}()\[\]]/, "@brackets"],
          [/[<>!~?:&|+\-*^%=]+/, "operator"],
        ],
        comment: [
          [/[^/*]+/, "comment"],
          [/\*\//, { token: "comment", next: "@pop" }],
          [/[/*]/, "comment"],
        ],
      },
    });

    monaco.editor.defineTheme("vista-dark", {
      base: "vs-dark",
      inherit: true,
      rules: [
        { token: "keyword",    foreground: "8b5cf6", fontStyle: "bold" },
        { token: "comment",    foreground: "6b7280", fontStyle: "italic" },
        { token: "number",     foreground: "14b8a6" },
        { token: "string",     foreground: "f59e0b" },
        { token: "operator",   foreground: "93c5fd" },
        { token: "identifier", foreground: "e5e7eb" },
      ],
      colors: {
        "editor.background":               "#12131f",
        "editor.foreground":               "#e5e7eb",
        "editorLineNumber.foreground":     "#3f3f5b",
        "editorLineNumber.activeForeground":"#94a3b8",
        "editor.selectionBackground":      "#2563eb55",
        "editor.lineHighlightBackground":  "#1a1b2e",
        "editorCursor.foreground":         "#60a5fa",
      },
    });
    monaco.editor.setTheme("vista-dark");
  };

  return (
    <div className="h-full w-full overflow-hidden rounded-lg border border-white/5">
      <MonacoEditor
        value={value}
        language={language}
        height={height}
        onMount={onMount}
        onChange={(v) => onChange(v ?? "")}
        options={{
          readOnly,
          minimap: { enabled: false },
          fontFamily: "'JetBrains Mono', ui-monospace, monospace",
          fontSize: 13,
          lineNumbers: "on",
          scrollBeyondLastLine: false,
          padding: { top: 12, bottom: 12 },
          smoothScrolling: true,
          cursorBlinking: "smooth",
          renderLineHighlight: "line",
          scrollbar: { verticalScrollbarSize: 10, horizontalScrollbarSize: 10 },
          tabSize: 2,
          wordWrap: "on",
        }}
      />
    </div>
  );
}
