`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    clk_117 = '0;
    rx_19 = '0;
    clk_8 = '0;
    clk_27 = '0;
    data_14 = '0;
    clk_16 = '0;
    sig_12 = '0;
    hw_6 = '0;
    data_1 = '0;
    core_37 = '0;
    tx_13 = '0;
    cfg_5 = '0;
    chip_17 = '0;
    fsm_4 = '0;
    sig_32 = '0;
    core_1 = '0;
    hw_16 = '0;
    core_112 = '0;
    core_5 = '0;
    fsm_115 = '0;
    tx_16 = '0;
    rx_20 = '0;
    fsm_42 = '0;
    clk_122 = '0;
    hw_1 = '0;
    rst_14 = '0;
    auth_8 = '0;
    cfg_18 = '0;
  end
  logic [31:0] clk_117;
  logic [31:0] rx_19;
  logic [31:0] clk_8;
  logic [31:0] clk_27;
  logic [31:0] data_14;
  logic [31:0] clk_16;
  logic [31:0] sig_12;
  logic [31:0] hw_6;
  logic [31:0] data_1;
  logic [31:0] core_37;
  logic [31:0] tx_13;
  logic [31:0] cfg_5;
  logic [31:0] chip_17;
  logic [31:0] fsm_4;
  logic [31:0] sig_32;
  logic [31:0] core_1;
  logic [31:0] hw_16;
  logic [31:0] core_112;
  logic [31:0] core_5;
  logic [31:0] fsm_115;
  logic [31:0] tx_16;
  logic [31:0] rx_20;
  logic [31:0] fsm_42;
  logic [31:0] clk_122;
  logic [31:0] hw_1;
  logic [31:0] rst_14;
  logic [31:0] auth_8;
  logic [31:0] cfg_18;
  always @* begin
if (  clk_117  != rx_19  || clk_8 ) begin
    clk_27 = data_14;
    if ( clk_16  && sig_12  != hw_6 ) begin
        data_1 = core_37;
    end
    else if (  tx_13  != cfg_5  && chip_17  && fsm_4 ) begin
        sig_32 = core_1;
    end
    else begin
        hw_16 = core_112;
    end
end
else begin
    core_5 = fsm_115;
    if (  tx_16  != rx_20 ) begin
        fsm_42 = clk_122;
    end
    else if (  hw_1 ) begin
        clk_27 = rst_14;
    end
    else begin
        auth_8 = cfg_18;
    end
end
    assume (!rst);
    assert ((!(( clk_117 != rx_19 || clk_8 ))) || (clk_27 == data_14));
    assert ((!(( clk_117 != rx_19 || clk_8 ) && ( clk_16 && sig_12 != hw_6 ))) || (data_1 == core_37));
    assert ((!(( clk_117 != rx_19 || clk_8 ) && (!( clk_16 && sig_12 != hw_6 ) && ( tx_13 != cfg_5 && chip_17 && fsm_4 ) ))) || (sig_32 == core_1));
    assert ((!(( clk_117 != rx_19 || clk_8 ) && ( !( clk_16 && sig_12 != hw_6 ) &&!( tx_13 != cfg_5 && chip_17 && fsm_4 ) ))) || (hw_16 == core_112));
    assert ((!(! ( clk_117 != rx_19 || clk_8 ))) || (core_5 == fsm_115));
    assert ((!(! ( clk_117 != rx_19 || clk_8 ) && ( tx_16 != rx_20 ))) || (fsm_42 == clk_122));
    assert ((!(! ( clk_117 != rx_19 || clk_8 ) && (!( tx_16 != rx_20 ) && ( hw_1 ) ))) || (clk_27 == rst_14));
    assert ((!(! ( clk_117 != rx_19 || clk_8 ) && (!( tx_16 != rx_20 ) &&!( hw_1 ) ))) || (auth_8 == cfg_18));
  end
endmodule
