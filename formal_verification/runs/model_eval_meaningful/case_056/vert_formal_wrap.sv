`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] auth_12;
  logic [31:0] b111xxx1;
  logic [31:0] b11x001;
  logic [31:0] bx111111;
  logic [31:0] bx1xxxx;
  logic [31:0] cfg_2;
  logic [31:0] chip_9;
  logic [31:0] core_6;
  logic [31:0] core_8;
  logic [31:0] data_6;
  logic [31:0] default;
  logic [31:0] err_18;
  logic [31:0] fsm_20;
  logic [31:0] h30;
  logic [31:0] sig_1;
  logic [31:0] start_signal_17;
  logic [31:0] tx_16;
  always @* begin
case ( start_signal_17 ) 
   6'b11x001 : begin
     sig_1 = auth_12;
   end
   7'b111xxx1 : begin
     core_8 = err_18;
   end
   7'bx111111 : begin
     core_6 = tx_16;
   end
   6'bx1xxxx : begin
     data_6 = core_8;
   end
   7'h30 : begin
     fsm_20 = tx_16;
   end
   default : begin 
     cfg_2 = chip_9;
   end
endcase
  end

  always @* begin
    assert (((!(: ( start_signal_17 ) == ( 6'b11x001 ))) || (sig_1 == auth_12)));
    assert (((!(: ( start_signal_17 ) == ( 7'b111xxx1 ))) || (core_8 == err_18)));
    assert (((!(: ( start_signal_17 ) == ( 7'bx111111 ))) || (core_6 == tx_16)));
    assert (((!(: ( start_signal_17 ) == ( 6'bx1xxxx ))) || (data_6 == core_8)));
    assert (((!(: ( start_signal_17 ) == ( 7'h30 ))) || (fsm_20 == tx_16)));
  end
endmodule
