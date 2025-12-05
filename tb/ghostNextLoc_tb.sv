
module ghostNextLoc_tb();

    logic [9:0] currPos, targetPos;
    logic [31:0] surroundingContainBlock [3:0];
    logic [3:0] surroundingBlockAddr [3:0];
    logic [9:0] nextPos;
    logic [:0] ghostPosX, ghostPosY;

    ghostNextLoc dut (.*);

    romFile dut (.*);

    initial begin
        currPos = 134; targetPos = 665; #50;
        currPos = 20; targetPos = 78; #50;
        currPos = 20; targetPos = 78; #50;
        currPos = 20; targetPos = 78; #50;
        currPos = 20; targetPos = 78; #50;


    end
endmodule