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
    assert ((!(( sig_8 || err_7 && chip_18 != rx_14 ))) || (reg_118 == cfg_8));
    assert ((!(( sig_8 || err_7 && chip_18 != rx_14 ) && ( sig_2020 ))) || (tx_12 == err_20));
    assert ((!(( sig_8 || err_7 && chip_18 != rx_14 ) && ( sig_2020 ) && ( chip_3 != sig_8 || auth_4 != fsm_2 ))) || (clk_20 == data_19));
  end
endmodule
