`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_gen_18;
  logic rst;
  initial begin
    rst = 1'b0;
    output_control_2 = '0;
    h5d = '0;
    core_2 = '0;
    data_19 = '0;
    tx_19 = '0;
    fsm_9 = '0;
    rst_14 = '0;
    clk_15 = '0;
    tx_5 = '0;
    sig_3 = '0;
    auth_2 = '0;
    err_3 = '0;
    rx_12 = '0;
    fsm_14 = '0;
    auth_13 = '0;
    cfg_3 = '0;
    hw_11 = '0;
    reg_3 = '0;
    data_3 = '0;
    fsm_8 = '0;
    rx_190 = '0;
    reg_20 = '0;
    auth_5 = '0;
    data_11 = '0;
    data_14 = '0;
    cfg_10 = '0;
    tx_1 = '0;
    rst_11 = '0;
    auth_6 = '0;
    sig_8 = '0;
    reg_18 = '0;
    chip_2 = '0;
    rst_20 = '0;
    data_17 = '0;
    sig_17 = '0;
    fsm_16 = '0;
    rx_14 = '0;
  end
  logic [31:0] output_control_2;
  logic [31:0] h5d;
  logic [31:0] core_2;
  logic [31:0] data_19;
  logic [31:0] tx_19;
  logic [31:0] fsm_9;
  logic [31:0] rst_14;
  logic [31:0] clk_15;
  logic [31:0] tx_5;
  logic [31:0] sig_3;
  logic [31:0] auth_2;
  logic [31:0] err_3;
  logic [31:0] rx_12;
  logic [31:0] fsm_14;
  logic [31:0] auth_13;
  logic [31:0] cfg_3;
  logic [31:0] hw_11;
  logic [31:0] reg_3;
  logic [31:0] data_3;
  logic [31:0] fsm_8;
  logic [31:0] rx_190;
  logic [31:0] reg_20;
  logic [31:0] auth_5;
  logic [31:0] data_11;
  logic [31:0] data_14;
  logic [31:0] cfg_10;
  logic [31:0] tx_1;
  logic [31:0] rst_11;
  logic [31:0] auth_6;
  logic [31:0] sig_8;
  logic [31:0] reg_18;
  logic [31:0] chip_2;
  logic [31:0] rst_20;
  logic [31:0] data_17;
  logic [31:0] sig_17;
  logic [31:0] fsm_16;
  logic [31:0] rx_14;
  reg _started = 0;
  always @(posedge clk_gen_18) begin
case ( output_control_2 )
   7'h5d : begin
      if (  core_2  != data_19  && tx_19 ) begin
          fsm_9 = rst_14;
          clk_15 = tx_5;
          sig_3 = auth_2;
          if ( err_3  != rx_12 ) begin
               fsm_14 <= tx_19;
               auth_13 = cfg_3;
               hw_11 = reg_3;
          end
      end
   end
   default : begin
      if (  data_3  != fsm_8  && rx_190 ) begin
          reg_20 <= auth_5;
          data_11 <= data_14;
          cfg_10 <= tx_1;
          if ( rst_11  || auth_6  || sig_8  || reg_18 ) begin
               chip_2 <= rst_20;
               data_17 <= sig_17;
               fsm_16 <= rx_14;
          end
      end
   end
endcase
    _started <= 1;
  end

  always @(posedge clk_gen_18) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( output_control_2 ) == ( 7'h5d ) && ( core_2 != data_19 && tx_19 ))) || (fsm_9 == rst_14 && clk_15 == tx_5 && sig_3 == auth_2));
    assert ((!(( output_control_2 ) == ( 7'h5d ) && ( core_2 != data_19 && tx_19 ) && ( err_3 != rx_12 ))) || (fsm_14 == tx_19 && auth_13 == cfg_3 && hw_11 == reg_3));
    assert ((!(( output_control_2 )!= 7'h5d && ( data_3 != fsm_8 && rx_190 ))) || (reg_20 == auth_5 && data_11 == data_14 && cfg_10 == tx_1));
    assert ((!(( output_control_2 )!= 7'h5d && ( data_3 != fsm_8 && rx_190 ) && ( rst_11 || auth_6 || sig_8 || reg_18 ))) || (chip_2 == rst_20 && data_17 == sig_17 && fsm_16 == rx_14));
    end
  end
endmodule
