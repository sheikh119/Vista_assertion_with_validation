`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_osc_3;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] sig_8;
  logic [31:0] err_7;
  logic [31:0] chip_18;
  logic [31:0] rx_14;
  logic [31:0] reg_118;
  logic [31:0] cfg_8;
  logic [31:0] sig_2020;
  logic [31:0] tx_12;
  logic [31:0] err_20;
  logic [31:0] chip_3;
  logic [31:0] auth_4;
  logic [31:0] fsm_2;
  logic [31:0] clk_20;
  logic [31:0] data_19;
  logic [31:0] b1;
  logic [31:0] tx_13;
  logic [31:0] clk_3;
  logic [31:0] err_2;
  logic [31:0] clk_10;
  logic [31:0] tx_20;
  logic [31:0] auth_15;
  logic [31:0] rx_12;
  logic [31:0] rst_10;
  logic [31:0] clk_5;
  logic [31:0] fsm_4;
  logic [31:0] rx_20;
  logic [31:0] clk_14;
  logic [31:0] Synchronous;
  logic [31:0] Clock;
  logic [31:0] clk_12;
  logic [31:0] Assertion;
  logic [31:0] SyncCheckeotid;
  always @(posedge clk_osc_3) begin
if (  sig_8  || err_7  && chip_18  != rx_14 ) begin
    reg_118 <= cfg_8;
    if ( sig_2020 ) begin
        tx_12 <= err_20;
    end
        if ( chip_3  != sig_8  || auth_4  != fsm_2 ) begin
            clk_20 = data_19;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
    assert (: if ( sig_8 || tx_13 ) begin tx_12 = clk_3; if ( err_2 && clk_10 != tx_20 && auth_15 ) begin rx_12 = clk_3; end if ( rst_10 || clk_5 && fsm_4 || rx_20 ) begin rx_12 = clk_14; end end Synchronous: True Clock: posedge clk_12 Assertion: assert SyncCheckeotid);
  end
endmodule
