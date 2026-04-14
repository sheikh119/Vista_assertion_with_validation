`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] hw_8;
  logic [31:0] reg_8;
  logic [31:0] chip_3;
  logic [31:0] hw_14;
  logic [31:0] clk_3;
  logic [31:0] data_118;
  logic [31:0] data_5;
  logic [31:0] rx_11;
  logic [31:0] err_6;
  logic [31:0] clk_17;
  logic [31:0] core_12;
  logic [31:0] reg_20;
  logic [31:0] b1;
  always @* begin
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

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
