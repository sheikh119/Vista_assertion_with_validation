`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_enable_18;
  logic rst;
  initial begin
    rst = 1'b0;
    hw_8 = '0;
    reg_8 = '0;
    chip_3 = '0;
    cfg_10 = '0;
    chip_14 = '0;
    hw_15 = '0;
    reg_1 = '0;
    tx_19 = '0;
    tx_9 = '0;
    tx_13 = '0;
    sig_12 = '0;
    err_11 = '0;
    clk_9 = '0;
    rst_111 = '0;
    auth_5 = '0;
    cfg_1 = '0;
    rst_15 = '0;
    rst_20 = '0;
    chip_4 = '0;
    sig_28 = '0;
    data_17 = '0;
    fsm_10 = '0;
    sig_9 = '0;
    rx_13 = '0;
    rx_114 = '0;
    reg_13 = '0;
    fsm_115 = '0;
    tx_3 = '0;
  end
  logic [31:0] hw_8;
  logic [31:0] reg_8;
  logic [31:0] chip_3;
  logic [31:0] cfg_10;
  logic [31:0] chip_14;
  logic [31:0] hw_15;
  logic [31:0] reg_1;
  logic [31:0] tx_19;
  logic [31:0] tx_9;
  logic [31:0] tx_13;
  logic [31:0] sig_12;
  logic [31:0] err_11;
  logic [31:0] clk_9;
  logic [31:0] rst_111;
  logic [31:0] auth_5;
  logic [31:0] cfg_1;
  logic [31:0] rst_15;
  logic [31:0] rst_20;
  logic [31:0] chip_4;
  logic [31:0] sig_28;
  logic [31:0] data_17;
  logic [31:0] fsm_10;
  logic [31:0] sig_9;
  logic [31:0] rx_13;
  logic [31:0] rx_114;
  logic [31:0] reg_13;
  logic [31:0] fsm_115;
  logic [31:0] tx_3;
  reg _started = 0;
  always @(negedge clk_enable_18) begin
if (  hw_8  || reg_8  && chip_3 ) begin
   cfg_10 <= chip_14;
    if ( hw_15  || reg_1  && tx_19  || tx_9 ) begin
      tx_13 <= sig_12;
   end
   else if (  err_11  && clk_9  != rst_111 ) begin
      auth_5 = cfg_1;
   end
   else begin
      rst_15 <= rst_20;
   end
end
else begin
   chip_4 = sig_28;
   if (  data_17 ) begin
      fsm_10 <= chip_3;
   end
   else if (  sig_9  || rx_13 ) begin
      rx_114 = reg_13;
   end
   else begin
      fsm_115 = tx_3;
   end
end
    _started <= 1;
  end

  always @(negedge clk_enable_18) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( hw_8 || reg_8 && chip_3 ))) || (cfg_10 == chip_14));
    assert ((!(( hw_8 || reg_8 && chip_3 ) && ( hw_15 || reg_1 && tx_19 || tx_9 ))) || (tx_13 == sig_12));
    assert ((!(( hw_8 || reg_8 && chip_3 ) && (!( hw_15 || reg_1 && tx_19 || tx_9 ) && ( err_11 && clk_9 != rst_111 ) ))) || (auth_5 == cfg_1));
    assert ((!(( hw_8 || reg_8 && chip_3 ) && ( !( hw_15 || reg_1 && tx_19 || tx_9 ) &&!( err_11 && clk_9 != rst_111 ) ))) || (rst_15 == rst_20));
    assert ((!(! ( hw_8 || reg_8 && chip_3 ))) || (chip_4 == sig_28));
    assert ((!(! ( hw_8 || reg_8 && chip_3 ) && ( data_17 ))) || (fsm_10 == chip_3));
    assert ((!(! ( hw_8 || reg_8 && chip_3 ) && (!( data_17 ) && ( sig_9 || rx_13 ) ))) || (rx_114 == reg_13));
    end
  end
endmodule
