`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] b0110x11;
  logic [31:0] clk_12;
  logic [31:0] core_1;
  logic [31:0] default;
  logic [31:0] interrupt_control_14;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] rst_10;
  logic [31:0] rx_14;
  always_comb begin
case ( interrupt_control_14 ) 
   7'b0110x11 : begin
     clk_12 = rst_10;
   end
   default : begin 
     rx_14 = core_1;
   end
endcase
  end
property p_gen_1; ( interrupt_control_14 ) == ( 7'b0110x11 ) |=> clk_12 == rst_10; endproperty
assert property (p_gen_1);
property p_gen_2; ( interrupt_control_14 )!= 7'b0110x11) ) |=> rx_14 == core_1; endproperty
assert property (p_gen_2);
endmodule
