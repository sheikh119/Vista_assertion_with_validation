`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] BufferCheckeotid;
  logic [31:0] BufferMatcheotid;
  logic [31:0] BufferSynceotid;
  logic [31:0] DataSynceotid;
  logic [31:0] b010110;
  logic [31:0] b010x;
  logic [31:0] b0x1011;
  logic [31:0] chip_20;
  logic [31:0] chip_6;
  logic [31:0] clk_8;
  logic [31:0] core_17;
  logic [31:0] default;
  logic [31:0] fsm_4;
  logic [31:0] output_buffer_2;
  logic [31:0] reg_19;
  logic [31:0] rst_3;
  logic [31:0] sig_16;

  always_comb begin
case ( output_buffer_2 ) 
   6'b010110 : begin
     reg_19 = chip_20;
   end
   4'b010x : begin
     core_17 = clk_8;
   end
   6'b0x1011 : begin
     chip_6 = sig_16;
   end
   default : begin 
     fsm_4 = rst_3;
   end
endcase
  end

 property DataSynceotid: ( output_buffer_2 ) == ( 6'b010110 ) |=> reg_19 == chip_20 ;endproperty
 property BufferSynceotid: ( output_buffer_2 ) == ( 4'b010x ) |=> core_17 == clk_8 ;endproperty
 property BufferMatcheotid: ( output_buffer_2 ) == ( 6'b0x1011 ) |=> chip_6 == sig_16 ;endproperty
 property BufferCheckeotid; ( ( output_buffer_2 )!= 6'b010110 ) && ( ( output_buffer_2 )!= 4'b010x ) && ( output_buffer_2 )!= 6'b0x1011 ) ) |=> fsm_4 == rst_3 ; endproperty
endmodule
