`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] data_status_register_8;
  logic [31:0] h19;
  logic [31:0] data_12;
  logic [31:0] auth_8;
  logic [31:0] hw_12;
  logic [31:0] chip_10;
  logic [31:0] reg_1;
  logic [31:0] hw_4;
  logic [31:0] tx_6;
  logic [31:0] data_1;
  logic [31:0] reg_20;
  logic [31:0] rst_12;
  logic [31:0] chip_12;
  logic [31:0] cfg_15;
  logic [31:0] fsm_13;
  logic [31:0] rst_16;
  logic [31:0] err_11;
  logic [31:0] chip_3;
  logic [31:0] rx_10;
  logic [31:0] chip_5;
  logic [31:0] rst_20;
  logic [31:0] auth_4;
  logic [31:0] data_2;
  logic [31:0] err_18;
  logic [31:0] auth_20;
  logic [31:0] hw_19;
  logic [31:0] tx_10;
  logic [31:0] chip_14;
  logic [31:0] chip_13;
  logic [31:0] hw_9;
  logic [31:0] chip_1;
  logic [31:0] sig_15;
  logic [31:0] sig_2;
  logic [31:0] data_19;
  logic [31:0] hw_18;
  logic [31:0] fsm_4;
  logic [31:0] tx_9;
  logic [31:0] core_8;
  logic [31:0] rx_12;
  logic [31:0] b1;
  always @* begin
case ( data_status_register_8 )
   7'h19 : begin

      if (  data_12  || auth_8  != hw_12  || chip_10 ) begin
          reg_1 = hw_4;
          tx_6 = data_1;
          data_1 = reg_20;
          if ( data_1  || rst_12  != chip_12  || cfg_15 ) begin
               fsm_13 = rst_16;
               err_11 = chip_3;
               rx_10 = chip_5;
          end
      end

   end
   default : begin
      if (  rst_20  != auth_4  && data_2  || err_18 ) begin
          auth_20 = hw_19;
          tx_10 = chip_14;
          chip_13 = hw_9;
          if ( chip_1  || sig_15  != sig_2  && data_19 ) begin
               hw_18 = fsm_4;
               cfg_15 = tx_9;
               core_8 = rx_12;
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
