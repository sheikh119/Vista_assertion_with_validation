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
    UUT.cfg_183 = 32'b10000000000000000000000000000000;
    UUT.chip_2 = 32'b10000000000000000000000000000000;
    UUT.core_5 = 32'b10000000000000000000000000000000;
    UUT.fsm_13 = 32'b10000000000000000000000000000000;
    UUT.sig_1 = 32'b10000000000000000000000000000000;
    UUT.tx_17 = 32'b10000000000000000000000000000000;

    // state 0
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
