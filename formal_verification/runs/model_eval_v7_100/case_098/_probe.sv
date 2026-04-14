`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    output_register_status_18 = '0;
    bx10x1x = '0;
    cfg_9 = '0;
    tx_2 = '0;
    err_16 = '0;
    rst_12 = '0;
    data_20 = '0;
    auth_15 = '0;
    rx_6 = '0;
    data_8 = '0;
    rx_17 = '0;
    reg_20 = '0;
    rst_10 = '0;
    chip_19 = '0;
    rx_7 = '0;
    rx_1 = '0;
    chip_10 = '0;
    hw_17 = '0;
    auth_8 = '0;
    data_7 = '0;
    rst_5 = '0;
    rx_19 = '0;
    tx_13 = '0;
    cfg_17 = '0;
    core_13 = '0;
    tx_16 = '0;
    err_4 = '0;
    err_17 = '0;
    chip_2 = '0;
    core_4 = '0;
    chip_11 = '0;
    tx_18 = '0;
    cfg_7 = '0;
    cfg_11 = '0;
    core_10 = '0;
    reg_13 = '0;
    sig_2 = '0;
    rst_19 = '0;
    hw_3 = '0;
  end
  logic [31:0] output_register_status_18;
  logic [31:0] bx10x1x;
  logic [31:0] cfg_9;
  logic [31:0] tx_2;
  logic [31:0] err_16;
  logic [31:0] rst_12;
  logic [31:0] data_20;
  logic [31:0] auth_15;
  logic [31:0] rx_6;
  logic [31:0] data_8;
  logic [31:0] rx_17;
  logic [31:0] reg_20;
  logic [31:0] rst_10;
  logic [31:0] chip_19;
  logic [31:0] rx_7;
  logic [31:0] rx_1;
  logic [31:0] chip_10;
  logic [31:0] hw_17;
  logic [31:0] auth_8;
  logic [31:0] data_7;
  logic [31:0] rst_5;
  logic [31:0] rx_19;
  logic [31:0] tx_13;
  logic [31:0] cfg_17;
  logic [31:0] core_13;
  logic [31:0] tx_16;
  logic [31:0] err_4;
  logic [31:0] err_17;
  logic [31:0] chip_2;
  logic [31:0] core_4;
  logic [31:0] chip_11;
  logic [31:0] tx_18;
  logic [31:0] cfg_7;
  logic [31:0] cfg_11;
  logic [31:0] core_10;
  logic [31:0] reg_13;
  logic [31:0] sig_2;
  logic [31:0] rst_19;
  logic [31:0] hw_3;
  always @* begin
case ( output_register_status_18 )
   6'bx10x1x : begin

      if (  cfg_9  || tx_2  && err_16  != rst_12 ) begin
          data_20 = auth_15;
          rx_6 = data_8;
          rx_17 = reg_20;
          if ( rst_10  != chip_19  && rx_7  && rx_1 ) begin
               chip_10 = hw_17;
               auth_8 = data_7;
               rst_5 = rx_19;
          end
      end

   end
   default : begin
      if (  tx_13  || cfg_17  && core_13  && tx_16 ) begin
          err_4 = err_17;
          chip_2 = core_4;
          chip_11 = tx_18;
          if ( cfg_7  || cfg_11 ) begin
               core_10 = reg_13;
               rx_7 = sig_2;
               rst_19 = hw_3;
          end
      end

   end
endcase
    assume (!rst);
    assert ((!(( output_register_status_18 ) == ( 6'bx10x1x ) && ( cfg_9 || tx_2 && err_16 != rst_12 ))) || (data_20 == auth_15 && rx_6 == data_8 && rx_17 == reg_20));
    assert ((!(( output_register_status_18 ) == ( 6'bx10x1x ) && ( cfg_9 || tx_2 && err_16 != rst_12 ) && ( rst_10 != chip_19 && rx_7 && rx_1 ))) || (chip_10 == hw_17 && auth_8 == data_7 && rst_5 == rx_19));
    assert ((!(( output_register_status_18 )!= 6'bx10x1x && ( tx_13 || cfg_17 && core_13 && tx_16 ))) || (err_4 == err_17 && chip_2 == core_4 && chip_11 == tx_18));
    assert ((!(( output_register_status_18 )!= 6'bx10x1x && ( tx_13 || cfg_17 && core_13 && tx_16 ) && ( cfg_7 || cfg_11 ))) || (core_10 == reg_13 && rx_7 == sig_2 && rst_19 == hw_3));
  end
endmodule
