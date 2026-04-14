`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_enable_11;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] tx_10;
  logic [31:0] rx_15;
  logic [31:0] core_14;
  logic [31:0] sig_5;
  logic [31:0] rx_130;
  logic [31:0] core_2;
  logic [31:0] hw_196;
  logic [31:0] auth_12;
  logic [31:0] tx_9;
  logic [31:0] data_5;
  logic [31:0] chip_14;
  logic [31:0] hw_11;
  logic [31:0] reg_17;
  logic [31:0] core_12;
  logic [31:0] rx_7;
  logic [31:0] chip_16;
  logic [31:0] rx_3;
  logic [31:0] fsm_100;
  logic [31:0] tx_1;
  logic [31:0] auth_114;
  logic [31:0] data_11;
  logic [31:0] b1;
  always @(posedge clk_enable_11) begin
if (  tx_10  && rx_15  != core_14  || sig_5 ) begin
    rx_130 <= core_2;
    hw_196 <= auth_12;
    if ( tx_9 ) begin
        data_5 <= chip_14;
        hw_11 = reg_17;
    end
        if ( core_12  || rx_7  != chip_16  && rx_3 ) begin
            fsm_100 = tx_1;
            auth_114 = data_11;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
