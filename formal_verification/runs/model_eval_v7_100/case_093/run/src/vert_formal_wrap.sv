`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    hw_13 = '0;
    rst_1 = '0;
    data_2 = '0;
    rx_12 = '0;
    core_13 = '0;
    fsm_2 = '0;
    tx_17 = '0;
    sig_2 = '0;
    chip_18 = '0;
    rx_1 = '0;
    data_10 = '0;
    chip_16 = '0;
    tx_117 = '0;
    cfg_18 = '0;
    reg_118 = '0;
    cfg_7 = '0;
    reg_16 = '0;
    err_18 = '0;
    core_3 = '0;
    err_15 = '0;
    core_1 = '0;
    tx_115 = '0;
    cfg_14 = '0;
    chip_7 = '0;
    rx_17 = '0;
    clk_118 = '0;
    clk_20 = '0;
  end
  logic [31:0] hw_13;
  logic [31:0] rst_1;
  logic [31:0] data_2;
  logic [31:0] rx_12;
  logic [31:0] core_13;
  logic [31:0] fsm_2;
  logic [31:0] tx_17;
  logic [31:0] sig_2;
  logic [31:0] chip_18;
  logic [31:0] rx_1;
  logic [31:0] data_10;
  logic [31:0] chip_16;
  logic [31:0] tx_117;
  logic [31:0] cfg_18;
  logic [31:0] reg_118;
  logic [31:0] cfg_7;
  logic [31:0] reg_16;
  logic [31:0] err_18;
  logic [31:0] core_3;
  logic [31:0] err_15;
  logic [31:0] core_1;
  logic [31:0] tx_115;
  logic [31:0] cfg_14;
  logic [31:0] chip_7;
  logic [31:0] rx_17;
  logic [31:0] clk_118;
  logic [31:0] clk_20;
  always @* begin
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
    assume (!rst);
    assert ((!(( hw_13 != rst_1 || data_2 ))) || (rx_12 == core_13));
    assert ((!(( hw_13 != rst_1 || data_2 ) && ( fsm_2 != tx_17 ))) || (sig_2 == chip_18));
    assert ((!(( hw_13 != rst_1 || data_2 ) && (!( fsm_2 != tx_17 ) && ( rx_1 ) ))) || (data_10 == chip_16));
    assert ((!(( hw_13 != rst_1 || data_2 ) && ( !( fsm_2 != tx_17 ) &&!( rx_1 ) ))) || (rx_1 == tx_117));
    assert ((!(! ( hw_13 != rst_1 || data_2 ))) || (cfg_18 == reg_118));
    assert ((!(! ( hw_13 != rst_1 || data_2 ) && ( cfg_7 != reg_16 || err_18 ))) || (core_3 == err_15));
    assert ((!(! ( hw_13 != rst_1 || data_2 ) && (!( cfg_7 != reg_16 || err_18 ) && ( core_1 != tx_115 && cfg_14 ) ))) || (chip_7 == rx_17));
    assert ((!(! ( hw_13 != rst_1 || data_2 ) && (!( cfg_7 != reg_16 || err_18 ) &&!( core_1 != tx_115 && cfg_14 ) ))) || (clk_118 == clk_20));
  end
endmodule
