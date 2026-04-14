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
    UUT.auth_117 = 32'b10000000000000000000000000000000;
    UUT.auth_3 = 32'b10000000000000000000000000000000;
    UUT.auth_8 = 32'b10000000000000000000000000000000;
    UUT.cfg_2 = 32'b10000000000000000000000000000000;
    UUT.fsm_9 = 32'b10000000000000000000000000000000;
    UUT.hw_4 = 32'b10000000000000000000000000000000;
    UUT.rst_9 = 32'b10000000000000000000000000000000;
    UUT.sig_11 = 32'b10000000000000000000000000000000;

    // state 0
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
