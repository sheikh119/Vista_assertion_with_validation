`timescale 1ns/1ps
module vert_formal_wrap;
  logic pll_clk_12;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] instruction_buffer_4;
  logic [31:0] bxx1;
  logic [31:0] rx_1;
  logic [31:0] fsm_2;
  logic [31:0] cfg_5;
  logic [31:0] reg_15;
  logic [31:0] reg_16;
  logic [31:0] fsm_5;
  logic [31:0] hw_20;
  logic [31:0] cfg_8;
  logic [31:0] reg_12;
  logic [31:0] hw_6;
  logic [31:0] sig_8;
  logic [31:0] rx_9;
  logic [31:0] fsm_6;
  logic [31:0] data_11;
  logic [31:0] clk_10;
  logic [31:0] data_18;
  logic [31:0] fsm_3;
  logic [31:0] b1;
  always @(negedge pll_clk_12) begin
case ( instruction_buffer_4 )
   3'bxx1 : begin
      if (  rx_1  && fsm_2  != cfg_5  && reg_15 ) begin
          reg_16 = fsm_5;
          if ( hw_20  || cfg_8 ) begin
               reg_12 = hw_6;
          end
      end
   end
   default : begin
      if (  sig_8  && rx_9 ) begin
          fsm_6 <= data_11;
          if ( clk_10 ) begin
               data_18 <= fsm_3;
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
