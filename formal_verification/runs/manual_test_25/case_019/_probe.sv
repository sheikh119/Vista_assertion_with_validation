`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] output_control_19;
  logic [31:0] b0xx1xx;
  logic [31:0] clk_17;
  logic [31:0] reg_13;
  logic [31:0] sig_20;
  logic [31:0] tx_19;
  logic [31:0] fsm_8;
  logic [31:0] rst_7;
  logic [31:0] rx_16;
  logic [31:0] chip_20;
  logic [31:0] cfg_15;
  logic [31:0] rx_13;
  logic [31:0] hw_12;
  logic [31:0] hw_8;
  logic [31:0] fsm_3;
  logic [31:0] err_16;
  logic [31:0] cfg_17;
  logic [31:0] b1;
  always @* begin
case ( output_control_19 )
   6'b0xx1xx : begin

      if (  clk_17 ) begin
          reg_13 = sig_20;
          if ( tx_19 ) begin
               fsm_8 = rst_7;
          end
      end

   end
   default : begin
      if (  rx_16  || chip_20  || cfg_15 ) begin
          rx_13 = hw_12;
          if ( hw_8  || fsm_3 ) begin
               err_16 = cfg_17;
          end
      end

   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
