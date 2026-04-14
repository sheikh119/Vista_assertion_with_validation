`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] err_14;
  logic [31:0] rst_1;
  logic [31:0] fsm_2;
  logic [31:0] rx_8;
  logic [31:0] chip_4;
  logic [31:0] clk_14;
  logic [31:0] fsm_20;
  logic [31:0] auth_18;
  logic [31:0] chip_5;
  logic [31:0] hw_2;
  logic [31:0] reg_14;
  logic [31:0] rx_20;
  logic [31:0] reg_8;
  logic [31:0] rx_9;
  logic [31:0] core_20;
  logic [31:0] chip_11;
  logic [31:0] b1;
  always @* begin
if (  err_14  && rst_1  != fsm_2  || rx_8 ) begin
     chip_4 = clk_14;
    if ( fsm_20  && auth_18  || chip_5 ) begin
        hw_2 = reg_14;
    end
        if ( rx_20  && reg_8  != rx_9 ) begin
            core_20 = chip_11;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
