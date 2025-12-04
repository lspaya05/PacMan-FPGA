// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module pac_man_behavior_tb ();
    
    logic clk, reset;
    logic up, down, left, right;
    logic [9:0] curr_block;
    logic [9:0] next_block;
    parameter int CLOCK_DELAY = 50;

    pac_man_behavior dut (.*);

    //Sets up the clock 
    initial begin 
		clk <= 0;
		forever #(CLOCK_DELAY/2) clk <= ~clk;
	end //initial

    initial begin
        reset = 1;                                     @(posedge clk);
        reset = 0;      curr_block = 495;                               @(posedge clk);
        up = 1; down = 0; left = 0; right = 0;         @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        up = 0; down = 0; left = 0; right = 1;         @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        $stop;
    end

endmodule