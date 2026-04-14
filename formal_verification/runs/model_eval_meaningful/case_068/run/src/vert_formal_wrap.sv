`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] clk_16;
  logic [31:0] core_10;
  logic [31:0] core_11;
  logic [31:0] core_2;
  logic [31:0] core_4;
  logic [31:0] data_98;
  logic [31:0] err_2;
  logic [31:0] err_6;
  logic [31:0] fsm_6;
  logic [31:0] hw_5;
  logic [31:0] rst_13;
  logic [31:0] rst_16;
  logic [31:0] sig_13;
  logic [31:0] sig_6;
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
  end

  always @* begin
    assert (((!(( rst_13 && core_4 && sig_13 != hw_5 ))) || (core_10 == sig_6)));
    assert (((!(( rst_13 && core_4 && sig_13 != hw_5 ) && ( rst_16 || core_11 || err_2 ))) || (err_6 == core_2)));
    assert (((!(( rst_13 && core_4 && sig_13 != hw_5 ) && ( rst_16 || core_11 || err_2 ) && ( data_98 ))) || (fsm_6 == clk_16)));
  end
endmodule
