`timescale 1ns/1ps
module vert_formal_wrap;
  logic sys_clk_9;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] fsm_2;
  logic [31:0] rst_12;
  logic [31:0] sig_2;
  logic [31:0] clk_1;
  logic [31:0] data_116;
  logic [31:0] err_158;
  logic [31:0] data_7;
  logic [31:0] hw_15;
  logic [31:0] data_20;
  logic [31:0] cfg_2;
  logic [31:0] reg_15;
  logic [31:0] hw_18;
  logic [31:0] fsm_16;
  logic [31:0] fsm_1;
  logic [31:0] rx_12;
  logic [31:0] data_11;
  logic [31:0] sig_12;
  logic [31:0] tx_16;
  logic [31:0] sig_1;
  logic [31:0] rx_6;
  logic [31:0] tx_112;
  logic [31:0] cfg_18;
  logic [31:0] core_11;
  logic [31:0] core_18;
  logic [31:0] tx_17;
  logic [31:0] hw_12;
  always @(negedge sys_clk_9) begin
if (  fsm_2  || rst_12  && sig_2 ) begin
   clk_1 = data_116;
    if ( err_158  != data_7 ) begin
      hw_15 = data_20;
   end
   else if (  cfg_2  != reg_15  || hw_18  || fsm_16 ) begin
      fsm_1 <= rx_12;
   end
   else begin
      data_11 <= sig_12;
   end
end
else begin
   tx_16 = sig_1;
   if (  rx_6  || cfg_2 ) begin
      tx_112 <= cfg_18;
   end
   else if (  reg_15 ) begin
      core_11 <= core_18;
   end
   else begin
      tx_17 <= hw_12;
   end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( fsm_2 || rst_12 && sig_2 ))) || (clk_1 == data_116));
    assert ((!(( fsm_2 || rst_12 && sig_2 ) && ( err_158 != data_7 ))) || (hw_15 == data_20));
    assert ((!(( fsm_2 || rst_12 && sig_2 ) && (!( err_158 != data_7 ) && ( cfg_2 != reg_15 || hw_18 || fsm_16 ) ))) || (fsm_1 == rx_12));
    assert ((!(( fsm_2 || rst_12 && sig_2 ) && ( !( err_158 != data_7 ) &&!( cfg_2 != reg_15 || hw_18 || fsm_16 ) ))) || (data_11 == sig_12));
    assert ((!(! ( fsm_2 || rst_12 && sig_2 ))) || (tx_16 == sig_1));
    assert ((!(! ( fsm_2 || rst_12 && sig_2 ) && ( rx_6 || cfg_2 ))) || (tx_112 == cfg_18));
    assert ((!(! ( fsm_2 || rst_12 && sig_2 ) && (!( rx_6 || cfg_2 ) && ( reg_15 ) ))) || (core_11 == core_18));
    assert ((!(! ( fsm_2 || rst_12 && sig_2 ) && ( !( rx_6 || cfg_2 ) &&!( reg_15 ) ))) || (tx_17 == hw_12));
  end
endmodule
