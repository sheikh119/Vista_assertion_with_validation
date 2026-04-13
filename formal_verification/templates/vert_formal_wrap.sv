// vert_formal_wrap.sv — single template for VERT → SymbiYosys / Yosys formal
//
// TWO WAYS TO FEED YOUR SNIPPET (pick one):
//
// (A) PASTE — Leave VERT_INCLUDE_SNIPPET undefined. Put your VERT "Code" inside
//     the always_comb block below (statement list only: case/if/assigns).
//
// (B) INCLUDE — Create vert_rtl_snippet.sv next to this file with the same
//     statement list only (no module/always header). In your .sby [script] use:
//       read_verilog -sv -DVERT_INCLUDE_SNIPPET vert_formal_wrap.sv
//     and list both files in [files]. Then you rarely edit this template.
//
// You still add ports (and internal logic decls) per row — VERT "Code" names differ
// each time. There is no magic parser; the template stays the shell, snippet stays RTL.
//
// Metadata: Synchronous False → always_comb. True → comment out always_comb, use
// always_ff @(posedge clk) and paste/include the same statement list there.
//
// Reference: https://symbiyosys.readthedocs.io/en/latest/verilog.html

`timescale 1ns/1ps

module vert_formal_wrap (
    input wire clk
    // --- PORTS: add every signal your snippet reads or writes -----------------
    // input wire [6:0] interrupt_request_15,
    // input wire auth_4,
    // output logic [31:0] chip_11,
);

  // --- INTERNALS: declare logic driven in "Code" but not listed as ports -----
  // logic [31:0] cfg_6;

  // --- Combinational (Synchronous == False) ---------------------------------
`ifndef VERT_USE_CLOCKED_SNIPPET
  always_comb begin
`ifdef VERT_INCLUDE_SNIPPET
    `include "vert_rtl_snippet.sv"
`else
    ; // <-- paste VERT "Code" here (replace this line)
`endif
  end
`else
  // --- Clocked (Synchronous == True): use posedge clk -------------------------
  always_ff @(posedge clk) begin
`ifdef VERT_INCLUDE_SNIPPET
    `include "vert_rtl_snippet.sv"
`else
    ; // <-- paste VERT "Code" here (replace this line)
`endif
  end
`endif

  // --- Formal (optional): assume inputs, assert properties / bind SVA ---------
  // SymbiYosys picks these up from procedural assert/assume in always @*.
  always @* begin
    // assume (interrupt_request_15 <= 7'h7f);
    // assert (/* your property under test */);
  end

endmodule
