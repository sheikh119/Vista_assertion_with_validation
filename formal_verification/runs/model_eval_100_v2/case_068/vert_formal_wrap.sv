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
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] rst_13;
  logic [31:0] rst_16;
  logic [31:0] sig_13;
  logic [31:0] sig_6;
  always_comb begin
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
property p_gen_1; ( rst_13 && core_4 && sig_13 != hw_5 ) |=> core_10 == sig_6; endproperty
assert property (p_gen_1);
property p_gen_2; ( rst_13 && core_4 && sig_13 != hw_5 ) && ( rst_16 || core_11 || err_2 ) |=> err_6 == core_2; endproperty
assert property (p_gen_2);
property p_gen_3; ( rst_13 && core_4 && sig_13 != hw_5 ) && ( rst_16 || core_11 || err_2 ) && ( data_98 ) |=> fsm_6 == clk_16; endproperty
assert property (p_gen_3);
endmodule
