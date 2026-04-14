`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] control_input_status_15;
  logic [31:0] h7e;
  logic [31:0] sig_5;
  logic [31:0] fsm_19;
  logic [31:0] b01000x;
  logic [31:0] cfg_11;
  logic [31:0] clk_17;
  logic [31:0] cfg_7;
  logic [31:0] rst_16;
  logic [31:0] b1;
  always @* begin
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

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
