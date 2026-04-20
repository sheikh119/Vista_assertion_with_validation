`timescale 1ns/1ps
module vert_formal_wrap;
  logic fast_clk_20;
  logic rst;
  initial begin
    rst = 1'b0;
    chip_16 = '0;
    err_10 = '0;
    fsm_11 = '0;
    sig_13 = '0;
    chip_10 = '0;
    clk_4 = '0;
    sig_12 = '0;
    sig_3 = '0;
    sig_14 = '0;
    err_20 = '0;
    err_1 = '0;
    cfg_116 = '0;
    auth_17 = '0;
    rst_52 = '0;
    fsm_160 = '0;
    sig_17 = '0;
    tx_14 = '0;
    auth_15 = '0;
    fsm_18 = '0;
    core_12 = '0;
    chip_18 = '0;
    tx_2 = '0;
    rx_18 = '0;
    rst_6 = '0;
  end
  logic [31:0] chip_16;
  logic [31:0] err_10;
  logic [31:0] fsm_11;
  logic [31:0] sig_13;
  logic [31:0] chip_10;
  logic [31:0] clk_4;
  logic [31:0] sig_12;
  logic [31:0] sig_3;
  logic [31:0] sig_14;
  logic [31:0] err_20;
  logic [31:0] err_1;
  logic [31:0] cfg_116;
  logic [31:0] auth_17;
  logic [31:0] rst_52;
  logic [31:0] fsm_160;
  logic [31:0] sig_17;
  logic [31:0] tx_14;
  logic [31:0] auth_15;
  logic [31:0] fsm_18;
  logic [31:0] core_12;
  logic [31:0] chip_18;
  logic [31:0] tx_2;
  logic [31:0] rx_18;
  logic [31:0] rst_6;
  reg _started = 0;
  always @(negedge fast_clk_20) begin
if (  chip_16  && err_10  || fsm_11 ) begin
    sig_13 = chip_10;
    clk_4 = sig_12;
    sig_3 <= sig_14;
    if ( err_20  && err_1 ) begin
        cfg_116 = auth_17;
        rst_52 = fsm_160;
        sig_17 = tx_14;
    end
        if ( auth_15 ) begin
            fsm_18 <= core_12;
            chip_18 <= tx_2;
            rx_18 = rst_6;
        end
end
    _started <= 1;
  end

  always @(negedge fast_clk_20) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( chip_16 && err_10 || fsm_11 ))) || (sig_13 == chip_10 && clk_4 == sig_12 && sig_3 == sig_14));
    assert ((!(( chip_16 && err_10 || fsm_11 ) && ( err_20 && err_1 ))) || (cfg_116 == auth_17 && rst_52 == fsm_160 && sig_17 == tx_14));
    assert ((!(( chip_16 && err_10 || fsm_11 ) && ( err_20 && err_1 ) && ( auth_15 ))) || (fsm_18 == core_12 && chip_18 == tx_2 && rx_18 == rst_6));
    end
  end
endmodule
