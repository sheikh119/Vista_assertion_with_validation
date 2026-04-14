`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    sig_7 = '0;
    rst_13 = '0;
    sig_17 = '0;
    hw_17 = '0;
    err_12 = '0;
    clk_43 = '0;
    auth_4 = '0;
    rst_18 = '0;
    fsm_11 = '0;
    fsm_10 = '0;
    auth_1 = '0;
    clk_117 = '0;
    chip_17 = '0;
    reg_11 = '0;
    hw_12 = '0;
    sig_14 = '0;
    rx_15 = '0;
    tx_114 = '0;
    auth_20 = '0;
    reg_15 = '0;
    core_37 = '0;
    rst_20 = '0;
    clk_11 = '0;
    core_5 = '0;
    sig_9 = '0;
    hw_5 = '0;
    hw_4 = '0;
    rst_52 = '0;
  end
  logic [31:0] sig_7;
  logic [31:0] rst_13;
  logic [31:0] sig_17;
  logic [31:0] hw_17;
  logic [31:0] err_12;
  logic [31:0] clk_43;
  logic [31:0] auth_4;
  logic [31:0] rst_18;
  logic [31:0] fsm_11;
  logic [31:0] fsm_10;
  logic [31:0] auth_1;
  logic [31:0] clk_117;
  logic [31:0] chip_17;
  logic [31:0] reg_11;
  logic [31:0] hw_12;
  logic [31:0] sig_14;
  logic [31:0] rx_15;
  logic [31:0] tx_114;
  logic [31:0] auth_20;
  logic [31:0] reg_15;
  logic [31:0] core_37;
  logic [31:0] rst_20;
  logic [31:0] clk_11;
  logic [31:0] core_5;
  logic [31:0] sig_9;
  logic [31:0] hw_5;
  logic [31:0] hw_4;
  logic [31:0] rst_52;
  always @* begin
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
    assume (!rst);
    assert ((!(( sig_7 || rst_13 || sig_17 || hw_17 ))) || (err_12 == clk_43));
    assert ((!(( sig_7 || rst_13 || sig_17 || hw_17 ) && ( auth_4 != rst_18 ))) || (fsm_11 == fsm_10));
    assert ((!(( sig_7 || rst_13 || sig_17 || hw_17 ) && (!( auth_4 != rst_18 ) && ( auth_1 && clk_117 != chip_17 || reg_11 ) ))) || (hw_12 == sig_14));
    assert ((!(( sig_7 || rst_13 || sig_17 || hw_17 ) && ( !( auth_4 != rst_18 ) &&!( auth_1 && clk_117 != chip_17 || reg_11 ) ))) || (rx_15 == chip_17));
    assert ((!(! ( sig_7 || rst_13 || sig_17 || hw_17 ))) || (tx_114 == auth_20));
    assert ((!(! ( sig_7 || rst_13 || sig_17 || hw_17 ) && ( reg_15 ))) || (core_37 == rst_20));
    assert ((!(! ( sig_7 || rst_13 || sig_17 || hw_17 ) && (!( reg_15 ) && ( clk_11 && core_5 && sig_9 ) ))) || (hw_5 == sig_17));
    assert ((!(! ( sig_7 || rst_13 || sig_17 || hw_17 ) && (!( reg_15 ) &&!( clk_11 && core_5 && sig_9 ) ))) || (hw_4 == rst_52));
  end
endmodule
