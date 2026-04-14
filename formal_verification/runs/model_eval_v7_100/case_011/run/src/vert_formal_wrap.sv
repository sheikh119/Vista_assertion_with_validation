`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    reg_4 = '0;
    tx_4 = '0;
    auth_16 = '0;
    rst_6 = '0;
    cfg_10 = '0;
    hw_15 = '0;
    rst_116 = '0;
    data_3 = '0;
    data_12 = '0;
    rx_11 = '0;
    reg_16 = '0;
    auth_4 = '0;
    fsm_12 = '0;
    fsm_10 = '0;
    clk_2 = '0;
    core_16 = '0;
    chip_13 = '0;
    err_79 = '0;
    fsm_6 = '0;
  end
  logic [31:0] reg_4;
  logic [31:0] tx_4;
  logic [31:0] auth_16;
  logic [31:0] rst_6;
  logic [31:0] cfg_10;
  logic [31:0] hw_15;
  logic [31:0] rst_116;
  logic [31:0] data_3;
  logic [31:0] data_12;
  logic [31:0] rx_11;
  logic [31:0] reg_16;
  logic [31:0] auth_4;
  logic [31:0] fsm_12;
  logic [31:0] fsm_10;
  logic [31:0] clk_2;
  logic [31:0] core_16;
  logic [31:0] chip_13;
  logic [31:0] err_79;
  logic [31:0] fsm_6;
  always @* begin
if (  reg_4  != tx_4 ) begin
     auth_16 = rst_6;
     cfg_10 = hw_15;
    if ( rst_116  && data_3  || data_12 ) begin
        rx_11 = reg_16;
        auth_4 = fsm_12;
    end
        if ( fsm_10  || clk_2 ) begin
            core_16 = chip_13;
            err_79 = fsm_6;
        end
end
    assume (!rst);
    assert ((!(( reg_4 != tx_4 ))) || (auth_16 == rst_6 && cfg_10 == hw_15));
    assert ((!(( reg_4 != tx_4 ) && ( rst_116 && data_3 || data_12 ))) || (rx_11 == reg_16 && auth_4 == fsm_12));
    assert ((!(( reg_4 != tx_4 ) && ( rst_116 && data_3 || data_12 ) && ( fsm_10 || clk_2 ))) || (core_16 == chip_13 && err_79 == fsm_6));
  end
endmodule
