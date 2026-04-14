`timescale 1ns/1ps
module vert_formal_wrap;
  logic negedge sys_clk_2;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] b00001;
  logic [31:0] b0x1100;
  logic [31:0] b1;
  logic [31:0] cfg_13;
  logic [31:0] cfg_16;
  logic [31:0] cfg_4;
  logic [31:0] chip_20;
  logic [31:0] clk_7;
  logic [31:0] core_11;
  logic [31:0] core_5;
  logic [31:0] core_9;
  logic [31:0] data_10;
  logic [31:0] data_18;
  logic [31:0] data_2;
  logic [31:0] data_3;
  logic [31:0] data_4;
  logic [31:0] data_status_register_11;
  logic [31:0] default;
  logic [31:0] fsm_14;
  logic [31:0] fsm_19;
  logic [31:0] h63;
  logic [31:0] hw_18;
  logic [31:0] reg_1;
  logic [31:0] reg_10;
  logic [31:0] reg_19;
  logic [31:0] rst_3;
  logic [31:0] rst_7;
  logic [31:0] rx_16;
  logic [31:0] sig_8;
  logic [31:0] tx_5;
  always @(posedge negedge sys_clk_2) begin
case ( data_status_register_11 ) 
   5'b00001 : begin
     cfg_13 = reg_1
     sig_8 = cfg_4
     reg_10 <= cfg_16;
   end
   7'h63 : begin
     core_5 <= tx_5
     clk_7 = fsm_14
     rx_16 <= hw_18;
   end
   6'b0x1100 : begin
     data_18 = chip_20
     core_11 = data_2
     fsm_19 <= data_3;
   end
   default : begin 
     rst_3 = data_4
     reg_19 <= rst_7
     core_9 = data_10;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
