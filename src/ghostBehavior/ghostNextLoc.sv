module ghostNextLoc(
    input logic clk, reset, start,
    input logic [9:0] currPos, targetPos,
    output logic [9:0] nextPos, 
    output logic done, ready,
    
    // Does not need to be used for every Ghost implementation.
    output logic [4:0] ghostPosX,
    output logic [4:0] ghostPosY
);

    logic [4:0] targetPosX;
    logic [4:0] targetPosY;
    
    // Translate Addr into XY Coordinates.
    assign ghostPosX = currPos % 32;
    assign ghostPosY = currPos / 32;
    assign targetPosX = targetPos % 32;
    assign targetPosY = targetPos / 32;

    // Find the difference in the Coordinates
    logic signed [5:0] diffPosX;
    logic signed [5:0] diffPosY;

    assign diffPosX = targetPosX - ghostPosX;
    assign diffPosY = targetPosY - ghostPosY;

    // Determine which direction to move:
    logic shouldMoveU, shouldMoveR;

    assign shouldMoveU = diffPosY < 0;
    assign shouldMoveR = diffPosX > 0;

// ------------------------------------ LOGIC FOR PULLING ADDR-------------------------------------

    // Determine the direction the character can move in.
    logic [10:0] posUp, posRight, posDown, posLeft;
    logic [31:0] posUp_data, posRight_data, posDown_data, posLeft_data;
    logic [4:0] posUp_addr, posRight_addr, posDown_addr, posLeft_addr;

    // These are the addresses for the positions:
    assign posUp = (currPos - 32);
    assign posRight = (currPos + 1);
    assign posDown = (currPos + 32);
    assign posLeft = (currPos - 1);
    // Find the Row that contains the data we want.
    assign posUp_addr = posUp / 32;
    assign posRight_addr = posRight / 32;
    assign posDown_addr = posDown / 32;
    assign posLeft_addr = posLeft / 32;

    // Logic to determine possible positions to move too 
    logic canMoveD, canMoveL, canMoveR, canMoveU;
    logic done_pullGhostData;

    pullGhostData gdata (
        .r_addr_up(posUp_addr), .r_data_up(posUp_data), 
        .r_addr_down(posDown_addr), .r_data_down(posDown_data), 
        .r_addr_left(posLeft_addr), .r_data_left(posLeft_data), 
        .r_addr_right(posRight_addr), .r_data_right(posRight_data),
        .start, .ready, .done(done_pullGhostData), .clk, .reset
    );

    //delay done signal by one so that the combinational logic from this module works.
    always_ff @(posedge clk) begin
        done <= done_pullGhostData;
    end // always_ff

    // Positions the ghost can move in.
    assign canMoveD = !(posDown_data [31 - posDown % 32]);
    assign canMoveL = !(posLeft_data [31 - posLeft % 32]);
    assign canMoveR = !(posRight_data [31 - posRight % 32]);
    assign canMoveU = !(posUp_data [31 - posUp % 32]);

// -------------------------------- END OF LOGIC FOR PULLING ADDR ---------------------------------
    // Valid next Position Logic.
    always_comb begin
        case ({shouldMoveU, shouldMoveR})
            2'b00: begin
                if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveL) begin
                    nextPos = posLeft;
                end else if (canMoveU) begin
                    nextPos = posUp;;
                end else if (canMoveR) begin
                    nextPos = posRight;
                end
            end

            2'b01: begin
                if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveR) begin
                    nextPos = posRight;
                end else if (canMoveU) begin
                    nextPos = posUp;
                end else if (canMoveL) begin
                    nextPos = posLeft;
                end
            end


            2'b10: begin
                if (canMoveU) begin
                    nextPos = posUp;
                end else if (canMoveL) begin
                    nextPos = posLeft;
                end else if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveR) begin
                    nextPos = posRight;
                end
            end

            2'b11: begin
                if (canMoveU) begin
                    nextPos = posUp;;
                end else if (canMoveR) begin
                    nextPos = posRight;
                end else if (canMoveD) begin
                    nextPos = posDown;
                end else if (canMoveL) begin
                    nextPos = posLeft;
                end
            end

        endcase
    end //always_comb
endmodule