`timescale 1ns/1ps
module vert_formal_wrap;
  logic clk_osc_3;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] status_register_buffer_6;
  logic [31:0] h3e;
  logic [31:0] fsm_11;
  logic [31:0] fsm_13;
  logic [31:0] core_12;
  logic [31:0] hw_18;
  logic [31:0] bxx0xx;
  logic [31:0] rst_4;
  logic [31:0] tx_1;
  logic [31:0] data_13;
  logic [31:0] auth_17;
  logic [31:0] b110x10;
  logic [31:0] data_14;
  logic [31:0] data_10;
  logic [31:0] data_19;
  logic [31:0] reg_20;
  logic [31:0] err_4;
  logic [31:0] sig_16;
  logic [31:0] auth_10;
  logic [31:0] err_16;
  logic [31:0] b1;
  always @(posedge clk_osc_3) begin
case ( status_register_buffer_6 )
   7'h3e : begin
     fsm_11 = fsm_13;
     core_12 <= hw_18;
   end
   5'bxx0xx : begin
     rst_4 <= tx_1;
     data_13 <= auth_17;
   end
   6'b110x10 : begin
     data_14 <= data_10;
     data_19 = reg_20;
   end
   default : begin
     err_4 <= sig_16;
     auth_10 = err_16;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
  end
endmodule
