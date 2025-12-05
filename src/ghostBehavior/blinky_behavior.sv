// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This module determines the next position of the red ghost, "blinky" who's behavior is based
//      on the current position of pacman. Blinky directly targets pacman, taking the path that
//      leads most directly to pacman.


module blinky_behavior (
    input logic [9:0] currPos, pacPos,
    input logic [31:0]surroundingContainBlock [3:0], 

    output logic [3:0] surroundingBlockAddr [3:0];
    output logic [9 : 0] nextPos
);
    // Dead logic 
    logic [ : 0] ghostPosX;
    logic [ : 0] ghostPosY;

    ghostNextLoc blinky (.currPos, .targetPos(pacPos), .surroundingContainBlock, 
                    .surroundingBlockAddr, .nextPos, .ghostPosX, .ghostPosY);

endmodule