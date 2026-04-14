`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_div_20;
  logic rst;
  initial begin
    rst = 1'b0;
    command_status_17 = '0;
    bx01x10x = '0;
    chip_10 = '0;
    hw_16 = '0;
    fsm_12 = '0;
    rst_9 = '0;
    bx0x000 = '0;
    cfg_13 = '0;
    chip_6 = '0;
    clk_1 = '0;
    reg_10 = '0;
    rst_12 = '0;
    auth_6 = '0;
    tx_20 = '0;
    rst_18 = '0;
  end
  logic [31:0] command_status_17;
  logic [31:0] bx01x10x;
  logic [31:0] chip_10;
  logic [31:0] hw_16;
  logic [31:0] fsm_12;
  logic [31:0] rst_9;
  logic [31:0] bx0x000;
  logic [31:0] cfg_13;
  logic [31:0] chip_6;
  logic [31:0] clk_1;
  logic [31:0] reg_10;
  logic [31:0] rst_12;
  logic [31:0] auth_6;
  logic [31:0] tx_20;
  logic [31:0] rst_18;
  reg _started = 0;
  always @(negedge clock_div_20) begin
case ( command_status_17 )
   7'bx01x10x : begin
     chip_10 = hw_16;
     fsm_12 <= rst_9;
   end
   6'bx0x000 : begin
     cfg_13 <= chip_6;
     clk_1 = reg_10;
   end
   default : begin
     rst_12 <= auth_6;
     tx_20 <= rst_18;
   end
endcase
    _started <= 1;
  end

  always @(negedge clock_div_20) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( command_status_17 ) == ( 7'bx01x10x ))) || (chip_10 == hw_16 && fsm_12 == rst_9));
    assert ((!(( command_status_17 ) == ( 6'bx0x000 ))) || (cfg_13 == chip_6 && clk_1 == reg_10));
    assert ((!(( command_status_17 )!= 7'bx01x10x && ( command_status_17 )!= 6'bx0x000)) || (rst_12 == auth_6 && tx_20 == rst_18));
    end
  end
endmodule
