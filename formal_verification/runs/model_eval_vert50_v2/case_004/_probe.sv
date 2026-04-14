`timescale 1ns/1ps
module vert_formal_wrap;
  logic negedge fast_clk_20;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] chip_16;
  logic [31:0] err_10;
  logic [31:0] fsm_11;
  logic [31:0] sig_13;
  logic [31:0] chip_10;
  logic [31:0] clk_4;
  logic [31:0] sig_12;
  logic [31:0] sig_3;
  logic [31:0] sig_14;
  logic [31:0] err_20;
  logic [31:0] err_1;
  logic [31:0] cfg_116;
  logic [31:0] auth_17;
  logic [31:0] rst_52;
  logic [31:0] fsm_160;
  logic [31:0] sig_17;
  logic [31:0] tx_14;
  logic [31:0] auth_15;
  logic [31:0] fsm_18;
  logic [31:0] core_12;
  logic [31:0] chip_18;
  logic [31:0] tx_2;
  logic [31:0] rx_18;
  logic [31:0] rst_6;
  always @(posedge negedge fast_clk_20) begin
if (  chip_16  && err_10  || fsm_11 ) begin 
    sig_13 = chip_10;
    clk_4 = sig_12;
    sig_3 <= sig_14;
    if ( err_20  && err_1 ) begin
        cfg_116 = auth_17;
        rst_52 = fsm_160;
        sig_17 = tx_14;
    end
        if ( auth_15 ) begin
            fsm_18 <= core_12;
            chip_18 <= tx_2;
            rx_18 = rst_6;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
