`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_signal_9;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] tx_2;
  logic [31:0] reg_13;
  logic [31:0] fsm_4;
  logic [31:0] err_6;
  logic [31:0] cfg_14;
  logic [31:0] sig_6;
  logic [31:0] rst_6;
  logic [31:0] fsm_2;
  logic [31:0] rst_12;
  logic [31:0] clk_15;
  logic [31:0] fsm_12;
  logic [31:0] rst_5;
  logic [31:0] chip_110;
  logic [31:0] core_15;
  logic [31:0] fsm_18;
  logic [31:0] sig_63;
  logic [31:0] data_10;
  logic [31:0] tx_115;
  logic [31:0] cfg_20;
  logic [31:0] sig_19;
  logic [31:0] rx_11;
  logic [31:0] reg_15;
  logic [31:0] clk_8;
  logic [31:0] hw_2;
  logic [31:0] hw_6;
  logic [31:0] cfg_16;
  logic [31:0] cfg_12;
  logic [31:0] data_203;
  logic [31:0] sig_32;
  logic [31:0] b1;
  always @(posedge clk_signal_9) begin
if (  tx_2  && reg_13 ) begin
   fsm_4 <= err_6;
    if ( cfg_14  || sig_6  || rst_6 ) begin
      fsm_2 <= rst_12;
   end
   else if (  clk_15  && fsm_12  && rst_5 ) begin
      chip_110 = core_15;
   end
   else begin
      fsm_18 <= sig_63;
   end
end
else begin
   data_10 = tx_115;
   if (  cfg_20  != sig_19  && data_10  || rx_11 ) begin
      reg_15 = clk_8;
   end
   else if (  hw_2  && hw_6 ) begin
      cfg_16 <= cfg_12;
   end
   else begin
      data_203 <= sig_32;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
