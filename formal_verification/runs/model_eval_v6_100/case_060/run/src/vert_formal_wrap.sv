`timescale 1ns/1ps
module vert_formal_wrap;
  logic core_clock_15;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] status_flag_8;
  logic [31:0] b1x1x1;
  logic [31:0] cfg_1;
  logic [31:0] rx_9;
  logic [31:0] data_2;
  logic [31:0] auth_4;
  logic [31:0] sig_3;
  logic [31:0] fsm_3;
  logic [31:0] core_4;
  logic [31:0] clk_10;
  always @(posedge core_clock_15) begin
case ( status_flag_8 )
   5'b1x1x1 : begin
     cfg_1 <= rx_9;
     data_2 <= auth_4;
   end
   default : begin
     sig_3 <= fsm_3;
     core_4 <= clk_10;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert ((!(( status_flag_8 ) == ( 5'b1x1x1 ))) || (cfg_1 == rx_9 && data_2 == auth_4));
    assert ((!(( status_flag_8 )!= 5'b1x1x1)) || (sig_3 == fsm_3 && core_4 == clk_10));
  end
endmodule
