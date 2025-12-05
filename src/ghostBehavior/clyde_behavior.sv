// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This module determines the next position of the orange ghost, "clyde" whos behavior is based 
//      on the current position of pacman. Clyde chases pacman directly, but once he gets within 
//      5 spaces of pac, Clyde 'runs away'.


module cylde_behavior (
    input logic [9:0] currPos, pacPos,
    input logic [31:0]surroundingContainBlock [3:0], 

    output logic [3:0] surroundingBlockAddr [3:0];
    output logic [9 : 0] nextPos
);
    logic [9:0] targetPos;

    logic signed [ : 0] diffPosX;
    logic signed [ : 0] diffPosY;

    logic [ : 0] pacPosX;
    logic [ : 0] pacPosY;

    assign pacPosX = pacPos % 32; 
    assign pacPosY = pacPos / 32;

    assign diffPosX = pacPosX - ghostPosX;
    assign diffPosY = pacPosY - ghostPosY;

    logic [ : 0] absDiffPosX;
    logic [ : 0] absDiffPosY;

    assign absDiffPosX = (diffPosX < 0) ? -diffPosX : diffPosX; 
    assign absDiffPosY = (diffPosY < 0) ? -diffPosY : diffPosY; 


    always_comb begin
       if (absDiffPosX < 5 | absDiffPosY < 5) begin
            targetPos = ~pacPos;
       end else begin
            targetPos = pacPos;
       end 
        
    end
    
    ghostNextLoc clyde (.currPos, .targetPos, .surroundingContainBlock, 
                    .surroundingBlockAddr, .nextPos, .ghostPosX, .ghostPosY);
endmodule