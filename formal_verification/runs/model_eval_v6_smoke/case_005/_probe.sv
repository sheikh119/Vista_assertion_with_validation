`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_osc_17;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] chip_16;
  logic [31:0] err_10;
  logic [31:0] fsm_11;
  logic [31:0] clk_15;
  logic [31:0] err_18;
  logic [31:0] chip_17;
  logic [31:0] cfg_20;
  logic [31:0] clk_6;
  logic [31:0] tx_5;
  logic [31:0] rx_1;
  logic [31:0] clk_10;
  logic [31:0] data_19;
  logic [31:0] clk_62;
  logic [31:0] err_7;
  logic [31:0] data_9;
  logic [31:0] cfg_7;
  logic [31:0] rst_12;
  logic [31:0] sig_6;
  logic [31:0] chip_12;
  logic [31:0] auth_15;
  logic [31:0] tx_2;
  logic [31:0] rst_15;
  logic [31:0] data_8;
  logic [31:0] reg_8;
  logic [31:0] rx_4;
  logic [31:0] rst_19;
  logic [31:0] core_5;
  logic [31:0] auth_19;
  always @(posedge clk_osc_17) begin
if (  chip_16  && err_10  || fsm_11 ) begin
    clk_15 <= err_18;
    chip_17 = cfg_20;
    clk_6 = tx_5;
    if ( rx_1  || clk_10  && data_19 ) begin
        clk_62 <= err_7;
        data_9 <= cfg_7;
        rst_12 <= sig_6;
    end
        if ( chip_12  && auth_15  || tx_2  || rst_15 ) begin
            data_8 = reg_8;
            rx_4 = rst_19;
            core_5 <= auth_19;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (!(( chip_16 && err_10 || fsm_11 ) && ( rx_1 || clk_10 && data_19 ) && ( chip_12 && auth_15 || tx_2 || rst_15 ))) || (data_8 == reg_8 && rx_4 == rst_19 && core_5 == auth_19);
  end
endmodule
