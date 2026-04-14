`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    clk_1 = '0;
    auth_2 = '0;
    rx_18 = '0;
    hw_20 = '0;
    clk_118 = '0;
    hw_15 = '0;
    data_12 = '0;
    core_19 = '0;
    clk_11 = '0;
    clk_19 = '0;
    hw_17 = '0;
    hw_16 = '0;
    tx_3 = '0;
    clk_3 = '0;
    tx_18 = '0;
    auth_16 = '0;
    core_2 = '0;
    auth_11 = '0;
    cfg_14 = '0;
    data_14 = '0;
  end
  logic [31:0] clk_1;
  logic [31:0] auth_2;
  logic [31:0] rx_18;
  logic [31:0] hw_20;
  logic [31:0] clk_118;
  logic [31:0] hw_15;
  logic [31:0] data_12;
  logic [31:0] core_19;
  logic [31:0] clk_11;
  logic [31:0] clk_19;
  logic [31:0] hw_17;
  logic [31:0] hw_16;
  logic [31:0] tx_3;
  logic [31:0] clk_3;
  logic [31:0] tx_18;
  logic [31:0] auth_16;
  logic [31:0] core_2;
  logic [31:0] auth_11;
  logic [31:0] cfg_14;
  logic [31:0] data_14;
  always @* begin
if (  clk_1 ) begin
     auth_2 = rx_18;
     hw_20 = clk_1;
     clk_118 = hw_15;
    if ( data_12  || core_19 ) begin
        clk_11 = clk_19;
        hw_17 = hw_16;
        tx_3 = clk_3;
    end
        if ( core_19 ) begin
            tx_18 = auth_16;
            core_2 = auth_11;
            cfg_14 = data_14;
        end
end
    assume (!rst);
    assert ((!(( clk_1 ))) || (auth_2 == rx_18 && hw_20 == clk_1 && clk_118 == hw_15));
    assert ((!(( clk_1 ) && ( data_12 || core_19 ))) || (clk_11 == clk_19 && hw_17 == hw_16 && tx_3 == clk_3));
    assert ((!(( clk_1 ) && ( data_12 || core_19 ) && ( core_19 ))) || (tx_18 == auth_16 && core_2 == auth_11 && cfg_14 == data_14));
  end
endmodule
