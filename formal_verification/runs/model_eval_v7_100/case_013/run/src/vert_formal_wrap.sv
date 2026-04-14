`timescale 1ns/1ps
module vert_formal_wrap;
  logic core_clock_8;
  logic rst;
  initial begin
    rst = 1'b0;
    interrupt_enable_9 = '0;
    h7e = '0;
    tx_6 = '0;
    data_6 = '0;
    reg_3 = '0;
    fsm_1 = '0;
    reg_6 = '0;
    chip_12 = '0;
    hw_5 = '0;
    auth_17 = '0;
    chip_8 = '0;
    hw_9 = '0;
    core_14 = '0;
    rx_9 = '0;
    reg_16 = '0;
    clk_2 = '0;
    sig_5 = '0;
    chip_7 = '0;
    fsm_13 = '0;
    core_11 = '0;
    err_3 = '0;
    chip_13 = '0;
    rst_16 = '0;
    rst_1 = '0;
    sig_11 = '0;
    rst_9 = '0;
    core_8 = '0;
    auth_8 = '0;
    cfg_5 = '0;
    rst_19 = '0;
    chip_10 = '0;
    cfg_14 = '0;
    sig_3 = '0;
    core_17 = '0;
    hw_3 = '0;
  end
  logic [31:0] interrupt_enable_9;
  logic [31:0] h7e;
  logic [31:0] tx_6;
  logic [31:0] data_6;
  logic [31:0] reg_3;
  logic [31:0] fsm_1;
  logic [31:0] reg_6;
  logic [31:0] chip_12;
  logic [31:0] hw_5;
  logic [31:0] auth_17;
  logic [31:0] chip_8;
  logic [31:0] hw_9;
  logic [31:0] core_14;
  logic [31:0] rx_9;
  logic [31:0] reg_16;
  logic [31:0] clk_2;
  logic [31:0] sig_5;
  logic [31:0] chip_7;
  logic [31:0] fsm_13;
  logic [31:0] core_11;
  logic [31:0] err_3;
  logic [31:0] chip_13;
  logic [31:0] rst_16;
  logic [31:0] rst_1;
  logic [31:0] sig_11;
  logic [31:0] rst_9;
  logic [31:0] core_8;
  logic [31:0] auth_8;
  logic [31:0] cfg_5;
  logic [31:0] rst_19;
  logic [31:0] chip_10;
  logic [31:0] cfg_14;
  logic [31:0] sig_3;
  logic [31:0] core_17;
  logic [31:0] hw_3;
  reg _started = 0;
  always @(posedge core_clock_8) begin
case ( interrupt_enable_9 )
   7'h7e : begin
      if (  tx_6  || data_6  != reg_3  && fsm_1 ) begin
          reg_6 = chip_12;
          hw_5 = auth_17;
          chip_8 <= hw_9;
          if ( core_14  != rx_9  && reg_16  || clk_2 ) begin
               chip_12 <= sig_5;
               sig_5 <= chip_7;
               fsm_13 <= core_11;
          end
      end
   end
   default : begin
      if (  err_3  != chip_13  && rst_16  || rst_1 ) begin
          sig_11 = chip_8;
          rst_9 <= core_8;
          auth_8 = cfg_5;
          if ( rst_19 ) begin
               chip_10 <= cfg_14;
               sig_3 = core_17;
               rst_19 <= hw_3;
          end
      end
   end
endcase
    _started <= 1;
  end

  always @(posedge core_clock_8) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( interrupt_enable_9 ) == ( 7'h7e ) && ( tx_6 || data_6 != reg_3 && fsm_1 ))) || (reg_6 == chip_12 && hw_5 == auth_17 && chip_8 == hw_9));
    assert ((!(( interrupt_enable_9 ) == ( 7'h7e ) && ( tx_6 || data_6 != reg_3 && fsm_1 ) && ( core_14 != rx_9 && reg_16 || clk_2 ))) || (chip_12 == sig_5 && sig_5 == chip_7 && fsm_13 == core_11));
    assert ((!(( interrupt_enable_9 )!= 7'h7e && ( err_3 != chip_13 && rst_16 || rst_1 ))) || (sig_11 == chip_8 && rst_9 == core_8 && auth_8 == cfg_5));
    assert ((!(( interrupt_enable_9 )!= 7'h7e && ( err_3 != chip_13 && rst_16 || rst_1 ) && ( rst_19 ))) || (chip_10 == cfg_14 && sig_3 == core_17 && rst_19 == hw_3));
    end
  end
endmodule
