`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] interrupt_control_14;
  logic [31:0] b0110x11;
  logic [31:0] clk_12;
  logic [31:0] rst_10;
  logic [31:0] rx_14;
  logic [31:0] core_1;
  logic [31:0] b1;
  logic [31:0] Synchronous;
  logic [31:0] Clock;
  logic [31:0] None;
  logic [31:0] Assertion;
  logic [31:0] CtrlSynceotid;
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
    assume (!rst);
    assert (1'b1);
    assert (: case ( interrupt_control_14 ) 7'b0110x11 : begin clk_12 = rst_10; end default : begin rx_14 = core_1; end endcase Synchronous: False Clock: None Assertion: assert CtrlSynceotid; ( interrupt_control_14 ) == ( 7'b0110x11 ) ) | ( rx_14 ) == core_1);
  end
endmodule
