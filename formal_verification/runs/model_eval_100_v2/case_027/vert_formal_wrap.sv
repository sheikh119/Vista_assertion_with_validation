`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] cfg_19;
  logic [31:0] cfg_20;
  logic [31:0] core_8;
  logic [31:0] data_16;
  logic [31:0] data_3;
  logic [31:0] data_7;
  logic [31:0] err_10;
  logic [31:0] err_18;
  logic [31:0] fsm_19;
  logic [31:0] fsm_8;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] p_gen_3;
  logic [31:0] reg_6;
  logic [31:0] rst_20;
  logic [31:0] sig_7;
  logic [31:0] sig_8;
  logic [31:0] tx_6;
  always_comb begin
if (  cfg_19  != data_7  || rst_20 ) begin 
     fsm_19 = err_18;
    if ( cfg_20  != fsm_8 ) begin
        core_8 = tx_6;
    end
        if ( data_16  && sig_8  != err_10  || data_3 ) begin
            sig_7 = reg_6;
        end
end
  end
property p_gen_1; ( cfg_19 != data_7 || rst_20 ) |=> fsm_19 == err_18; endproperty
assert property (p_gen_1);
property p_gen_2; ( cfg_19 != data_7 || rst_20 ) && ( cfg_20 != fsm_8 ) |=> core_8 == tx_6; endproperty
assert property (p_gen_2);
property p_gen_3; ( cfg_19 != data_7 || rst_20 ) && ( cfg_20 != fsm_8 ) && ( data_16 && sig_8 != err_10 || data_3 ) |=> sig_7 == reg_6; endproperty
assert property (p_gen_3);
endmodule
