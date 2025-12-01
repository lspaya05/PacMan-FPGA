
module cylde_behavior (
    input clk, reset,
    input logic [: 0] pacPosX,
    input logic [: 0] pacPosY,
    input logic [1 : 0] userInput,
    input logic canMoveU, canMoveR, canMoveD, canMoveL

    output [1 : 0] dirToMove
);
    logic [: 0] targetPosX,
    logic [: 0] targetPosY,

    always_comb begin
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
    end
    
    ghost_behavior pinky (.*);
endmodule