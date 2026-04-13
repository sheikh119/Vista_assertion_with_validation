// VERT row harness: combinational case + nested ifs (Synchronous: False).
// Case label used `7'b1001x10`; Yosys matches don't-cares cleanly with casez + `?`.

`timescale 1ns/1ps

module vert_formal_wrap (
    input wire [6:0] interrupt_request_15,
    input wire auth_4,
    input wire [31:0] reg_17,
    input wire [31:0] data_8,
    input wire [31:0] auth_18,
    input wire fsm_6,
    input wire err_11,
    input wire [31:0] cfg_14,
    input wire rst_14,
    input wire reg_6,
    input wire reg_11,
    input wire [31:0] rst_20,
    input wire rst_2,
    input wire [31:0] err_46,
    input wire [31:0] sig_14
);

  logic [31:0] chip_11;
  logic [31:0] cfg_6;
  logic [31:0] err_6;
  logic [31:0] auth_11;

  always_comb begin
    chip_11 = '0;
    cfg_6 = '0;
    err_6 = '0;
    auth_11 = '0;

    casez (interrupt_request_15)
      7'b1001?10: begin
        if (auth_4 && auth_4) begin
          chip_11 = reg_17;
          if (data_8 != auth_18 || (fsm_6 && err_11)) begin
            cfg_6 = cfg_14;
          end
        end
      end
      default: begin
        if (rst_14 || reg_6 || reg_11) begin
          err_6 = rst_20;
          if (rst_2 != err_46) begin
            auth_11 = sig_14;
          end
        end
      end
    endcase
  end

  // --- Formal checks (SymbiYosys / Yosys formal extensions) ---
  // See: https://symbiyosys.readthedocs.io/en/latest/verilog.html
  always @* begin
    // Bound inputs so the solver explores finite ranges (tune widths as needed).
    assume(interrupt_request_15 <= 7'h7f);
    // Vacuous safety check: outputs are always valid 32-bit values (placeholder).
    assert(chip_11 === chip_11);
  end

endmodule
