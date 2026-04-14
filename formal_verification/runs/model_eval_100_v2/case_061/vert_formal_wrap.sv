`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge bus_clock_20;
  logic rst;
  logic [31:0] auth_117;
  logic [31:0] auth_2;
  logic [31:0] auth_3;
  logic [31:0] auth_8;
  logic [31:0] bus_clock_20;
  logic [31:0] cfg_2;
  logic [31:0] chip_8;
  logic [31:0] clk_20;
  logic [31:0] clk_6;
  logic [31:0] data_11;
  logic [31:0] data_16;
  logic [31:0] err_11;
  logic [31:0] err_16;
  logic [31:0] err_20;
  logic [31:0] fsm_16;
  logic [31:0] fsm_9;
  logic [31:0] hw_4;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_5;
  logic [31:0] rst_3;
  logic [31:0] rst_7;
  logic [31:0] rst_9;
  logic [31:0] rx_17;
  logic [31:0] rx_4;
  logic [31:0] sig_10;
  logic [31:0] sig_11;
  logic [31:0] tx_114;
  always_ff @(posedge posedge bus_clock_20) begin
if (  fsm_16  || err_16  != data_11 ) begin 
   rst_9 <= chip_8;
    if ( clk_20  || rst_7 ) begin
      auth_3 <= rst_3;
   end
   else if (  data_16  || err_20  != rx_4 ) begin
      auth_117 = sig_10;
   end
   else begin
      sig_11 <= clk_6;
   end
end
else begin 
   cfg_2 = tx_114;
   if (  auth_2 ) begin
      fsm_9 = reg_5;
   end
   else if (  err_11 ) begin
      auth_8 = auth_2;
   end
   else begin
      hw_4 = rx_17;
   end
end
  end
property p_gen_1; @(posedge bus_clock_20) ( fsm_16 || err_16 != data_11 ) |-> rst_9 == chip_8; endproperty
assert property (p_gen_1);
property p_gen_2; @(posedge bus_clock_20) ( fsm_16 || err_16 != data_11 ) && ( clk_20 || rst_7 ) |-> auth_3 == rst_3; endproperty
assert property (p_gen_2);
property p_gen_3; @(posedge bus_clock_20) ( fsm_16 || err_16 != data_11 ) && (!( clk_20 || rst_7 ) && ( data_16 || err_20 != rx_4 ) ) |-> auth_117 == sig_10; endproperty
assert property (p_gen_3);
endmodule
