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
    UUT.auth_17 = 32'b10000000000000000000000000000000;
    UUT.auth_6 = 32'b10000000000000000000000000000000;
    UUT.cfg_16 = 32'b10000000000000000000000000000000;
    UUT.cfg_17 = 32'b10000000000000000000000000000000;
    UUT.chip_18 = 32'b10000000000000000000000000000000;
    UUT.reg_13 = 32'b10000000000000000000000000000000;
    UUT.rst_6 = 32'b10000000000000000000000000000000;
    UUT.tx_115 = 32'b10000000000000000000000000000000;

    // state 0
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
