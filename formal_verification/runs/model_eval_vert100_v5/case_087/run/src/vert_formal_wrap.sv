`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_source_19;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] data_7;
  logic [31:0] rx_5;
  logic [31:0] sig_149;
  logic [31:0] hw_17;
  logic [31:0] err_8;
  logic [31:0] tx_4;
  logic [31:0] cfg_20;
  logic [31:0] tx_115;
  logic [31:0] data_14;
  logic [31:0] auth_7;
  logic [31:0] rx_8;
  logic [31:0] tx_14;
  logic [31:0] fsm_116;
  logic [31:0] tx_12;
  logic [31:0] data_4;
  logic [31:0] cfg_183;
  logic [31:0] rst_17;
  logic [31:0] tx_17;
  logic [31:0] chip_2;
  logic [31:0] rst_3;
  logic [31:0] tx_33;
  logic [31:0] fsm_8;
  logic [31:0] rx_15;
  logic [31:0] cfg_14;
  logic [31:0] rx_6;
  logic [31:0] b1;
  always @(posedge clock_source_19) begin
if (  data_7  && rx_5 ) begin
   sig_149 = hw_17;
    if ( err_8  && tx_4  || cfg_20 ) begin
      tx_115 = data_14;
   end
   else if (  auth_7 ) begin
      rx_8 = tx_14;
   end
   else begin
      fsm_116 = tx_12;
   end
end
else begin
   data_4 = cfg_183;
   if (  rst_17  || tx_17  && chip_2 ) begin
      rst_3 = tx_33;
   end
   else if (  cfg_20  != fsm_8 ) begin
      rx_5 = rx_15;
   end
   else begin
      cfg_14 = rx_6;
   end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
