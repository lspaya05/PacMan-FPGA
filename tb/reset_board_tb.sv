// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

`timescale 1 ps / 1 ps
module reset_board_tb ();
    
    logic clk, reset;
    logic hold;
    logic [9:0] overwrite_addr;
    logic [3:0] initial_data;

    parameter int CLOCK_DELAY = 50;

    reset_board dut (.*);

    //Sets up the clock 
    initial begin 
		clk <= 0;
		forever #(CLOCK_DELAY/2) clk <= ~clk;
	end //initial

    initial begin
        reset = 1;      @(posedge clk);
        reset = 0;      @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        $stop;
    end

endmodule