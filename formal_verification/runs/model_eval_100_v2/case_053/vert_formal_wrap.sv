`timescale 1ns/1ps
module vert_formal_wrap;
  logic negedge clock_div_20;
  logic rst;
  logic [31:0] auth_6;
  logic [31:0] bx01x10x;
  logic [31:0] bx0x000;
  logic [31:0] cfg_13;
  logic [31:0] chip_10;
  logic [31:0] chip_6;
  logic [31:0] clk_1;
  logic [31:0] clock_div_20;
  logic [31:0] command_status_17;
  logic [31:0] default;
  logic [31:0] fsm_12;
  logic [31:0] hw_16;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_10;
  logic [31:0] rst_12;
  logic [31:0] rst_18;
  logic [31:0] rst_9;
  logic [31:0] tx_20;
  always_ff @(posedge negedge clock_div_20) begin
case ( command_status_17 ) 
   7'bx01x10x : begin
     chip_10 = hw_16
     fsm_12 <= rst_9;
   end
   6'bx0x000 : begin
     cfg_13 <= chip_6
     clk_1 = reg_10;
   end
   default : begin 
     rst_12 <= auth_6
     tx_20 <= rst_18;
   end
endcase
  end
property p_gen_1; @(negedge clock_div_20) ( command_status_17 ) == ( 7'bx01x10x ) |-> chip_10 == hw_16 && fsm_12 == rst_9 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(negedge clock_div_20) ( command_status_17 ) == ( 6'bx0x000 ) |-> cfg_13 == chip_6 && clk_1 == reg_10 ; endproperty
assert property (p_gen_2);
property p_gen_3; ( command_status_17 )!= 7'bx01x10x && @(negedge clock_div_20) ( command_status_17 )!= 6'bx0x000 |-> rst_12 == auth_6 && tx_20 == rst_18; endproperty
assert property (p_gen_3);
endmodule
