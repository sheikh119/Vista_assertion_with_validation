`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    start_address_18 = '0;
    b0101000 = '0;
    fsm_13 = '0;
    reg_6 = '0;
    b1110x0x = '0;
    data_13 = '0;
    rst_4 = '0;
    bxxxxx11 = '0;
    core_12 = '0;
    cfg_7 = '0;
    bx110x = '0;
    cfg_20 = '0;
    rst_7 = '0;
    core_9 = '0;
    fsm_12 = '0;
  end
  logic [31:0] start_address_18;
  logic [31:0] b0101000;
  logic [31:0] fsm_13;
  logic [31:0] reg_6;
  logic [31:0] b1110x0x;
  logic [31:0] data_13;
  logic [31:0] rst_4;
  logic [31:0] bxxxxx11;
  logic [31:0] core_12;
  logic [31:0] cfg_7;
  logic [31:0] bx110x;
  logic [31:0] cfg_20;
  logic [31:0] rst_7;
  logic [31:0] core_9;
  logic [31:0] fsm_12;
  always @* begin
case ( start_address_18 )
   7'b0101000 : begin
     fsm_13 = reg_6;
   end
   7'b1110x0x : begin
     data_13 = rst_4;
   end
   7'bxxxxx11 : begin
     core_12 = cfg_7;
   end
   5'bx110x : begin
     cfg_20 = rst_7;
   end
   default : begin
     core_9 = fsm_12;
   end
endcase
    assume (!rst);
    assert ((!(( start_address_18 ) == ( 7'b0101000 ))) || (fsm_13 == reg_6));
    assert ((!(( start_address_18 ) == ( 7'b1110x0x ))) || (data_13 == rst_4));
    assert ((!(( start_address_18 ) == ( 7'bxxxxx11 ))) || (core_12 == cfg_7));
    assert ((!(( start_address_18 ) == ( 5'bx110x ))) || (cfg_20 == rst_7));
  end
endmodule
