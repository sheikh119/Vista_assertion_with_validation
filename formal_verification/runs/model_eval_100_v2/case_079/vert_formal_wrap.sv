`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_8;
  logic [31:0] b001xxxx;
  logic [31:0] chip_6;
  logic [31:0] clk_15;
  logic [31:0] data_16;
  logic [31:0] default;
  logic [31:0] h27;
  logic [31:0] h8;
  logic [31:0] hw_15;
  logic [31:0] hw_17;
  logic [31:0] hw_20;
  logic [31:0] input_buffer_6;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] p_gen_4;
  logic [31:0] sig_11;
  always_comb begin
case ( input_buffer_6 ) 
   5'h8 : begin
     hw_20 = hw_15;
   end
   7'h27 : begin
     data_16 = clk_15;
   end
   7'b001xxxx : begin
     sig_11 = chip_6;
   end
   default : begin 
     hw_17 = auth_8;
   end
endcase
  end
property p_gen_1; : ( input_buffer_6 ) == ( 5'h8 ) |=> hw_20 == hw_15 ; endproperty
assert property (p_gen_1);
property p_gen_2; : ( input_buffer_6 ) == ( 7'h27 ) |=> data_16 == clk_15 ; endproperty
assert property (p_gen_2);
property p_gen_3; : ( input_buffer_6 ) == ( 7'b001xxxx ) |=> sig_11 == chip_6 ; endproperty
assert property (p_gen_3);
property p_gen_4; ( ( input_buffer_6 )!= 5'h8 ) && ( ( input_buffer_6 )!= 7'h27 ) && ( input_buffer_6 )!= 7'b001xxxx ) ) |=> hw_17 == auth_8 ; endproperty
assert property (p_gen_4);
endmodule
