`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] output_data_12;
  logic [31:0] b01xxx0;
  logic [31:0] sig_8;
  logic [31:0] rx_9;
  logic [31:0] core_16;
  logic [31:0] data_2;
  logic [31:0] chip_8;
  logic [31:0] rx_4;
  logic [31:0] rst_19;
  logic [31:0] auth_7;
  logic [31:0] reg_4;
  logic [31:0] hw_7;
  logic [31:0] core_3;
  logic [31:0] rx_18;
  logic [31:0] rst_4;
  logic [31:0] fsm_3;
  logic [31:0] clk_9;
  logic [31:0] core_11;
  logic [31:0] rst_14;
  logic [31:0] sig_13;
  logic [31:0] data_16;
  logic [31:0] core_5;
  logic [31:0] sig_18;
  logic [31:0] err_1;
  logic [31:0] auth_3;
  logic [31:0] tx_16;
  logic [31:0] rst_9;
  logic [31:0] rst_12;
  logic [31:0] tx_12;
  logic [31:0] chip_2;
  logic [31:0] hw_5;
  logic [31:0] core_12;
  logic [31:0] auth_5;
  logic [31:0] cfg_9;
  logic [31:0] clk_13;
  logic [31:0] chip_4;
  logic [31:0] b1;
  always @* begin
case ( output_data_12 )
   6'b01xxx0 : begin

      if (  sig_8  && rx_9 ) begin
          core_16 = data_2;
          chip_8 = rx_4;
          rst_19 = auth_7;
          if ( reg_4  && hw_7  != core_3 ) begin
               rx_18 = rst_4;
               fsm_3 = clk_9;
               core_11 = core_3;
          end
      end

   end
   default : begin
      if (  rst_14  != sig_13  && data_16 ) begin
          core_5 = sig_18;
          err_1 = auth_3;
          tx_16 = rst_9;
          if ( rst_12  || tx_12  && chip_2 ) begin
               hw_5 = core_12;
               auth_5 = cfg_9;
               clk_13 = chip_4;
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
