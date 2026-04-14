`timescale 1ns/1ps
module vert_formal_wrap;
  logic posedge core_clock_8;
  logic rst;
  logic [31:0] auth_17;
  logic [31:0] auth_8;
  logic [31:0] cfg_14;
  logic [31:0] cfg_5;
  logic [31:0] chip_10;
  logic [31:0] chip_12;
  logic [31:0] chip_13;
  logic [31:0] chip_7;
  logic [31:0] chip_8;
  logic [31:0] clk_2;
  logic [31:0] core_11;
  logic [31:0] core_14;
  logic [31:0] core_17;
  logic [31:0] core_8;
  logic [31:0] core_clock_8;
  logic [31:0] data_6;
  logic [31:0] default;
  logic [31:0] err_3;
  logic [31:0] fsm_1;
  logic [31:0] fsm_13;
  logic [31:0] h7e;
  logic [31:0] hw_3;
  logic [31:0] hw_5;
  logic [31:0] hw_9;
  logic [31:0] interrupt_enable_9;
  logic [31:0] p_gen_1;
  logic [31:0] reg_16;
  logic [31:0] reg_3;
  logic [31:0] reg_6;
  logic [31:0] rst_1;
  logic [31:0] rst_16;
  logic [31:0] rst_19;
  logic [31:0] rst_9;
  logic [31:0] rx_9;
  logic [31:0] sig_11;
  logic [31:0] sig_3;
  logic [31:0] sig_5;
  logic [31:0] tx_6;
  always_ff @(posedge posedge core_clock_8) begin
case ( interrupt_enable_9 ) 
   7'h7e : begin
      if (  tx_6  || data_6  != reg_3  && fsm_1 ) begin 
          reg_6 = chip_12;
          hw_5 = auth_17;
          chip_8 <= hw_9;
          if ( core_14  != rx_9  && reg_16  || clk_2 ) begin
               chip_12 <= sig_5;
               sig_5 <= chip_7;
               fsm_13 <= core_11;
          end
      end
   end
   default : begin 
      if (  err_3  != chip_13  && rst_16  || rst_1 ) begin 
          sig_11 = chip_8;
          rst_9 <= core_8;
          auth_8 = cfg_5;
          if ( rst_19 ) begin
               chip_10 <= cfg_14;
               sig_3 = core_17;
               rst_19 <= hw_3;
          end
      end
   end
endcase
  end
property p_gen_1; @(posedge core_clock_8) ( interrupt_enable_9 ) == ( 7'h7e ) && ( tx_6 || data_6 != reg_3 && fsm_1 ) |-> reg_6 == chip_12 && hw_5 == auth_17 && chip_8 == hw_9 ; endproperty
assert property (p_gen_1);
endmodule
