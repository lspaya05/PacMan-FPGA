// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

module ghost_behavior (
    input clk, reset,
    input logic [: 0] targetPosX,
    input logic [: 0] targetPosY,
    input logic canMoveU, canMoveR, canMoveD, canMoveL

    output [1 : 0] dirToMove
);

    logic [ : 0] ghostPosX;
    logic [ : 0] ghostPosY;


    logic signed [ : 0] diffPosX;
    logic signed [ : 0] diffPosY;

    assign diffPosX = targetPosX - ghostPosX;
    assign diffPosY = targetPosY - ghostPosY;

    logic shouldMoveU, shouldMoveR;

    assign shouldMoveU = diffPosY < 0;
    assign shouldMoveR = diffPosX > 0;

    always_comb begin
        case ({shouldMoveU, shouldMoveR})
            2'b00: begin
                if (canMoveD) begin
                    dirToMove = 2'd2;
                end else if (canMoveL) begin
                    dirToMove = 2'd3;
                end else if (canMoveU) begin
                    dirToMove = 2'd0;
                end else if (canMoveR) begin
                    dirToMove = 2'd2;
                end

            end

            2'b01: begin
                if (canMoveD) begin
                    dirToMove = 2'd2;
                end else if (canMoveR) begin
                    dirToMove = 2'd1;
                end else if (canMoveU) begin
                    dirToMove = 2'd0;
                end else if (canMoveL) begin
                    dirToMove = 2'd3;
                end

            end


            2'b10: begin
                if (canMoveU) begin
                    dirToMove = 2'd0;
                end else if (canMoveL) begin
                    dirToMove = 2'd3;
                end else if (canMoveD) begin
                    dirToMove = 2'd2;
                end else if (canMoveR) begin
                    dirToMove = 2'd1;
                end

            end


            2'b11: begin
                if (canMoveU) begin
                    dirToMove = 2'd0;
                end else if (canMoveR) begin
                    dirToMove = 2'd1;
                end else if (canMoveD) begin
                    dirToMove = 2'd2;
                end else if (canMoveL) begin
                    dirToMove = 2'd3;
                end

            end

        endcase


    end //always_comb
endmodule