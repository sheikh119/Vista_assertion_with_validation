`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    cfg_4 = '0;
    core_15 = '0;
    rst_13 = '0;
    rst_20 = '0;
    rx_17 = '0;
    rx_9 = '0;
    chip_11 = '0;
    chip_7 = '0;
    reg_8 = '0;
    clk_10 = '0;
    sig_4 = '0;
    rx_19 = '0;
    auth_20 = '0;
    core_20 = '0;
    fsm_13 = '0;
    reg_11 = '0;
    chip_20 = '0;
    cfg_183 = '0;
    clk_118 = '0;
    rx_2 = '0;
    data_16 = '0;
    chip_12 = '0;
    rx_6 = '0;
    cfg_2 = '0;
    cfg_6 = '0;
    sig_14 = '0;
    fsm_118 = '0;
    sig_18 = '0;
    chip_96 = '0;
    data_14 = '0;
  end
  logic [31:0] cfg_4;
  logic [31:0] core_15;
  logic [31:0] rst_13;
  logic [31:0] rst_20;
  logic [31:0] rx_17;
  logic [31:0] rx_9;
  logic [31:0] chip_11;
  logic [31:0] chip_7;
  logic [31:0] reg_8;
  logic [31:0] clk_10;
  logic [31:0] sig_4;
  logic [31:0] rx_19;
  logic [31:0] auth_20;
  logic [31:0] core_20;
  logic [31:0] fsm_13;
  logic [31:0] reg_11;
  logic [31:0] chip_20;
  logic [31:0] cfg_183;
  logic [31:0] clk_118;
  logic [31:0] rx_2;
  logic [31:0] data_16;
  logic [31:0] chip_12;
  logic [31:0] rx_6;
  logic [31:0] cfg_2;
  logic [31:0] cfg_6;
  logic [31:0] sig_14;
  logic [31:0] fsm_118;
  logic [31:0] sig_18;
  logic [31:0] chip_96;
  logic [31:0] data_14;
  always @* begin
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
    assume (!rst);
    assert ((!(( cfg_4 != core_15 || rst_13 || rst_20 ))) || (rx_17 == rx_9));
    assert ((!(( cfg_4 != core_15 || rst_13 || rst_20 ) && ( chip_11 || chip_7 && reg_8 || clk_10 ))) || (sig_4 == rx_19));
    assert ((!(( cfg_4 != core_15 || rst_13 || rst_20 ) && (!( chip_11 || chip_7 && reg_8 || clk_10 ) && ( auth_20 || core_20 != fsm_13 && reg_11 ) ))) || (chip_20 == cfg_183));
    assert ((!(( cfg_4 != core_15 || rst_13 || rst_20 ) && ( !( chip_11 || chip_7 && reg_8 || clk_10 ) &&!( auth_20 || core_20 != fsm_13 && reg_11 ) ))) || (clk_118 == rx_2));
    assert ((!(! ( cfg_4 != core_15 || rst_13 || rst_20 ))) || (data_16 == chip_12));
    assert ((!(! ( cfg_4 != core_15 || rst_13 || rst_20 ) && ( rx_6 || cfg_2 ))) || (cfg_6 == sig_14));
    assert ((!(! ( cfg_4 != core_15 || rst_13 || rst_20 ) && (!( rx_6 || cfg_2 ) && ( fsm_118 ) ))) || (sig_18 == cfg_6));
    assert ((!(! ( cfg_4 != core_15 || rst_13 || rst_20 ) && (!( rx_6 || cfg_2 ) &&!( fsm_118 ) ))) || (chip_96 == data_14));
  end
endmodule
