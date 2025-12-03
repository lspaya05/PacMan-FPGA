module ghostNextLoc(
    input logic [9:0] currPos, targetPos,
    input logic [21 : 0] surroundingContainBlock [3:0];
    output logic [4:0] surroundingBlockAddr [3:0];
    output logic [9:0] nextPos,
);
    // Translate Addr into XY Coordinates:
    logic [ : 0] ghostPosX;
    logic [ : 0] ghostPosY;
    logic [ : 0] targetPosX;
    logic [ : 0] targetPosY;

    assign ghostPosX = 
    assign ghostPosY = 
    assign targetPosX = 
    assign targetPosY = 

    // Find the difference in the Coordinates
    logic signed [ : 0] diffPosX;
    logic signed [ : 0] diffPosY;

    assign diffPosX = targetPosX - ghostPosX;
    assign diffPosY = targetPosY - ghostPosY;

    // Determine which direction to move:
    logic shouldMoveU, shouldMoveR;

    assign shouldMoveU = diffPosY < 0;
    assign shouldMoveR = diffPosX > 0;

    // Determine the direction the character can move in.
    logic posUp, posRight, posDown, posLeft;

    assign posUp = (targetPos - 22);
    assign posRight = (targetPos + 1);
    assign posDown = (targetPos + 22);
    assign posLeft = (targetPos - 1);

    assign surroundingBlockAddr[0] = posUp / 22;
    assign surroundingBlockAddr[1] = posRight / 22;
    assign surroundingBlockAddr[2] = posDown / 22;
    assign surroundingBlockAddr[3] = posLeft / 22;

    logic canMoveD, canMoveL, canMoveR, canMoveU;

    assign canMoveD = !(surroundingContainBlock[2][posDown % 22]);
    assign canMoveL = !(surroundingContainBlock[3][posLeft % 22]);
    assign canMoveR = !(surroundingContainBlock[1][posRight % 22]);
    assign canMoveU = !(surroundingContainBlock[0][posUp % 22]);

    // Valid next Position Logic.
    always_comb begin
        case ({shouldMoveU, shouldMoveR})
            2'b00: begin
                if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveL) begin
                    nextPos = posLeft;;
                end else if (canMoveU) begin
                    nextPos = posUp;;
                end else if (canMoveR) begin
                    nextPos = posRight;;
                end

            end

            2'b01: begin
                if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveR) begin
                    nextPos = posRight;;
                end else if (canMoveU) begin
                    nextPos = posUp;;
                end else if (canMoveL) begin
                    nextPos = posLeft;;
                end

            end


            2'b10: begin
                if (canMoveU) begin
                    nextPos = posUp;;
                end else if (canMoveL) begin
                    nextPos = posLeft;;
                end else if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveR) begin
                    nextPos = posRight;;
                end

            end


            2'b11: begin
                if (canMoveU) begin
                    nextPos = posUp;;
                end else if (canMoveR) begin
                    nextPos = posRight;;
                end else if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveL) begin
                    nextPos = posLeft;;
                end

            end

        endcase
    end //always_comb
endmodule