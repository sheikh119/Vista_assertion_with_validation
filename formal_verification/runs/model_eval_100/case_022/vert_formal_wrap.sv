`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge async_clk_8;
  logic rst;
  logic [31:0] ClockSynceotid;
  logic [31:0] ValidTxeotid;
  logic [31:0] async_clk_8;
  logic [31:0] auth_15;
  logic [31:0] b10100x;
  logic [31:0] bx0xxx0;
  logic [31:0] chip_11;
  logic [31:0] clk_10;
  logic [31:0] clk_15;
  logic [31:0] control_data_9;
  logic [31:0] data_7;
  logic [31:0] default;
  logic [31:0] err_10;
  logic [31:0] err_13;
  logic [31:0] err_14;
  logic [31:0] err_7;
  logic [31:0] err_9;
  logic [31:0] fsm_;
  logic [31:0] fsm_10;
  logic [31:0] fsm_5;
  logic [31:0] fsm_9;
  logic [31:0] hw_19;
  logic [31:0] hw_3;
  logic [31:0] reg_13;
  logic [31:0] tx_10;

  always_ff @(posedge posedge async_clk_8) begin
case ( control_data_9 ) 
   6'b10100x : begin
     data_7 = hw_3
     clk_15 <= err_7
     err_10 <= clk_10;
   end
   6'bx0xxx0 : begin
     fsm_5 <= err_13
     err_14 = hw_19
     tx_10 = auth_15;
   end
   default : begin 
     fsm_10 = fsm_9
     auth_15 = chip_11
     err_9 = reg_13;
   end
endcase
  end

 property ClockSynceotid; @(posedge async_clk_8) ( control_data_9 ) == ( 6'b10100x ) |-> data_7 == hw_3 && clk_15 == err_7 && err_10 == clk_10 ; endproperty
 property ValidTxeotid; @(posedge async_clk_8) ( control_data_9 ) == ( 6'bx0xxx0 ) |-> fsm_
endmodule
