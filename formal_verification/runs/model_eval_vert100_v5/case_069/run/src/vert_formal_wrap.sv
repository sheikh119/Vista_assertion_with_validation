`timescale 1ns/1ps
module vert_formal_wrap;
  logic mem_clock_3;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] acknowledge_8;
  logic [31:0] bxxx1x0;
  logic [31:0] sig_11;
  logic [31:0] chip_18;
  logic [31:0] err_5;
  logic [31:0] sig_6;
  logic [31:0] sig_10;
  logic [31:0] auth_8;
  logic [31:0] rx_5;
  logic [31:0] auth_2;
  logic [31:0] cfg_1;
  logic [31:0] auth_20;
  logic [31:0] data_20;
  logic [31:0] rst_8;
  logic [31:0] clk_3;
  logic [31:0] err_7;
  logic [31:0] rx_19;
  logic [31:0] sig_5;
  logic [31:0] sig_14;
  logic [31:0] auth_12;
  logic [31:0] auth_1;
  logic [31:0] auth_4;
  logic [31:0] auth_17;
  logic [31:0] chip_6;
  logic [31:0] rx_8;
  logic [31:0] data_15;
  logic [31:0] auth_5;
  logic [31:0] rst_18;
  logic [31:0] clk_17;
  logic [31:0] b1;
  always @(posedge mem_clock_3) begin
case ( acknowledge_8 )
   6'bxxx1x0 : begin
      if (  sig_11  != chip_18 ) begin
          err_5 = sig_6;
          sig_10 = auth_8;
          if ( rx_5  && auth_2  || cfg_1 ) begin
               auth_20 <= data_20;
               rst_8 <= clk_3;
          end
      end
   end
   default : begin
      if (  err_7  != rx_19  || sig_5  || sig_14 ) begin
          auth_12 = auth_1;
          auth_4 = auth_17;
          if ( err_5  != chip_6  || rx_8 ) begin
               data_15 <= auth_5;
               rst_18 = clk_17;
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
