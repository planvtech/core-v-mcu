module pulp_clock_gating
  (
   input  logic clk_i,
   input  logic en_i,
   input  logic test_en_i,
   output logic clk_o
   );
  logic         clk_en;

  assign clk_en = en_i | test_en_i;  
  BUFGCE #(
      .CE_TYPE("SYNC"),               // ASYNC, HARDSYNC, SYNC
      .IS_CE_INVERTED(1'b0),          // Programmable inversion on CE
      .IS_I_INVERTED(1'b0),           // Programmable inversion on I
      .SIM_DEVICE("ULTRASCALE_PLUS")  // ULTRASCALE, ULTRASCALE_PLUS
   )
   BUFGCE_inst (
      .O(clk_o),   // 1-bit output: Buffer
      .CE(clk_en), // 1-bit input: Buffer enable
      .I(clk_i)    // 1-bit input: Buffer
   );

endmodule
