`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] data_register_status_8;
  logic [31:0] bx11110x;
  logic [31:0] chip_10;
  logic [31:0] err_9;
  logic [31:0] tx_6;
  logic [31:0] cfg_17;
  logic [31:0] sig_1515;
  logic [31:0] err_3;
  logic [31:0] reg_9;
  logic [31:0] rst_152;
  logic [31:0] cfg_10;
  logic [31:0] rst_15;
  logic [31:0] sig_8;
  logic [31:0] hw_20;
  logic [31:0] chip_19;
  logic [31:0] rx_1;
  logic [31:0] core_13;
  logic [31:0] tx_9;
  logic [31:0] fsm_12;
  logic [31:0] cfg_1;
  logic [31:0] data_1;
  always @* begin
case ( data_register_status_8 )
   7'bx11110x : begin

      if (  chip_10  != err_9 ) begin
          tx_6 = cfg_17;
          if ( sig_1515  != err_3  && reg_9  != rst_152 ) begin
               cfg_10 = rst_15;
          end
      end

   end
   default : begin
      if (  sig_8  && hw_20  != chip_19  && rx_1 ) begin
          core_13 = tx_9;
          if ( fsm_12 ) begin
               cfg_1 = data_1;
          end
      end

   end
endcase
  end

  always @* begin
    assume (!rst);
    assert ((!(( data_register_status_8 ) == ( 7'bx11110x ) && ( chip_10 != err_9 ))) || (tx_6 == cfg_17));
    assert ((!(( data_register_status_8 ) == ( 7'bx11110x ) && ( chip_10 != err_9 ) && ( sig_1515 != err_3 && reg_9 != rst_152 ))) || (cfg_10 == rst_15));
    assert ((!(( data_register_status_8 )!= 7'bx11110x && ( sig_8 && hw_20 != chip_19 && rx_1 ))) || (core_13 == tx_9));
    assert ((!(( data_register_status_8 )!= 7'bx11110x && ( sig_8 && hw_20 != chip_19 && rx_1 ) && ( fsm_12 ))) || (cfg_1 == data_1));
  end
endmodule
