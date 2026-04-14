`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] auth_4;
  logic [31:0] b1;
  logic [31:0] cfg_116;
  logic [31:0] cfg_17;
  logic [31:0] chip_3;
  logic [31:0] clk_118;
  logic [31:0] core_13;
  logic [31:0] core_17;
  logic [31:0] data_140;
  logic [31:0] err_14;
  logic [31:0] err_16;
  logic [31:0] err_20;
  logic [31:0] fsm_112;
  logic [31:0] fsm_114;
  logic [31:0] fsm_2;
  logic [31:0] fsm_4;
  logic [31:0] hw_19;
  logic [31:0] hw_20;
  logic [31:0] reg_13;
  logic [31:0] reg_5;
  logic [31:0] rst_116;
  logic [31:0] rst_2;
  logic [31:0] rst_8;
  logic [31:0] rx_11;
  logic [31:0] rx_1414;
  logic [31:0] rx_7;
  logic [31:0] sig_13;
  logic [31:0] sig_15;
  logic [31:0] sig_4;
  logic [31:0] sig_8;
  logic [31:0] tx_1010;
  always @* begin
if (  core_13 ) begin 
    rst_116 = sig_4;
    if ( fsm_4  && data_140  || err_14  && rx_1414 ) begin
        reg_13 = sig_15;
    end
    else if (  rx_7  != cfg_17  || err_20  || sig_13 ) begin
        cfg_116 = fsm_112;
    end
    else begin
        fsm_114 = tx_1010;
    end
end
else begin 
    rx_11 = rst_8;
    if (  chip_3  != sig_8  || auth_4  != fsm_2 ) begin
        hw_20 = rst_2;
    end
    else if (  rst_2  != err_16 ) begin
        clk_118 = core_17;
    end
    else begin
        hw_19 = reg_5;
    end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
