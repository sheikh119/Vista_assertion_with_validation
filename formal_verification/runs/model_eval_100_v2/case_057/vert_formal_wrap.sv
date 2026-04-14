`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_12;
  logic [31:0] cfg_10;
  logic [31:0] cfg_13;
  logic [31:0] cfg_15;
  logic [31:0] cfg_19;
  logic [31:0] cfg_4;
  logic [31:0] cfg_5;
  logic [31:0] clk_14;
  logic [31:0] clk_7;
  logic [31:0] fsm_15;
  logic [31:0] fsm_2;
  logic [31:0] fsm_4;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_15;
  logic [31:0] rx_1;
  always_comb begin
if (  rx_1  && fsm_2  != cfg_5  && reg_15 ) begin 
     fsm_4 = cfg_19;
    if ( clk_7  != auth_12  || cfg_10 ) begin
        cfg_15 = cfg_4;
    end
        if ( clk_7  != auth_12  || cfg_13 ) begin
            fsm_15 = clk_14;
        end
end
  end
property p_gen_1; ( rx_1 && fsm_2 != cfg_5 && reg_15 ) |=> fsm_4 == cfg_19; endproperty
assert property (p_gen_1);
property p_gen_2; ( rx_1 && fsm_2 != cfg_5 && reg_15 ) && ( clk_7 != auth_12 || cfg_10 ) |=> cfg_15 == cfg_4; endproperty
assert property (p_gen_2);
property p_gen_3; ( rx_1 && fsm_2 != cfg_5 && reg_15 ) && ( clk_7 != auth_12 || cfg_10 ) && ( clk_7 != auth_12 || cfg_13 ) |=> fsm_15 == clk_14; endproperty
assert property (p_gen_3);
endmodule
