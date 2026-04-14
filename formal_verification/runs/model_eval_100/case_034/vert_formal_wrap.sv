`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  logic [31:0] AuthGoeotid;
  logic [31:0] AuthOKeotid;
  logic [31:0] N;
  logic [31:0] SyncCheckeotid;
  logic [31:0] auth_3;
  logic [31:0] cfg_10;
  logic [31:0] cfg_13;
  logic [31:0] chip_13;
  logic [31:0] chip_15;
  logic [31:0] clk_15;
  logic [31:0] core_3;
  logic [31:0] data_1;
  logic [31:0] data_178;
  logic [31:0] fsm_112;
  logic [31:0] fsm_12;
  logic [31:0] fsm_8;
  logic [31:0] hw_19;
  logic [31:0] reg_14;
  logic [31:0] rst_116;
  logic [31:0] rst_13;
  logic [31:0] rx_16;
  logic [31:0] sig_5;
  logic [31:0] tx_118;

  always_comb begin
if (  chip_13  || auth_3  && rst_13 ) begin 
     core_3 = data_1;
     fsm_112 = chip_15;
    if ( rx_16 ) begin
        fsm_8 = fsm_12;
        data_178 = auth_3;
    end
        if ( tx_118  != reg_14  || clk_15  != sig_5 ) begin
            cfg_10 = cfg_13;
            rst_116 = hw_19;
        end
end
  end

 property AuthGoeotid; (  chip_13  || auth_3  && rst_13 ) |=> core_3 == data_1 && fsm_112 == chip_15 ;endproperty
 property AuthOKeotid; (  chip_13  || auth_3  && rst_13 ) &&  (  rx_16 ) |=> fsm_8 == fsm_12 && data_178 == auth_3 ;endproperty
 property SyncCheckeotid; (  chip_13  || auth_3  && rst_13 ) &&  (  rx_16 ) &&  (  tx_118 != reg_14  || clk_15 != sig_5 ) |=> cfg_10 == cfg_13 && rst_116 == hw_19 ;endproperty
 ЎыџN
endmodule
