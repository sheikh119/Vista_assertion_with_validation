`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clk_gen_8;
  logic rst;
  logic [31:0] DataSynceotid;
  logic [31:0] ValidSynceotid;
  logic [31:0] auth_10;
  logic [31:0] auth_11;
  logic [31:0] auth_7;
  logic [31:0] b0x01x;
  logic [31:0] b0xx1xx;
  logic [31:0] bx1x1;
  logic [31:0] cfg_5;
  logic [31:0] clk_1;
  logic [31:0] clk_2;
  logic [31:0] clk_gen_8;
  logic [31:0] core_13;
  logic [31:0] core_2;
  logic [31:0] core_9;
  logic [31:0] data_6;
  logic [31:0] data_buffer_15;
  logic [31:0] default;
  logic [31:0] err_4;
  logic [31:0] err_6;
  logic [31:0] fsm;
  logic [31:0] fsm_17;
  logic [31:0] fsm_18;
  logic [31:0] fsm_4;
  logic [31:0] hw_13;
  logic [31:0] rst_18;
  logic [31:0] rx_5;
  logic [31:0] sig_11;
  logic [31:0] sig_2;
  logic [31:0] sig_5;
  logic [31:0] tx_1;
  logic [31:0] tx_19;

  always_ff @(posedge posedge clk_gen_8) begin
case ( data_buffer_15 ) 
   6'b0xx1xx : begin
     fsm_17 <= data_6
     core_9 <= auth_7
     clk_1 = rx_5;
   end
   5'b0x01x : begin
     hw_13 <= err_4
     err_6 <= core_13
     fsm_4 = sig_2;
   end
   4'bx1x1 : begin
     cfg_5 <= clk_2
     core_2 <= sig_5
     sig_11 <= fsm_18;
   end
   default : begin 
     auth_10 <= tx_1
     rst_18 = auth_11
     tx_19 <= rst_18;
   end
endcase
  end

property DataSynceotid; @(posedge clk_gen_8) ( data_buffer_15 ) == ( 6'b0xx1xx ) |-> fsm_17 == data_6 && core_9 == auth_7 && clk_1 == rx_5 ; endproperty
 property DataSynceotid; @(posedge clk_gen_8) ( data_buffer_15 ) == ( 5'b0x01x ) |-> hw_13 == err_4 && err_6 == core_13 && fsm_4 == sig_2 ; endproperty
 property ValidSynceotid; @(posedge clk_gen_8) ( data_buffer_15 ) == ( 4'bx1x1 ) |-> cfg_5 == clk_2 && core_2 == sig_5 && sig_11 == fsm
endmodule
