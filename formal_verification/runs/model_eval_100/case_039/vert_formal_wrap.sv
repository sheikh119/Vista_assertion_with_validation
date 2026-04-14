`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] N;
  logic [31:0] ResetTriggereotid;
  logic [31:0] SyncRxeotid;
  logic [31:0] b0110x11;
  logic [31:0] clk_12;
  logic [31:0] core_1;
  logic [31:0] default;
  logic [31:0] interrupt_control_14;
  logic [31:0] l;
  logic [31:0] lmaktad;
  logic [31:0] r;
  logic [31:0] rst_10;
  logic [31:0] rx_14;
  logic [31:0] sil;

  always_comb begin
case ( interrupt_control_14 ) 
   7'b0110x11 : begin
     clk_12 = rst_10;
   end
   default : begin 
     rx_14 = core_1;
   end
endcase
  end

 property ResetTriggereotid: ( interrupt_control_14 ) == ( 7'b0110x11 ) |=> clk_12 == rst_10 ;endproperty
 property SyncRxeotid; ( interrupt_control_14 )!= 7'b0110x11 ) ) |=> rx_14 == core_1 ; endproperty
 lásilЎыџNЎыџNılmaktadırыџN
endmodule
