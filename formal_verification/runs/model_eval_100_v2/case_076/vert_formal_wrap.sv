`timescale 1ns/1ps
module vert_formal_wrap;
  logic negedge pll_clk_7;
  logic rst;
  logic [31:0] auth_2;
  logic [31:0] b11xx1;
  logic [31:0] bxx00x;
  logic [31:0] chip_14;
  logic [31:0] chip_3;
  logic [31:0] chip_5;
  logic [31:0] core_5;
  logic [31:0] default;
  logic [31:0] enable_16;
  logic [31:0] err_8;
  logic [31:0] fsm_17;
  logic [31:0] fsm_18;
  logic [31:0] h4a;
  logic [31:0] hw_7;
  logic [31:0] hw_8;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] pll_clk_7;
  logic [31:0] reg_7;
  logic [31:0] rst_15;
  logic [31:0] rst_9;
  logic [31:0] rx_19;
  logic [31:0] sig_9;
  logic [31:0] tx_4;
  always_ff @(posedge negedge pll_clk_7) begin
case ( enable_16 ) 
   5'bxx00x : begin
     chip_3 <= rst_9
     fsm_17 <= rst_15;
   end
   7'h4a : begin
     tx_4 = core_5
     rx_19 = auth_2;
   end
   5'b11xx1 : begin
     fsm_18 = err_8
     hw_7 = chip_5;
   end
   default : begin 
     reg_7 = chip_14
     hw_8 <= sig_9;
   end
endcase
  end
property p_gen_1; @(negedge pll_clk_7) ( enable_16 ) == ( 5'bxx00x ) |-> chip_3 == rst_9 && fsm_17 == rst_15 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(negedge pll_clk_7) ( enable_16 ) == ( 7'h4a ) |-> tx_4 == core_5 && rx_19 == auth_2 ; endproperty
assert property (p_gen_2);
property p_gen_3; @(negedge pll_clk_7) ( enable_16 ) == ( 5'b11xx1 ) |-> fsm_18 == err_8 && hw_7 == chip_5 ; endproperty
assert property (p_gen_3);
endmodule
