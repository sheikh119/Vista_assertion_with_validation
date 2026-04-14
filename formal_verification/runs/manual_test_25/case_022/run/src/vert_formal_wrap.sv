`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] rst_ni;
  logic [31:0] chip_110;
  logic [31:0] clk_15;
  logic [31:0] rx_114;
  logic [31:0] fsm_18;
  logic [31:0] rst_80;
  logic [31:0] clk_3;
  logic [31:0] core_75;
  logic [31:0] reg_9;
  logic [31:0] sig_63;
  logic [31:0] rx_13;
  logic [31:0] tx_13;
  logic [31:0] reg_16;
  logic [31:0] tx_9;
  logic [31:0] clk_27;
  logic [31:0] chip_14;
  logic [31:0] chip_15;
  logic [31:0] chip_9;
  logic [31:0] b1;
  always @* begin
if ( !rst_ni ) begin
     chip_110 = clk_15;
     rx_114 = fsm_18;
    if ( rst_80  || clk_3 ) begin
        core_75 = reg_9;
        sig_63 = rx_13;
    end
        if ( tx_13  != reg_16  || tx_9 ) begin
            clk_27 = chip_14;
            chip_15 = chip_9;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
