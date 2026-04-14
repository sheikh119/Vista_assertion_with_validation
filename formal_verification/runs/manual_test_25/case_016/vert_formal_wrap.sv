`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] status_register_buffer_11;
  logic [31:0] bx100100;
  logic [31:0] fsm_12;
  logic [31:0] auth_17;
  logic [31:0] cfg_13;
  logic [31:0] tx_17;
  logic [31:0] tx_15;
  logic [31:0] auth_15;
  logic [31:0] hw_16;
  logic [31:0] hw_17;
  logic [31:0] fsm_16;
  logic [31:0] hw_9;
  logic [31:0] data_5;
  logic [31:0] hw_3;
  logic [31:0] hw_13;
  logic [31:0] auth_1;
  logic [31:0] rst_16;
  logic [31:0] chip_15;
  logic [31:0] chip_9;
  logic [31:0] chip_6;
  logic [31:0] sig_10;
  logic [31:0] rx_1;
  logic [31:0] clk_2;
  logic [31:0] cfg_20;
  logic [31:0] chip_1;
  logic [31:0] cfg_2;
  logic [31:0] rx_12;
  logic [31:0] rst_15;
  logic [31:0] auth_12;
  logic [31:0] reg_16;
  logic [31:0] rx_15;
  logic [31:0] data_3;
  logic [31:0] tx_12;
  logic [31:0] b1;
  always @* begin
case ( status_register_buffer_11 )
   7'bx100100 : begin

      if (  fsm_12  || auth_17 ) begin
          cfg_13 = tx_17;
          tx_15 = auth_15;
          hw_16 = hw_17;
          if ( fsm_16  && hw_9 ) begin
               data_5 = hw_3;
               hw_13 = auth_1;
               rst_16 = chip_15;
          end
      end

   end
   default : begin
      if (  chip_9  || chip_6  != sig_10  && rx_1 ) begin
          clk_2 = cfg_20;
          chip_1 = cfg_2;
          rx_12 = rst_15;
          if ( chip_6 ) begin
               auth_12 = reg_16;
               rx_15 = data_3;
               tx_12 = fsm_16;
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
