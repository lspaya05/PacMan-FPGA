// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This module determines the next position of the red ghost, "blinky" who's behavior is based
//      on the current position of pacman. Blinky directly targets pacman, taking the path that
//      leads most directly to pacman.


module blinky_behavior (
    input logic clk, reset, start,
    input logic [9:0] currPos, targetPos,
    output logic [9:0] nextPos, 
    output logic done, ready
);

    ghostNextLoc blinky ( 
    .clk, .reset, .start,
    .currPos, .targetPos,
    .nextPos, 
    .done, .ready);

endmodule