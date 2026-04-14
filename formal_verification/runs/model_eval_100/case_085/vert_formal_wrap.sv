`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] N;
  logic [31:0] ValidSendeotid;
  logic [31:0] ValidTxeotid;
  logic [31:0] cfg_105;
  logic [31:0] cfg_15;
  logic [31:0] cfg_17;
  logic [31:0] err_12;
  logic [31:0] fsm_2;
  logic [31:0] hw_13;
  logic [31:0] hw_2;
  logic [31:0] reg_115;
  logic [31:0] reg_5;
  logic [31:0] tx_2;
  logic [31:0] tx_8;

  always_comb begin
if (  tx_2  != err_12  && hw_2 ) begin 
     cfg_105 = cfg_15;
    if ( cfg_17 ) begin
        hw_13 = fsm_2;
    end
        if ( tx_8 ) begin
            reg_115 = reg_5;
        end
end
  end

 property ValidTxeotid; (  tx_2 != err_12  && hw_2 ) |=> cfg_105 == cfg_15;endproperty
 property ValidSendeotid; (  tx_2 != err_12  && hw_2 ) &&  (  cfg_17 ) |=> hw_13 == fsm_2;endproperty
 property ValidTxeotid; (  tx_2 != err_12  && hw_2 ) &&  (  cfg_17 ) &&  (  tx_8 ) |=> reg_115 == reg_5;endproperty
 ЎыџNЎыџN
endmodule
