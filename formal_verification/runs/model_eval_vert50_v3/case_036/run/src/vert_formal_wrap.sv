`timescale 1ns/1ps
module vert_formal_wrap;
  logic pll_clk_9;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] rx_198;
  logic [31:0] tx_115;
  logic [31:0] rx_6;
  logic [31:0] rst_99;
  logic [31:0] chip_18;
  logic [31:0] sig_16;
  logic [31:0] rx_5;
  logic [31:0] auth_3;
  logic [31:0] cfg_1;
  logic [31:0] auth_17;
  logic [31:0] core_112;
  logic [31:0] reg_13;
  logic [31:0] rst_6;
  logic [31:0] reg_12;
  logic [31:0] err_11;
  logic [31:0] tx_11;
  logic [31:0] data_8;
  logic [31:0] rst_14;
  logic [31:0] cfg_16;
  logic [31:0] chip_10;
  logic [31:0] hw_9;
  logic [31:0] core_10;
  logic [31:0] cfg_6;
  logic [31:0] fsm_6;
  logic [31:0] cfg_17;
  logic [31:0] cfg_5;
  logic [31:0] auth_6;
  logic [31:0] cfg_7;
  always @(negedge pll_clk_9) begin
if (  rx_198 ) begin 
   tx_115 = rx_6;
    if ( rst_99 ) begin
      chip_18 <= sig_16;
   end
   else if (  rx_5  && auth_3  || cfg_1 ) begin
      auth_17 = core_112;
   end
   else begin
      reg_13 <= rx_6;
   end
end
else begin 
   rst_6 = reg_12;
   if (  err_11  && tx_11  || data_8  != rst_14 ) begin
      cfg_16 <= chip_10;
   end
   else if (  hw_9  != core_10  || cfg_6  != fsm_6 ) begin
      cfg_17 = cfg_5;
   end
   else begin
      auth_6 <= cfg_7;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
