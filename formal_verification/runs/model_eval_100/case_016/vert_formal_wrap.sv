`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] CoreSynceotid;
  logic [31:0] InitOKeotid;
  logic [31:0] ResetSynceotid;
  logic [31:0] ValidAddreotid;
  logic [31:0] b0101000;
  logic [31:0] b1110x0;
  logic [31:0] b1110x0x;
  logic [31:0] bx110x;
  logic [31:0] bxxxxx11;
  logic [31:0] cfg_20;
  logic [31:0] cfg_7;
  logic [31:0] core_12;
  logic [31:0] core_9;
  logic [31:0] data_13;
  logic [31:0] default;
  logic [31:0] fsm_12;
  logic [31:0] fsm_13;
  logic [31:0] reg_6;
  logic [31:0] rst_4;
  logic [31:0] rst_7;
  logic [31:0] start_address_18;

  always_comb begin
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
  end

 property InitOKeotid: ( start_address_18 ) == ( 7'b0101000 ) |=> fsm_13 == reg_6 ;endproperty
 property ResetSynceotid: ( start_address_18 ) == ( 7'b1110x0x ) |=> data_13 == rst_4 ;endproperty
 property CoreSynceotid: ( start_address_18 ) == ( 7'bxxxxx11 ) |=> core_12 == cfg_7 ;endproperty
 property ResetSynceotid: ( start_address_18 ) == ( 5'bx110x ) |=> cfg_20 == rst_7 ;endproperty
 property ValidAddreotid; ( ( start_address_18 )!= 7'b0101000 ) && ( ( start_address_18 )!= 7'b1110x0
endmodule
