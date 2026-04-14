`timescale 1ns/1ps
module vert_formal_wrap;
  logic ref_clk_19;
  logic rst;
  initial begin
    rst = 1'b0;
    auth_16 = '0;
    auth_17 = '0;
    data_5 = '0;
    rst_19 = '0;
    cfg_183 = '0;
    core_6 = '0;
    core_5 = '0;
    rx_7 = '0;
    rst_99 = '0;
    sig_1 = '0;
    err_10 = '0;
    chip_2 = '0;
    rst_12 = '0;
    reg_4 = '0;
    hw_7 = '0;
    core_3 = '0;
    fsm_13 = '0;
    clk_13 = '0;
    tx_17 = '0;
  end
  logic [31:0] auth_16;
  logic [31:0] auth_17;
  logic [31:0] data_5;
  logic [31:0] rst_19;
  logic [31:0] cfg_183;
  logic [31:0] core_6;
  logic [31:0] core_5;
  logic [31:0] rx_7;
  logic [31:0] rst_99;
  logic [31:0] sig_1;
  logic [31:0] err_10;
  logic [31:0] chip_2;
  logic [31:0] rst_12;
  logic [31:0] reg_4;
  logic [31:0] hw_7;
  logic [31:0] core_3;
  logic [31:0] fsm_13;
  logic [31:0] clk_13;
  logic [31:0] tx_17;
  reg _started = 0;
  always @(negedge ref_clk_19) begin
if (  auth_16  != auth_17  || data_5  && rst_19 ) begin
    cfg_183 = core_6;
    core_5 <= rx_7;
    if ( rst_99 ) begin
        sig_1 <= err_10;
        chip_2 = rst_12;
    end
        if ( reg_4  && hw_7  != core_3 ) begin
            fsm_13 = clk_13;
            tx_17 <= data_5;
        end
end
    _started <= 1;
  end

  always @(negedge ref_clk_19) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( auth_16 != auth_17 || data_5 && rst_19 ))) || (cfg_183 == core_6 && core_5 == rx_7));
    assert ((!(( auth_16 != auth_17 || data_5 && rst_19 ) && ( rst_99 ))) || (sig_1 == err_10 && chip_2 == rst_12));
    assert ((!(( auth_16 != auth_17 || data_5 && rst_19 ) && ( rst_99 ) && ( reg_4 && hw_7 != core_3 ))) || (fsm_13 == clk_13 && tx_17 == data_5));
    end
  end
endmodule
