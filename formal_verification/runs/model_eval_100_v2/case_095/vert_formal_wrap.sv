`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_13;
  logic [31:0] cfg_16;
  logic [31:0] cfg_19;
  logic [31:0] cfg_4;
  logic [31:0] chip_11;
  logic [31:0] chip_15;
  logic [31:0] chip_46;
  logic [31:0] clk_43;
  logic [31:0] core_11;
  logic [31:0] core_12;
  logic [31:0] core_4;
  logic [31:0] data_178;
  logic [31:0] err_10;
  logic [31:0] err_17;
  logic [31:0] err_18;
  logic [31:0] err_3;
  logic [31:0] err_7;
  logic [31:0] fsm_114;
  logic [31:0] fsm_20;
  logic [31:0] fsm_40;
  logic [31:0] hw_12;
  logic [31:0] hw_15;
  logic [31:0] hw_2;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_1;
  logic [31:0] reg_2;
  logic [31:0] rx_6;
  logic [31:0] sig_10;
  logic [31:0] sig_20;
  logic [31:0] tx_6;
  logic [31:0] tx_9;
  always_comb begin
if (  core_12  && hw_12  != cfg_16 ) begin 
    core_11 = hw_15;
    if ( fsm_40  != chip_46  || fsm_20 ) begin
        err_3 = chip_15;
    end
    else if (  hw_15  || reg_1  && tx_6  || tx_9 ) begin
        hw_2 = data_178;
    end
    else begin
        err_17 = clk_43;
    end
end
else begin 
    reg_2 = err_17;
    if (  err_7  || cfg_19  || sig_10 ) begin
        sig_20 = core_4;
    end
    else if (  err_10  || chip_15  && err_18  || cfg_4 ) begin
        chip_11 = auth_13;
    end
    else begin
        fsm_114 = rx_6;
    end
end
  end
property p_gen_1; ( core_12 && hw_12 != cfg_16 ) |=> core_11 == hw_15; endproperty
assert property (p_gen_1);
property p_gen_2; ( core_12 && hw_12 != cfg_16 ) && ( fsm_40 != chip_46 || fsm_20 ) |=> err_3 == chip_15; endproperty
assert property (p_gen_2);
property p_gen_3; ( core_12 && hw_12 != cfg_16 ) && (!( fsm_40 != chip_46 || fsm_20 ) && ( hw_15 || reg_1 && tx_6 || tx_9 ) ) |=> hw_2 == data_178; endproperty
assert property (p_gen_3);
endmodule
