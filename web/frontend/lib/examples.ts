/**
 * Example RTL snippets shown in the Playground.
 *
 * All snippets use the VERT training distribution (signal-name style
 * `<prefix>_<number>` with prefixes drawn from {auth, cfg, chip, clk, core,
 * data, err, fsm, hw, reg, rst, rx, sig, tx}) so the fine-tuned model
 * generates high-quality assertions.
 */

export type Example = {
  id: string;
  label: string;
  synchronous: boolean;
  clock: string | null;
  code: string;
};

export const examples: Example[] = [
  {
    id: "comb-if-basic",
    label: "Nested if / combinational",
    synchronous: false,
    clock: null,
    code:
`if (  auth_6  && data_1 ) begin
     sig_17 = data_10;
     hw_13 = reg_9;
    if ( data_15  && rx_6  && hw_6 ) begin
        tx_2 = chip_8;
        cfg_15 = clk_4;
    end
end`,
  },
  {
    id: "sync-clocked",
    label: "Synchronous clocked RTL",
    synchronous: true,
    clock: "posedge core_clock_12",
    code:
`if (  data_3 ) begin
   rx_5 <= cfg_15;
    if ( clk_3  && err_5  && auth_13 ) begin
      tx_9 <= sig_2;
   end
end
else begin
   sig_4 <= cfg_16;
   if (  hw_14  && rst_5  && clk_115 ) begin
      cfg_9 <= clk_7;
   end
end`,
  },
  {
    id: "case-decoder",
    label: "Case decoder",
    synchronous: false,
    clock: null,
    code:
`case ( acknowledge_14 )
   7'bx101xxx : begin
     rst_6 = hw_3;
   end
   7'bxxxxxx1 : begin
     data_13 = chip_12;
   end
   default : begin
     clk_7 = sig_18;
   end
endcase`,
  },
  {
    id: "sync-nested-case",
    label: "Sync case with inner if",
    synchronous: true,
    clock: "posedge clk_osc_3",
    code:
`case ( input_status_register_4 )
   7'h39 : begin
      if ( !cfg_7 ) begin
          sig_19 <= rst_1;
          hw_10 <= core_3;
          cfg_4 = reg_2;
      end
   end
   default : begin
      if (  rx_16  != rx_12  || data_5  || fsm_12 ) begin
          auth_4 <= hw_10;
          err_16 = tx_3;
      end
   end
endcase`,
  },
  {
    id: "reset-guarded",
    label: "Reset-guarded combinational",
    synchronous: false,
    clock: null,
    code:
`if ( !rst_ni ) begin
     chip_110 = clk_15;
     rx_114 = fsm_18;
    if ( rst_80  || clk_3 ) begin
        core_75 = reg_9;
        sig_63 = rx_13;
    end
end`,
  },
];
