`timescale 1ns/1ps
module vert_formal_wrap;
  logic clock_ctrl_5;
  logic rst;
  initial begin rst = 1'b0; end
  logic [31:0] data_ready_17;
  logic [31:0] b1101001;
  logic [31:0] auth_14;
  logic [31:0] auth_6;
  logic [31:0] fsm_9;
  logic [31:0] clk_1;
  logic [31:0] hw_20;
  logic [31:0] tx_18;
  logic [31:0] h21;
  logic [31:0] clk_17;
  logic [31:0] fsm_2;
  logic [31:0] rst_12;
  logic [31:0] auth_9;
  logic [31:0] hw_5;
  logic [31:0] err_16;
  logic [31:0] sig_4;
  logic [31:0] core_10;
  logic [31:0] auth_17;
  logic [31:0] fsm_6;
  logic [31:0] hw_13;
  logic [31:0] cfg_17;
  logic [31:0] b1;
  logic [31:0] ValidSynceotid;
  logic [31:0] Data;
  logic [31:0] ready;
  logic [31:0] check;
  logic [31:0] on;
  logic [31:0] clock;
  logic [31:0] edge;
  always @(posedge clock_ctrl_5) begin
case ( data_ready_17 )
   7'b1101001 : begin
     auth_14 = auth_6;
     fsm_9 = clk_1;
     hw_20 <= tx_18;
   end
   6'h21 : begin
     clk_17 <= fsm_2;
     rst_12 = auth_9;
     hw_5 = err_16;
   end
   default : begin
     sig_4 <= core_10;
     auth_17 <= fsm_6;
     hw_13 = cfg_17;
   end
endcase
  end

  always @* begin
    assume (!rst);
    assert (1'b1);
    assert (ValidSynceotid; ( data_ready_17 ) == ( 6'h21 ) && ( clk_17 ) == ( fsm_2 ) && ( rst_12 ) == ( auth_9 ) && ( hw_5 ) == ( err_16 ) ) : "Data ready check on clock edge");
  end
endmodule
