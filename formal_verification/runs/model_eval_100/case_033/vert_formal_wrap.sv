`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge ref_clk_11;
  logic rst;
  logic [31:0] N;
  logic [31:0] ValidReadeotid;
  logic [31:0] ValidTxeotid;
  logic [31:0] b1x01000;
  logic [31:0] cfg_17;
  logic [31:0] chip_6;
  logic [31:0] clk_1;
  logic [31:0] core_14;
  logic [31:0] default;
  logic [31:0] lmaktad;
  logic [31:0] r;
  logic [31:0] read_data_12;
  logic [31:0] ref_clk_11;
  logic [31:0] rst_18;
  logic [31:0] rx_17;
  logic [31:0] sig_16;
  logic [31:0] tx_4;

  always_ff @(posedge posedge ref_clk_11) begin
case ( read_data_12 ) 
   7'b1x01000 : begin
     rst_18 = rx_17
     clk_1 <= tx_4;
   end
   default : begin 
     chip_6 = sig_16
     core_14 <= cfg_17;
   end
endcase
  end

property ValidTxeotid; @(posedge ref_clk_11) ( read_data_12 ) == ( 7'b1x01000 ) |-> rst_18 == rx_17 && clk_1 == tx_4 ; endproperty
 property ValidReadeotid; @(posedge ref_clk_11) ( read_data_12 )!= 7'b1x01000  |-> chip_6 == sig_16 && core_14 == cfg_17; endproperty
 ılmaktadırЎыџNЎыџNЎыџN
endmodule
