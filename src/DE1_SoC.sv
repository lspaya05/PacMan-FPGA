// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This is the top level module holding our logic that controls pacmans logic and interfaces with
//	the DE1_SOC, and the VGA display. No ghost logic, or game end logic has been implemented yet, 
//	but our current progress can be seen in the link below.

// VERSION: 0.0.1a
// LINK: https://github.com/lspaya05/PacMan-FPGA

// Inputs:
//		- CLOCK_50: 1 bit signal for the onboard FPGA Clock (50 MHZ).

//InOuts:
//		- V_GPIO : Virtual GPIO pins, pins [26] and [27] and [28] are used to interface with the
//				 controller addition.

// Outputs: 
//		- HEX 0-5: This is the signal bus for all the on board Hex displays. Displays 2-0 display
//					the word 'eat'
//		- LEDR: This is the output to the 10 onboard LEDs - This is not used in our game.
//		- VGA_R: 8 bit VGA signal to display a certain amount of red.
//		- VGA_G: 8 bit VGA signal to display a certain amount of green.
//		- VGA_B: 8 bit VGA signal to display a certain amount of blue.
//      - VGA_BLANK_N: 1 bit VGA signal sent by the provided VGA driver.
//	 	- VGA_CLK: 1 bit VGA signal sent by the provided VGA driver.
//		- VGA_HS: 1 bit VGA signal sent by the provided VGA driver.
//		- VGA_SYNC_N: 1 bit VGA signal sent by the provided VGA driver.
//		- VGA_VS: 1 bit VGA signal sent by the provided VGA driver.

import Seg7_pkg::*;
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, V_GPIO);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	inout [35:0] V_GPIO;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;

	// For Clock Divider: -------------------------------------------------------------------------
    parameter whichClock = 20;
	
    logic [31:0] clk;
	
	clock_divider cdiv (CLOCK_50, clk);
	// End Clock Divider --------------------------------------------------------------------------

	logic reset;
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
	
	video_driver #(.WIDTH(640), .HEIGHT(480)) v1 (
		.CLOCK_50, .reset(reset), .x, .y, .r, .g, .b,
		.VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
		.VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS
	); // video_driver
	
	// Hex Eat Assignment: 
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			HEX0 <= 7'b1111111;
		 	HEX1 <= 7'b1111111;
		 	HEX2 <= 7'b1111111;
		end else if (start) begin
			HEX0 <= T;
		 	HEX1 <= A;
		 	HEX2 <= E;
		end
	end

	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;

	logic up;
    logic down;
    logic left;
    logic right;
    logic b1;
	logic a1;

    logic latch;
    logic pulse;
    
    assign V_GPIO[27] = pulse;
    assign V_GPIO[26] = latch;
	logic start;

	n8_driver driver(
        .clk(CLOCK_50),
        .data_in(V_GPIO[28]),
        .latch(latch),
        .pulse(pulse),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .select(reset),
        .start(start),
        .a(a1),
        .b(b1)
    ); // n8_driver
// ------------------------------------------- Non Driver Logic------------------------------------ 
	// PacMan and ghosts locations
	logic [9:0] pac_loc;
	logic [9:0] pac_next;

	logic [4:0] block_x; // 0 through 31
	logic [4:0] block_y; // 0 through 23
	logic [4:0] local_x; // 0 through 19, for each pixel in the block
	logic [4:0] local_y; // 0 through 19, for each pixel in the block
	logic [3:0] block_type; // the type of block to draw

	logic wren;
	logic [3:0] write_data;
	logic [9:0] write_addr;

	assign block_x  = x / 20;        
	assign block_y  = y / 20;        
	assign local_x = x % 20;        
	assign local_y = y % 20;  

	// there are 768 blocks in the game board
	// initial game board RAM has 768 addresses
		// each address is a block
		// each address holds info about what type of block it should be
	Board_RAM mem_board (.data(write_data), .rdaddress(block_y * 32 + block_x), .rdclock(CLOCK_50),
						 .wraddress(write_addr), .wrclock(CLOCK_50), .wren(wren), .q(block_type));

	// type_rom_address = block_type * 400 + (local_y * 20 + local_x)
	// output of type_rom is pixel color {r, g, b}
	type_rom mem_type (.address(block_type * 400 + (local_y * 20 + local_x)), .clock(CLOCK_50), 
						.q({r, g, b})); 

	// module to determine the next location for pac to move
	pac_man_behavior pac (.clk(CLOCK_50), .reset(reset), .up(up), .down(down), .left(left), 
							.right(right), .curr_block(pac_loc), .next_block(pac_next), 
							.start(start));

	enum {idle, clear_old, draw_pac, update} ps, ns;

	always_comb begin
		case (ps) 
			idle: begin 
				if (pac_loc != pac_next) 
					ns = clear_old;
				else 
					ns = idle;
			end

			clear_old: 
				ns = draw_pac;

			draw_pac: 
				ns = update;

			update: 
				ns = idle;
		endcase
	end //always_comb

	always_ff @(posedge clk[whichClock]) begin
		if (reset) begin 
			ps <= idle;
		end else 
			ps <= ns;
	end //always_ff

	always_ff @(posedge clk[whichClock]) begin 
		if (reset) begin
			pac_loc <= 495;
			wren <= 0;
		end

		if (start) begin
			pac_loc <= 495;
			wren <= 0;
		end

		if (ps == idle) begin
			wren <= 0;
		end

		if (ps == clear_old) begin
			wren <= 1;
			write_data <= 4'b0000;
			write_addr <= pac_loc;
		end

		if (ps == draw_pac) begin
			wren <= 1;
			write_data <= 4'b0011;
			write_addr <= pac_next;
		end

		if (ps == update) begin
			pac_loc <= pac_next;
			wren <= 0;
		end
	end //always_ff
	
endmodule  // DE1_SoC