`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_out_18;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] err_10;
  logic [31:0] core_20;
  logic [31:0] sig_2;
  logic [31:0] reg_20;
  logic [31:0] core_6;
  logic [31:0] cfg_15;
  logic [31:0] tx_7;
  logic [31:0] chip_11;
  logic [31:0] data_3;
  logic [31:0] err_2;
  logic [31:0] hw_8;
  logic [31:0] rx_11;
  logic [31:0] sig_11;
  logic [31:0] rst_6;
  logic [31:0] data_10;
  logic [31:0] core_18;
  logic [31:0] chip_19;
  logic [31:0] chip_3;
  logic [31:0] sig_8;
  logic [31:0] auth_4;
  logic [31:0] fsm_1;
  logic [31:0] data_1;
  logic [31:0] sig_1;
  logic [31:0] tx_2;
  logic [31:0] cfg_20;
  logic [31:0] rst_8;
  logic [31:0] chip_7;
  always @(posedge clk_out_18) begin
if (  err_10  && core_20 ) begin
    sig_2 = reg_20;
    core_6 <= cfg_15;
    tx_7 = chip_11;
    if ( data_3  && err_2  && hw_8 ) begin
        rx_11 = sig_11;
        rst_6 <= data_10;
        core_18 = chip_19;
    end
        if ( chip_3  != sig_8  || auth_4  != fsm_1 ) begin
            data_1 <= sig_1;
            tx_2 = cfg_20;
            rst_8 <= chip_7;
        end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( err_10 && core_20 ))) || (sig_2 == reg_20 && core_6 == cfg_15 && tx_7 == chip_11));
    assert ((!(( err_10 && core_20 ) && ( data_3 && err_2 && hw_8 ))) || (rx_11 == sig_11 && rst_6 == data_10 && core_18 == chip_19));
    assert ((!(( err_10 && core_20 ) && ( data_3 && err_2 && hw_8 ) && ( chip_3 != sig_8 || auth_4 != fsm_1 ))) || (data_1 == sig_1 && tx_2 == cfg_20 && rst_8 == chip_7));
  end
endmodule
