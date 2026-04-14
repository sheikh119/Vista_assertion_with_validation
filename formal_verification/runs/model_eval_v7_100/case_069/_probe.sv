`timescale 1ns/1ps
module vert_formal_wrap;
  logic mem_clock_3;
  logic rst;
  initial begin
    rst = 1'b0;
    acknowledge_8 = '0;
    bxxx1x0 = '0;
    sig_11 = '0;
    chip_18 = '0;
    err_5 = '0;
    sig_6 = '0;
    sig_10 = '0;
    auth_8 = '0;
    rx_5 = '0;
    auth_2 = '0;
    cfg_1 = '0;
    auth_20 = '0;
    data_20 = '0;
    rst_8 = '0;
    clk_3 = '0;
    err_7 = '0;
    rx_19 = '0;
    sig_5 = '0;
    sig_14 = '0;
    auth_12 = '0;
    auth_1 = '0;
    auth_4 = '0;
    auth_17 = '0;
    chip_6 = '0;
    rx_8 = '0;
    data_15 = '0;
    auth_5 = '0;
    rst_18 = '0;
    clk_17 = '0;
  end
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
  reg _started = 0;
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
    _started <= 1;
  end

  always @(posedge mem_clock_3) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( acknowledge_8 ) == ( 6'bxxx1x0 ) && ( sig_11 != chip_18 ))) || (err_5 == sig_6 && sig_10 == auth_8));
    assert ((!(( acknowledge_8 ) == ( 6'bxxx1x0 ) && ( sig_11 != chip_18 ) && ( rx_5 && auth_2 || cfg_1 ))) || (auth_20 == data_20 && rst_8 == clk_3));
    assert ((!(( acknowledge_8 )!= 6'bxxx1x0 && ( err_7 != rx_19 || sig_5 || sig_14 ))) || (auth_12 == auth_1 && auth_4 == auth_17));
    assert ((!(( acknowledge_8 )!= 6'bxxx1x0 && ( err_7 != rx_19 || sig_5 || sig_14 ) && ( err_5 != chip_6 || rx_8 ))) || (data_15 == auth_5 && rst_18 == clk_17));
    end
  end
endmodule
