`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    control_flag_register_3 = '0;
    h6e = '0;
    fsm_19 = '0;
    auth_13 = '0;
    b1010x = '0;
    cfg_19 = '0;
    rst_3 = '0;
    b0xxx010 = '0;
    rx_16 = '0;
    cfg_12 = '0;
    b111111x = '0;
    auth_5 = '0;
    tx_18 = '0;
    rst_2 = '0;
    auth_14 = '0;
  end
  logic [31:0] control_flag_register_3;
  logic [31:0] h6e;
  logic [31:0] fsm_19;
  logic [31:0] auth_13;
  logic [31:0] b1010x;
  logic [31:0] cfg_19;
  logic [31:0] rst_3;
  logic [31:0] b0xxx010;
  logic [31:0] rx_16;
  logic [31:0] cfg_12;
  logic [31:0] b111111x;
  logic [31:0] auth_5;
  logic [31:0] tx_18;
  logic [31:0] rst_2;
  logic [31:0] auth_14;
  always @* begin
case ( control_flag_register_3 )
   7'h6e : begin
     fsm_19 = auth_13;
   end
   5'b1010x : begin
     cfg_19 = rst_3;
   end
   7'b0xxx010 : begin
     rx_16 = cfg_12;
   end
   7'b111111x : begin
     auth_5 = tx_18;
   end
   default : begin
     rst_2 = auth_14;
   end
endcase
    assume (!rst);
    assert ((!(( control_flag_register_3 ) == ( 7'h6e ))) || (fsm_19 == auth_13));
    assert ((!(( control_flag_register_3 ) == ( 5'b1010x ))) || (cfg_19 == rst_3));
    assert ((!(( control_flag_register_3 ) == ( 7'b0xxx010 ))) || (rx_16 == cfg_12));
    assert ((!(( control_flag_register_3 ) == ( 7'b111111x ))) || (auth_5 == tx_18));
    assert ((!(( ( control_flag_register_3 )!= 7'h6e ) && ( ( control_flag_register_3 )!= 5'b1010x ) && ( ( control_flag_register_3 )!= 7'b0xxx010 ) && ( control_flag_register_3 )!= 7'b111111x ) ))) || (rst_2 == auth_14));
  end
endmodule
