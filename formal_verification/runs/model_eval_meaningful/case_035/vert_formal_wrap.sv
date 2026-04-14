`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_1;
  logic [31:0] auth_17;
  logic [31:0] auth_18;
  logic [31:0] auth_5;
  logic [31:0] cfg_11;
  logic [31:0] cfg_8;
  logic [31:0] cfg_9;
  logic [31:0] chip_11;
  logic [31:0] chip_17;
  logic [31:0] chip_7;
  logic [31:0] clk_19;
  logic [31:0] clk_3;
  logic [31:0] core_14;
  logic [31:0] data_7;
  logic [31:0] default;
  logic [31:0] err_12;
  logic [31:0] err_56;
  logic [31:0] fsm_1;
  logic [31:0] fsm_2;
  logic [31:0] h44;
  logic [31:0] hw_11;
  logic [31:0] hw_8;
  logic [31:0] hw_9;
  logic [31:0] reg_14;
  logic [31:0] reg_15;
  logic [31:0] rst_13;
  logic [31:0] rst_18;
  logic [31:0] rst_7;
  logic [31:0] rx_10;
  logic [31:0] rx_12;
  logic [31:0] sig_16;
  logic [31:0] tx_3;
  logic [31:0] valid_input_4;
  always @* begin
case ( valid_input_4 ) 
   7'h44 : begin

      if (  cfg_8  || reg_15  && rst_13 ) begin 
          cfg_11 = auth_1;
          rx_10 = chip_11;
          if ( fsm_2  && hw_9  && err_56 ) begin
               auth_18 = hw_8;
               sig_16 = core_14;
          end
      end

   end
   default : begin 
      if (  data_7  || chip_7  && tx_3  != auth_5 ) begin 
          rx_12 = clk_19;
          hw_11 = auth_17;
          if ( rst_18  != rst_7  && clk_3  || reg_14 ) begin
               fsm_1 = err_12;
               cfg_9 = chip_17;
          end
      end

   end
endcase
  end

  always @* begin
    assert (((!(( valid_input_4 ) == ( 7'h44 ) && ( cfg_8 || reg_15 && rst_13 ))) || (cfg_11 == auth_1 && rx_10 == chip_11)));
    assert (((!(( valid_input_4 ) == ( 7'h44 ) && ( cfg_8 || reg_15 && rst_13 ) && ( fsm_2 && hw_9 && err_56 ))) || (auth_18 == hw_8 && sig_16 == core_14)));
  end
endmodule
