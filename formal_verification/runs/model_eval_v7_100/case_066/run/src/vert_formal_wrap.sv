`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    data_12 = '0;
    reg_18 = '0;
    err_12 = '0;
    chip_17 = '0;
    rx_8 = '0;
    hw_2 = '0;
    data_5 = '0;
    clk_2 = '0;
    sig_3 = '0;
    data_13 = '0;
    rx_20 = '0;
    rx_4 = '0;
    clk_18 = '0;
    err_11 = '0;
    sig_6 = '0;
    reg_12 = '0;
    hw_15 = '0;
    fsm_19 = '0;
    cfg_15 = '0;
    cfg_7 = '0;
    err_190 = '0;
  end
  logic [31:0] data_12;
  logic [31:0] reg_18;
  logic [31:0] err_12;
  logic [31:0] chip_17;
  logic [31:0] rx_8;
  logic [31:0] hw_2;
  logic [31:0] data_5;
  logic [31:0] clk_2;
  logic [31:0] sig_3;
  logic [31:0] data_13;
  logic [31:0] rx_20;
  logic [31:0] rx_4;
  logic [31:0] clk_18;
  logic [31:0] err_11;
  logic [31:0] sig_6;
  logic [31:0] reg_12;
  logic [31:0] hw_15;
  logic [31:0] fsm_19;
  logic [31:0] cfg_15;
  logic [31:0] cfg_7;
  logic [31:0] err_190;
  always @* begin
if (  data_12  || reg_18  && err_12  && chip_17 ) begin
     rx_8 = hw_2;
     data_5 = clk_2;
    if ( sig_3  != data_13  && rx_20  && rx_4 ) begin
        clk_18 = err_11;
        sig_6 = reg_12;
    end
        if ( hw_15 ) begin
            fsm_19 = cfg_15;
            cfg_7 = err_190;
        end
end
    assume (!rst);
    assert ((!(( data_12 || reg_18 && err_12 && chip_17 ))) || (rx_8 == hw_2 && data_5 == clk_2));
    assert ((!(( data_12 || reg_18 && err_12 && chip_17 ) && ( sig_3 != data_13 && rx_20 && rx_4 ))) || (clk_18 == err_11 && sig_6 == reg_12));
    assert ((!(( data_12 || reg_18 && err_12 && chip_17 ) && ( sig_3 != data_13 && rx_20 && rx_4 ) && ( hw_15 ))) || (fsm_19 == cfg_15 && cfg_7 == err_190));
  end
endmodule
