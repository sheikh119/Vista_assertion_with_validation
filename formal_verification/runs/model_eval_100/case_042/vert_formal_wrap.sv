`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] CtrlCheckeotid;
  logic [31:0] CtrlValideotid;
  logic [31:0] EnableSynceotid;
  logic [31:0] N;
  logic [31:0] b01000x;
  logic [31:0] cfg_11;
  logic [31:0] cfg_7;
  logic [31:0] clk_17;
  logic [31:0] control_input_status_15;
  logic [31:0] default;
  logic [31:0] fsm_19;
  logic [31:0] h7e;
  logic [31:0] rst_16;
  logic [31:0] sig_5;

  always_comb begin
case ( control_input_status_15 ) 
   7'h7e : begin
     sig_5 = fsm_19;
   end
   6'b01000x : begin
     cfg_11 = clk_17;
   end
   default : begin 
     cfg_7 = rst_16;
   end
endcase
  end

 property CtrlValideotid: ( control_input_status_15 ) == ( 7'h7e ) |=> sig_5 == fsm_19 ;endproperty
 property EnableSynceotid: ( control_input_status_15 ) == ( 6'b01000x ) |=> cfg_11 == clk_17 ;endproperty
 property CtrlCheckeotid; ( ( control_input_status_15 )!= 7'h7e ) && ( control_input_status_15 )!= 6'b01000x ) ) |=> cfg_7 == rst_16 ; endproperty
 ЎыџNЎыџN
endmodule
