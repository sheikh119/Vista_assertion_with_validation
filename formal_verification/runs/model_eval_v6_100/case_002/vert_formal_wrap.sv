`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] chip_7;
  logic [31:0] data_11;
  logic [31:0] data_20;
  logic [31:0] data_6;
  logic [31:0] chip_5;
  logic [31:0] data_17;
  logic [31:0] rst_11;
  logic [31:0] cfg_105;
  logic [31:0] chip_1;
  logic [31:0] tx_10;
  logic [31:0] rx_3;
  logic [31:0] hw_16;
  logic [31:0] data_178;
  logic [31:0] data_155;
  logic [31:0] sig_1;
  logic [31:0] err_14;
  logic [31:0] auth_120;
  logic [31:0] core_37;
  logic [31:0] err_15;
  logic [31:0] hw_17;
  logic [31:0] cfg_12;
  logic [31:0] tx_7;
  logic [31:0] auth_14;
  logic [31:0] core_19;
  logic [31:0] fsm_18;
  logic [31:0] reg_1;
  logic [31:0] rst_16;
  logic [31:0] fsm_10;
  logic [31:0] sig_28;
  always @* begin
if (  chip_7  != data_11 ) begin
    data_20 = data_6;
    if ( chip_5  && data_17  || rst_11 ) begin
        cfg_105 = chip_1;
    end
    else if (  tx_10  != rx_3  || hw_16 ) begin
        data_178 = data_155;
    end
    else begin
        sig_1 = err_14;
    end
end
else begin
    auth_120 = core_37;
    if (  err_15  || hw_17  != cfg_12  && tx_7 ) begin
        auth_14 = core_19;
    end
    else if (  fsm_18 ) begin
        reg_1 = rst_16;
    end
    else begin
        fsm_10 = sig_28;
    end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( chip_7 != data_11 ))) || (data_20 == data_6));
    assert ((!(( chip_7 != data_11 ) && ( chip_5 && data_17 || rst_11 ))) || (cfg_105 == chip_1));
    assert ((!(( chip_7 != data_11 ) && (!( chip_5 && data_17 || rst_11 ) && ( tx_10 != rx_3 || hw_16 ) ))) || (data_178 == data_155));
    assert ((!(( chip_7 != data_11 ) && ( !( chip_5 && data_17 || rst_11 ) &&!( tx_10 != rx_3 || hw_16 ) ))) || (sig_1 == err_14));
    assert ((!(! ( chip_7 != data_11 ))) || (auth_120 == core_37));
    assert ((!(! ( chip_7 != data_11 ) && ( err_15 || hw_17 != cfg_12 && tx_7 ))) || (auth_14 == core_19));
    assert ((!(! ( chip_7 != data_11 ) && (!( err_15 || hw_17 != cfg_12 && tx_7 ) && ( fsm_18 ) ))) || (reg_1 == rst_16));
    assert ((!(! ( chip_7 != data_11 ) && (!( err_15 || hw_17 != cfg_12 && tx_7 ) &&!( fsm_18 ) ))) || (fsm_10 == sig_28));
  end
endmodule
