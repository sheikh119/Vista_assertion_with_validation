`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clk_reset_7;
  logic rst;
  logic [31:0] auth_12;
  logic [31:0] auth_14;
  logic [31:0] auth_7;
  logic [31:0] cfg_12;
  logic [31:0] cfg_14;
  logic [31:0] cfg_20;
  logic [31:0] cfg_3;
  logic [31:0] cfg_4;
  logic [31:0] chip_12;
  logic [31:0] clk_14;
  logic [31:0] clk_15;
  logic [31:0] clk_17;
  logic [31:0] clk_18;
  logic [31:0] clk_6;
  logic [31:0] clk_8;
  logic [31:0] clk_reset_7;
  logic [31:0] core_14;
  logic [31:0] core_9;
  logic [31:0] err_195;
  logic [31:0] err_60;
  logic [31:0] fsm_17;
  logic [31:0] fsm_19;
  logic [31:0] hw_20;
  logic [31:0] hw_7;
  logic [31:0] hw_8;
  logic [31:0] reg_58;
  logic [31:0] rx_19;
  logic [31:0] rx_8;
  logic [31:0] tx_10;
  logic [31:0] tx_7;
  always @(posedge posedge clk_reset_7) begin
if (  clk_14  != rx_19  || clk_8 ) begin 
   clk_15 <= hw_8;
    if ( cfg_14  != rx_19  || tx_10  != cfg_20 ) begin
      core_14 <= cfg_3;
   end
   else if (  hw_7  != hw_20 ) begin
      clk_6 <= err_60;
   end
   else begin
      cfg_12 <= fsm_19;
   end
end
else begin 
   cfg_4 = err_195;
   if (  clk_18  != auth_14  || rx_8  && core_9 ) begin
      clk_17 <= fsm_17;
   end
   else if (  auth_7 ) begin
      tx_7 = chip_12;
   end
   else begin
      reg_58 <= auth_12;
   end
end
  end

  always @* begin
    assert (((!(@(posedge clk_reset_7) ( clk_14 != rx_19 || clk_8 ))) || (clk_15 == hw_8)));
    assert (((!(@(posedge clk_reset_7) ( clk_14 != rx_19 || clk_8 ) && ( cfg_14 != rx_19 || tx_10 != cfg_20 ))) || (core_14 == cfg_3)));
  end
endmodule
