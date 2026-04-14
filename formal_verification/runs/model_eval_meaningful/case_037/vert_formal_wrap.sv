`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_13;
  logic [31:0] auth_14;
  logic [31:0] auth_5;
  logic [31:0] b0xxx010;
  logic [31:0] b1010x;
  logic [31:0] b111111x;
  logic [31:0] cfg_12;
  logic [31:0] cfg_19;
  logic [31:0] control_flag_register_3;
  logic [31:0] default;
  logic [31:0] fsm_19;
  logic [31:0] h6e;
  logic [31:0] rst_2;
  logic [31:0] rst_3;
  logic [31:0] rx_16;
  logic [31:0] tx_18;
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
  end

  always @* begin
    assert (((!(: ( control_flag_register_3 ) == ( 7'h6e ))) || (fsm_19 == auth_13)));
    assert (((!(: ( control_flag_register_3 ) == ( 5'b1010x ))) || (cfg_19 == rst_3)));
    assert (((!(: ( control_flag_register_3 ) == ( 7'b0xxx010 ))) || (rx_16 == cfg_12)));
    assert (((!(: ( control_flag_register_3 ) == ( 7'b111111x ))) || (auth_5 == tx_18)));
  end
endmodule
