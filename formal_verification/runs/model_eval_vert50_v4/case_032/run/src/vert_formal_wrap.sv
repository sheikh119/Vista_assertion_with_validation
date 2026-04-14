`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] reg_134;
  logic [31:0] rx_2;
  logic [31:0] sig_13;
  logic [31:0] auth_204;
  logic [31:0] fsm_16;
  logic [31:0] hw_4;
  logic [31:0] err_114;
  logic [31:0] sig_20;
  logic [31:0] core_11;
  logic [31:0] auth_18;
  logic [31:0] auth_17;
  logic [31:0] reg_9;
  logic [31:0] sig_5;
  logic [31:0] rst_9;
  logic [31:0] auth_2;
  logic [31:0] sig_2;
  logic [31:0] fsm_14;
  logic [31:0] rst_12;
  logic [31:0] chip_4;
  logic [31:0] clk_10;
  logic [31:0] reg_1;
  logic [31:0] auth_7;
  logic [31:0] chip_20;
  logic [31:0] data_11;
  logic [31:0] clk_13;
  logic [31:0] chip_5;
  logic [31:0] data_120;
  logic [31:0] b1;
  always @* begin
if (  reg_134  != rx_2 ) begin 
    sig_13 = auth_204;
    if ( fsm_16  && hw_4  != err_114 ) begin
        sig_20 = core_11;
    end
    else if (  auth_18  && auth_17 ) begin
        core_11 = reg_9;
    end
    else begin
        sig_5 = rst_9;
    end
end
else begin 
    auth_2 = sig_2;
    if (  fsm_14  || rst_12 ) begin
        chip_4 = clk_10;
    end
    else if (  reg_1  || auth_7  != clk_10  && chip_20 ) begin
        data_11 = clk_13;
    end
    else begin
        chip_5 = data_120;
    end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
