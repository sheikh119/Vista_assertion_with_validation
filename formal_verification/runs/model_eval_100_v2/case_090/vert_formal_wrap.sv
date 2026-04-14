`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge fast_clk_2;
  logic rst;
  logic [31:0] auth_3;
  logic [31:0] bxxxx10x;
  logic [31:0] chip_18;
  logic [31:0] chip_5;
  logic [31:0] chip_9;
  logic [31:0] core_14;
  logic [31:0] default;
  logic [31:0] err_1;
  logic [31:0] err_3;
  logic [31:0] err_5;
  logic [31:0] fast_clk_2;
  logic [31:0] fsm_11;
  logic [31:0] fsm_15;
  logic [31:0] fsm_2;
  logic [31:0] input_data_13;
  logic [31:0] p_gen_1;
  logic [31:0] p_gen_2;
  logic [31:0] reg_17;
  logic [31:0] rst_12;
  logic [31:0] rst_13;
  logic [31:0] rst_16;
  logic [31:0] sig_2;
  logic [31:0] tx_13;
  always_ff @(posedge posedge fast_clk_2) begin
case ( input_data_13 ) 
   7'bxxxx10x : begin
      if (  fsm_2  || rst_12  && sig_2 ) begin 
          rst_13 <= rst_16;
          if ( err_3 ) begin
               fsm_15 <= err_5;
          end
      end
   end
   default : begin 
      if (  chip_5  != core_14  && chip_18 ) begin 
          fsm_11 = err_1;
          if ( chip_9  != auth_3 ) begin
               tx_13 = reg_17;
          end
      end
   end
endcase
  end
property p_gen_1; @(posedge fast_clk_2) ( input_data_13 ) == ( 7'bxxxx10x ) && ( fsm_2 || rst_12 && sig_2 ) |-> rst_13 == rst_16 ; endproperty
assert property (p_gen_1);
property p_gen_2; @(posedge fast_clk_2) ( input_data_13 ) == ( 7'bxxxx10x ) && ( fsm_2 || rst_12 && sig_2 ) && ( err_3 ) |-> fsm_15 == err_5 ; endproperty
assert property (p_gen_2);
endmodule
