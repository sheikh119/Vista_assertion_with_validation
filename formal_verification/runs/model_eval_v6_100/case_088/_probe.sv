`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] status_output_buffer_12;
  logic [31:0] h2;
  logic [31:0] fsm_7;
  logic [31:0] err_20;
  logic [31:0] cfg_6;
  logic [31:0] data_9;
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
    assume (!rst);
    assert ((!(( status_output_buffer_12 )!= 2'h2 ) ))) || (cfg_6 == data_9));
  end
endmodule
