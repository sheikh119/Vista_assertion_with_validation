`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_120;
  logic [31:0] bx1011x;
  logic [31:0] cfg_16;
  logic [31:0] clk_14;
  logic [31:0] control_data_5;
  logic [31:0] core_17;
  logic [31:0] data_1;
  logic [31:0] data_14;
  logic [31:0] data_8;
  logic [31:0] default;
  logic [31:0] err_10;
  logic [31:0] err_17;
  logic [31:0] fsm_11;
  logic [31:0] hw_14;
  logic [31:0] hw_17;
  logic [31:0] rx_1;
  logic [31:0] rx_19;
  logic [31:0] sig_1;
  logic [31:0] sig_10;
  logic [31:0] sig_17;
  logic [31:0] tx_15;
  always @* begin
case ( control_data_5 ) 
   6'bx1011x : begin

      if (  err_17  && fsm_11  || rx_19  != clk_14 ) begin 
          data_1 = core_17;
          if ( rx_1 ) begin
               err_10 = data_8;
          end
      end

   end
   default : begin 
      if (  sig_1 ) begin 
          data_14 = cfg_16;
          if ( tx_15  != hw_17  || auth_120  && hw_14 ) begin
               sig_10 = sig_17;
          end
      end

   end
endcase
  end

  always @* begin
    assert (((!(( control_data_5 ) == ( 6'bx1011x ) && ( err_17 && fsm_11 || rx_19 != clk_14 ))) || (data_1 == core_17)));
    assert (((!(( control_data_5 ) == ( 6'bx1011x ) && ( err_17 && fsm_11 || rx_19 != clk_14 ) && ( rx_1 ))) || (err_10 == data_8)));
    assert (((!(( control_data_5 )!= 6'bx1011x && ( sig_1 ))) || (data_14 == cfg_16)));
  end
endmodule
