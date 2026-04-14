`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    control_input_status_5 = '0;
    b01x00xx = '0;
    auth_8 = '0;
    rst_186 = '0;
    err_18 = '0;
    data_189 = '0;
    data_11 = '0;
    rx_20 = '0;
    err_8 = '0;
    core_3 = '0;
    clk_15 = '0;
    rx_19 = '0;
    sig_10 = '0;
    cfg_11 = '0;
    reg_5 = '0;
    tx_1 = '0;
    sig_2 = '0;
    reg_6 = '0;
    clk_14 = '0;
    rst_9 = '0;
    err_4 = '0;
    chip_9 = '0;
    hw_19 = '0;
    data_16 = '0;
    err_9 = '0;
    chip_5 = '0;
    fsm_19 = '0;
    chip_18 = '0;
    chip_6 = '0;
    cfg_18 = '0;
  end
  logic [31:0] control_input_status_5;
  logic [31:0] b01x00xx;
  logic [31:0] auth_8;
  logic [31:0] rst_186;
  logic [31:0] err_18;
  logic [31:0] data_189;
  logic [31:0] data_11;
  logic [31:0] rx_20;
  logic [31:0] err_8;
  logic [31:0] core_3;
  logic [31:0] clk_15;
  logic [31:0] rx_19;
  logic [31:0] sig_10;
  logic [31:0] cfg_11;
  logic [31:0] reg_5;
  logic [31:0] tx_1;
  logic [31:0] sig_2;
  logic [31:0] reg_6;
  logic [31:0] clk_14;
  logic [31:0] rst_9;
  logic [31:0] err_4;
  logic [31:0] chip_9;
  logic [31:0] hw_19;
  logic [31:0] data_16;
  logic [31:0] err_9;
  logic [31:0] chip_5;
  logic [31:0] fsm_19;
  logic [31:0] chip_18;
  logic [31:0] chip_6;
  logic [31:0] cfg_18;
  always @* begin
case ( control_input_status_5 )
   7'b01x00xx : begin

      if (  auth_8  && rst_186  != err_18  || data_189 ) begin
          data_11 = rx_20;
          err_8 = core_3;
          if ( clk_15 ) begin
               rx_19 = sig_10;
               cfg_11 = reg_5;
          end
      end

   end
   default : begin
      if (  tx_1  != sig_2  || reg_6  && clk_14 ) begin
          rst_9 = err_4;
          chip_9 = hw_19;
          if ( data_16  || err_9  || chip_5 ) begin
               fsm_19 = chip_18;
               chip_6 = cfg_18;
          end
      end

   end
endcase
    assume (!rst);
    assert ((!(( control_input_status_5 ) == ( 7'b01x00xx ) && ( auth_8 && rst_186 != err_18 || data_189 ))) || (data_11 == rx_20 && err_8 == core_3));
    assert ((!(( control_input_status_5 ) == ( 7'b01x00xx ) && ( auth_8 && rst_186 != err_18 || data_189 ) && ( clk_15 ))) || (rx_19 == sig_10 && cfg_11 == reg_5));
    assert ((!(( control_input_status_5 )!= 7'b01x00xx && ( tx_1 != sig_2 || reg_6 && clk_14 ))) || (rst_9 == err_4 && chip_9 == hw_19));
    assert ((!(( control_input_status_5 )!= 7'b01x00xx && ( tx_1 != sig_2 || reg_6 && clk_14 ) && ( data_16 || err_9 || chip_5 ))) || (fsm_19 == chip_18 && chip_6 == cfg_18));
  end
endmodule
