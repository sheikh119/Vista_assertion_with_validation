`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_ctrl_20;
  logic rst;
  initial begin
    rst = 1'b0;
    hw_12 = '0;
    chip_119 = '0;
    chip_10 = '0;
    auth_20 = '0;
    err_9 = '0;
    core_17 = '0;
    reg_9 = '0;
    tx_2 = '0;
    sig_19 = '0;
    err_79 = '0;
    tx_46 = '0;
    auth_3 = '0;
    rst_7 = '0;
    fsm_16 = '0;
    fsm_5 = '0;
    sig_20 = '0;
    chip_12 = '0;
    err_16 = '0;
    rst_1 = '0;
    clk_11 = '0;
    fsm_17 = '0;
    hw_15 = '0;
    data_8 = '0;
    err_1 = '0;
    auth_13 = '0;
    clk_6 = '0;
    data_15 = '0;
    sig_12 = '0;
    clk_43 = '0;
    core_37 = '0;
    chip_9 = '0;
    auth_19 = '0;
  end
  logic [31:0] hw_12;
  logic [31:0] chip_119;
  logic [31:0] chip_10;
  logic [31:0] auth_20;
  logic [31:0] err_9;
  logic [31:0] core_17;
  logic [31:0] reg_9;
  logic [31:0] tx_2;
  logic [31:0] sig_19;
  logic [31:0] err_79;
  logic [31:0] tx_46;
  logic [31:0] auth_3;
  logic [31:0] rst_7;
  logic [31:0] fsm_16;
  logic [31:0] fsm_5;
  logic [31:0] sig_20;
  logic [31:0] chip_12;
  logic [31:0] err_16;
  logic [31:0] rst_1;
  logic [31:0] clk_11;
  logic [31:0] fsm_17;
  logic [31:0] hw_15;
  logic [31:0] data_8;
  logic [31:0] err_1;
  logic [31:0] auth_13;
  logic [31:0] clk_6;
  logic [31:0] data_15;
  logic [31:0] sig_12;
  logic [31:0] clk_43;
  logic [31:0] core_37;
  logic [31:0] chip_9;
  logic [31:0] auth_19;
  reg _started = 0;
  always @(negedge clock_ctrl_20) begin
if (  hw_12  || chip_119  != chip_10  || auth_20 ) begin
   err_9 <= core_17;
    if ( reg_9  != tx_2  && sig_19 ) begin
      err_79 <= tx_46;
   end
   else if (  auth_3  != rst_7  && fsm_16 ) begin
      fsm_5 <= sig_20;
   end
   else begin
      chip_12 <= fsm_5;
   end
end
else begin
   err_9 = err_16;
   if (  rst_1  != clk_11  || fsm_17  || hw_15 ) begin
      data_8 = err_1;
   end
   else if (  auth_13  || clk_6  && data_15  && sig_12 ) begin
      clk_43 = core_37;
   end
   else begin
      chip_9 <= auth_19;
   end
end
    _started <= 1;
  end

  always @(negedge clock_ctrl_20) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( hw_12 || chip_119 != chip_10 || auth_20 ))) || (err_9 == core_17));
    assert ((!(( hw_12 || chip_119 != chip_10 || auth_20 ) && ( reg_9 != tx_2 && sig_19 ))) || (err_79 == tx_46));
    assert ((!(( hw_12 || chip_119 != chip_10 || auth_20 ) && (!( reg_9 != tx_2 && sig_19 ) && ( auth_3 != rst_7 && fsm_16 ) ))) || (fsm_5 == sig_20));
    assert ((!(( hw_12 || chip_119 != chip_10 || auth_20 ) && ( !( reg_9 != tx_2 && sig_19 ) &&!( auth_3 != rst_7 && fsm_16 ) ))) || (chip_12 == fsm_5));
    assert ((!(! ( hw_12 || chip_119 != chip_10 || auth_20 ))) || (err_9 == err_16));
    assert ((!(! ( hw_12 || chip_119 != chip_10 || auth_20 ) && ( rst_1 != clk_11 || fsm_17 || hw_15 ))) || (data_8 == err_1));
    end
  end
endmodule
