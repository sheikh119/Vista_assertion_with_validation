`ifndef VERILATOR
module testbench;
  reg [4095:0] vcdfile;
  reg clock;
`else
module testbench(input clock, output reg genclock);
  initial genclock = 1;
`endif
  reg genclock = 1;
  reg [31:0] cycle = 0;
  vert_formal_wrap UUT (

  );
`ifndef VERILATOR
  initial begin
    if ($value$plusargs("vcd=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, testbench);
    end
    #5 clock = 0;
    while (genclock) begin
      #5 clock = 0;
      #5 clock = 1;
    end
  end
`endif
  initial begin
`ifndef VERILATOR
    #1;
`endif
    // UUT.$auto$async2sync.\cc:107:execute$223  = 1'b0;
    // UUT.$auto$async2sync.\cc:116:execute$191  = 1'b1;
    // UUT.$auto$async2sync.\cc:116:execute$197  = 1'b1;
    // UUT.$auto$async2sync.\cc:116:execute$203  = 1'b1;
    // UUT.$auto$async2sync.\cc:116:execute$209  = 1'b1;
    // UUT.$auto$async2sync.\cc:116:execute$215  = 1'b1;
    // UUT.$auto$async2sync.\cc:116:execute$221  = 1'b1;
    // UUT.$auto$async2sync.\cc:116:execute$227  = 1'b1;
    UUT.cfg_16 = 32'b10000000000000000000000000000000;
    UUT.clk_10 = 32'b10000000000000000000000000000000;
    UUT.clk_62 = 32'b00000000000000000000000000000000;
    UUT.data_4 = 32'b10000000000000000000000000000000;
    UUT.err_16 = 32'b00000000000000000000000000000000;
    UUT.rst_3 = 32'b10000000000000000000000000000000;
    UUT.tx_115 = 32'b10000000000000000000000000000000;

    // state 0
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
    end

    genclock <= cycle < 1;
    cycle <= cycle + 1;
  end
endmodule
