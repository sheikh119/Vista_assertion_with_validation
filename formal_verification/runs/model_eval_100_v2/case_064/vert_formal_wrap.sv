`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge clock_div_15;
  logic rst;
  logic [31:0] cfg_13;
  logic [31:0] chip_10;
  logic [31:0] clock_div_15;
  logic [31:0] core_7;
  logic [31:0] data_register_18;
  logic [31:0] default;
  logic [31:0] err_14;
  logic [31:0] fsm_17;
  logic [31:0] fsm_18;
  logic [31:0] fsm_20;
  logic [31:0] fsm_6;
  logic [31:0] hw_16;
  logic [31:0] hw_17;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] reg_6;
  logic [31:0] rst_4;
  logic [31:0] rst_8;
  logic [31:0] rx_19;
  logic [31:0] rx_3;
  logic [31:0] rx_9;
  logic [31:0] sig_13;
  logic [31:0] sig_20;
  logic [31:0] sig_6;
  logic [31:0] tx_10;
  always_ff @(posedge posedge clock_div_15) begin
case ( data_register_18 ) 
   fsm_20 : begin
      if (  cfg_13  != rst_4  || reg_6 ) begin 
          sig_20 = rst_8;
          if ( fsm_18  && rx_9  != sig_13  && sig_6 ) begin
               fsm_6 = core_7;
          end
      end
   end
   default : begin 
      if (  fsm_17 ) begin 
          chip_10 <= err_14;
          if ( tx_10  != rx_3  || hw_16 ) begin
               rx_19 <= hw_17;
          end
      end
   end
endcase
  end
property p_gen_1; @(posedge clock_div_15) ( data_register_18 ) == ( fsm_20 ) && ( cfg_13 != rst_4 || reg_6 ) |-> sig_20 == rst_8 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(posedge clock_div_15) ( data_register_18 ) == ( fsm_20 ) && ( cfg_13 != rst_4 || reg_6 ) && ( fsm_18 && rx_9 != sig_13 && sig_6 ) |-> fsm_6 == core_7 ; endproperty
assert property (p_gen_2);
endmodule
