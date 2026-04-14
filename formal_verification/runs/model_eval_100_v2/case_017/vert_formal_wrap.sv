`timescale 1ns/1ps
module vert_formal_wrap;
  logic negedge fast_clk_8;
  logic rst;
  logic [31:0] auth_15;
  logic [31:0] auth_17;
  logic [31:0] auth_4;
  logic [31:0] b00x0001;
  logic [31:0] b1x1xxxx;
  logic [31:0] bxx0x0x;
  logic [31:0] cfg_11;
  logic [31:0] core_20;
  logic [31:0] core_4;
  logic [31:0] data_1;
  logic [31:0] default;
  logic [31:0] fast_clk_8;
  logic [31:0] hw_10;
  logic [31:0] hw_4;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] rst_9;
  logic [31:0] rx_20;
  logic [31:0] rx_5;
  logic [31:0] sig_17;
  logic [31:0] status_register_status_10;
  logic [31:0] tx_18;
  logic [31:0] tx_3;
  logic [31:0] tx_9;
  always_ff @(posedge negedge fast_clk_8) begin
case ( status_register_status_10 ) 
   6'bxx0x0x : begin
     auth_15 = auth_4
     rx_20 = tx_9;
   end
   7'b00x0001 : begin
     auth_17 = core_20
     hw_10 = tx_18;
   end
   7'b1x1xxxx : begin
     core_4 = data_1
     tx_3 = rst_9;
   end
   default : begin 
     hw_4 = rx_5
     cfg_11 <= sig_17;
   end
endcase
  end
property p_gen_1; @(negedge fast_clk_8) ( status_register_status_10 ) == ( 6'bxx0x0x ) |-> auth_15 == auth_4 && rx_20 == tx_9 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(negedge fast_clk_8) ( status_register_status_10 ) == ( 7'b00x0001 ) |-> auth_17 == core_20 && hw_10 == tx_18 ; endproperty
assert property (p_gen_2);
property p_gen_3; @(negedge fast_clk_8) ( status_register_status_10 ) == ( 7'b1x1xxxx ) |-> core_4 == data_1 && tx_3 == rst_9 ; endproperty
assert property (p_gen_3);
endmodule
