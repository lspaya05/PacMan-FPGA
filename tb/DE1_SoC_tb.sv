// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

`timescale 1 ps / 1 ps
module DE1_SoC_tb ();
    
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [35:0] V_GPIO;

	logic CLOCK_50;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;
    parameter int CLOCK_DELAY = 50;

    DE1_SoC dut (.*);

    //Sets up the clock 
    initial begin 
		CLOCK_50 <= 0;
		forever #(CLOCK_DELAY/2) CLOCK_50 <= ~CLOCK_50;
	end //initial

    initial begin
                                         @(posedge CLOCK_50);
        repeat (1000) @(posedge CLOCK_50)

        $stop;
    end

endmodule