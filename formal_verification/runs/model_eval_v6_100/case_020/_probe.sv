`timescale 1ns/1ps
module vert_formal_wrap;
  logic core_clock_20;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] rx_3;
  logic [31:0] auth_17;
  logic [31:0] hw_12;
  logic [31:0] core_11;
  logic [31:0] sig_18;
  logic [31:0] auth_9;
  logic [31:0] cfg_4;
  logic [31:0] auth_3;
  logic [31:0] auth_12;
  logic [31:0] err_16;
  logic [31:0] rst_160;
  logic [31:0] tx_18;
  logic [31:0] rx_9;
  logic [31:0] data_16;
  logic [31:0] err_5;
  logic [31:0] cfg_6;
  logic [31:0] fsm_10;
  logic [31:0] fsm_14;
  logic [31:0] rst_12;
  logic [31:0] clk_20;
  logic [31:0] sig_9;
  logic [31:0] err_13;
  logic [31:0] chip_7;
  logic [31:0] hw_7;
  logic [31:0] data_203;
  logic [31:0] tx_114;
  logic [31:0] core_12;
  logic [31:0] core_8;
  always @(negedge core_clock_20) begin
if (  rx_3  != auth_17 ) begin
   hw_12 <= core_11;
    if ( sig_18  || auth_9  || cfg_4  || auth_3 ) begin
      cfg_4 = auth_12;
   end
   else if (  err_16  != rst_160 ) begin
      tx_18 <= rx_9;
   end
   else begin
      data_16 = err_5;
   end
end
else begin
   cfg_6 = fsm_10;
   if (  fsm_14  || rst_12 ) begin
      clk_20 = sig_9;
   end
   else if (  rst_12  && err_13  != chip_7  && hw_7 ) begin
      data_203 <= tx_114;
   end
   else begin
      core_12 <= core_8;
   end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( rx_3 != auth_17 ))) || (hw_12 == core_11));
    assert ((!(( rx_3 != auth_17 ) && ( sig_18 || auth_9 || cfg_4 || auth_3 ))) || (cfg_4 == auth_12));
    assert ((!(( rx_3 != auth_17 ) && (!( sig_18 || auth_9 || cfg_4 || auth_3 ) && ( err_16 != rst_160 ) ))) || (tx_18 == rx_9));
    assert ((!(( rx_3 != auth_17 ) && ( !( sig_18 || auth_9 || cfg_4 || auth_3 ) &&!( err_16 != rst_160 ) ))) || (data_16 == err_5));
    assert ((!(! ( rx_3 != auth_17 ))) || (cfg_6 == fsm_10));
    assert ((!(! ( rx_3 != auth_17 ) && ( fsm_14 || rst_12 ))) || (clk_20 == sig_9));
    assert ((!(! ( rx_3 != auth_17 ) && (!( fsm_14 || rst_12 ) && ( rst_12 && err_13 != chip_7 && hw_7 ) ))) || (data_203 == tx_114));
    assert ((!(! ( rx_3 != auth_17 ) && ( !( fsm_14 || rst_12 ) &&!( rst_12 && err_13 != chip_7 && hw_7 ) ))) || (core_12 == core_8));
  end
endmodule
