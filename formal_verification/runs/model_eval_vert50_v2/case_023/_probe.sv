`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clk_signal_13;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] rx_19;
  logic [31:0] auth_19;
  logic [31:0] data_5;
  logic [31:0] tx_115;
  logic [31:0] hw_1;
  logic [31:0] tx_17;
  logic [31:0] rx_20;
  logic [31:0] auth_117;
  logic [31:0] clk_15;
  logic [31:0] auth_15;
  logic [31:0] rx_8;
  logic [31:0] core_147;
  logic [31:0] rst_4;
  logic [31:0] fsm_11;
  logic [31:0] clk_43;
  logic [31:0] core_9;
  logic [31:0] rst_12;
  logic [31:0] tx_12;
  logic [31:0] chip_2;
  logic [31:0] hw_15;
  logic [31:0] tx_18;
  logic [31:0] cfg_7;
  logic [31:0] rst_3;
  logic [31:0] rst_10;
  logic [31:0] rst_19;
  logic [31:0] rst_52;
  logic [31:0] hw_17;
  always @(posedge posedge clk_signal_13) begin
if (  rx_19  != auth_19  || data_5 ) begin 
   tx_115 = hw_1;
    if ( hw_1  || tx_17  && rx_20 ) begin
      auth_117 = clk_15;
   end
   else if (  auth_15 ) begin
      rx_8 = core_147;
   end
   else begin
      rst_4 <= fsm_11;
   end
end
else begin 
   clk_43 = core_9;
   if (  rst_12  || tx_12  && chip_2 ) begin
      hw_15 = tx_18;
   end
   else if (  cfg_7  != rst_3 ) begin
      rst_10 <= rst_19;
   end
   else begin
      rst_52 <= hw_17;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
