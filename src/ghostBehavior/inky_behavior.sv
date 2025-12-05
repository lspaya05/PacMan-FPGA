// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This module determines the next of position of the blue ghost, "inky" whos behavior is based 
//      on the current position of pacman. Inky aims to get in between pacman and blinky, and once
//      less than 7 spaces away from pacman or when blinky is dead, Inky targets pacman directly.

module inky_behavior (
    input logic [9:0] currPos, pacPos, blinkyPos,
    input logic blinkyDead,
    input logic [31:0]surroundingContainBlock [3:0], 

    output logic [3:0] surroundingBlockAddr [3:0];
    output logic [9 : 0] nextPos
);

    logic signed [ : 0] diffPosX;
    logic signed [ : 0] diffPosY;

    logic [ : 0] absDiffPosX;
    logic [ : 0] absDiffPosY;

    logic [ : 0] pacPosX;
    logic [ : 0] pacPosY;
    logic [ : 0] blinkyPosX;
    logic [ : 0] blinkyPosY;

    assign pacPosX = pacPos % 32; 
    assign pacPosY = pacPos / 32;
    assign blinkyPosX = blinkyPos % 32;
    assign blinkyPosY = blinkyPos / 32;

    assign diffPosX = pacPosX - blinkyPosX;
    assign diffPosY = pacPosY - blinkyPosY;

    assign absDiffPosX = (diffPosX < 0) ? -diffPosX : diffPosX; 
    assign absDiffPosY = (diffPosY < 0) ? -diffPosY : diffPosY; 


    always_comb begin
        if (absDiffPosX < 7 | absDiffPosY < 7 | !blinkyDead) begin
            targetPos = (pacPosY + diffPosY) * 32 + (pacPosX + diffPosX);
        end else begin
            targetPos = pacPos;
        end
    end

    ghost_behavior inky (.*);

endmodule