`timescale 1ns/1ps
module vert_formal_wrap;
  logic negedge clk_reset_10;
  logic rst;
  logic [31:0] b1;
  logic [31:0] bx11xxx;
  logic [31:0] chip_7;
  logic [31:0] control_register_status_status_13;
  logic [31:0] default;
  logic [31:0] fsm_7;
  logic [31:0] hw_18;
  logic [31:0] reg_11;
  logic [31:0] rx_1;
  logic [31:0] sig_11;
  logic [31:0] sig_19;
  logic [31:0] tx_10;
  always @(posedge negedge clk_reset_10) begin
case ( control_register_status_status_13 ) 
   6'bx11xxx : begin
     fsm_7 = rx_1
     tx_10 = chip_7;
   end
   default : begin 
     sig_19 <= hw_18
     reg_11 = sig_11;
   end
endcase
  end

  always @* begin
    assert (1'b1);
  end
endmodule
