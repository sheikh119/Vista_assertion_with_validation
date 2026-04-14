`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    hw_5 = '0;
    rx_14 = '0;
    rst_12 = '0;
    fsm_20 = '0;
    hw_9 = '0;
    err_60 = '0;
    hw_13 = '0;
    chip_17 = '0;
    clk_16 = '0;
    tx_16 = '0;
    reg_16 = '0;
    rst_16 = '0;
    core_11 = '0;
    rx_1 = '0;
    rst_5 = '0;
    rst_3 = '0;
    data_4 = '0;
    clk_3 = '0;
    auth_14 = '0;
    core_1 = '0;
    tx_12 = '0;
    cfg_14 = '0;
    err_79 = '0;
    hw_196 = '0;
    core_3 = '0;
    data_8 = '0;
    reg_15 = '0;
    tx_114 = '0;
    err_18 = '0;
    sig_28 = '0;
    chip_4 = '0;
  end
  logic [31:0] hw_5;
  logic [31:0] rx_14;
  logic [31:0] rst_12;
  logic [31:0] fsm_20;
  logic [31:0] hw_9;
  logic [31:0] err_60;
  logic [31:0] hw_13;
  logic [31:0] chip_17;
  logic [31:0] clk_16;
  logic [31:0] tx_16;
  logic [31:0] reg_16;
  logic [31:0] rst_16;
  logic [31:0] core_11;
  logic [31:0] rx_1;
  logic [31:0] rst_5;
  logic [31:0] rst_3;
  logic [31:0] data_4;
  logic [31:0] clk_3;
  logic [31:0] auth_14;
  logic [31:0] core_1;
  logic [31:0] tx_12;
  logic [31:0] cfg_14;
  logic [31:0] err_79;
  logic [31:0] hw_196;
  logic [31:0] core_3;
  logic [31:0] data_8;
  logic [31:0] reg_15;
  logic [31:0] tx_114;
  logic [31:0] err_18;
  logic [31:0] sig_28;
  logic [31:0] chip_4;
  always @* begin
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
    assume (!rst);
    assert ((!(( hw_5 && rx_14 && rst_12 || fsm_20 ))) || (hw_9 == err_60));
    assert ((!(( hw_5 && rx_14 && rst_12 || fsm_20 ) && ( hw_13 && chip_17 ))) || (clk_16 == tx_16));
    assert ((!(( hw_5 && rx_14 && rst_12 || fsm_20 ) && (!( hw_13 && chip_17 ) && ( tx_16 || reg_16 || rst_16 || core_11 ) ))) || (rx_1 == rst_5));
    assert ((!(( hw_5 && rx_14 && rst_12 || fsm_20 ) && ( !( hw_13 && chip_17 ) &&!( tx_16 || reg_16 || rst_16 || core_11 ) ))) || (rst_3 == data_4));
    assert ((!(! ( hw_5 && rx_14 && rst_12 || fsm_20 ))) || (clk_3 == auth_14));
    assert ((!(! ( hw_5 && rx_14 && rst_12 || fsm_20 ) && ( core_1 != tx_12 && cfg_14 ))) || (err_79 == hw_196));
    assert ((!(! ( hw_5 && rx_14 && rst_12 || fsm_20 ) && (!( core_1 != tx_12 && cfg_14 ) && ( core_3 != data_8 && reg_15 ) ))) || (tx_114 == err_18));
    assert ((!(! ( hw_5 && rx_14 && rst_12 || fsm_20 ) && (!( core_1 != tx_12 && cfg_14 ) &&!( core_3 != data_8 && reg_15 ) ))) || (sig_28 == chip_4));
  end
endmodule
