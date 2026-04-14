`timescale 1ns/1ps
module vert_formal_wrap;
  logic negedge clk_out_14;
  logic rst;
  logic [31:0] auth_13;
  logic [31:0] cfg_11;
  logic [31:0] cfg_13;
  logic [31:0] chip_10;
  logic [31:0] chip_4;
  logic [31:0] clk_27;
  logic [31:0] clk_out_14;
  logic [31:0] core_13;
  logic [31:0] fsm_11;
  logic [31:0] fsm_15;
  logic [31:0] fsm_2;
  logic [31:0] fsm_8;
  logic [31:0] hw_4;
  logic [31:0] hw_8;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_4;
  logic [31:0] rx_11;
  logic [31:0] sig_20;
  logic [31:0] tx_11;
  logic [31:0] tx_115;
  always_ff @(posedge negedge clk_out_14) begin
if (  hw_8 ) begin 
    reg_4 <= core_13;
    clk_27 = hw_4;
    if ( cfg_13 ) begin
        fsm_8 <= sig_20;
        tx_115 <= fsm_2;
    end
        if ( chip_4  || fsm_11  || tx_11  || cfg_11 ) begin
            fsm_15 = rx_11;
            chip_10 = auth_13;
        end
end
  end
property p_gen_1; @(negedge clk_out_14) ( hw_8 ) |-> reg_4 == core_13 && clk_27 == hw_4 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(negedge clk_out_14) ( hw_8 ) && ( cfg_13 ) |-> fsm_8 == sig_20 && tx_115 == fsm_2 ; endproperty
assert property (p_gen_2);
property p_gen_3; @(negedge clk_out_14) ( hw_8 ) && ( cfg_13 ) && ( chip_4 || fsm_11 || tx_11 || cfg_11 ) |-> fsm_15 == rx_11 && chip_10 == auth_13 ; endproperty
assert property (p_gen_3);
endmodule
