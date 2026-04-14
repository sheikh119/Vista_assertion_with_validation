`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_1;
  logic [31:0] auth_20;
  logic [31:0] auth_4;
  logic [31:0] chip_17;
  logic [31:0] clk_11;
  logic [31:0] clk_117;
  logic [31:0] clk_43;
  logic [31:0] core_37;
  logic [31:0] core_5;
  logic [31:0] err_12;
  logic [31:0] fsm_10;
  logic [31:0] fsm_11;
  logic [31:0] hw_12;
  logic [31:0] hw_17;
  logic [31:0] hw_4;
  logic [31:0] hw_5;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_11;
  logic [31:0] reg_15;
  logic [31:0] rst_13;
  logic [31:0] rst_18;
  logic [31:0] rst_20;
  logic [31:0] rst_52;
  logic [31:0] rx_15;
  logic [31:0] sig_14;
  logic [31:0] sig_17;
  logic [31:0] sig_7;
  logic [31:0] sig_9;
  logic [31:0] tx_114;
  always_comb begin
if (  sig_7  || rst_13  || sig_17  || hw_17 ) begin 
    err_12 = clk_43;
    if ( auth_4  != rst_18 ) begin
        fsm_11 = fsm_10;
    end
    else if (  auth_1  && clk_117  != chip_17  || reg_11 ) begin
        hw_12 = sig_14;
    end
    else begin
        rx_15 = chip_17;
    end
end
else begin 
    tx_114 = auth_20;
    if (  reg_15 ) begin
        core_37 = rst_20;
    end
    else if (  clk_11  && core_5  && sig_9 ) begin
        hw_5 = sig_17;
    end
    else begin
        hw_4 = rst_52;
    end
end
  end
property p_gen_1; ( sig_7 || rst_13 || sig_17 || hw_17 ) |=> err_12 == clk_43; endproperty
assert property (p_gen_1);
property p_gen_2; ( sig_7 || rst_13 || sig_17 || hw_17 ) && ( auth_4 != rst_18 ) |=> fsm_11 == fsm_10; endproperty
assert property (p_gen_2);
property p_gen_3; ( sig_7 || rst_13 || sig_17 || hw_17 ) && (!( auth_4 != rst_18 ) && ( auth_1 && clk_117 != chip_17 || reg_11 ) ) |=> hw_12 == sig_14; endproperty
assert property (p_gen_3);
endmodule
