// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

//

module pinky_behavior (
    input clk, reset,
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
        if (absDiffPosX < 4 | absDiffPosY < 4) begin
            case (userInput)
                2'b00: begin 
                    targetPosX = pacPosX;
                    targetPosY = pacPosY - 4;
                end 

                2'b01: begin
                    targetPosX = pacPosX + 4;
                    targetPosY = pacPosY;
                end

                2'b10: begin 
                    targetPosX = pacPosX;
                    targetPosY = pacPosY + 4;

                end

                2'b11: begin 
                    targetPosX = pacPosX - 4;
                    targetPosY = pacPosY;
                end

                default: begin 
                    targetPosX = pacPosX;
                    targetPosY = pacPosY;
                end 
            endcase
        end else begin
            targetPosX = pacPosX;
            targetPosY = pacPosY;
        end
    end

    ghost_behavior pinky (.*);
endmodule