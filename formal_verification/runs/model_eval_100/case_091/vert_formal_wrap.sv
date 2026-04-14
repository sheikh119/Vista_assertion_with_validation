`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] ClockSynceotid;
  logic [31:0] ResetCheckeotid;
  logic [31:0] SyncStarteotid;
  logic [31:0] b0xxx00;
  logic [31:0] b10x11;
  logic [31:0] b1x;
  logic [31:0] cfg_12;
  logic [31:0] chip_8;
  logic [31:0] clk_10;
  logic [31:0] clk_17;
  logic [31:0] clk_2;
  logic [31:0] core_4;
  logic [31:0] data_15;
  logic [31:0] default;
  logic [31:0] err_17;
  logic [31:0] feTxeotid;
  logic [31:0] hw_12;
  logic [31:0] rst_1;
  logic [31:0] start_address_;
  logic [31:0] start_address_12;
  logic [31:0] tx_12;

  always_comb begin
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
  end

 property ClockSynceotid: ( start_address_12 ) == ( 5'b10x11 ) |=> core_4 == clk_2 ;endproperty
 property ResetCheckeotid: ( start_address_12 ) == ( 6'b0xxx00 ) |=> err_17 == chip_8 ;endproperty
 property SyncStarteotid: ( start_address_12 ) == ( 2'b1x ) |=> clk_17 == hw_12 ;endproperty
 property ClockSynceotid: ( start_address_12 ) == ( clk_10 ) |=> data_15 == cfg_12 ;endproperty
 property feTxeotid; ( ( start_address_12 )!= 5'b10x11 ) && ( ( start_address_12 )!= 6'b0xxx00 ) && ( ( start_address_
endmodule
