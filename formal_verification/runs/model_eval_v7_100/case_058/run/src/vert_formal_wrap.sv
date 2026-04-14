`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    address_3 = '0;
    h6e = '0;
    data_20 = '0;
    rst_15 = '0;
    h26 = '0;
    data_10 = '0;
    rx_11 = '0;
    bxxxxx00 = '0;
    hw_9 = '0;
    chip_20 = '0;
    h37 = '0;
    rst_9 = '0;
    data_19 = '0;
    b000001 = '0;
    fsm_11 = '0;
    data_11 = '0;
    reg_5 = '0;
    rx_4 = '0;
  end
  logic [31:0] address_3;
  logic [31:0] h6e;
  logic [31:0] data_20;
  logic [31:0] rst_15;
  logic [31:0] h26;
  logic [31:0] data_10;
  logic [31:0] rx_11;
  logic [31:0] bxxxxx00;
  logic [31:0] hw_9;
  logic [31:0] chip_20;
  logic [31:0] h37;
  logic [31:0] rst_9;
  logic [31:0] data_19;
  logic [31:0] b000001;
  logic [31:0] fsm_11;
  logic [31:0] data_11;
  logic [31:0] reg_5;
  logic [31:0] rx_4;
  always @* begin
case ( address_3 )
   7'h6e : begin
     data_20 = rst_15;
   end
   7'h26 : begin
     data_10 = rx_11;
   end
   7'bxxxxx00 : begin
     hw_9 = chip_20;
   end
   7'h37 : begin
     rst_9 = data_19;
   end
   6'b000001 : begin
     fsm_11 = data_11;
   end
   default : begin
     reg_5 = rx_4;
   end
endcase
    assume (!rst);
    assert ((!(( address_3 ) == ( 7'h6e ))) || (data_20 == rst_15));
    assert ((!(( address_3 ) == ( 7'h26 ))) || (data_10 == rx_11));
    assert ((!(( address_3 ) == ( 7'bxxxxx00 ))) || (hw_9 == chip_20));
    assert ((!(( address_3 ) == ( 7'h37 ))) || (rst_9 == data_19));
    assert ((!(( address_3 ) == ( 6'b000001 ))) || (fsm_11 == data_11));
  end
endmodule
