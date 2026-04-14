`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_source_8;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] control_valid_2;
  logic [31:0] h51;
  logic [31:0] clk_18;
  logic [31:0] reg_11;
  logic [31:0] data_3;
  logic [31:0] auth_7;
  logic [31:0] cfg_15;
  logic [31:0] clk_11;
  logic [31:0] tx_2;
  logic [31:0] fsm_12;
  logic [31:0] sig_15;
  logic [31:0] cfg_11;
  logic [31:0] hw_6;
  logic [31:0] rx_4;
  logic [31:0] data_110;
  logic [31:0] clk_15;
  logic [31:0] cfg_14;
  logic [31:0] data_7;
  logic [31:0] rst_20;
  logic [31:0] clk_8;
  logic [31:0] rst_16;
  logic [31:0] clk_12;
  logic [31:0] fsm_4;
  logic [31:0] reg_18;
  logic [31:0] reg_8;
  always @(posedge clock_source_8) begin
case ( control_valid_2 )
   7'h51 : begin
      if (  clk_18  && reg_11 ) begin
          data_3 <= auth_7;
          cfg_15 = clk_11;
          if ( tx_2  && fsm_12 ) begin
               sig_15 <= cfg_11;
               hw_6 = rx_4;
          end
      end
   end
   default : begin
      if (  data_110 ) begin
          clk_15 <= cfg_14;
          data_7 <= rst_20;
          if ( clk_8  && rst_16  && clk_12 ) begin
               fsm_4 = clk_8;
               reg_18 <= reg_8;
          end
      end
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert ((!(( control_valid_2 ) == ( 7'h51 ) && ( clk_18 && reg_11 ))) || (data_3 == auth_7 && cfg_15 == clk_11));
    assert ((!(( control_valid_2 ) == ( 7'h51 ) && ( clk_18 && reg_11 ) && ( tx_2 && fsm_12 ))) || (sig_15 == cfg_11 && hw_6 == rx_4));
    assert ((!(( control_valid_2 )!= 7'h51 && ( data_110 ))) || (clk_15 == cfg_14 && data_7 == rst_20));
    assert ((!(( control_valid_2 )!= 7'h51 && ( data_110 ) && ( clk_8 && rst_16 && clk_12 ))) || (fsm_4 == clk_8 && reg_18 == reg_8));
  end
endmodule
