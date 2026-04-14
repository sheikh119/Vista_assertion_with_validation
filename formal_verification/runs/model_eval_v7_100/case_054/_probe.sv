`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_out_14;
  logic rst;
  initial begin
    rst = 1'b0;
    hw_8 = '0;
    reg_4 = '0;
    core_13 = '0;
    clk_27 = '0;
    hw_4 = '0;
    cfg_13 = '0;
    fsm_8 = '0;
    sig_20 = '0;
    tx_115 = '0;
    fsm_2 = '0;
    chip_4 = '0;
    fsm_11 = '0;
    tx_11 = '0;
    cfg_11 = '0;
    fsm_15 = '0;
    rx_11 = '0;
    chip_10 = '0;
    auth_13 = '0;
  end
  logic [31:0] hw_8;
  logic [31:0] reg_4;
  logic [31:0] core_13;
  logic [31:0] clk_27;
  logic [31:0] hw_4;
  logic [31:0] cfg_13;
  logic [31:0] fsm_8;
  logic [31:0] sig_20;
  logic [31:0] tx_115;
  logic [31:0] fsm_2;
  logic [31:0] chip_4;
  logic [31:0] fsm_11;
  logic [31:0] tx_11;
  logic [31:0] cfg_11;
  logic [31:0] fsm_15;
  logic [31:0] rx_11;
  logic [31:0] chip_10;
  logic [31:0] auth_13;
  reg _started = 0;
  always @(negedge clk_out_14) begin
if (  hw_8 ) begin
    reg_4 <= core_13;
    clk_27 = hw_4;
    if ( cfg_13 ) begin
        fsm_8 <= sig_20;
        tx_115 <= fsm_2;
    end
        if ( chip_4  || fsm_11  || tx_11  || cfg_11 ) begin
            fsm_15 = rx_11;
            chip_10 = auth_13;
        end
end
    _started <= 1;
  end

  always @(negedge clk_out_14) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( hw_8 ))) || (reg_4 == core_13 && clk_27 == hw_4));
    assert ((!(( hw_8 ) && ( cfg_13 ))) || (fsm_8 == sig_20 && tx_115 == fsm_2));
    assert ((!(( hw_8 ) && ( cfg_13 ) && ( chip_4 || fsm_11 || tx_11 || cfg_11 ))) || (fsm_15 == rx_11 && chip_10 == auth_13));
    end
  end
endmodule
