`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] address_6;
  logic [31:0] b0011x1;
  logic [31:0] fsm_20;
  logic [31:0] auth_7;
  logic [31:0] chip_12;
  logic [31:0] fsm_17;
  logic [31:0] sig_2;
  logic [31:0] chip_11;
  logic [31:0] fsm_14;
  logic [31:0] rx_1;
  logic [31:0] core_9;
  logic [31:0] rx_12;
  logic [31:0] fsm_6;
  logic [31:0] data_1;
  logic [31:0] reg_11;
  logic [31:0] err_11;
  logic [31:0] chip_19;
  logic [31:0] tx_17;
  logic [31:0] hw_2;
  logic [31:0] core_18;
  logic [31:0] auth_13;
  logic [31:0] clk_6;
  logic [31:0] b1;
  always @* begin
case ( address_6 )
   6'b0011x1 : begin

      if (  fsm_20  || auth_7  && chip_12  != fsm_17 ) begin
          sig_2 = chip_11;
          if ( fsm_14  || rx_1  != core_9 ) begin
               rx_12 = fsm_6;
          end
      end

   end
   default : begin
      if (  data_1  || reg_11 ) begin
          err_11 = chip_19;
          if ( tx_17  && hw_2  != core_18 ) begin
               auth_13 = clk_6;
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
