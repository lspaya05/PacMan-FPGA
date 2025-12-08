// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This is a testbench for a romFile that contains all possible locations pacman can possibly move. 
// The testbench tests all possible address inputs to ensure the romFile outputs the correct value
// for each input.

// Input: 
//      - clk: 1 bit clock signal.
//      - r_addr: an 5 bit signal that represets the address in the rom we want to read a row from.
// Outputs:
//      - r_data: an 32 bit signal that holds all valid positions in a certain row.

module romFile_pac_tb ();

    logic clk;
    logic [5 - 1 : 0] r_addr;
	logic [32 - 1 : 0] r_data;
    parameter int CLOCK_DELAY = 50;

    //Sets up the clock 
    initial begin 
		clk <= 0;
		forever #(CLOCK_DELAY/2) clk <= ~clk;
	end //initial

    romFile_pac dut (.*);

    int i;
    initial begin
        for (i = 0; i < 25; i++) begin
            r_addr = i; @(posedge clk);
        end
        @(posedge clk);
        $stop;
    end // initial

endmodule //romFile_pac_tb