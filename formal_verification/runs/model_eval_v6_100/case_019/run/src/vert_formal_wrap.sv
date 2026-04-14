`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] end_address_2;
  logic [31:0] h1b;
  logic [31:0] cfg_14;
  logic [31:0] reg_13;
  logic [31:0] b010x000;
  logic [31:0] rst_16;
  logic [31:0] reg_14;
  logic [31:0] b1100101;
  logic [31:0] data_12;
  logic [31:0] cfg_9;
  logic [31:0] b0111x0x;
  logic [31:0] chip_17;
  logic [31:0] chip_15;
  logic [31:0] sig_17;
  logic [31:0] chip_6;
  logic [31:0] b1;
  always @* begin
case ( end_address_2 )
   6'h1b : begin
     cfg_14 = reg_13;
   end
   7'b010x000 : begin
     rst_16 = reg_14;
   end
   7'b1100101 : begin
     data_12 = cfg_9;
   end
   7'b0111x0x : begin
     chip_17 = chip_15;
   end
   default : begin
     sig_17 = chip_6;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
