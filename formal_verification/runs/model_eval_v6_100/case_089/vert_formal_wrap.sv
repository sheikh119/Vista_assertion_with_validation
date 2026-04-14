`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] data_3;
  logic [31:0] sig_14;
  logic [31:0] fsm_14;
  logic [31:0] rst_114;
  logic [31:0] hw_4;
  logic [31:0] chip_15;
  logic [31:0] err_14;
  logic [31:0] clk_7;
  logic [31:0] core_4;
  logic [31:0] sig_20;
  logic [31:0] clk_18;
  logic [31:0] rst_6;
  logic [31:0] rst_17;
  logic [31:0] tx_17;
  logic [31:0] chip_2;
  logic [31:0] data_20;
  logic [31:0] rst_3;
  logic [31:0] auth_8;
  logic [31:0] chip_13;
  always @* begin
if (  data_3  && sig_14 ) begin
     fsm_14 = rst_114;
     hw_4 = chip_15;
    if ( err_14  != clk_7 ) begin
        core_4 = sig_20;
        clk_18 = rst_6;
    end
        if ( rst_17  || tx_17  && chip_2 ) begin
            data_20 = rst_3;
            auth_8 = chip_13;
        end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( data_3 && sig_14 ))) || (fsm_14 == rst_114 && hw_4 == chip_15));
    assert ((!(( data_3 && sig_14 ) && ( err_14 != clk_7 ))) || (core_4 == sig_20 && clk_18 == rst_6));
    assert ((!(( data_3 && sig_14 ) && ( err_14 != clk_7 ) && ( rst_17 || tx_17 && chip_2 ))) || (data_20 == rst_3 && auth_8 == chip_13));
  end
endmodule
