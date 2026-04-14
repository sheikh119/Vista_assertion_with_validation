`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] interrupt_request_3;
  logic [31:0] h9;
  logic [31:0] tx_20;
  logic [31:0] reg_13;
  logic [31:0] bxx0100x;
  logic [31:0] hw_11;
  logic [31:0] err_6;
  logic [31:0] bxx0xx1x;
  logic [31:0] reg_17;
  logic [31:0] rx_20;
  logic [31:0] h37;
  logic [31:0] clk_7;
  logic [31:0] tx_12;
  logic [31:0] b0011x1;
  logic [31:0] rst_8;
  logic [31:0] rst_6;
  logic [31:0] rst_19;
  logic [31:0] fsm_3;
  logic [31:0] b1;
  always @* begin
case ( interrupt_request_3 )
   5'h9 : begin
     tx_20 = reg_13;
   end
   7'bxx0100x : begin
     hw_11 = err_6;
   end
   7'bxx0xx1x : begin
     reg_17 = rx_20;
   end
   6'h37 : begin
     clk_7 = tx_12;
   end
   6'b0011x1 : begin
     rst_8 = rst_6;
   end
   default : begin
     rst_19 = fsm_3;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
