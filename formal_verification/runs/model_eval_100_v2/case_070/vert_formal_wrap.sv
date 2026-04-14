`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_14;
  logic [31:0] cfg_14;
  logic [31:0] chip_17;
  logic [31:0] chip_4;
  logic [31:0] clk_16;
  logic [31:0] clk_3;
  logic [31:0] core_1;
  logic [31:0] core_11;
  logic [31:0] core_3;
  logic [31:0] data_4;
  logic [31:0] data_8;
  logic [31:0] err_18;
  logic [31:0] err_60;
  logic [31:0] err_79;
  logic [31:0] fsm_20;
  logic [31:0] hw_13;
  logic [31:0] hw_196;
  logic [31:0] hw_5;
  logic [31:0] hw_9;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_15;
  logic [31:0] reg_16;
  logic [31:0] rst_12;
  logic [31:0] rst_16;
  logic [31:0] rst_3;
  logic [31:0] rst_5;
  logic [31:0] rx_1;
  logic [31:0] rx_14;
  logic [31:0] sig_28;
  logic [31:0] tx_114;
  logic [31:0] tx_12;
  logic [31:0] tx_16;
  always_comb begin
if (  hw_5  && rx_14  && rst_12  || fsm_20 ) begin 
    hw_9 = err_60;
    if ( hw_13  && chip_17 ) begin
        clk_16 = tx_16;
    end
    else if (  tx_16  || reg_16  || rst_16  || core_11 ) begin
        rx_1 = rst_5;
    end
    else begin
        rst_3 = data_4;
    end
end
else begin 
    clk_3 = auth_14;
    if (  core_1  != tx_12  && cfg_14 ) begin
        err_79 = hw_196;
    end
    else if (  core_3  != data_8  && reg_15 ) begin
        tx_114 = err_18;
    end
    else begin
        sig_28 = chip_4;
    end
end
  end
property p_gen_1; ( hw_5 && rx_14 && rst_12 || fsm_20 ) |=> hw_9 == err_60; endproperty
assert property (p_gen_1);
property p_gen_2; ( hw_5 && rx_14 && rst_12 || fsm_20 ) && ( hw_13 && chip_17 ) |=> clk_16 == tx_16; endproperty
assert property (p_gen_2);
property p_gen_3; ( hw_5 && rx_14 && rst_12 || fsm_20 ) && (!( hw_13 && chip_17 ) && ( tx_16 || reg_16 || rst_16 || core_11 ) ) |=> rx_1 == rst_5; endproperty
assert property (p_gen_3);
endmodule
