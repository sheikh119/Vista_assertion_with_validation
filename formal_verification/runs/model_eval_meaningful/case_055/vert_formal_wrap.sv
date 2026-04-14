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
  logic [31:0] reg_58;
  logic [31:0] rst_14;
  logic [31:0] rst_8;
  logic [31:0] rx_13;
  logic [31:0] rx_20;
  logic [31:0] sig_16;
  always @(posedge posedge clock_div_15) begin
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

  always @* begin
    assert (((!(@(posedge clock_div_15) ( cfg_9 != rx_13 && chip_7 ))) || (reg_58 == auth_9)));
    assert (((!(@(posedge clock_div_15) ( cfg_9 != rx_13 && chip_7 ) && ( hw_20 != auth_5 && sig_16 ))) || (rx_20 == hw_7)));
  end
endmodule
