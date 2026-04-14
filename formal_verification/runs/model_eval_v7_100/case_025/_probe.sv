`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_ctrl_3;
  logic rst;
  initial begin
    rst = 1'b0;
    flag_control_19 = '0;
    b1001001 = '0;
    fsm_19 = '0;
    clk_15 = '0;
    core_4 = '0;
    err_17 = '0;
    reg_4 = '0;
    sig_17 = '0;
    core_11 = '0;
    err_5 = '0;
    hw_4 = '0;
    rst_18 = '0;
    err_13 = '0;
    chip_7 = '0;
    hw_7 = '0;
    reg_12 = '0;
    hw_17 = '0;
    core_20 = '0;
    hw_1 = '0;
    rst_1 = '0;
    auth_11 = '0;
    auth_12 = '0;
    err_6 = '0;
    clk_4 = '0;
    clk_1 = '0;
    chip_6 = '0;
    fsm_10 = '0;
    rx_11 = '0;
    fsm_13 = '0;
    reg_14 = '0;
    hw_5 = '0;
    clk_20 = '0;
    rx_19 = '0;
    clk_14 = '0;
    rst_15 = '0;
    clk_16 = '0;
    hw_16 = '0;
    reg_8 = '0;
  end
  logic [31:0] flag_control_19;
  logic [31:0] b1001001;
  logic [31:0] fsm_19;
  logic [31:0] clk_15;
  logic [31:0] core_4;
  logic [31:0] err_17;
  logic [31:0] reg_4;
  logic [31:0] sig_17;
  logic [31:0] core_11;
  logic [31:0] err_5;
  logic [31:0] hw_4;
  logic [31:0] rst_18;
  logic [31:0] err_13;
  logic [31:0] chip_7;
  logic [31:0] hw_7;
  logic [31:0] reg_12;
  logic [31:0] hw_17;
  logic [31:0] core_20;
  logic [31:0] hw_1;
  logic [31:0] rst_1;
  logic [31:0] auth_11;
  logic [31:0] auth_12;
  logic [31:0] err_6;
  logic [31:0] clk_4;
  logic [31:0] clk_1;
  logic [31:0] chip_6;
  logic [31:0] fsm_10;
  logic [31:0] rx_11;
  logic [31:0] fsm_13;
  logic [31:0] reg_14;
  logic [31:0] hw_5;
  logic [31:0] clk_20;
  logic [31:0] rx_19;
  logic [31:0] clk_14;
  logic [31:0] rst_15;
  logic [31:0] clk_16;
  logic [31:0] hw_16;
  logic [31:0] reg_8;
  reg _started = 0;
  always @(posedge clock_ctrl_3) begin
case ( flag_control_19 )
   7'b1001001 : begin
      if (  fsm_19  || clk_15  != core_4 ) begin
          err_17 = reg_4;
          sig_17 = core_11;
          err_5 = hw_4;
          if ( rst_18  && err_13  != chip_7  && hw_7 ) begin
               reg_12 <= hw_17;
               core_20 = hw_1;
               rst_1 = auth_11;
          end
      end
   end
   default : begin
      if (  auth_12  && err_6  || clk_4  || clk_1 ) begin
          chip_6 <= fsm_10;
          rx_11 <= sig_17;
          fsm_13 = reg_14;
          if ( hw_5  != clk_20 ) begin
               rx_19 <= clk_14;
               rst_15 = clk_16;
               hw_16 <= reg_8;
          end
      end
   end
endcase
    _started <= 1;
  end

  always @(posedge clock_ctrl_3) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( flag_control_19 ) == ( 7'b1001001 ) && ( fsm_19 || clk_15 != core_4 ))) || (err_17 == reg_4 && sig_17 == core_11 && err_5 == hw_4));
    assert ((!(( flag_control_19 ) == ( 7'b1001001 ) && ( fsm_19 || clk_15 != core_4 ) && ( rst_18 && err_13 != chip_7 && hw_7 ))) || (reg_12 == hw_17 && core_20 == hw_1 && rst_1 == auth_11));
    assert ((!(( flag_control_19 )!= 7'b1001001 && ( auth_12 && err_6 || clk_4 || clk_1 ))) || (chip_6 == fsm_10 && rx_11 == sig_17 && fsm_13 == reg_14));
    assert ((!(( flag_control_19 )!= 7'b1001001 && ( auth_12 && err_6 || clk_4 || clk_1 ) && ( hw_5 != clk_20 ))) || (rx_19 == clk_14 && rst_15 == clk_16 && hw_16 == reg_8));
    end
  end
endmodule
