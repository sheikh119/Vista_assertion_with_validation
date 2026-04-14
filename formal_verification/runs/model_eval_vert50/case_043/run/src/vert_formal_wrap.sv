`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_120;
  logic [31:0] auth_18;
  logic [31:0] b1;
  logic [31:0] cfg_11;
  logic [31:0] cfg_4;
  logic [31:0] chip_3;
  logic [31:0] chip_6;
  logic [31:0] clk_16;
  logic [31:0] core_16;
  logic [31:0] core_17;
  logic [31:0] core_18;
  logic [31:0] data_155;
  logic [31:0] data_16;
  logic [31:0] data_19;
  logic [31:0] data_9;
  logic [31:0] err_19;
  logic [31:0] err_2;
  logic [31:0] fsm_9;
  logic [31:0] rst_15;
  logic [31:0] rst_2;
  logic [31:0] rst_7;
  logic [31:0] rst_9;
  logic [31:0] rx_7;
  logic [31:0] sig_11;
  logic [31:0] sig_19;
  logic [31:0] sig_32;
  logic [31:0] sig_7;
  logic [31:0] tx_3;
  logic [31:0] tx_4;
  always @* begin
if (  clk_16 ) begin 
    core_17 = data_16;
    if ( chip_3  != chip_6  || cfg_11  && auth_18 ) begin
        core_16 = rx_7;
    end
    else if (  core_18 ) begin
        data_9 = data_155;
    end
    else begin
        tx_4 = auth_120;
    end
end
else begin 
    err_2 = rst_15;
    if (  sig_19  && err_19  && tx_3 ) begin
        sig_7 = sig_32;
    end
    else if (  sig_11  && rst_2  || rst_9  && cfg_4 ) begin
        data_19 = rst_7;
    end
    else begin
        sig_32 = fsm_9;
    end
end
  end

  always @* begin
    assert (1'b1);
  end
endmodule
