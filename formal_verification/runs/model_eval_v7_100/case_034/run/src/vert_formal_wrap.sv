`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    chip_13 = '0;
    auth_3 = '0;
    rst_13 = '0;
    core_3 = '0;
    data_1 = '0;
    fsm_112 = '0;
    chip_15 = '0;
    rx_16 = '0;
    fsm_8 = '0;
    fsm_12 = '0;
    data_178 = '0;
    tx_118 = '0;
    reg_14 = '0;
    clk_15 = '0;
    sig_5 = '0;
    cfg_10 = '0;
    cfg_13 = '0;
    rst_116 = '0;
    hw_19 = '0;
  end
  logic [31:0] chip_13;
  logic [31:0] auth_3;
  logic [31:0] rst_13;
  logic [31:0] core_3;
  logic [31:0] data_1;
  logic [31:0] fsm_112;
  logic [31:0] chip_15;
  logic [31:0] rx_16;
  logic [31:0] fsm_8;
  logic [31:0] fsm_12;
  logic [31:0] data_178;
  logic [31:0] tx_118;
  logic [31:0] reg_14;
  logic [31:0] clk_15;
  logic [31:0] sig_5;
  logic [31:0] cfg_10;
  logic [31:0] cfg_13;
  logic [31:0] rst_116;
  logic [31:0] hw_19;
  always @* begin
if (  chip_13  || auth_3  && rst_13 ) begin
     core_3 = data_1;
     fsm_112 = chip_15;
    if ( rx_16 ) begin
        fsm_8 = fsm_12;
        data_178 = auth_3;
    end
        if ( tx_118  != reg_14  || clk_15  != sig_5 ) begin
            cfg_10 = cfg_13;
            rst_116 = hw_19;
        end
end
    assume (!rst);
    assert ((!(( chip_13 || auth_3 && rst_13 ))) || (core_3 == data_1 && fsm_112 == chip_15));
    assert ((!(( chip_13 || auth_3 && rst_13 ) && ( rx_16 ))) || (fsm_8 == fsm_12 && data_178 == auth_3));
    assert ((!(( chip_13 || auth_3 && rst_13 ) && ( rx_16 ) && ( tx_118 != reg_14 || clk_15 != sig_5 ))) || (cfg_10 == cfg_13 && rst_116 == hw_19));
  end
endmodule
