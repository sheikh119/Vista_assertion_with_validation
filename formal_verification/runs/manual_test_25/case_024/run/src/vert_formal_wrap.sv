`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] cfg_2;
  logic [31:0] data_20;
  logic [31:0] clk_11;
  logic [31:0] data_10;
  logic [31:0] core_9;
  logic [31:0] rst_14;
  logic [31:0] rst_2;
  logic [31:0] err_46;
  logic [31:0] auth_19;
  logic [31:0] chip_12;
  logic [31:0] rst_6;
  logic [31:0] err_4;
  logic [31:0] cfg_7;
  logic [31:0] b1;
  always @* begin
if (  cfg_2  && data_20  || clk_11  || data_10 ) begin
     core_9 = rst_14;
    if ( rst_2  != err_46 ) begin
        auth_19 = chip_12;
    end
        if ( rst_6 ) begin
            err_4 = cfg_7;
        end
end
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
