`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] After;
  logic [31:0] Allowed;
  logic [31:0] Assertion;
  logic [31:0] Do;
  logic [31:0] Each;
  logic [31:0] MUST;
  logic [31:0] NOT;
  logic [31:0] ONLY;
  logic [31:0] Parenthesize;
  logic [31:0] RTL;
  logic [31:0] Use;
  logic [31:0] appear;
  logic [31:0] assertions;
  logic [31:0] auth_16;
  logic [31:0] auth_4;
  logic [31:0] be;
  logic [31:0] below;
  logic [31:0] boolean;
  logic [31:0] cfg_10;
  logic [31:0] chip_13;
  logic [31:0] clk_2;
  logic [31:0] core_16;
  logic [31:0] data_12;
  logic [31:0] data_3;
  logic [31:0] err_79;
  logic [31:0] exactly;
  logic [31:0] expression;
  logic [31:0] fsm_10;
  logic [31:0] fsm_12;
  logic [31:0] fsm_6;
  logic [31:0] generously;
  logic [31:0] here;
  logic [31:0] hw_15;
  logic [31:0] immediate;
  logic [31:0] in;
  logic [31:0] invent;
  logic [31:0] is;
  logic [31:0] line;
  logic [31:0] names;
  logic [31:0] new;
  logic [31:0] not;
  logic [31:0] one;
  logic [31:0] only;
  logic [31:0] operators;
  logic [31:0] per;
  logic [31:0] precedence;
  logic [31:0] procedural;
  logic [31:0] reg_16;
  logic [31:0] reg_4;
  logic [31:0] rst_116;
  logic [31:0] rst_6;
  logic [31:0] rx_11;
  logic [31:0] signal;
  logic [31:0] snippet;
  logic [31:0] so;
  logic [31:0] style;
  logic [31:0] that;
  logic [31:0] the;
  logic [31:0] they;
  logic [31:0] tx_4;
  logic [31:0] unambiguous;
  logic [31:0] use;
  always @* begin
if (  reg_4  != tx_4 ) begin 
     auth_16 = rst_6;
     cfg_10 = hw_15;
    if ( rst_116  && data_3  || data_12 ) begin
        rx_11 = reg_16;
        auth_4 = fsm_12;
    end
        if ( fsm_10  || clk_2 ) begin
            core_16 = chip_13;
            err_79 = fsm_6;
        end
end
  end

  always @* begin
    assert ((here): 1. After the line "Assertion:" output ONLY immediate procedural assertions, one per line. 2. Each line MUST be exactly: assert (<boolean expression>); 3. Use only signal names that appear in the RTL snippet below. Do not invent new names. 4. Allowed operators: ==,!=, <, >, <=, >=, &&, ||,!, &, |, ^, ~, +, -, *, /, %, <<, >> (only if they appear in the RTL style). 5. Parenthesize generously so precedence is unambiguous. 6. Do NOT use: property,));
  end
endmodule
