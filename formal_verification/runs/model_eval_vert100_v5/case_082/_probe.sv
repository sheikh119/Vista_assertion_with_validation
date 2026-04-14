`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_enable_15;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] instruction_register_11;
  logic [31:0] bx000x0;
  logic [31:0] core_8;
  logic [31:0] clk_20;
  logic [31:0] sig_1;
  logic [31:0] hw_12;
  logic [31:0] rst_7;
  logic [31:0] sig_10;
  logic [31:0] reg_20;
  logic [31:0] rst_10;
  logic [31:0] sig_17;
  logic [31:0] rst_12;
  logic [31:0] sig_5;
  logic [31:0] tx_17;
  logic [31:0] rst_1;
  logic [31:0] hw_10;
  logic [31:0] rx_7;
  logic [31:0] rx_11;
  logic [31:0] b1;
  always @(negedge clk_enable_15) begin
case ( instruction_register_11 )
   6'bx000x0 : begin
      if (  core_8  && clk_20 ) begin
          sig_1 = hw_12;
          if ( rst_7  || sig_10  && reg_20 ) begin
               rst_10 <= sig_17;
          end
      end
   end
   default : begin
      if (  !rst_12 ) begin
          sig_5 = tx_17;
          if ( rst_1  && hw_10  && rx_7 ) begin
               rst_7 = rx_11;
          end
      end
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
    assert (!(( !rst_12 ) && ( rst_1 && hw_10 && rx_7 ))) || (rst_7 == rx_11);
  end
endmodule
