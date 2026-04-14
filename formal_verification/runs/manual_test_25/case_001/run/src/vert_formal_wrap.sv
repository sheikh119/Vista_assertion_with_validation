`timescale 1ns/1ps
module vert_formal_wrap;
  logic async_clk_13;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] fsm_5;
  logic [31:0] hw_9;
  logic [31:0] reg_5;
  logic [31:0] cfg_16;
  logic [31:0] hw_68;
  logic [31:0] fsm_13;
  logic [31:0] data_17;
  logic [31:0] fsm_16;
  logic [31:0] data_135;
  logic [31:0] core_14;
  logic [31:0] rx_9;
  logic [31:0] reg_16;
  logic [31:0] clk_2;
  logic [31:0] fsm_6;
  logic [31:0] reg_8;
  logic [31:0] err_18;
  logic [31:0] fsm_12;
  logic [31:0] chip_17;
  logic [31:0] chip_14;
  logic [31:0] chip_11;
  logic [31:0] sig_14;
  logic [31:0] chip_2;
  logic [31:0] rx_11;
  logic [31:0] rx_6;
  logic [31:0] reg_19;
  logic [31:0] core_20;
  logic [31:0] rx_5;
  logic [31:0] b1;
  always @(posedge async_clk_13) begin
if (  fsm_5  || hw_9  || reg_5 ) begin
    cfg_16 <= hw_68;
    fsm_13 = data_17;
    fsm_16 <= data_135;
    if ( core_14  != rx_9  && reg_16  || clk_2 ) begin
        fsm_6 <= reg_8;
        err_18 = fsm_12;
        chip_17 = chip_14;
    end
        if ( chip_11  != sig_14 ) begin
            chip_2 <= rx_11;
            rx_6 <= reg_19;
            core_20 <= rx_5;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
