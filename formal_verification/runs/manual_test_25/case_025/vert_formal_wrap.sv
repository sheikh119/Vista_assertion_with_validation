`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_source_11;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] clk_20;
  logic [31:0] reg_15;
  logic [31:0] reg_8;
  logic [31:0] tx_17;
  logic [31:0] rst_14;
  logic [31:0] tx_2;
  logic [31:0] chip_20;
  logic [31:0] clk_18;
  logic [31:0] auth_5;
  logic [31:0] fsm_114;
  logic [31:0] data_11;
  logic [31:0] core_63;
  logic [31:0] tx_66;
  logic [31:0] auth_7;
  logic [31:0] clk_1;
  logic [31:0] hw_38;
  logic [31:0] fsm_12;
  logic [31:0] err_2;
  logic [31:0] err_17;
  logic [31:0] core_17;
  logic [31:0] chip_1;
  logic [31:0] err_60;
  logic [31:0] cfg_6;
  logic [31:0] sig_16;
  logic [31:0] err_16;
  logic [31:0] data_185;
  logic [31:0] tx_1;
  logic [31:0] b1;
  always @(negedge clock_source_11) begin
if (  clk_20  && reg_15  != reg_8 ) begin
   tx_17 = rst_14;
    if ( tx_2  || chip_20  && clk_18  || auth_5 ) begin
      fsm_114 <= data_11;
   end
   else if (  core_63  || tx_66  || auth_7 ) begin
      clk_1 = hw_38;
   end
   else begin
      fsm_12 = err_2;
   end
end
else begin
   err_17 = core_17;
   if (  rst_14  != chip_1 ) begin
      hw_38 = err_60;
   end
   else if (  cfg_6  != sig_16 ) begin
      err_16 <= fsm_12;
   end
   else begin
      data_185 <= tx_1;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
