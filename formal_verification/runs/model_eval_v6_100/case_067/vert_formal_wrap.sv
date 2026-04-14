`timescale 1ns/1ps
module vert_formal_wrap;
  logic core_clock_12;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] auth_6;
  logic [31:0] chip_3;
  logic [31:0] hw_19;
  logic [31:0] chip_1;
  logic [31:0] clk_5;
  logic [31:0] fsm_10;
  logic [31:0] chip_16;
  logic [31:0] fsm_20;
  logic [31:0] clk_6;
  logic [31:0] err_11;
  logic [31:0] hw_7;
  logic [31:0] hw_20;
  logic [31:0] tx_11;
  logic [31:0] clk_4;
  logic [31:0] tx_1010;
  logic [31:0] data_155;
  logic [31:0] data_10;
  logic [31:0] core_112;
  logic [31:0] err_113;
  logic [31:0] hw_10;
  logic [31:0] chip_8;
  logic [31:0] rst_16;
  logic [31:0] tx_33;
  logic [31:0] rst_99;
  logic [31:0] chip_96;
  logic [31:0] cfg_2;
  logic [31:0] err_195;
  logic [31:0] data_2;
  always @(posedge core_clock_12) begin
if (  auth_6  && chip_3  || hw_19 ) begin
   chip_1 <= clk_5;
    if ( fsm_10  != chip_16  || fsm_20 ) begin
      clk_6 = err_11;
   end
   else if (  hw_7  != hw_20 ) begin
      tx_11 = clk_4;
   end
   else begin
      tx_1010 = data_155;
   end
end
else begin
   data_10 = core_112;
   if (  chip_3  != err_113  || hw_10  || chip_8 ) begin
      rst_16 <= tx_33;
   end
   else if (  rst_99 ) begin
      chip_96 = cfg_2;
   end
   else begin
      err_195 = data_2;
   end
end
  end

  always @* begin
    assume (!rst);
    assert ((!(( auth_6 && chip_3 || hw_19 ))) || (chip_1 == clk_5));
    assert ((!(( auth_6 && chip_3 || hw_19 ) && ( fsm_10 != chip_16 || fsm_20 ))) || (clk_6 == err_11));
    assert ((!(( auth_6 && chip_3 || hw_19 ) && (!( fsm_10 != chip_16 || fsm_20 ) && ( hw_7 != hw_20 ) ))) || (tx_11 == clk_4));
    assert ((!(( auth_6 && chip_3 || hw_19 ) && ( !( fsm_10 != chip_16 || fsm_20 ) &&!( hw_7 != hw_20 ) ))) || (tx_1010 == data_155));
    assert ((!(! ( auth_6 && chip_3 || hw_19 ))) || (data_10 == core_112));
    assert ((!(! ( auth_6 && chip_3 || hw_19 ) && ( chip_3 != err_113 || hw_10 || chip_8 ))) || (rst_16 == tx_33));
    assert ((!(! ( auth_6 && chip_3 || hw_19 ) && (!( chip_3 != err_113 || hw_10 || chip_8 ) && ( rst_99 ) ))) || (chip_96 == cfg_2));
  end
endmodule
