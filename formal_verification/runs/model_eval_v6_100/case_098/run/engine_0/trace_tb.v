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
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_236 = 32'b10000000000000000000000000000000;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_265 = 32'b10000000000000000000000000000000;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_286 = 32'b10000000000000000000000000000000;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_307 = 32'b11111111111111111111111111111111;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_364 = 32'b10000000000000000000000000000000;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_411 = 32'b10000000000000000000000000000000;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_444 = 32'b10000000000000000000000000000000;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_477 = 32'b11111111111111111111111111111111;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_502 = 32'b11111111111111111111111111111111;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_525 = 32'b11111111111111111111111111111111;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_548 = 32'b01111111111111111111111111111111;
    UUT._witness_.anyinit_auto_proc_dlatch_cc_432_proc_dlatch_585 = 32'b11111111111111111111111111111111;

    // state 0
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
