`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] b0110x11;
  logic [31:0] clk_12;
  logic [31:0] core_1;
  logic [31:0] default;
  logic [31:0] interrupt_control_14;
  logic [31:0] rst_10;
  logic [31:0] rx_14;
  always @* begin
case ( interrupt_control_14 ) 
   7'b0110x11 : begin
     clk_12 = rst_10;
   end
   default : begin 
     rx_14 = core_1;
   end
endcase
  end

  always @* begin
    assert (((!(: ( interrupt_control_14 ) == ( 7'b0110x11 ))) || (clk_12 == rst_10)));
    assert (((!(( interrupt_control_14 )!= 7'b0110x11 ) ))) || (rx_14 == core_1)));
  end
endmodule
