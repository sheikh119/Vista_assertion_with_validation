`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_signal_16;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] control_status_buffer_2;
  logic [31:0] b11xx110;
  logic [31:0] hw_11;
  logic [31:0] tx_16;
  logic [31:0] rst_12;
  logic [31:0] cfg_4;
  logic [31:0] h3;
  logic [31:0] auth_10;
  logic [31:0] reg_3;
  logic [31:0] chip_10;
  logic [31:0] chip_7;
  logic [31:0] reg_9;
  logic [31:0] chip_14;
  logic [31:0] data_6;
  logic [31:0] sig_8;
  logic [31:0] b1;
  always @(posedge clk_signal_16) begin
case ( control_status_buffer_2 )
   7'b11xx110 : begin
     hw_11 <= tx_16;
     rst_12 <= cfg_4;
   end
   3'h3 : begin
     auth_10 = reg_3;
     chip_10 <= chip_7;
   end
   default : begin
     reg_9 = chip_14;
     data_6 <= sig_8;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
