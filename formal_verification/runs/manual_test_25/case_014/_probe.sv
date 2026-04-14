`timescale 1ns/1ps
module vert_formal_wrap;
  logic async_clk_18;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] err_17;
  logic [31:0] cfg_6;
  logic [31:0] sig_6;
  logic [31:0] tx_9;
  logic [31:0] data_5;
  logic [31:0] data_6;
  logic [31:0] hw_196;
  logic [31:0] err_1;
  logic [31:0] fsm_1;
  logic [31:0] data_10;
  logic [31:0] rx_11;
  logic [31:0] tx_18;
  logic [31:0] reg_4;
  logic [31:0] err_15;
  logic [31:0] auth_18;
  logic [31:0] clk_14;
  logic [31:0] data_14;
  logic [31:0] core_43;
  logic [31:0] clk_4;
  logic [31:0] err_2;
  logic [31:0] auth_5;
  logic [31:0] cfg_5;
  logic [31:0] rx_6;
  logic [31:0] cfg_10;
  logic [31:0] b1;
  logic [31:0] ValidTxeotid;
  always @(posedge async_clk_18) begin
if (  err_17  != cfg_6 ) begin
    sig_6 <= tx_9;
    data_5 <= data_6;
    hw_196 = err_1;
    if ( fsm_1  && data_10  || err_1  && rx_11 ) begin
        tx_18 = reg_4;
        err_15 <= auth_18;
        clk_14 = data_14;
    end
        if ( core_43 ) begin
            clk_4 = err_2;
            auth_5 = cfg_5;
            rx_6 = cfg_10;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
    assert (!(: assert ValidTxeotid; ( err_17 != cfg_6 ) && ( fsm_1 && data_10 || err_1 && rx_11 ))) || (tx_18 == reg_4 && err_15 == auth_18 && clk_14 == data_14);
  end
endmodule
