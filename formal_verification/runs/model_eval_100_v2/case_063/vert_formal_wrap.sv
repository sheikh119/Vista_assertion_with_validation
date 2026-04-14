`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clk_osc_3;
  logic rst;
  logic [31:0] auth_4;
  logic [31:0] cfg_8;
  logic [31:0] chip_18;
  logic [31:0] chip_3;
  logic [31:0] clk_20;
  logic [31:0] clk_osc_3;
  logic [31:0] data_19;
  logic [31:0] err_20;
  logic [31:0] err_7;
  logic [31:0] fsm_2;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] reg_118;
  logic [31:0] rx_14;
  logic [31:0] sig_2020;
  logic [31:0] sig_8;
  logic [31:0] tx_12;
  always_ff @(posedge posedge clk_osc_3) begin
if (  sig_8  || err_7  && chip_18  != rx_14 ) begin 
    reg_118 <= cfg_8;
    if ( sig_2020 ) begin
        tx_12 <= err_20;
    end
        if ( chip_3  != sig_8  || auth_4  != fsm_2 ) begin
            clk_20 = data_19;
        end
end
  end
property p_gen_1; @(posedge clk_osc_3) ( sig_8 || err_7 && chip_18 != rx_14 ) |-> reg_118 == cfg_8 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(posedge clk_osc_3) ( sig_8 || err_7 && chip_18 != rx_14 ) && ( sig_2020 ) |-> tx_12 == err_20 ; endproperty
assert property (p_gen_2);
endmodule
