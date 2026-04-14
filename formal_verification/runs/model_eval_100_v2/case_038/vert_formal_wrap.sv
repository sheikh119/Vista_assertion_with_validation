`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] chip_3;
  logic [31:0] clk_17;
  logic [31:0] clk_3;
  logic [31:0] core_12;
  logic [31:0] data_118;
  logic [31:0] data_5;
  logic [31:0] err_6;
  logic [31:0] hw_14;
  logic [31:0] hw_8;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_20;
  logic [31:0] reg_8;
  logic [31:0] rx_11;
  always_comb begin
if (  hw_8  || reg_8  && chip_3 ) begin 
     hw_14 = clk_3;
    if ( data_118 ) begin
        data_5 = rx_11;
    end
        if ( err_6  || clk_17 ) begin
            core_12 = reg_20;
        end
end
  end
property p_gen_1; ( hw_8 || reg_8 && chip_3 ) |=> hw_14 == clk_3; endproperty
assert property (p_gen_1);
property p_gen_2; ( hw_8 || reg_8 && chip_3 ) && ( data_118 ) |=> data_5 == rx_11; endproperty
assert property (p_gen_2);
property p_gen_3; ( hw_8 || reg_8 && chip_3 ) && ( data_118 ) && ( err_6 || clk_17 ) |=> core_12 == reg_20; endproperty
assert property (p_gen_3);
endmodule
