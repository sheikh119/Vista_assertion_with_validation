`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] tx_16;
  logic [31:0] tx_15;
  logic [31:0] clk_17;
  logic [31:0] rx_114;
  logic [31:0] core_17;
  logic [31:0] tx_12;
  logic [31:0] core_20;
  logic [31:0] rx_1;
  logic [31:0] chip_9;
  logic [31:0] hw_70;
  logic [31:0] hw_11;
  logic [31:0] chip_14;
  logic [31:0] cfg_5;
  logic [31:0] reg_15;
  logic [31:0] clk_5;
  logic [31:0] chip_16;
  logic [31:0] clk_12;
  logic [31:0] clk_118;
  logic [31:0] rst_19;
  logic [31:0] hw_12;
  logic [31:0] reg_14;
  logic [31:0] b1;
  always @* begin
if (  tx_16  != tx_15  && clk_17 ) begin 
     rx_114 = core_17;
     tx_12 = core_20;
    if ( rx_1  != chip_9  && hw_70 ) begin
        hw_11 = chip_14;
        cfg_5 = reg_15;
    end
        if ( clk_5  != chip_16  || clk_12 ) begin
            clk_118 = rst_19;
            hw_12 = reg_14;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
