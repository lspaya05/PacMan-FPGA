// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This module determines the next of position of the blue ghost, "inky" whos behavior is based 
//      on the current position of pacman. Inky aims to get in between pacman and blinky, and once
//      less than 7 spaces away from pacman or when blinky is dead, Inky targets pacman directly.

// Note, the current position of the ghost is saved within this module.

// Inputs:
//      - clk: 1 bit clock input.
//      - reset: 1 bit reset input
//      - pacPosX: TODO bit input representing the X point of pacman.
//      - pacPosY: TODO bit input representing the Y point of pacman.
//      - blinkyPosX: TODO bit input representing the X point of blinky.
//      - blinkyPosY: TODO bit input representing the Y point of blinky.
//      - userInput: 2-bit input that should be the user input to control pacman.
//                      uses same encoding as output 'dirToMove'.
//      - canMoveU: 1-bit input, when true character is allowed to move UP.
//      - canMoveR: 1-bit input, when true character is allowed to move RIGHT.
//      - canMoveD: 1-bit input, when true character is allowed to move DOWN.
//      - canMoveL: 1-bit input, when true character is allowed to move LEFT.
// Outputs:
//      - dirToMove: 2-bit output that outlines which direction the ghost should move.
//                  - 00: Up
//                  - 01: Right
//                  - 10: Down
//                  - 11: Left
module inky_behavior (
    input clk, reset,
    input logic [: 0] pacPosX,
    input logic [: 0] pacPosY,
    input logic [ : 0] blinkyPosX,
    input logic [ : 0] blinkyPosY,
    input logic blinkyDead,
    input logic [1 : 0] userInput,
    input logic canMoveU, canMoveR, canMoveD, canMoveL,

    output [1 : 0] dirToMove
);

    logic [: 0] targetPosX,
    logic [: 0] targetPosY,

    logic signed [ : 0] diffPosX;
    logic signed [ : 0] diffPosY;

    logic [ : 0] absDiffPosX;
    logic [ : 0] absDiffPosY;

    assign diffPosX = pacPosX - blinkyPosX;
    assign diffPosY = pacPosY - blinkyPosY;

    assign absDiffPosX = (diffPosX < 0) ? -diffPosX : diffPosX; 
    assign absDiffPosY = (diffPosY < 0) ? -diffPosY : diffPosY; 


    always_comb begin
        if (absDiffPosX < 7 | absDiffPosY < 7 | !blinkyDead) begin
            targetPosX = pacPosX + diffPosX;
            targetPosY = pacPosY + diffPosY;
        end else begin
            targetPosX = pacPosX;
            targetPosY = pacPosY;
        end
    end

    ghost_behavior inky (.*);

endmodule