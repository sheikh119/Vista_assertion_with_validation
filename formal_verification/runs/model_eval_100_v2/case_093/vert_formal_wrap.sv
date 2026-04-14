`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] cfg_14;
  logic [31:0] cfg_18;
  logic [31:0] cfg_7;
  logic [31:0] chip_16;
  logic [31:0] chip_18;
  logic [31:0] chip_7;
  logic [31:0] clk_118;
  logic [31:0] clk_20;
  logic [31:0] core_1;
  logic [31:0] core_13;
  logic [31:0] core_3;
  logic [31:0] data_10;
  logic [31:0] data_2;
  logic [31:0] err_15;
  logic [31:0] err_18;
  logic [31:0] fsm_2;
  logic [31:0] hw_13;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_118;
  logic [31:0] reg_16;
  logic [31:0] rst_1;
  logic [31:0] rx_1;
  logic [31:0] rx_12;
  logic [31:0] rx_17;
  logic [31:0] sig_2;
  logic [31:0] tx_115;
  logic [31:0] tx_117;
  logic [31:0] tx_17;
  always_comb begin
if (  hw_13  != rst_1  || data_2 ) begin 
    rx_12 = core_13;
    if ( fsm_2  != tx_17 ) begin
        sig_2 = chip_18;
    end
    else if (  rx_1 ) begin
        data_10 = chip_16;
    end
    else begin
        rx_1 = tx_117;
    end
end
else begin 
    cfg_18 = reg_118;
    if (  cfg_7  != reg_16  || err_18 ) begin
        core_3 = err_15;
    end
    else if (  core_1  != tx_115  && cfg_14 ) begin
        chip_7 = rx_17;
    end
    else begin
        clk_118 = clk_20;
    end
end
  end
property p_gen_1; ( hw_13 != rst_1 || data_2 ) |=> rx_12 == core_13; endproperty
assert property (p_gen_1);
property p_gen_2; ( hw_13 != rst_1 || data_2 ) && ( fsm_2 != tx_17 ) |=> sig_2 == chip_18; endproperty
assert property (p_gen_2);
property p_gen_3; ( hw_13 != rst_1 || data_2 ) && (!( fsm_2 != tx_17 ) && ( rx_1 ) ) |=> data_10 == chip_16; endproperty
assert property (p_gen_3);
endmodule
