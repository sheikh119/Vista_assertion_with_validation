`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_120;
  logic [31:0] b1;
  logic [31:0] cfg_14;
  logic [31:0] clk_62;
  logic [31:0] core_1;
  logic [31:0] core_2;
  logic [31:0] core_8;
  logic [31:0] data_11;
  logic [31:0] data_12;
  logic [31:0] data_18;
  logic [31:0] data_20;
  logic [31:0] fsm_11;
  logic [31:0] fsm_3;
  logic [31:0] hw_19;
  logic [31:0] rst_12;
  logic [31:0] rst_14;
  logic [31:0] rst_17;
  logic [31:0] rst_2;
  logic [31:0] sig_14;
  logic [31:0] tx_12;
  logic [31:0] tx_14;
  always @* begin
if (  core_2  && fsm_3 ) begin 
     data_11 = data_12;
     auth_120 = rst_14;
    if ( core_1  != tx_12  && cfg_14 ) begin
        data_20 = tx_14;
        core_8 = fsm_11;
    end
        if ( sig_14  || rst_17  || data_18  && tx_12 ) begin
            rst_2 = rst_12;
            clk_62 = hw_19;
        end
end
  end

  always @* begin
    assert (1'b1);
  end
endmodule
