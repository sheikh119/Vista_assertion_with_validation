`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_ctrl_18;
  logic rst;
  initial begin
    rst = 1'b0;
    chip_14 = '0;
    clk_6 = '0;
    cfg_14 = '0;
    fsm_115 = '0;
    sig_5 = '0;
    reg_20 = '0;
    hw_20 = '0;
    core_147 = '0;
    sig_6 = '0;
    data_1 = '0;
    core_6 = '0;
    data_20 = '0;
    err_16 = '0;
    rst_4 = '0;
    rx_12 = '0;
    data_185 = '0;
    fsm_12 = '0;
    data_8 = '0;
    auth_1 = '0;
    fsm_6 = '0;
    err_11 = '0;
    fsm_8 = '0;
    hw_17 = '0;
    rst_10 = '0;
    chip_19 = '0;
    rx_7 = '0;
    rx_1 = '0;
    tx_4 = '0;
    err_14 = '0;
  end
  logic [31:0] chip_14;
  logic [31:0] clk_6;
  logic [31:0] cfg_14;
  logic [31:0] fsm_115;
  logic [31:0] sig_5;
  logic [31:0] reg_20;
  logic [31:0] hw_20;
  logic [31:0] core_147;
  logic [31:0] sig_6;
  logic [31:0] data_1;
  logic [31:0] core_6;
  logic [31:0] data_20;
  logic [31:0] err_16;
  logic [31:0] rst_4;
  logic [31:0] rx_12;
  logic [31:0] data_185;
  logic [31:0] fsm_12;
  logic [31:0] data_8;
  logic [31:0] auth_1;
  logic [31:0] fsm_6;
  logic [31:0] err_11;
  logic [31:0] fsm_8;
  logic [31:0] hw_17;
  logic [31:0] rst_10;
  logic [31:0] chip_19;
  logic [31:0] rx_7;
  logic [31:0] rx_1;
  logic [31:0] tx_4;
  logic [31:0] err_14;
  reg _started = 0;
  always @(posedge clock_ctrl_18) begin
if (  chip_14  != clk_6  || cfg_14 ) begin
   fsm_115 = sig_5;
    if ( reg_20  && hw_20 ) begin
      core_147 = sig_6;
   end
   else if (  data_1  != core_6  && data_20 ) begin
      err_16 <= rst_4;
   end
   else begin
      rx_12 = data_185;
   end
end
else begin
   fsm_12 = data_8;
   if (  data_8  != auth_1  || fsm_6  && err_11 ) begin
      fsm_8 = hw_17;
   end
   else if (  rst_10  != chip_19  && rx_7  && rx_1 ) begin
      rst_4 <= tx_4;
   end
   else begin
      fsm_6 <= err_14;
   end
end
    _started <= 1;
  end

  always @(posedge clock_ctrl_18) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( chip_14 != clk_6 || cfg_14 ))) || (fsm_115 == sig_5));
    assert ((!(( chip_14 != clk_6 || cfg_14 ) && ( reg_20 && hw_20 ))) || (core_147 == sig_6));
    assert ((!(( chip_14 != clk_6 || cfg_14 ) && (!( reg_20 && hw_20 ) && ( data_1 != core_6 && data_20 ) ))) || (err_16 == rst_4));
    assert ((!(( chip_14 != clk_6 || cfg_14 ) && ( !( reg_20 && hw_20 ) &&!( data_1 != core_6 && data_20 ) ))) || (rx_12 == data_185));
    assert ((!(! ( chip_14 != clk_6 || cfg_14 ))) || (fsm_12 == data_8));
    assert ((!(! ( chip_14 != clk_6 || cfg_14 ) && ( data_8 != auth_1 || fsm_6 && err_11 ))) || (fsm_8 == hw_17));
    assert ((!(! ( chip_14 != clk_6 || cfg_14 ) && (!( data_8 != auth_1 || fsm_6 && err_11 ) && ( rst_10 != chip_19 && rx_7 && rx_1 ) ))) || (rst_4 == tx_4));
    end
  end
endmodule
