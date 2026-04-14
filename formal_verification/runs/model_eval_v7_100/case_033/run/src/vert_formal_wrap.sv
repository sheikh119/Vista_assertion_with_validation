`timescale 1ns/1ps
module vert_formal_wrap;
  logic ref_clk_11;
  logic rst;
  initial begin
    rst = 1'b0;
    read_data_12 = '0;
    b1x01000 = '0;
    rst_18 = '0;
    rx_17 = '0;
    clk_1 = '0;
    tx_4 = '0;
    chip_6 = '0;
    sig_16 = '0;
    core_14 = '0;
    cfg_17 = '0;
  end
  logic [31:0] read_data_12;
  logic [31:0] b1x01000;
  logic [31:0] rst_18;
  logic [31:0] rx_17;
  logic [31:0] clk_1;
  logic [31:0] tx_4;
  logic [31:0] chip_6;
  logic [31:0] sig_16;
  logic [31:0] core_14;
  logic [31:0] cfg_17;
  reg _started = 0;
  always @(posedge ref_clk_11) begin
case ( read_data_12 )
   7'b1x01000 : begin
     rst_18 = rx_17;
     clk_1 <= tx_4;
   end
   default : begin
     chip_6 = sig_16;
     core_14 <= cfg_17;
   end
endcase
    _started <= 1;
  end

  always @(posedge ref_clk_11) begin
    if (_started) begin
    assume (!rst);
      assert ((!(( read_data_12 ) == ( 7'b1x01000 ))) || (rst_18 == rx_17 && clk_1 == tx_4));
    assert ((!(( read_data_12 )!= 7'b1x01000)) || (chip_6 == sig_16 && core_14 == cfg_17));
    end
  end
endmodule
