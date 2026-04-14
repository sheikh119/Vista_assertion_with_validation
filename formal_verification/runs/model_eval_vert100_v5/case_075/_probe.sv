`timescale 1ns/1ps
module vert_formal_wrap;
  logic core_clock_4;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] cfg_9;
  logic [31:0] hw_173;
  logic [31:0] fsm_1;
  logic [31:0] err_11;
  logic [31:0] reg_5;
  logic [31:0] clk_2;
  logic [31:0] rx_166;
  logic [31:0] tx_11;
  logic [31:0] chip_195;
  logic [31:0] rx_13;
  logic [31:0] rx_3;
  logic [31:0] rst_14;
  logic [31:0] tx_6;
  logic [31:0] rst_10;
  logic [31:0] err_16;
  logic [31:0] sig_20;
  logic [31:0] core_20;
  logic [31:0] data_203;
  logic [31:0] auth_12;
  logic [31:0] b1;
  logic [31:0] Assertions;
  logic [31:0] Assertion;
  logic [31:0] ClockSynceotid;
  always @(negedge core_clock_4) begin
if (  cfg_9  && hw_173 ) begin
    fsm_1 <= err_11;
    reg_5 = clk_2;
    if ( rx_166 ) begin
        tx_11 <= chip_195;
        rx_13 = rx_3;
    end
        if ( rst_14  != tx_6  || rst_10  != err_16 ) begin
            sig_20 <= core_20;
            data_203 <= auth_12;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
    assert (!(( cfg_9 && hw_173 ) begin if ( rx_166 ) begin tx_11 = chip_195; rx_13 = rx_3; end if ( rst_14 != tx_6 || rst_10 != err_16 ) begin sig_20 = core_20; data_203 = auth_12; end end end OUTPUT (Assertions): Assertion: ClockSynceotid; ( cfg_9 && hw_173 ))) || (fsm_1 == err_11 && reg_5 == clk_2);
  end
endmodule
