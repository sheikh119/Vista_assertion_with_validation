`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_osc_3;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] input_status_register_4;
  logic [31:0] h39;
  logic [31:0] cfg_7;
  logic [31:0] sig_19;
  logic [31:0] rst_1;
  logic [31:0] hw_10;
  logic [31:0] core_3;
  logic [31:0] cfg_4;
  logic [31:0] reg_2;
  logic [31:0] reg_18;
  logic [31:0] chip_9;
  logic [31:0] sig_5;
  logic [31:0] rst_2;
  logic [31:0] sig_12;
  logic [31:0] tx_1;
  logic [31:0] clk_1;
  logic [31:0] cfg_11;
  logic [31:0] tx_12;
  logic [31:0] clk_8;
  logic [31:0] rx_16;
  logic [31:0] rx_12;
  logic [31:0] data_5;
  logic [31:0] fsm_12;
  logic [31:0] auth_4;
  logic [31:0] err_16;
  logic [31:0] tx_3;
  logic [31:0] fsm_15;
  logic [31:0] data_9;
  logic [31:0] rx_8;
  logic [31:0] tx_4;
  logic [31:0] core_1;
  logic [31:0] cfg_10;
  logic [31:0] clk_14;
  logic [31:0] core_10;
  logic [31:0] hw_16;
  logic [31:0] rx_20;
  logic [31:0] err_1;
  logic [31:0] b1;
  always @(posedge clk_osc_3) begin
case ( input_status_register_4 )
   7'h39 : begin
      if ( !cfg_7 ) begin
          sig_19 <= rst_1;
          hw_10 <= core_3;
          cfg_4 = reg_2;
          if ( reg_18  != chip_9  || sig_5  && rst_2 ) begin
               sig_12 = tx_1;
               clk_1 = cfg_11;
               tx_12 <= clk_8;
          end
      end
   end
   default : begin
      if (  rx_16  != rx_12  || data_5  || fsm_12 ) begin
          auth_4 <= hw_10;
          err_16 = tx_3;
          fsm_15 <= data_9;
          if ( rx_8  || tx_4  && core_1  || cfg_10 ) begin
               clk_14 = core_10;
               hw_16 <= rx_20;
               err_1 <= clk_1;
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
