`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] ErrorSynceotid;
  logic [31:0] ResetGuardeotid;
  logic [31:0] ResetSynceotid;
  logic [31:0] auth_9;
  logic [31:0] bxxxxxxx;
  logic [31:0] cfg_120;
  logic [31:0] cfg_17;
  logic [31:0] cfg_18;
  logic [31:0] cfg_3;
  logic [31:0] chip_13;
  logic [31:0] chip_4;
  logic [31:0] clk_117;
  logic [31:0] clk_8;
  logic [31:0] core_15;
  logic [31:0] core_19;
  logic [31:0] core_4;
  logic [31:0] core_7;
  logic [31:0] data_20;
  logic [31:0] data_7;
  logic [31:0] default;
  logic [31:0] err_10;
  logic [31:0] err_13;
  logic [31:0] err_19;
  logic [31:0] fsm_10;
  logic [31:0] fsm_17;
  logic [31:0] fsm_2;
  logic [31:0] hw_1;
  logic [31:0] hw_15;
  logic [31:0] hw_5;
  logic [31:0] interrupt_control_19;
  logic [31:0] reg_13;
  logic [31:0] rst_13;
  logic [31:0] rst_9;
  logic [31:0] rx_11;
  logic [31:0] rx_19;
  logic [31:0] sig_;
  logic [31:0] sig_17;

  always_comb begin
case ( interrupt_control_19 ) 
   7'bxxxxxxx : begin

      if (  clk_117  != rx_19  || clk_8 ) begin 
          rx_11 = cfg_3;
          chip_13 = rst_9;
          if ( err_13  && cfg_120  != hw_1  && chip_4 ) begin
               cfg_18 = fsm_10;
               fsm_17 = err_13;
          end
      end

   end
   default : begin 
      if (  rst_13  && core_4  && sig_17  != hw_5 ) begin 
          core_15 = reg_13;
          cfg_17 = err_19;
          if ( auth_9  || data_20  && err_10  != core_19 ) begin
               data_7 = core_7;
               fsm_2 = hw_15;
          end
      end

   end
endcase
  end

 property ResetSynceotid; ( interrupt_control_19 ) == ( 7'bxxxxxxx ) &&  (  clk_117 != rx_19  || clk_8 ) |=> rx_11 == cfg_3 && chip_13 == rst_9 ;endproperty
 property ErrorSynceotid; ( interrupt_control_19 ) == ( 7'bxxxxxxx ) &&  (  clk_117 != rx_19  || clk_8 ) &&  (  err_13  && cfg_120 != hw_1  && chip_4 ) |=> cfg_18 == fsm_10 && fsm_17 == err_13 ;endproperty
  property ResetGuardeotid;  ( interrupt_control_19 )!= 7'bxxxxxxx &&  (  rst_13  && core_4  && sig_
endmodule
