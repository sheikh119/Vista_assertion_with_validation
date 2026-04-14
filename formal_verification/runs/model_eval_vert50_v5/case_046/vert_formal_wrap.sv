`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_in_1;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] cfg_10;
  logic [31:0] cfg_14;
  logic [31:0] fsm_5;
  logic [31:0] reg_19;
  logic [31:0] fsm_116;
  logic [31:0] rx_5;
  logic [31:0] tx_163;
  logic [31:0] fsm_163;
  logic [31:0] core_4;
  logic [31:0] core_20;
  logic [31:0] chip_20;
  logic [31:0] hw_14;
  logic [31:0] rst_5;
  logic [31:0] clk_115;
  logic [31:0] sig_6;
  logic [31:0] fsm_15;
  logic [31:0] rx_11;
  logic [31:0] reg_18;
  logic [31:0] reg_116;
  logic [31:0] reg_12;
  logic [31:0] clk_16;
  logic [31:0] hw_20;
  logic [31:0] chip_18;
  logic [31:0] tx_8;
  logic [31:0] err_14;
  logic [31:0] err_3;
  logic [31:0] fsm_19;
  logic [31:0] cfg_18;
  logic [31:0] core_1;
  logic [31:0] data_18;
  logic [31:0] b1;
  always @(negedge clk_in_1) begin
if (  cfg_10  != cfg_14  && fsm_5  && reg_19 ) begin
   fsm_116 = rx_5;
    if ( tx_163  != fsm_163  || core_4 ) begin
      core_20 = chip_20;
   end
   else if (  hw_14  && rst_5  && clk_115 ) begin
      sig_6 = fsm_15;
   end
   else begin
      rx_11 <= reg_18;
   end
end
else begin
   reg_116 = reg_12;
   if (  clk_16  && hw_20 ) begin
      chip_18 = tx_8;
   end
   else if (  err_14  && err_3 ) begin
      fsm_19 <= cfg_18;
   end
   else begin
      core_1 = data_18;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
