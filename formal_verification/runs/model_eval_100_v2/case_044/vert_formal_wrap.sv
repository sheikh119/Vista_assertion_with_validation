`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clk_osc_4;
  logic rst;
  logic [31:0] auth_1;
  logic [31:0] auth_114;
  logic [31:0] auth_19;
  logic [31:0] cfg_19;
  logic [31:0] cfg_20;
  logic [31:0] chip_1;
  logic [31:0] chip_15;
  logic [31:0] clk_10;
  logic [31:0] clk_12;
  logic [31:0] clk_osc_4;
  logic [31:0] data_16;
  logic [31:0] data_3;
  logic [31:0] err_10;
  logic [31:0] err_19;
  logic [31:0] err_3;
  logic [31:0] fsm_11;
  logic [31:0] fsm_33;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] reg_1;
  logic [31:0] reg_13;
  logic [31:0] reg_15;
  logic [31:0] rst_10;
  logic [31:0] rst_14;
  logic [31:0] rx_37;
  logic [31:0] sig_20;
  logic [31:0] tx_12;
  logic [31:0] tx_7;
  always_ff @(posedge posedge clk_osc_4) begin
if (  reg_1  != tx_7 ) begin 
    auth_114 = chip_15;
    fsm_11 <= rst_10;
    data_16 = sig_20;
    if ( rst_14  != chip_1 ) begin
        reg_15 <= cfg_20;
        auth_1 <= tx_12;
        clk_10 <= err_10;
    end
        if ( data_3  || fsm_33  != err_3  || rx_37 ) begin
            reg_13 = cfg_19;
            err_19 <= data_3;
            auth_19 = clk_12;
        end
end
  end
property p_gen_1; @(posedge clk_osc_4) ( reg_1 != tx_7 ) |-> auth_114 == chip_15 && fsm_11 == rst_10 && data_16 == sig_20 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(posedge clk_osc_4) ( reg_1 != tx_7 ) && ( rst_14 != chip_1 ) |-> reg_15 == cfg_20 && auth_1 == tx_12 && clk_10 == err_10 ; endproperty
assert property (p_gen_2);
endmodule
