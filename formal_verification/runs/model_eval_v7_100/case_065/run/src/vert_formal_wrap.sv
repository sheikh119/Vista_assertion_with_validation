`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    err_10 = '0;
    core_150 = '0;
    sig_63 = '0;
    rx_3 = '0;
    core_4 = '0;
    rx_14 = '0;
    chip_1 = '0;
    reg_11 = '0;
    clk_7 = '0;
    rst_52 = '0;
    tx_8 = '0;
    fsm_4 = '0;
    data_10 = '0;
    err_1 = '0;
    rx_11 = '0;
    rst_15 = '0;
    clk_9 = '0;
    reg_15 = '0;
    cfg_1 = '0;
  end
  logic [31:0] err_10;
  logic [31:0] core_150;
  logic [31:0] sig_63;
  logic [31:0] rx_3;
  logic [31:0] core_4;
  logic [31:0] rx_14;
  logic [31:0] chip_1;
  logic [31:0] reg_11;
  logic [31:0] clk_7;
  logic [31:0] rst_52;
  logic [31:0] tx_8;
  logic [31:0] fsm_4;
  logic [31:0] data_10;
  logic [31:0] err_1;
  logic [31:0] rx_11;
  logic [31:0] rst_15;
  logic [31:0] clk_9;
  logic [31:0] reg_15;
  logic [31:0] cfg_1;
  always @* begin
if (  err_10  && core_150 ) begin
     sig_63 = rx_3;
     core_4 = rx_14;
    if ( chip_1 ) begin
        reg_11 = clk_7;
        rst_52 = tx_8;
    end
        if ( fsm_4  && data_10  || err_1  && rx_11 ) begin
            rst_15 = clk_9;
            reg_15 = cfg_1;
        end
end
    assume (!rst);
    assert ((!(( err_10 && core_150 ))) || (sig_63 == rx_3 && core_4 == rx_14));
    assert ((!(( err_10 && core_150 ) && ( chip_1 ))) || (reg_11 == clk_7 && rst_52 == tx_8));
    assert ((!(( err_10 && core_150 ) && ( chip_1 ) && ( fsm_4 && data_10 || err_1 && rx_11 ))) || (rst_15 == clk_9 && reg_15 == cfg_1));
  end
endmodule
