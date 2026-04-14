`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] auth_6;
  logic [31:0] b1;
  logic [31:0] boolean;
  logic [31:0] cfg_15;
  logic [31:0] chip_8;
  logic [31:0] clk_13;
  logic [31:0] clk_3;
  logic [31:0] clk_4;
  logic [31:0] data_1;
  logic [31:0] data_10;
  logic [31:0] data_15;
  logic [31:0] data_2;
  logic [31:0] expr;
  logic [31:0] expression;
  logic [31:0] hw_13;
  logic [31:0] hw_6;
  logic [31:0] reg_12;
  logic [31:0] reg_9;
  logic [31:0] rx_6;
  logic [31:0] sig_116;
  logic [31:0] sig_17;
  logic [31:0] tx_14;
  logic [31:0] tx_16;
  logic [31:0] tx_2;
  always @* begin
if (  auth_6  && data_1 ) begin 
     sig_17 = data_10;
     hw_13 = reg_9;
    if ( data_15  && rx_6  && hw_6 ) begin
        tx_2 = chip_8;
        cfg_15 = clk_4;
    end
        if ( tx_16  && tx_14  && reg_12 ) begin
            clk_13 = clk_3;
            sig_116 = data_2;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (<boolean expression>);
    assert (expr);
    assert (1'b1);
    assert (...);
  end
endmodule
