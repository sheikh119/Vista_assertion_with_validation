`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] sig_15;
  logic [31:0] rst_12;
  logic [31:0] reg_19;
  logic [31:0] cfg_6;
  logic [31:0] cfg_208;
  logic [31:0] cfg_5;
  logic [31:0] rx_19;
  logic [31:0] data_7;
  logic [31:0] reg_17;
  logic [31:0] rst_19;
  logic [31:0] sig_8;
  logic [31:0] err_9;
  logic [31:0] reg_6;
  logic [31:0] fsm_112;
  logic [31:0] rx_18;
  logic [31:0] data_203;
  logic [31:0] auth_2;
  logic [31:0] chip_18;
  logic [31:0] core_7;
  logic [31:0] rst_17;
  logic [31:0] fsm_13;
  logic [31:0] chip_17;
  logic [31:0] chip_9;
  logic [31:0] auth_10;
  logic [31:0] err_17;
  logic [31:0] sig_10;
  logic [31:0] err_5;
  always @* begin
if (  sig_15  || rst_12  || reg_19  != cfg_6 ) begin 
    cfg_208 = cfg_5;
    if ( rx_19  || data_7  != reg_17  || rst_19 ) begin
        sig_8 = err_9;
    end
    else if (  reg_6 ) begin
        fsm_112 = rx_18;
    end
    else begin
        data_203 = auth_2;
    end
end
else begin 
    chip_18 = core_7;
    if (  rst_17  != fsm_13  || rx_19  != chip_17 ) begin
        chip_9 = data_203;
    end
    else if (  auth_10 ) begin
        err_17 = sig_10;
    end
    else begin
        err_5 = chip_18;
    end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
