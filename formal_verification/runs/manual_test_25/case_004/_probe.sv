`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] cfg_6;
  logic [31:0] cfg_12;
  logic [31:0] core_5;
  logic [31:0] chip_20;
  logic [31:0] rst_7;
  logic [31:0] clk_20;
  logic [31:0] cfg_183;
  logic [31:0] auth_14;
  logic [31:0] hw_1;
  logic [31:0] tx_17;
  logic [31:0] rx_90;
  logic [31:0] err_6;
  logic [31:0] err_19;
  logic [31:0] chip_16;
  logic [31:0] fsm_11;
  logic [31:0] rx_9;
  logic [31:0] sig_16;
  logic [31:0] fsm_3;
  logic [31:0] sig_28;
  logic [31:0] hw_10;
  logic [31:0] reg_13;
  logic [31:0] auth_6;
  logic [31:0] cfg_1;
  logic [31:0] reg_8;
  logic [31:0] tx_7;
  logic [31:0] auth_16;
  logic [31:0] cfg_9;
  logic [31:0] b1;
  always @* begin
if (  cfg_6  && cfg_12  != core_5 ) begin
    chip_20 = rst_7;
    if ( clk_20  || rst_7 ) begin
        cfg_183 = auth_14;
    end
    else if (  hw_1  || tx_17  && rx_90 ) begin
        err_6 = err_19;
    end
    else begin
        chip_16 = fsm_11;
    end
end
else begin
    rx_9 = sig_16;
    if (  fsm_3 ) begin
        sig_28 = hw_10;
    end
    else if (  reg_13  || auth_6  && cfg_1  && reg_8 ) begin
        tx_7 = auth_16;
    end
    else begin
        cfg_9 = reg_13;
    end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
