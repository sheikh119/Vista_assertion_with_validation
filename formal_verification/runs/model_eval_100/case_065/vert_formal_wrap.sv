`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] ErrorSynceotid;
  logic [31:0] SafeSynceotid;
  logic [31:0] SyncCheckeotid;
  logic [31:0] cfg_1;
  logic [31:0] chip_1;
  logic [31:0] clk_7;
  logic [31:0] clk_9;
  logic [31:0] core_150;
  logic [31:0] core_4;
  logic [31:0] data_10;
  logic [31:0] err_1;
  logic [31:0] err_10;
  logic [31:0] fsm_4;
  logic [31:0] reg_11;
  logic [31:0] reg_15;
  logic [31:0] rst_15;
  logic [31:0] rst_52;
  logic [31:0] rx_11;
  logic [31:0] rx_14;
  logic [31:0] rx_3;
  logic [31:0] sig_63;
  logic [31:0] tx_8;

  always_comb begin
if (  err_10  && core_150 ) begin 
     sig_63 = rx_3;
     core_4 = rx_14;
    if ( chip_1 ) begin
        reg_11 = clk_7;
        rst_52 = tx_8;
    end
        if ( fsm_4  && data_10  || err_1  && rx_11 ) begin
            rst_15 = clk_9;
            reg_15 = cfg_1;
        end
end
  end

 property ErrorSynceotid; (  err_10  && core_150 ) |=> sig_63 == rx_3 && core_4 == rx_14 ;endproperty
 property SyncCheckeotid; (  err_10  && core_150 ) &&  (  chip_1 ) |=> reg_11 == clk_7 && rst_52 == tx_8 ;endproperty
 property SafeSynceotid; (  err_10  && core_150 ) &&  (  chip_1 ) &&  (  fsm_4  && data_10  || err_1  && rx_11 ) |=> rst_15 == clk_9 && reg_15 == cfg_1 ;endproperty
endmodule
