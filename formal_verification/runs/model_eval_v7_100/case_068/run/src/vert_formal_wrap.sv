`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    rst_13 = '0;
    core_4 = '0;
    sig_13 = '0;
    hw_5 = '0;
    core_10 = '0;
    sig_6 = '0;
    rst_16 = '0;
    core_11 = '0;
    err_2 = '0;
    err_6 = '0;
    core_2 = '0;
    data_98 = '0;
    fsm_6 = '0;
    clk_16 = '0;
  end
  logic [31:0] rst_13;
  logic [31:0] core_4;
  logic [31:0] sig_13;
  logic [31:0] hw_5;
  logic [31:0] core_10;
  logic [31:0] sig_6;
  logic [31:0] rst_16;
  logic [31:0] core_11;
  logic [31:0] err_2;
  logic [31:0] err_6;
  logic [31:0] core_2;
  logic [31:0] data_98;
  logic [31:0] fsm_6;
  logic [31:0] clk_16;
  always @* begin
if (  rst_13  && core_4  && sig_13  != hw_5 ) begin
     core_10 = sig_6;
    if ( rst_16  || core_11  || err_2 ) begin
        err_6 = core_2;
    end
        if ( data_98 ) begin
            fsm_6 = clk_16;
        end
end
    assume (!rst);
    assert ((!(( rst_13 && core_4 && sig_13 != hw_5 ))) || (core_10 == sig_6));
    assert ((!(( rst_13 && core_4 && sig_13 != hw_5 ) && ( rst_16 || core_11 || err_2 ))) || (err_6 == core_2));
    assert ((!(( rst_13 && core_4 && sig_13 != hw_5 ) && ( rst_16 || core_11 || err_2 ) && ( data_98 ))) || (fsm_6 == clk_16));
  end
endmodule
