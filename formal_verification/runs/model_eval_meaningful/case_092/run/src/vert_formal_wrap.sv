`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_1;
  logic [31:0] auth_10;
  logic [31:0] cfg_12;
  logic [31:0] chip_16;
  logic [31:0] chip_8;
  logic [31:0] clk_15;
  logic [31:0] clk_7;
  logic [31:0] core_9;
  logic [31:0] data_16;
  logic [31:0] err_15;
  logic [31:0] err_2;
  logic [31:0] err_5;
  logic [31:0] err_60;
  logic [31:0] fsm_12;
  logic [31:0] fsm_19;
  logic [31:0] hw_11;
  logic [31:0] hw_2;
  logic [31:0] hw_6;
  logic [31:0] rst_11;
  logic [31:0] rst_154;
  logic [31:0] rst_4;
  logic [31:0] rx_11;
  logic [31:0] rx_20;
  logic [31:0] rx_5;
  logic [31:0] sig_1;
  logic [31:0] sig_18;
  logic [31:0] sig_7;
  logic [31:0] tx_13;
  logic [31:0] tx_33;
  logic [31:0] tx_7;
  always @* begin
if (  chip_8  != sig_7  && err_2  != hw_6 ) begin 
    rst_154 = core_9;
    if ( rst_11 ) begin
        rst_4 = chip_16;
    end
    else if (  err_15  || hw_11  != cfg_12  && tx_7 ) begin
        data_16 = err_60;
    end
    else begin
        hw_2 = tx_13;
    end
end
else begin 
    tx_33 = rx_20;
    if (  fsm_19  != sig_1  || fsm_12 ) begin
        rx_5 = err_5;
    end
    else if (  clk_15  != tx_7  && clk_7 ) begin
        sig_18 = auth_1;
    end
    else begin
        auth_10 = rx_11;
    end
end
  end

  always @* begin
    assert (((!(( chip_8 != sig_7 && err_2 != hw_6 ))) || (rst_154 == core_9)));
    assert (((!(( chip_8 != sig_7 && err_2 != hw_6 ) && ( rst_11 ))) || (rst_4 == chip_16)));
    assert (((!(( chip_8 != sig_7 && err_2 != hw_6 ) && (!( rst_11 ) && ( err_15 || hw_11 != cfg_12 && tx_7 ) ))) || (data_16 == err_60)));
  end
endmodule
