`timescale 1ns/1ps
module vert_formal_wrap;
  logic main_clk_5;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] status_output_buffer_2;
  logic [31:0] bx1x10;
  logic [31:0] clk_14;
  logic [31:0] clk_10;
  logic [31:0] hw_2;
  logic [31:0] hw_19;
  logic [31:0] reg_19;
  logic [31:0] data_7;
  logic [31:0] sig_20;
  logic [31:0] default;
  logic [31:0] rst_11;
  logic [31:0] chip_15;
  logic [31:0] cfg_10;
  logic [31:0] auth_3;
  logic [31:0] fsm_18;
  logic [31:0] reg_11;
  logic [31:0] clk_11;
  logic [31:0] err_13;
  always @(negedge main_clk_5) begin
case ( status_output_buffer_2 ) 
   5'bx1x10 : begin
      if (  clk_14  || clk_10 ) begin 
          hw_2 = hw_19;
          if ( reg_19 ) begin
               data_7 = sig_20;
          end
      end
   end
   default : begin 
      if (  rst_11  != chip_15 ) begin 
          cfg_10 = auth_3;
          if ( fsm_18  != reg_11 ) begin
               clk_11 = err_13;
          end
      end
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
