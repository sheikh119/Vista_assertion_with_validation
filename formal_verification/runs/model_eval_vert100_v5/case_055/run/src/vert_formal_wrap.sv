`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_div_15;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] cfg_9;
  logic [31:0] rx_13;
  logic [31:0] chip_7;
  logic [31:0] reg_58;
  logic [31:0] auth_9;
  logic [31:0] hw_20;
  logic [31:0] auth_5;
  logic [31:0] sig_16;
  logic [31:0] rx_20;
  logic [31:0] hw_7;
  logic [31:0] fsm_18;
  logic [31:0] cfg_12;
  logic [31:0] rst_14;
  logic [31:0] core_75;
  logic [31:0] rst_8;
  logic [31:0] b1;
  always @(posedge clock_div_15) begin
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
    assume (!rst);
    assert (1'b1);
  end
endmodule
