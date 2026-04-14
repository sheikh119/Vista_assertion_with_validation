`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin
    rst = 1'b0;
    rx_1 = '0;
    fsm_2 = '0;
    cfg_5 = '0;
    reg_15 = '0;
    fsm_4 = '0;
    cfg_19 = '0;
    clk_7 = '0;
    auth_12 = '0;
    cfg_10 = '0;
    cfg_15 = '0;
    cfg_4 = '0;
    cfg_13 = '0;
    fsm_15 = '0;
    clk_14 = '0;
  end
  logic [31:0] rx_1;
  logic [31:0] fsm_2;
  logic [31:0] cfg_5;
  logic [31:0] reg_15;
  logic [31:0] fsm_4;
  logic [31:0] cfg_19;
  logic [31:0] clk_7;
  logic [31:0] auth_12;
  logic [31:0] cfg_10;
  logic [31:0] cfg_15;
  logic [31:0] cfg_4;
  logic [31:0] cfg_13;
  logic [31:0] fsm_15;
  logic [31:0] clk_14;
  always @* begin
if (  rx_1  && fsm_2  != cfg_5  && reg_15 ) begin
     fsm_4 = cfg_19;
    if ( clk_7  != auth_12  || cfg_10 ) begin
        cfg_15 = cfg_4;
    end
        if ( clk_7  != auth_12  || cfg_13 ) begin
            fsm_15 = clk_14;
        end
end
    assume (!rst);
    assert ((!(( rx_1 && fsm_2 != cfg_5 && reg_15 ))) || (fsm_4 == cfg_19));
    assert ((!(( rx_1 && fsm_2 != cfg_5 && reg_15 ) && ( clk_7 != auth_12 || cfg_10 ))) || (cfg_15 == cfg_4));
    assert ((!(( rx_1 && fsm_2 != cfg_5 && reg_15 ) && ( clk_7 != auth_12 || cfg_10 ) && ( clk_7 != auth_12 || cfg_13 ))) || (fsm_15 == clk_14));
  end
endmodule
