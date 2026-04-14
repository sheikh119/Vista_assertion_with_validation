`timescale 1ns/1ps
module vert_formal_wrap;
  logic pll_clk_12;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] core_2;
  logic [31:0] data_14;
  logic [31:0] tx_19;
  logic [31:0] core_15;
  logic [31:0] fsm_115;
  logic [31:0] auth_11;
  logic [31:0] sig_18;
  logic [31:0] auth_9;
  logic [31:0] chip_4;
  logic [31:0] rst_18;
  logic [31:0] rst_7;
  logic [31:0] clk_3;
  logic [31:0] reg_13;
  logic [31:0] fsm_11;
  logic [31:0] fsm_100;
  logic [31:0] reg_15;
  logic [31:0] rst_52;
  logic [31:0] err_60;
  logic [31:0] core_13;
  logic [31:0] hw_19;
  logic [31:0] clk_4;
  logic [31:0] data_4;
  logic [31:0] rst_15;
  logic [31:0] reg_9;
  logic [31:0] hw_9;
  logic [31:0] err_4;
  logic [31:0] b1;
  always @(posedge pll_clk_12) begin
if (  core_2  != data_14  && tx_19 ) begin
   core_15 = fsm_115;
    if ( auth_11  || sig_18 ) begin
      auth_9 = chip_4;
   end
   else if (  rst_18  != rst_7  && clk_3  || reg_13 ) begin
      fsm_11 = fsm_100;
   end
   else begin
      reg_15 = rst_52;
   end
end
else begin
   err_60 = core_13;
   if (  hw_19 ) begin
      clk_4 = core_13;
   end
   else if (  data_4  || rst_15  != core_15 ) begin
      reg_9 <= hw_9;
   end
   else begin
      auth_9 <= err_4;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
