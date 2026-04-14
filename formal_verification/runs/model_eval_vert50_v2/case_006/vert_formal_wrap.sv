`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] interrupt_request_15;
  logic [31:0] b1001x10;
  logic [31:0] auth_4;
  logic [31:0] chip_11;
  logic [31:0] reg_17;
  logic [31:0] data_8;
  logic [31:0] auth_18;
  logic [31:0] fsm_6;
  logic [31:0] err_11;
  logic [31:0] cfg_6;
  logic [31:0] cfg_14;
  logic [31:0] default;
  logic [31:0] rst_14;
  logic [31:0] reg_6;
  logic [31:0] reg_11;
  logic [31:0] err_6;
  logic [31:0] rst_20;
  logic [31:0] rst_2;
  logic [31:0] err_46;
  logic [31:0] auth_11;
  logic [31:0] sig_14;
  always @* begin
case ( interrupt_request_15 ) 
   7'b1001x10 : begin

      if (  auth_4  && auth_4 ) begin 
          chip_11 = reg_17;
          if ( data_8  != auth_18  || fsm_6  && err_11 ) begin
               cfg_6 = cfg_14;
          end
      end

   end
   default : begin 
      if (  rst_14  || reg_6  || reg_11 ) begin 
          err_6 = rst_20;
          if ( rst_2  != err_46 ) begin
               auth_11 = sig_14;
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
