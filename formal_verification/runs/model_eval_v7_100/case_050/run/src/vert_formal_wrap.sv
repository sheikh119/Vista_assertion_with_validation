`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_reset_10;
  logic rst;
  initial begin
    rst = 1'b0;
    control_register_status_status_13 = '0;
    bx11xxx = '0;
    fsm_7 = '0;
    rx_1 = '0;
    tx_10 = '0;
    chip_7 = '0;
    sig_19 = '0;
    hw_18 = '0;
    reg_11 = '0;
    sig_11 = '0;
  end
  logic [31:0] control_register_status_status_13;
  logic [31:0] bx11xxx;
  logic [31:0] fsm_7;
  logic [31:0] rx_1;
  logic [31:0] tx_10;
  logic [31:0] chip_7;
  logic [31:0] sig_19;
  logic [31:0] hw_18;
  logic [31:0] reg_11;
  logic [31:0] sig_11;
  reg _started = 0;
  always @(negedge clk_reset_10) begin
case ( control_register_status_status_13 )
   6'bx11xxx : begin
     fsm_7 = rx_1;
     tx_10 = chip_7;
   end
   default : begin
     sig_19 <= hw_18;
     reg_11 = sig_11;
   end
endcase
    _started <= 1;
  end

  always @(negedge clk_reset_10) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( control_register_status_status_13 ) == ( 6'bx11xxx ))) || (fsm_7 == rx_1 && tx_10 == chip_7));
    assert ((!(( control_register_status_status_13 )!= 6'bx11xxx)) || (sig_19 == hw_18 && reg_11 == sig_11));
    end
  end
endmodule
