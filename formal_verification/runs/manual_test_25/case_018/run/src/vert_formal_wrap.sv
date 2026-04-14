`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] command_status_6;
  logic [31:0] b11x101;
  logic [31:0] auth_3;
  logic [31:0] cfg_3;
  logic [31:0] sig_3;
  logic [31:0] reg_3;
  logic [31:0] reg_20;
  logic [31:0] fsm_6;
  logic [31:0] rst_4;
  logic [31:0] sig_5;
  logic [31:0] auth_1;
  logic [31:0] rst_1;
  logic [31:0] rx_1;
  logic [31:0] rst_20;
  logic [31:0] rst_17;
  logic [31:0] core_11;
  logic [31:0] auth_11;
  logic [31:0] data_9;
  logic [31:0] chip_16;
  logic [31:0] chip_4;
  logic [31:0] reg_16;
  logic [31:0] fsm_9;
  logic [31:0] data_3;
  logic [31:0] rx_12;
  logic [31:0] rx_18;
  logic [31:0] auth_7;
  logic [31:0] reg_12;
  logic [31:0] b1;
  always @* begin
case ( command_status_6 )
   6'b11x101 : begin

      if (  auth_3  != cfg_3  || sig_3  != reg_3 ) begin
          reg_20 = fsm_6;
          rst_4 = rst_4;
          if ( sig_5 ) begin
               auth_1 = rst_1;
               rx_1 = rst_20;
          end
      end

   end
   default : begin
      if (  rst_17  && core_11 ) begin
          auth_11 = data_9;
          chip_16 = chip_4;
          if ( reg_16  && fsm_9  && data_3 ) begin
               rx_12 = rx_18;
               auth_7 = reg_12;
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
