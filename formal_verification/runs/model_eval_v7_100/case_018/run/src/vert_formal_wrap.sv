`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    start_bit_1 = '0;
    b0xx1x0x = '0;
    chip_8 = '0;
    core_19 = '0;
    bxx11x00 = '0;
    rx_10 = '0;
    data_6 = '0;
    b111111 = '0;
    rx_9 = '0;
    rst_18 = '0;
    b10x1x00 = '0;
    fsm_6 = '0;
    auth_1 = '0;
    data_8 = '0;
    data_17 = '0;
  end
  logic [31:0] start_bit_1;
  logic [31:0] b0xx1x0x;
  logic [31:0] chip_8;
  logic [31:0] core_19;
  logic [31:0] bxx11x00;
  logic [31:0] rx_10;
  logic [31:0] data_6;
  logic [31:0] b111111;
  logic [31:0] rx_9;
  logic [31:0] rst_18;
  logic [31:0] b10x1x00;
  logic [31:0] fsm_6;
  logic [31:0] auth_1;
  logic [31:0] data_8;
  logic [31:0] data_17;
  always @* begin
case ( start_bit_1 )
   7'b0xx1x0x : begin
     chip_8 = core_19;
   end
   7'bxx11x00 : begin
     rx_10 = data_6;
   end
   6'b111111 : begin
     rx_9 = rst_18;
   end
   7'b10x1x00 : begin
     fsm_6 = auth_1;
   end
   default : begin
     data_8 = data_17;
   end
endcase
    assume (!rst);
    assert ((!(( start_bit_1 ) == ( 7'b0xx1x0x ))) || (chip_8 == core_19));
    assert ((!(( start_bit_1 ) == ( 7'bxx11x00 ))) || (rx_10 == data_6));
    assert ((!(( start_bit_1 ) == ( 6'b111111 ))) || (rx_9 == rst_18));
    assert ((!(( start_bit_1 ) == ( 7'b10x1x00 ))) || (fsm_6 == auth_1));
  end
endmodule
