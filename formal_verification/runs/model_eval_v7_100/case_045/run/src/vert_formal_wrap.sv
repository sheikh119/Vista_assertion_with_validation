`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    interrupt_request_3 = '0;
    h9 = '0;
    tx_20 = '0;
    reg_13 = '0;
    bxx0100x = '0;
    hw_11 = '0;
    err_6 = '0;
    bxx0xx1x = '0;
    reg_17 = '0;
    rx_20 = '0;
    h37 = '0;
    clk_7 = '0;
    tx_12 = '0;
    b0011x1 = '0;
    rst_8 = '0;
    rst_6 = '0;
    rst_19 = '0;
    fsm_3 = '0;
  end
  logic [31:0] interrupt_request_3;
  logic [31:0] h9;
  logic [31:0] tx_20;
  logic [31:0] reg_13;
  logic [31:0] bxx0100x;
  logic [31:0] hw_11;
  logic [31:0] err_6;
  logic [31:0] bxx0xx1x;
  logic [31:0] reg_17;
  logic [31:0] rx_20;
  logic [31:0] h37;
  logic [31:0] clk_7;
  logic [31:0] tx_12;
  logic [31:0] b0011x1;
  logic [31:0] rst_8;
  logic [31:0] rst_6;
  logic [31:0] rst_19;
  logic [31:0] fsm_3;
  always @* begin
case ( interrupt_request_3 )
   5'h9 : begin
     tx_20 = reg_13;
   end
   7'bxx0100x : begin
     hw_11 = err_6;
   end
   7'bxx0xx1x : begin
     reg_17 = rx_20;
   end
   6'h37 : begin
     clk_7 = tx_12;
   end
   6'b0011x1 : begin
     rst_8 = rst_6;
   end
   default : begin
     rst_19 = fsm_3;
   end
endcase
    assume (!rst);
    assert ((!(( interrupt_request_3 ) == ( 5'h9 ))) || (tx_20 == reg_13));
    assert ((!(( interrupt_request_3 ) == ( 7'bxx0100x ))) || (hw_11 == err_6));
    assert ((!(( interrupt_request_3 ) == ( 7'bxx0xx1x ))) || (reg_17 == rx_20));
    assert ((!(( interrupt_request_3 ) == ( 6'h37 ))) || (clk_7 == tx_12));
    assert ((!(( interrupt_request_3 ) == ( 6'b0011x1 ))) || (rst_8 == rst_6));
  end
endmodule
