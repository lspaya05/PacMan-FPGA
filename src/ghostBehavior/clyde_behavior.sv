// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This module determines the next position of the orange ghost, "clyde" whos behavior is based 
//      on the current position of pacman. Clyde chases pacman directly, but once he gets within 
//      5 spaces of pac, Clyde 'runs away'.

// Note, the current position of the ghost is saved within this module.

// Inputs:
//      - clk: 1 bit clock input.
//      - reset: 1 bit reset input.
//      - update: 1 bit signal that signals the current position of the ghost should be updated.
//      - intPosX: TODO bit input representing the intial X coordinate to start the ghost at.
//      - intPosY: TODO bit input representing the intial Y coordinate to start the ghost at.
//      - pacPosX: TODO bit input representing the X point of pacman.
//      - pacPosY: TODO bit input representing the Y point of pacman.
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
module cylde_behavior (
    input clk, reset, update,
    input logic [: 0] intPosX,
    input logic [: 0] intPosY,
    input logic [: 0] pacPosX,
    input logic [: 0] pacPosY,
    input logic [1 : 0] userInput,
    input logic canMoveU, canMoveR, canMoveD, canMoveL

    output [1 : 0] dirToMove
);
    logic [: 0] targetPosX,
    logic [: 0] targetPosY,

    logic signed [ : 0] diffPosX;
    logic signed [ : 0] diffPosY;

    logic [ : 0] absDiffPosX;
    logic [ : 0] absDiffPosY;

    assign diffPosX = pacPosX - ghostPosX;
    assign diffPosY = pacPosY - ghostPosY;

    assign absDiffPosX = (diffPosX < 0) ? -diffPosX : diffPosX; 
    assign absDiffPosY = (diffPosY < 0) ? -diffPosY : diffPosY; 


    always_comb begin
       if (absDiffPosX < 5 | absDiffPosY < 5) begin
            targetPosX = ~pacPosX;
            targetPosY = ~pacPosY;
       end else begin
            targetPosX = pacPosX;
            targetPosY = pacPosY;
       end 
        
    end
    
    ghost_behavior cylde (.*);
endmodule