`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] acknowledge_14;
  logic [31:0] bx101xxx;
  logic [31:0] rst_6;
  logic [31:0] hw_3;
  logic [31:0] bxxxxxx1;
  logic [31:0] data_13;
  logic [31:0] chip_12;
  logic [31:0] clk_7;
  logic [31:0] sig_18;
  logic [31:0] b1;
  always @* begin
case ( acknowledge_14 )
   7'bx101xxx : begin
     rst_6 = hw_3;
   end
   7'bxxxxxx1 : begin
     data_13 = chip_12;
   end
   default : begin
     clk_7 = sig_18;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
