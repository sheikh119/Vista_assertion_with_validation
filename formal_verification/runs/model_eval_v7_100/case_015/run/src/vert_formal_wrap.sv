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
    tx_7 = '0;
    data_18 = '0;
    core_16 = '0;
    fsm_3 = '0;
    clk_7 = '0;
    auth_12 = '0;
    cfg_10 = '0;
    tx_15 = '0;
    reg_16 = '0;
    cfg_17 = '0;
    rst_8 = '0;
    auth_19 = '0;
    fsm_1 = '0;
    core_10 = '0;
    chip_19 = '0;
    rst_52 = '0;
    tx_2 = '0;
    cfg_12 = '0;
    err_18 = '0;
  end
  logic [31:0] cfg_4;
  logic [31:0] core_15;
  logic [31:0] rst_13;
  logic [31:0] rst_20;
  logic [31:0] tx_7;
  logic [31:0] data_18;
  logic [31:0] core_16;
  logic [31:0] fsm_3;
  logic [31:0] clk_7;
  logic [31:0] auth_12;
  logic [31:0] cfg_10;
  logic [31:0] tx_15;
  logic [31:0] reg_16;
  logic [31:0] cfg_17;
  logic [31:0] rst_8;
  logic [31:0] auth_19;
  logic [31:0] fsm_1;
  logic [31:0] core_10;
  logic [31:0] chip_19;
  logic [31:0] rst_52;
  logic [31:0] tx_2;
  logic [31:0] cfg_12;
  logic [31:0] err_18;
  always @* begin
if (  cfg_4  != core_15  || rst_13  || rst_20 ) begin
     tx_7 = data_18;
     core_16 = fsm_3;
    if ( clk_7  != auth_12  || cfg_10 ) begin
        tx_15 = reg_16;
        cfg_17 = rst_8;
    end
        if ( auth_19  != fsm_1  || core_10  || chip_19 ) begin
            rst_52 = tx_2;
            cfg_12 = err_18;
        end
end
    assume (!rst);
    assert ((!(( cfg_4 != core_15 || rst_13 || rst_20 ))) || (tx_7 == data_18 && core_16 == fsm_3));
    assert ((!(( cfg_4 != core_15 || rst_13 || rst_20 ) && ( clk_7 != auth_12 || cfg_10 ))) || (tx_15 == reg_16 && cfg_17 == rst_8));
    assert ((!(( cfg_4 != core_15 || rst_13 || rst_20 ) && ( clk_7 != auth_12 || cfg_10 ) && ( auth_19 != fsm_1 || core_10 || chip_19 ))) || (rst_52 == tx_2 && cfg_12 == err_18));
  end
endmodule
