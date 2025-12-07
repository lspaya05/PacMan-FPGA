// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This module implements a clock divider that is able to divide the clocks with certain frequencies.
//  the pattern follows: divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
//  [25] = 0.75Hz... THIS IS HARDWARE ONLY - not to be used in simulation

//Inputs:
//    - clock: 1 bit clock input signal.
//Outputs:
//    - divided_clocks: An array of 32 clock signals, each with varying frequencies.

module clock_divider (clock, divided_clocks);
  input  logic        clock;
  output logic [31:0] divided_clocks = 0;

  always_ff @(posedge clock) begin
    divided_clocks <= divided_clocks + 1;
  end // always_ff

endmodule  // clock_divider
