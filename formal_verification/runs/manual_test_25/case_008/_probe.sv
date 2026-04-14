`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] chip_12;
  logic [31:0] fsm_11;
  logic [31:0] tx_2;
  logic [31:0] core_8;
  logic [31:0] err_18;
  logic [31:0] auth_16;
  logic [31:0] cfg_13;
  logic [31:0] clk_18;
  logic [31:0] chip_5;
  logic [31:0] data_18;
  logic [31:0] cfg_183;
  logic [31:0] core_1;
  logic [31:0] tx_15;
  logic [31:0] core_14;
  logic [31:0] rx_12;
  logic [31:0] cfg_10;
  logic [31:0] chip_14;
  logic [31:0] hw_9;
  logic [31:0] rx_3;
  logic [31:0] hw_6;
  logic [31:0] tx_46;
  logic [31:0] sig_13;
  logic [31:0] err_5;
  logic [31:0] chip_6;
  logic [31:0] rx_8;
  logic [31:0] reg_17;
  logic [31:0] chip_15;
  logic [31:0] data_11;
  logic [31:0] clk_16;
  logic [31:0] fsm_14;
  logic [31:0] clk_11;
  logic [31:0] tx_19;
  logic [31:0] b1;
  always @* begin
if (  chip_12  != fsm_11  && tx_2  != core_8 ) begin
    err_18 = auth_16;
    if ( cfg_13  != clk_18  && chip_5  && data_18 ) begin
        cfg_183 = core_1;
    end
    else if (  tx_15  != core_14  && rx_12  != cfg_10 ) begin
        chip_14 = hw_9;
    end
    else begin
        rx_3 = hw_6;
    end
end
else begin
    tx_46 = sig_13;
    if (  err_5  != chip_6  || rx_8 ) begin
        core_14 = reg_17;
    end
    else if (  chip_15  != data_11 ) begin
        clk_16 = fsm_14;
    end
    else begin
        clk_11 = tx_19;
    end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
