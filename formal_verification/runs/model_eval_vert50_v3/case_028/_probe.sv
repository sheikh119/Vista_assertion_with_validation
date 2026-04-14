`timescale 1ns/1ps
module vert_formal_wrap;
  logic mem_clock_20;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] rst_5;
  logic [31:0] auth_16;
  logic [31:0] rx_16;
  logic [31:0] rst_52;
  logic [31:0] tx_13;
  logic [31:0] fsm_13;
  logic [31:0] core_4;
  logic [31:0] rst_14;
  logic [31:0] rst_8;
  logic [31:0] tx_119;
  logic [31:0] tx_14;
  logic [31:0] reg_36;
  logic [31:0] reg_2;
  logic [31:0] fsm_5;
  logic [31:0] tx_27;
  logic [31:0] auth_204;
  logic [31:0] tx_2;
  logic [31:0] chip_20;
  logic [31:0] clk_18;
  logic [31:0] auth_8;
  logic [31:0] reg_58;
  logic [31:0] reg_11;
  logic [31:0] auth_13;
  logic [31:0] clk_6;
  logic [31:0] data_15;
  logic [31:0] sig_12;
  logic [31:0] hw_13;
  logic [31:0] tx_5;
  logic [31:0] hw_8;
  always @(posedge mem_clock_20) begin
if (  rst_5  || auth_16 ) begin 
   rx_16 = rst_52;
    if ( tx_13  != fsm_13  || core_4 ) begin
      rst_14 = rst_8;
   end
   else if (  tx_119 ) begin
      tx_14 = reg_36;
   end
   else begin
      reg_2 <= fsm_5;
   end
end
else begin 
   tx_27 = auth_204;
   if (  tx_2  || chip_20  && clk_18  || auth_8 ) begin
      reg_58 <= reg_11;
   end
   else if (  auth_13  || clk_6  && data_15  && sig_12 ) begin
      hw_13 = tx_5;
   end
   else begin
      hw_8 = auth_13;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
