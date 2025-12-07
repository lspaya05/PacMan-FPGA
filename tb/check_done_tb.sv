// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

`timescale 1 ps / 1 ps
module check_done_tb ();
    
    logic clk, reset;
    logic [9:0] read_addr;
    logic [3:0] read_data;
    logic game_over;
    parameter int CLOCK_DELAY = 50;

    check_done dut (.*);

    //Sets up the clock 
    initial begin 
		clk <= 0;
		forever #(CLOCK_DELAY/2) clk <= ~clk;
	end //initial

    initial begin
        reset = 1;      @(posedge clk);
        reset = 0;      @(posedge clk);
        read_addr = 764;   read_data = 0; @(posedge clk);
        read_addr = 765;   read_data = 2; @(posedge clk);
        read_addr = 766;   read_data = 0; @(posedge clk);
        read_addr = 767;   read_data = 0; @(posedge clk);
        read_addr = 768;   read_data = 0; @(posedge clk);
        read_addr = 0;   read_data = 0; @(posedge clk);

        $stop;
    end

endmodule