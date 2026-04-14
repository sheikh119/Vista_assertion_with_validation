`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_gen_4;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] control_input_status_4;
  logic [31:0] bxxx1xx1;
  logic [31:0] auth_17;
  logic [31:0] core_11;
  logic [31:0] data_2;
  logic [31:0] auth_7;
  logic [31:0] rx_14;
  logic [31:0] chip_16;
  logic [31:0] fsm_12;
  logic [31:0] reg_1;
  logic [31:0] clk_11;
  logic [31:0] cfg_15;
  logic [31:0] data_14;
  logic [31:0] auth_15;
  logic [31:0] chip_14;
  logic [31:0] rx_130;
  logic [31:0] sig_5;
  logic [31:0] sig_8;
  logic [31:0] fsm_7;
  logic [31:0] clk_13;
  logic [31:0] err_2;
  logic [31:0] reg_16;
  logic [31:0] rst_15;
  logic [31:0] fsm_2;
  always @(posedge clk_gen_4) begin
case ( control_input_status_4 )
   7'bxxx1xx1 : begin
      if (  auth_17  != core_11  || data_2  && auth_7 ) begin
          rx_14 = chip_16;
          if ( fsm_12  != reg_1  || clk_11  && cfg_15 ) begin
               data_14 <= auth_15;
          end
      end
   end
   default : begin
      if (  chip_14  && rx_130  || sig_5  != sig_8 ) begin
          fsm_7 <= clk_13;
          if ( err_2  || reg_16 ) begin
               rst_15 <= fsm_2;
          end
      end
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert ((!(( control_input_status_4 ) == ( 7'bxxx1xx1 ) && ( auth_17 != core_11 || data_2 && auth_7 ))) || (rx_14 == chip_16));
    assert ((!(( control_input_status_4 ) == ( 7'bxxx1xx1 ) && ( auth_17 != core_11 || data_2 && auth_7 ) && ( fsm_12 != reg_1 || clk_11 && cfg_15 ))) || (data_14 == auth_15));
    assert ((!(( control_input_status_4 )!= 7'bxxx1xx1 && ( chip_14 && rx_130 || sig_5 != sig_8 ))) || (fsm_7 == clk_13));
    assert ((!(( control_input_status_4 )!= 7'bxxx1xx1 && ( chip_14 && rx_130 || sig_5 != sig_8 ) && ( err_2 || reg_16 ))) || (rst_15 == fsm_2));
  end
endmodule
