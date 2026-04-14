`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    rst_18 = '0;
    clk_122 = '0;
    tx_3 = '0;
    auth_208 = '0;
    data_10 = '0;
    auth_2 = '0;
    clk_119 = '0;
    sig_12 = '0;
    hw_15 = '0;
    rx_114 = '0;
    core_19 = '0;
  end
  logic [31:0] rst_18;
  logic [31:0] clk_122;
  logic [31:0] tx_3;
  logic [31:0] auth_208;
  logic [31:0] data_10;
  logic [31:0] auth_2;
  logic [31:0] clk_119;
  logic [31:0] sig_12;
  logic [31:0] hw_15;
  logic [31:0] rx_114;
  logic [31:0] core_19;
  always @* begin
if (  rst_18 ) begin
     clk_122 = tx_3;
    if ( auth_208 ) begin
        data_10 = auth_2;
    end
        if ( clk_119  && sig_12  != hw_15 ) begin
            rx_114 = core_19;
        end
end
    assume (!rst);
    assert ((!(( rst_18 ))) || (clk_122 == tx_3));
    assert ((!(( rst_18 ) && ( auth_208 ))) || (data_10 == auth_2));
    assert ((!(( rst_18 ) && ( auth_208 ) && ( clk_119 && sig_12 != hw_15 ))) || (rx_114 == core_19));
  end
endmodule
