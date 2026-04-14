`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clk_osc_13;
  logic rst;
  logic [31:0] auth_10;
  logic [31:0] auth_7;
  logic [31:0] b0x1011;
  logic [31:0] cfg_9;
  logic [31:0] chip_19;
  logic [31:0] chip_3;
  logic [31:0] chip_8;
  logic [31:0] clk_osc_13;
  logic [31:0] data_14;
  logic [31:0] default;
  logic [31:0] err_13;
  logic [31:0] err_18;
  logic [31:0] err_5;
  logic [31:0] h58;
  logic [31:0] hw_2;
  logic [31:0] hw_5;
  logic [31:0] interrupt_control_10;
  logic [31:0] rst_12;
  logic [31:0] rst_5;
  logic [31:0] rx_7;
  logic [31:0] sig_16;
  logic [31:0] sig_4;
  logic [31:0] tx_13;
  always @(posedge posedge clk_osc_13) begin
case ( interrupt_control_10 ) 
   6'b0x1011 : begin
     err_5 = sig_4
     hw_2 <= rst_12
     hw_5 = cfg_9;
   end
   7'h58 : begin
     data_14 <= err_13
     rst_5 = rx_7
     chip_8 <= auth_7;
   end
   default : begin 
     err_18 <= auth_10
     chip_3 <= tx_13
     sig_16 = chip_19;
   end
endcase
  end

  always @* begin
    assert (((!(@(posedge clk_osc_13) ( interrupt_control_10 ) == ( 6'b0x1011 ))) || (err_5 == sig_4 && hw_2 == rst_12 && hw_5 == cfg_9)));
    assert (((!(@(posedge clk_osc_13) ( interrupt_control_10 ) == ( 7'h58 ))) || (data_14 == err_13 && rst_5 == rx_7 && chip_8 == auth_7)));
  end
endmodule
