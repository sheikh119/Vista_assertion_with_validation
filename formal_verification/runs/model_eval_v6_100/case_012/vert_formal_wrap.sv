`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_in_4;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] reg_8;
  logic [31:0] rst_4;
  logic [31:0] auth_11;
  logic [31:0] chip_17;
  logic [31:0] clk_19;
  logic [31:0] reg_10;
  logic [31:0] tx_18;
  logic [31:0] tx_7;
  logic [31:0] core_19;
  logic [31:0] auth_7;
  logic [31:0] clk_100;
  logic [31:0] chip_20;
  logic [31:0] chip_1;
  logic [31:0] err_1;
  logic [31:0] hw_15;
  logic [31:0] hw_10;
  logic [31:0] data_120;
  logic [31:0] data_18;
  logic [31:0] rx_7;
  logic [31:0] cfg_17;
  logic [31:0] clk_15;
  logic [31:0] data_12;
  logic [31:0] tx_1;
  logic [31:0] data_85;
  logic [31:0] core_17;
  always @(negedge clk_in_4) begin
if (  reg_8  != rst_4  || auth_11 ) begin
    chip_17 <= clk_19;
    reg_10 = tx_18;
    tx_7 <= core_19;
    if ( reg_10  || auth_7  != clk_100  && chip_20 ) begin
        chip_1 <= err_1;
        hw_15 = hw_10;
        data_120 = data_18;
    end
        if ( rx_7  && cfg_17 ) begin
            clk_15 <= data_12;
            tx_1 <= data_85;
            err_1 <= core_17;
        end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( reg_8 != rst_4 || auth_11 ))) || (chip_17 == clk_19 && reg_10 == tx_18 && tx_7 == core_19));
    assert ((!(( reg_8 != rst_4 || auth_11 ) && ( reg_10 || auth_7 != clk_100 && chip_20 ))) || (chip_1 == err_1 && hw_15 == hw_10 && data_120 == data_18));
    assert ((!(( reg_8 != rst_4 || auth_11 ) && ( reg_10 || auth_7 != clk_100 && chip_20 ) && ( rx_7 && cfg_17 ))) || (clk_15 == data_12 && tx_1 == data_85 && err_1 == core_17));
  end
endmodule
