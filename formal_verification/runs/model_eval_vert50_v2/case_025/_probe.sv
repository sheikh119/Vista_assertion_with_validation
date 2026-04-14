`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clock_ctrl_3;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] flag_control_19;
  logic [31:0] b1001001;
  logic [31:0] fsm_19;
  logic [31:0] clk_15;
  logic [31:0] core_4;
  logic [31:0] err_17;
  logic [31:0] reg_4;
  logic [31:0] sig_17;
  logic [31:0] core_11;
  logic [31:0] err_5;
  logic [31:0] hw_4;
  logic [31:0] rst_18;
  logic [31:0] err_13;
  logic [31:0] chip_7;
  logic [31:0] hw_7;
  logic [31:0] reg_12;
  logic [31:0] hw_17;
  logic [31:0] core_20;
  logic [31:0] hw_1;
  logic [31:0] rst_1;
  logic [31:0] auth_11;
  logic [31:0] default;
  logic [31:0] auth_12;
  logic [31:0] err_6;
  logic [31:0] clk_4;
  logic [31:0] clk_1;
  logic [31:0] chip_6;
  logic [31:0] fsm_10;
  logic [31:0] rx_11;
  logic [31:0] fsm_13;
  logic [31:0] reg_14;
  logic [31:0] hw_5;
  logic [31:0] clk_20;
  logic [31:0] rx_19;
  logic [31:0] clk_14;
  logic [31:0] rst_15;
  logic [31:0] clk_16;
  logic [31:0] hw_16;
  logic [31:0] reg_8;
  always @(posedge posedge clock_ctrl_3) begin
case ( flag_control_19 ) 
   7'b1001001 : begin
      if (  fsm_19  || clk_15  != core_4 ) begin 
          err_17 = reg_4;
          sig_17 = core_11;
          err_5 = hw_4;
          if ( rst_18  && err_13  != chip_7  && hw_7 ) begin
               reg_12 <= hw_17;
               core_20 = hw_1;
               rst_1 = auth_11;
          end
      end
   end
   default : begin 
      if (  auth_12  && err_6  || clk_4  || clk_1 ) begin 
          chip_6 <= fsm_10;
          rx_11 <= sig_17;
          fsm_13 = reg_14;
          if ( hw_5  != clk_20 ) begin
               rx_19 <= clk_14;
               rst_15 = clk_16;
               hw_16 <= reg_8;
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
