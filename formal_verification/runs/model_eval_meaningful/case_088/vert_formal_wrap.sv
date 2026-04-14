`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] cfg_6;
  logic [31:0] data_9;
  logic [31:0] default;
  logic [31:0] err_20;
  logic [31:0] fsm_7;
  logic [31:0] h2;
  logic [31:0] status_output_buffer_12;
  always @* begin
case ( status_output_buffer_12 ) 
   2'h2 : begin
     fsm_7 = err_20;
   end
   default : begin 
     cfg_6 = data_9;
   end
endcase
  end

  always @* begin
    assert (((!(: ( status_output_buffer_12 ) == ( 2'h2 ))) || (fsm_7 == err_20)));
    assert (((!(( status_output_buffer_12 )!= 2'h2 ) ))) || (cfg_6 == data_9)));
  end
endmodule
