`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_div_15;
  logic rst;
  initial begin
    rst = 1'b0;
    data_register_18 = '0;
    fsm_20 = '0;
    cfg_13 = '0;
    rst_4 = '0;
    reg_6 = '0;
    sig_20 = '0;
    rst_8 = '0;
    fsm_18 = '0;
    rx_9 = '0;
    sig_13 = '0;
    sig_6 = '0;
    fsm_6 = '0;
    core_7 = '0;
    fsm_17 = '0;
    chip_10 = '0;
    err_14 = '0;
    tx_10 = '0;
    rx_3 = '0;
    hw_16 = '0;
    rx_19 = '0;
    hw_17 = '0;
  end
  logic [31:0] data_register_18;
  logic [31:0] fsm_20;
  logic [31:0] cfg_13;
  logic [31:0] rst_4;
  logic [31:0] reg_6;
  logic [31:0] sig_20;
  logic [31:0] rst_8;
  logic [31:0] fsm_18;
  logic [31:0] rx_9;
  logic [31:0] sig_13;
  logic [31:0] sig_6;
  logic [31:0] fsm_6;
  logic [31:0] core_7;
  logic [31:0] fsm_17;
  logic [31:0] chip_10;
  logic [31:0] err_14;
  logic [31:0] tx_10;
  logic [31:0] rx_3;
  logic [31:0] hw_16;
  logic [31:0] rx_19;
  logic [31:0] hw_17;
  reg _started = 0;
  always @(posedge clock_div_15) begin
case ( data_register_18 )
   fsm_20 : begin
      if (  cfg_13  != rst_4  || reg_6 ) begin
          sig_20 = rst_8;
          if ( fsm_18  && rx_9  != sig_13  && sig_6 ) begin
               fsm_6 = core_7;
          end
      end
   end
   default : begin
      if (  fsm_17 ) begin
          chip_10 <= err_14;
          if ( tx_10  != rx_3  || hw_16 ) begin
               rx_19 <= hw_17;
          end
      end
   end
endcase
    _started <= 1;
  end

  always @(posedge clock_div_15) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( data_register_18 ) == ( fsm_20 ) && ( cfg_13 != rst_4 || reg_6 ))) || (sig_20 == rst_8));
    assert ((!(( data_register_18 ) == ( fsm_20 ) && ( cfg_13 != rst_4 || reg_6 ) && ( fsm_18 && rx_9 != sig_13 && sig_6 ))) || (fsm_6 == core_7));
    assert ((!(( data_register_18 )!= fsm_20 && ( fsm_17 ))) || (chip_10 == err_14));
    assert ((!(( data_register_18 )!= fsm_20 && ( fsm_17 ) && ( tx_10 != rx_3 || hw_16 ))) || (rx_19 == hw_17));
    end
  end
endmodule
