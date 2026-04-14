`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] err_11;
  logic [31:0] core_12;
  logic [31:0] rx_17;
  logic [31:0] data_20;
  logic [31:0] core_118;
  logic [31:0] core_19;
  logic [31:0] err_8;
  logic [31:0] fsm_14;
  logic [31:0] core_18;
  logic [31:0] tx_4;
  logic [31:0] err_20;
  logic [31:0] auth_9;
  logic [31:0] auth_5;
  logic [31:0] tx_13;
  logic [31:0] rx_16;
  logic [31:0] sig_12;
  logic [31:0] sig_3;
  logic [31:0] data_2;
  logic [31:0] rx_20;
  logic [31:0] rx_4;
  logic [31:0] clk_120;
  logic [31:0] reg_8;
  logic [31:0] auth_13;
  logic [31:0] clk_6;
  logic [31:0] data_15;
  logic [31:0] fsm_8;
  logic [31:0] fsm_4;
  logic [31:0] tx_10;
  always @* begin
if (  err_11  && core_12  || rx_17  != data_20 ) begin 
    core_118 = core_19;
    if ( err_8  && fsm_14  && core_18 ) begin
        core_19 = tx_4;
    end
    else if (  err_20  && err_20 ) begin
        auth_9 = auth_5;
    end
    else begin
        core_118 = tx_13;
    end
end
else begin 
    rx_16 = sig_12;
    if (  sig_3  != data_2  && rx_20  && rx_4 ) begin
        clk_120 = reg_8;
    end
    else if (  auth_13  || clk_6  && data_15  && sig_12 ) begin
        auth_5 = fsm_8;
    end
    else begin
        fsm_4 = tx_10;
    end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
