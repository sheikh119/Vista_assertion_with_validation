`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] address_status_16;
  logic [31:0] bxxxxxx1;
  logic [31:0] cfg_9;
  logic [31:0] rx_7;
  logic [31:0] bxx0100;
  logic [31:0] err_8;
  logic [31:0] hw_18;
  logic [31:0] b0xx101x;
  logic [31:0] hw_4;
  logic [31:0] core_13;
  logic [31:0] cfg_11;
  logic [31:0] clk_6;
  logic [31:0] b1;
  always @* begin
case ( address_status_16 )
   7'bxxxxxx1 : begin
     cfg_9 = rx_7;
   end
   6'bxx0100 : begin
     err_8 = hw_18;
   end
   7'b0xx101x : begin
     hw_4 = core_13;
   end
   default : begin
     cfg_11 = clk_6;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
