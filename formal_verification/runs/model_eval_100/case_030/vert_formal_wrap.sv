`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] AuthOKeotid;
  logic [31:0] ReadyCheckeotid;
  logic [31:0] ValidInputeotid;
  logic [31:0] ValidTxeotid;
  logic [31:0] auth_12;
  logic [31:0] b0xxx0;
  logic [31:0] b110010;
  logic [31:0] bx1xxxxx;
  logic [31:0] cfg_9;
  logic [31:0] chip_5;
  logic [31:0] core_6;
  logic [31:0] default;
  logic [31:0] err_16;
  logic [31:0] fsm_15;
  logic [31:0] h9;
  logic [31:0] input_ready_;
  logic [31:0] input_ready_3;
  logic [31:0] lidTxeotid;
  logic [31:0] reg_3;
  logic [31:0] sig_7;
  logic [31:0] tx_3;
  logic [31:0] tx_6;

  always_comb begin
case ( input_ready_3 ) 
   5'b0xxx0 : begin
     chip_5 = cfg_9;
   end
   6'h9 : begin
     err_16 = reg_3;
   end
   7'bx1xxxxx : begin
     sig_7 = auth_12;
   end
   6'b110010 : begin
     tx_3 = fsm_15;
   end
   default : begin 
     tx_6 = core_6;
   end
endcase
  end

 property ValidInputeotid: ( input_ready_3 ) == ( 5'b0xxx0 ) |=> chip_5 == cfg_9 ;endproperty
property ReadyCheckeotid: ( input_ready_3 ) == ( 6'h9 ) |=> err_16 == reg_3 ;endproperty
property AuthOKeotid: ( input_ready_3 ) == ( 7'bx1xxxxx ) |=> sig_7 == auth_12 ;endproperty
property ValidTxeotid: ( input_ready_3 ) == ( 6'b110010 ) |=> tx_3 == fsm_15 ;endproperty
property lidTxeotid; ( ( input_ready_3 )!= 5'b0xxx0 ) && ( ( input_ready_3 )!= 6'h9 ) && ( ( input_ready_
endmodule
