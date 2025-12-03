module ghostNextLoc(
    input logic [9:0] currPos, targetPos,
    input logic [21 : 0] surroundingContainBlock [3:0];
    output logic [4:0] surroundingBlockAddr [3:0];
    output logic [9:0] next_block,
);

    logic [ : 0] ghostPosX;
    logic [ : 0] ghostPosY;
    logic [ : 0] targetPosX;
    logic [ : 0] targetPosY;

    assign ghostPosX = 
    assign ghostPosY = 
    assign targetPosX = 
    assign targetPosY = 

    logic signed [ : 0] diffPosX;
    logic signed [ : 0] diffPosY;

    assign diffPosX = targetPosX - ghostPosX;
    assign diffPosY = targetPosY - ghostPosY;

    logic shouldMoveU, shouldMoveR;

    assign shouldMoveU = diffPosY < 0;
    assign shouldMoveR = diffPosX > 0;

    // Valid next Position Logic.
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