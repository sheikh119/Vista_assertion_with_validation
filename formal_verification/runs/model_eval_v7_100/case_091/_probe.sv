`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    start_address_12 = '0;
    b10x11 = '0;
    core_4 = '0;
    clk_2 = '0;
    b0xxx00 = '0;
    err_17 = '0;
    chip_8 = '0;
    b1x = '0;
    clk_17 = '0;
    hw_12 = '0;
    clk_10 = '0;
    data_15 = '0;
    cfg_12 = '0;
    tx_12 = '0;
    rst_1 = '0;
  end
  logic [31:0] start_address_12;
  logic [31:0] b10x11;
  logic [31:0] core_4;
  logic [31:0] clk_2;
  logic [31:0] b0xxx00;
  logic [31:0] err_17;
  logic [31:0] chip_8;
  logic [31:0] b1x;
  logic [31:0] clk_17;
  logic [31:0] hw_12;
  logic [31:0] clk_10;
  logic [31:0] data_15;
  logic [31:0] cfg_12;
  logic [31:0] tx_12;
  logic [31:0] rst_1;
  always @* begin
case ( start_address_12 )
   5'b10x11 : begin
     core_4 = clk_2;
   end
   6'b0xxx00 : begin
     err_17 = chip_8;
   end
   2'b1x : begin
     clk_17 = hw_12;
   end
   clk_10 : begin
     data_15 = cfg_12;
   end
   default : begin
     tx_12 = rst_1;
   end
endcase
    assume (!rst);
    assert ((!(( start_address_12 ) == ( 5'b10x11 ))) || (core_4 == clk_2));
    assert ((!(( start_address_12 ) == ( 6'b0xxx00 ))) || (err_17 == chip_8));
    assert ((!(( start_address_12 ) == ( 2'b1x ))) || (clk_17 == hw_12));
    assert ((!(( start_address_12 ) == ( clk_10 ))) || (data_15 == cfg_12));
    assert ((!(( ( start_address_12 )!= 5'b10x11 ) && ( ( start_address_12 )!= 6'b0xxx00 ) && ( ( start_address_12 )!= 2'b1x ) && ( start_address_12 )!= clk_10 ) ))) || (tx_12 == rst_1));
  end
endmodule
