
module ghostNextLoc_tb();
    logic clk, reset, start, done, ready;
    logic [9:0] currPos, targetPos;
    logic [9:0] nextPos;
    logic [4:0] ghostPosX, ghostPosY;

    ghostNextLoc dut (.*);
    
    int CLOCK_DELAY = 200;
    //Sets up the clock 
    initial begin 
		clk <= 0;
		forever #(CLOCK_DELAY/2) clk <= ~clk;
	end //initial

    int i;
    initial begin
        reset = 1; @(posedge clk);
        for (i = 134; i < 153; i++) begin
            reset = 0;
            currPos = i; targetPos = 10'd646; start = 1; @(posedge clk);
                                                             @(posedge clk);
                                                             @(posedge clk);
                                                             @(posedge clk);
                                                             @(posedge clk);
            start = 0;                                       @(posedge clk);
        end 

        $stop;
    end //initial
endmodule