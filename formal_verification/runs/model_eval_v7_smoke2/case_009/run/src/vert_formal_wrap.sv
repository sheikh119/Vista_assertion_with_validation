`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_in_18;
  logic rst;
  initial begin
    rst = 1'b0;
    tx_6 = '0;
    data_6 = '0;
    reg_3 = '0;
    fsm_1 = '0;
    cfg_16 = '0;
    fsm_3 = '0;
    clk_16 = '0;
    hw_20 = '0;
    rst_3 = '0;
    rx_20 = '0;
    sig_16 = '0;
    fsm_18 = '0;
    rst_19 = '0;
    err_16 = '0;
    chip_109 = '0;
    data_4 = '0;
    rx_6 = '0;
    tx_115 = '0;
    rst_18 = '0;
    core_9 = '0;
    data_17 = '0;
    clk_62 = '0;
    cfg_105 = '0;
    rx_8 = '0;
    data_7 = '0;
    reg_17 = '0;
    rst_8 = '0;
    clk_10 = '0;
    sig_32 = '0;
    data_120 = '0;
    fsm_17 = '0;
  end
  logic [31:0] tx_6;
  logic [31:0] data_6;
  logic [31:0] reg_3;
  logic [31:0] fsm_1;
  logic [31:0] cfg_16;
  logic [31:0] fsm_3;
  logic [31:0] clk_16;
  logic [31:0] hw_20;
  logic [31:0] rst_3;
  logic [31:0] rx_20;
  logic [31:0] sig_16;
  logic [31:0] fsm_18;
  logic [31:0] rst_19;
  logic [31:0] err_16;
  logic [31:0] chip_109;
  logic [31:0] data_4;
  logic [31:0] rx_6;
  logic [31:0] tx_115;
  logic [31:0] rst_18;
  logic [31:0] core_9;
  logic [31:0] data_17;
  logic [31:0] clk_62;
  logic [31:0] cfg_105;
  logic [31:0] rx_8;
  logic [31:0] data_7;
  logic [31:0] reg_17;
  logic [31:0] rst_8;
  logic [31:0] clk_10;
  logic [31:0] sig_32;
  logic [31:0] data_120;
  logic [31:0] fsm_17;
  reg _started = 0;
  always @(negedge clk_in_18) begin
if (  tx_6  || data_6  != reg_3  && fsm_1 ) begin
   cfg_16 <= fsm_3;
    if ( clk_16  && hw_20 ) begin
      rst_3 <= rx_20;
   end
   else if (  sig_16  != fsm_18  && rst_19 ) begin
      err_16 = chip_109;
   end
   else begin
      data_4 = rx_6;
   end
end
else begin
   tx_115 = rx_6;
   if (  rst_18  != core_9  && data_17 ) begin
      clk_62 = cfg_105;
   end
   else if (  rx_8  || data_7  != reg_17  || rst_8 ) begin
      clk_10 = sig_32;
   end
   else begin
      data_120 <= fsm_17;
   end
end
    _started <= 1;
  end

  always @(negedge clk_in_18) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( tx_6 || data_6 != reg_3 && fsm_1 ))) || (cfg_16 == fsm_3));
    assert ((!(( tx_6 || data_6 != reg_3 && fsm_1 ) && ( clk_16 && hw_20 ))) || (rst_3 == rx_20));
    assert ((!(( tx_6 || data_6 != reg_3 && fsm_1 ) && (!( clk_16 && hw_20 ) && ( sig_16 != fsm_18 && rst_19 ) ))) || (err_16 == chip_109));
    assert ((!(( tx_6 || data_6 != reg_3 && fsm_1 ) && ( !( clk_16 && hw_20 ) &&!( sig_16 != fsm_18 && rst_19 ) ))) || (data_4 == rx_6));
    assert ((!(! ( tx_6 || data_6 != reg_3 && fsm_1 ))) || (tx_115 == rx_6));
    assert ((!(! ( tx_6 || data_6 != reg_3 && fsm_1 ) && ( rst_18 != core_9 && data_17 ))) || (clk_62 == cfg_105));
    assert ((!(! ( tx_6 || data_6 != reg_3 && fsm_1 ) && (!( rst_18 != core_9 && data_17 ) && ( rx_8 || data_7 != reg_17 || rst_8 ) ))) || (clk_10 == sig_32));
    end
  end
endmodule
