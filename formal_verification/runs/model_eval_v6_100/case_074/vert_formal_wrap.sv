`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_osc_1;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] data_buffer_status_3;
  logic [31:0] b0xxx1x;
  logic [31:0] err_6;
  logic [31:0] fsm_10;
  logic [31:0] rst_3;
  logic [31:0] cfg_6;
  logic [31:0] bxx1xx;
  logic [31:0] auth_15;
  logic [31:0] cfg_8;
  logic [31:0] hw_14;
  logic [31:0] rst_11;
  logic [31:0] sig_19;
  logic [31:0] sig_5;
  logic [31:0] core_4;
  logic [31:0] data_20;
  logic [31:0] sig_2;
  logic [31:0] rst_12;
  logic [31:0] cfg_2;
  logic [31:0] err_15;
  logic [31:0] clk_17;
  always @(posedge clk_osc_1) begin
case ( data_buffer_status_3 )
   6'b0xxx1x : begin
     err_6 = fsm_10;
     rst_3 = cfg_6;
   end
   5'bxx1xx : begin
     auth_15 <= cfg_8;
     hw_14 <= rst_11;
   end
   sig_19 : begin
     sig_5 = core_4;
     data_20 = sig_2;
   end
   default : begin
     rst_12 <= cfg_2;
     err_15 = clk_17;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert ((!(( data_buffer_status_3 ) == ( 6'b0xxx1x ))) || (err_6 == fsm_10 && rst_3 == cfg_6));
    assert ((!(( data_buffer_status_3 ) == ( 5'bxx1xx ))) || (auth_15 == cfg_8 && hw_14 == rst_11));
    assert ((!(( data_buffer_status_3 ) == ( sig_19 ))) || (sig_5 == core_4 && data_20 == sig_2));
    assert ((!(( data_buffer_status_3 )!= 6'b0xxx1x && ( data_buffer_status_3 )!= 5'bxx1xx && ( data_buffer_status_3 )!= sig_19)) || (rst_12 == cfg_2 && err_15 == clk_17));
  end
endmodule
