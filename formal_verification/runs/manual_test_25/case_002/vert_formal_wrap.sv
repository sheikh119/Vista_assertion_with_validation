`timescale 1ns/1ps
module vert_formal_wrap;
  logic cpu_clock_20;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] reg_2;
  logic [31:0] auth_19;
  logic [31:0] sig_19;
  logic [31:0] fsm_20;
  logic [31:0] rst_52;
  logic [31:0] tx_2;
  logic [31:0] chip_20;
  logic [31:0] clk_18;
  logic [31:0] auth_8;
  logic [31:0] cfg_13;
  logic [31:0] tx_115;
  logic [31:0] chip_120;
  logic [31:0] clk_5;
  logic [31:0] hw_16;
  logic [31:0] clk_4;
  logic [31:0] fsm_15;
  logic [31:0] fsm_3;
  logic [31:0] chip_5;
  logic [31:0] data_10;
  logic [31:0] auth_12;
  logic [31:0] hw_1;
  logic [31:0] tx_17;
  logic [31:0] rx_20;
  logic [31:0] hw_5;
  logic [31:0] chip_7;
  logic [31:0] data_2;
  logic [31:0] cfg_8;
  logic [31:0] rx_6;
  logic [31:0] fsm_112;
  logic [31:0] rx_8;
  logic [31:0] sig_2;
  logic [31:0] b1;
  always @(posedge cpu_clock_20) begin
if (  reg_2  && auth_19  && sig_19 ) begin
   fsm_20 = rst_52;
    if ( tx_2  || chip_20  && clk_18  || auth_8 ) begin
      cfg_13 = tx_115;
   end
   else if (  chip_120  && clk_5  != hw_16 ) begin
      clk_4 <= fsm_15;
   end
   else begin
      fsm_3 = chip_5;
   end
end
else begin
   data_10 = auth_12;
   if (  hw_1  || tx_17  && rx_20 ) begin
      hw_5 = auth_19;
   end
   else if (  chip_7  && data_2  && cfg_8  && rx_6 ) begin
      fsm_112 = rx_8;
   end
   else begin
      auth_12 = sig_2;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
