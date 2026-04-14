`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] data_7;
  logic [31:0] fsm_7;
  logic [31:0] fsm_9;
  logic [31:0] reg_4;
  logic [31:0] core_112;
  logic [31:0] rst_19;
  logic [31:0] reg_7;
  logic [31:0] reg_5;
  logic [31:0] core_17;
  logic [31:0] hw_5;
  logic [31:0] tx_18;
  logic [31:0] sig_3;
  logic [31:0] err_16;
  logic [31:0] tx_8;
  logic [31:0] data_178;
  logic [31:0] data_3;
  logic [31:0] cfg_2;
  logic [31:0] rst_133;
  logic [31:0] sig_20;
  logic [31:0] auth_16;
  logic [31:0] auth_120;
  logic [31:0] core_15;
  logic [31:0] chip_96;
  logic [31:0] data_16;
  logic [31:0] sig_14;
  logic [31:0] sig_2;
  always @* begin
if (  data_7  && fsm_7 ) begin
     fsm_9 = reg_4;
     core_112 = rst_19;
     reg_7 = reg_5;
    if ( core_17  && hw_5  && tx_18  != sig_3 ) begin
        err_16 = tx_8;
        data_178 = data_3;
        cfg_2 = rst_133;
    end
        if ( sig_20  != auth_16 ) begin
            auth_120 = core_15;
            chip_96 = data_16;
            sig_14 = sig_2;
        end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( data_7 && fsm_7 ))) || (fsm_9 == reg_4 && core_112 == rst_19 && reg_7 == reg_5));
    assert ((!(( data_7 && fsm_7 ) && ( core_17 && hw_5 && tx_18 != sig_3 ))) || (err_16 == tx_8 && data_178 == data_3 && cfg_2 == rst_133));
    assert ((!(( data_7 && fsm_7 ) && ( core_17 && hw_5 && tx_18 != sig_3 ) && ( sig_20 != auth_16 ))) || (auth_120 == core_15 && chip_96 == data_16 && sig_14 == sig_2));
  end
endmodule
