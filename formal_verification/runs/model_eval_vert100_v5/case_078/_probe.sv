`timescale 1ns/1ps
module vert_formal_wrap;
  logic bus_clock_11;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] tx_6;
  logic [31:0] sig_116;
  logic [31:0] fsm_6;
  logic [31:0] chip_7;
  logic [31:0] err_11;
  logic [31:0] rst_18;
  logic [31:0] core_1;
  logic [31:0] hw_8;
  logic [31:0] clk_7;
  logic [31:0] core_12;
  logic [31:0] core_11;
  logic [31:0] err_20;
  logic [31:0] tx_16;
  logic [31:0] chip_11;
  logic [31:0] tx_115;
  logic [31:0] core_10;
  logic [31:0] core_20;
  logic [31:0] clk_118;
  logic [31:0] hw_38;
  logic [31:0] hw_1;
  logic [31:0] tx_17;
  logic [31:0] rx_20;
  logic [31:0] rx_2;
  logic [31:0] chip_16;
  logic [31:0] core_18;
  logic [31:0] cfg_16;
  logic [31:0] tx_19;
  logic [31:0] hw_20;
  logic [31:0] cfg_11;
  logic [31:0] b1;
  always @(posedge bus_clock_11) begin
if ( !tx_6 ) begin
   sig_116 = fsm_6;
    if ( chip_7  != err_11  || rst_18  != core_1 ) begin
      hw_8 <= clk_7;
   end
   else if (  core_12  || core_11  || err_20  != tx_16 ) begin
      chip_11 <= tx_115;
   end
   else begin
      core_10 = core_20;
   end
end
else begin
   clk_118 = hw_38;
   if (  hw_1  || tx_17  && rx_20 ) begin
      rx_2 = chip_16;
   end
   else if (  core_18 ) begin
      cfg_16 <= tx_19;
   end
   else begin
      hw_20 <= cfg_11;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
