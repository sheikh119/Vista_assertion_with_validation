`timescale 1ns/1ps
module vert_formal_wrap;
  logic ref_clk_20;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] clk_20;
  logic [31:0] reg_15;
  logic [31:0] reg_8;
  logic [31:0] err_2;
  logic [31:0] reg_20;
  logic [31:0] sig_12;
  logic [31:0] sig_3;
  logic [31:0] fsm_11;
  logic [31:0] core_17;
  logic [31:0] clk_14;
  logic [31:0] rx_14;
  logic [31:0] err_4;
  logic [31:0] hw_9;
  logic [31:0] auth_8;
  logic [31:0] err_20;
  logic [31:0] core_14;
  logic [31:0] hw_10;
  logic [31:0] tx_14;
  logic [31:0] fsm_100;
  logic [31:0] core_5;
  logic [31:0] data_16;
  logic [31:0] rx_8;
  logic [31:0] sig_172;
  logic [31:0] core_3;
  logic [31:0] data_4;
  logic [31:0] chip_79;
  logic [31:0] chip_13;
  logic [31:0] core_2;
  logic [31:0] reg_5;
  logic [31:0] b1;
  always @(posedge ref_clk_20) begin
if (  clk_20  && reg_15  != reg_8 ) begin
   err_2 = reg_20;
    if ( sig_12  && sig_3 ) begin
      fsm_11 <= core_17;
   end
   else if (  clk_14  != rx_14  || err_4  || hw_9 ) begin
      auth_8 = err_20;
   end
   else begin
      core_14 = hw_10;
   end
end
else begin
   tx_14 = fsm_100;
   if (  core_5  != data_16 ) begin
      rx_8 <= sig_172;
   end
   else if (  core_3  || data_4 ) begin
      chip_79 <= chip_13;
   end
   else begin
      core_2 <= reg_5;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
