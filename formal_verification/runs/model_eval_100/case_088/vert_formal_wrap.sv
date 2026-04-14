`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] N;
  logic [31:0] SafeWriteeotid;
  logic [31:0] StatusCheckeotid;
  logic [31:0] cfg_6;
  logic [31:0] data_9;
  logic [31:0] default;
  logic [31:0] err_20;
  logic [31:0] fsm_7;
  logic [31:0] h2;
  logic [31:0] lmaktad;
  logic [31:0] r;
  logic [31:0] status_output_buffer_12;

  always_comb begin
case ( status_output_buffer_12 ) 
   2'h2 : begin
     fsm_7 = err_20;
   end
   default : begin 
     cfg_6 = data_9;
   end
endcase
  end

 property StatusCheckeotid: ( status_output_buffer_12 ) == ( 2'h2 ) |=> fsm_7 == err_20 ;endproperty
  property SafeWriteeotid; ( status_output_buffer_12 )!= 2'h2 ) ) |=> cfg_6 == data_9 ; endproperty
 ılmaktadırилактиЎыџNилася
endmodule
