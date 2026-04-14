`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    transfer_complete_13 = '0;
    b1x11111 = '0;
    chip_117 = '0;
    rx_4 = '0;
    chip_4 = '0;
    core_15 = '0;
    hw_13 = '0;
    auth_19 = '0;
    auth_16 = '0;
    core_11 = '0;
    clk_15 = '0;
    chip_12 = '0;
    tx_2 = '0;
    rst_16 = '0;
    clk_18 = '0;
    err_13 = '0;
    auth_10 = '0;
    hw_3 = '0;
    auth_4 = '0;
    cfg_11 = '0;
    hw_8 = '0;
    clk_1 = '0;
    chip_8 = '0;
    sig_7 = '0;
    fsm_4 = '0;
    fsm_18 = '0;
    data_13 = '0;
    err_9 = '0;
    hw_2 = '0;
    rx_20 = '0;
    tx_17 = '0;
    sig_2 = '0;
    tx_1 = '0;
    rst_8 = '0;
    core_14 = '0;
  end
  logic [31:0] transfer_complete_13;
  logic [31:0] b1x11111;
  logic [31:0] chip_117;
  logic [31:0] rx_4;
  logic [31:0] chip_4;
  logic [31:0] core_15;
  logic [31:0] hw_13;
  logic [31:0] auth_19;
  logic [31:0] auth_16;
  logic [31:0] core_11;
  logic [31:0] clk_15;
  logic [31:0] chip_12;
  logic [31:0] tx_2;
  logic [31:0] rst_16;
  logic [31:0] clk_18;
  logic [31:0] err_13;
  logic [31:0] auth_10;
  logic [31:0] hw_3;
  logic [31:0] auth_4;
  logic [31:0] cfg_11;
  logic [31:0] hw_8;
  logic [31:0] clk_1;
  logic [31:0] chip_8;
  logic [31:0] sig_7;
  logic [31:0] fsm_4;
  logic [31:0] fsm_18;
  logic [31:0] data_13;
  logic [31:0] err_9;
  logic [31:0] hw_2;
  logic [31:0] rx_20;
  logic [31:0] tx_17;
  logic [31:0] sig_2;
  logic [31:0] tx_1;
  logic [31:0] rst_8;
  logic [31:0] core_14;
  always @* begin
case ( transfer_complete_13 )
   7'b1x11111 : begin

      if (  chip_117  || rx_4  || chip_4 ) begin
          core_15 = hw_13;
          auth_19 = auth_16;
          core_11 = clk_15;
          if ( chip_12  && auth_16  || tx_2  || rst_16 ) begin
               clk_18 = err_13;
               auth_10 = hw_3;
               auth_4 = cfg_11;
          end
      end

   end
   default : begin
      if (  hw_8 ) begin
          clk_1 = chip_8;
          sig_7 = fsm_4;
          fsm_18 = data_13;
          if ( err_9  || hw_2 ) begin
               rx_20 = tx_17;
               sig_2 = tx_1;
               rst_8 = core_14;
          end
      end

   end
endcase
    assume (!rst);
    assert ((!(( transfer_complete_13 ) == ( 7'b1x11111 ) && ( chip_117 || rx_4 || chip_4 ))) || (core_15 == hw_13 && auth_19 == auth_16 && core_11 == clk_15));
    assert ((!(( transfer_complete_13 ) == ( 7'b1x11111 ) && ( chip_117 || rx_4 || chip_4 ) && ( chip_12 && auth_16 || tx_2 || rst_16 ))) || (clk_18 == err_13 && auth_10 == hw_3 && auth_4 == cfg_11));
    assert ((!(( transfer_complete_13 )!= 7'b1x11111 && ( hw_8 ))) || (clk_1 == chip_8 && sig_7 == fsm_4 && fsm_18 == data_13));
    assert ((!(( transfer_complete_13 )!= 7'b1x11111 && ( hw_8 ) && ( err_9 || hw_2 ))) || (rx_20 == tx_17 && sig_2 == tx_1 && rst_8 == core_14));
  end
endmodule
