`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clock_div_15;
  logic rst;
  logic [31:0] auth_5;
  logic [31:0] auth_9;
  logic [31:0] cfg_12;
  logic [31:0] cfg_9;
  logic [31:0] chip_7;
  logic [31:0] clock_div_15;
  logic [31:0] core_75;
  logic [31:0] fsm_18;
  logic [31:0] hw_20;
  logic [31:0] hw_7;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] reg_58;
  logic [31:0] rst_14;
  logic [31:0] rst_8;
  logic [31:0] rx_13;
  logic [31:0] rx_20;
  logic [31:0] sig_16;
  always_ff @(posedge posedge clock_div_15) begin
if (  cfg_9  != rx_13  && chip_7 ) begin 
    reg_58 = auth_9;
    if ( hw_20  != auth_5  && sig_16 ) begin
        rx_20 <= hw_7;
    end
        if ( fsm_18  != cfg_12  && rst_14 ) begin
            core_75 <= rst_8;
        end
end
  end
property p_gen_1; @(posedge clock_div_15) ( cfg_9 != rx_13 && chip_7 ) |-> reg_58 == auth_9 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(posedge clock_div_15) ( cfg_9 != rx_13 && chip_7 ) && ( hw_20 != auth_5 && sig_16 ) |-> rx_20 == hw_7 ; endproperty
assert property (p_gen_2);
endmodule
