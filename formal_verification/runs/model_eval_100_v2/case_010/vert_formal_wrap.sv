`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_20;
  logic [31:0] cfg_183;
  logic [31:0] cfg_2;
  logic [31:0] cfg_4;
  logic [31:0] cfg_6;
  logic [31:0] chip_11;
  logic [31:0] chip_12;
  logic [31:0] chip_20;
  logic [31:0] chip_7;
  logic [31:0] chip_96;
  logic [31:0] clk_10;
  logic [31:0] clk_118;
  logic [31:0] core_15;
  logic [31:0] core_20;
  logic [31:0] data_14;
  logic [31:0] data_16;
  logic [31:0] fsm_118;
  logic [31:0] fsm_13;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] reg_11;
  logic [31:0] reg_8;
  logic [31:0] rst_13;
  logic [31:0] rst_20;
  logic [31:0] rx_17;
  logic [31:0] rx_19;
  logic [31:0] rx_2;
  logic [31:0] rx_6;
  logic [31:0] rx_9;
  logic [31:0] sig_14;
  logic [31:0] sig_18;
  logic [31:0] sig_4;
  always_comb begin
if (  cfg_4  != core_15  || rst_13  || rst_20 ) begin 
    rx_17 = rx_9;
    if ( chip_11  || chip_7  && reg_8  || clk_10 ) begin
        sig_4 = rx_19;
    end
    else if (  auth_20  || core_20  != fsm_13  && reg_11 ) begin
        chip_20 = cfg_183;
    end
    else begin
        clk_118 = rx_2;
    end
end
else begin 
    data_16 = chip_12;
    if (  rx_6  || cfg_2 ) begin
        cfg_6 = sig_14;
    end
    else if (  fsm_118 ) begin
        sig_18 = cfg_6;
    end
    else begin
        chip_96 = data_14;
    end
end
  end
property p_gen_1; ( cfg_4 != core_15 || rst_13 || rst_20 ) |=> rx_17 == rx_9; endproperty
assert property (p_gen_1);
property p_gen_2; ( cfg_4 != core_15 || rst_13 || rst_20 ) && ( chip_11 || chip_7 && reg_8 || clk_10 ) |=> sig_4 == rx_19; endproperty
assert property (p_gen_2);
endmodule
