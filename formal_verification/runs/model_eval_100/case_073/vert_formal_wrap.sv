`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] ClockSynceotid;
  logic [31:0] ErrorSynceotid;
  logic [31:0] ValidTxeotid;
  logic [31:0] b1100x01;
  logic [31:0] cfg_18;
  logic [31:0] chip_13;
  logic [31:0] clk_17;
  logic [31:0] clk_3;
  logic [31:0] core_1;
  logic [31:0] core_14;
  logic [31:0] core_18;
  logic [31:0] core_7;
  logic [31:0] data_14;
  logic [31:0] default;
  logic [31:0] err_5;
  logic [31:0] err_6;
  logic [31:0] err_8;
  logic [31:0] fsm_1;
  logic [31:0] fsm_14;
  logic [31:0] hw_10;
  logic [31:0] output_register_status_4;
  logic [31:0] reg_13;
  logic [31:0] rx_18;
  logic [31:0] rx_9;
  logic [31:0] sig_22;
  logic [31:0] tx_8;

  always_comb begin
case ( output_register_status_4 ) 
   7'b1100x01 : begin

      if (  err_5  != core_7  || sig_22 ) begin 
          clk_3 = tx_8;
          if ( err_8  && fsm_14  && core_18 ) begin
               err_6 = hw_10;
          end
      end

   end
   default : begin 
      if (  rx_18  != data_14  && clk_17 ) begin 
          fsm_1 = cfg_18;
          if ( core_14  != rx_9  && reg_13  || clk_17 ) begin
               core_1 = chip_13;
          end
      end

   end
endcase
  end

 property ClockSynceotid; ( output_register_status_4 ) == ( 7'b1100x01 ) &&  (  err_5 != core_7  || sig_22 ) |=> clk_3 == tx_8 ;endproperty
 property ErrorSynceotid; ( output_register_status_4 ) == ( 7'b1100x01 ) &&  (  err_5 != core_7  || sig_22 ) &&  (  err_8  && fsm_14  && core_18 ) |=> err_6 == hw_10 ;endproperty
  property ValidTxeotid;  ( output_register_status_4 )!= 7'b1100x01 &&  (  rx_18 != data_14  && clk_17 ) |=> fsm_1 == cfg_18 ;
endmodule
