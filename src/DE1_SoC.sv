module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, V_GPIO);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
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

	logic reset;
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
	
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign reset = 0;

	wire up;
    wire down;
    wire left;
    wire right;
    wire a;
    wire b;

    wire latch;
    wire pulse;
    
    assign V_GPIO[27] = pulse;
    assign V_GPIO[26] = latch;

	n8_driver driver(
        .clk(CLOCK_50),
        .data_in(V_GPIO[28]),
        .latch(latch),
        .pulse(pulse),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .select(LEDR[9]),
        .start(LEDR[8]),
        .a(a),
        .b(b)
    );

	// PacMan and ghosts locations
	logic [9:0] pac_loc;
	logic [9:0] blinky_loc;
	logic [9:0] clyde_loc;
	logic [9:0] inky_loc;
	logic [9:0] pinky_loc;
	logic [9:0] pac_next;
	logic [9:0] blinky_next;
	logic [9:0] clyde_next;
	logic [9:0] inky_next;
	logic [9:0] pinky_next;

	// AND pac with all the ghosts, if any are true, end game

	logic [4:0] block_x; // 0 through 31
	logic [4:0] block_y; // 0 through 23
	logic [4:0] local_x; // 0 through 19, for each pixel in the block
	logic [4:0] local_y; // 0 through 19, for each pixel in the block
	logic [3:0] block_type; // the type of block to draw

	assign block_x  = x / 20;        
	assign block_y  = y / 20;        
	assign local_x = x % 20;        
	assign local_y = y % 20;  

	// there are 768 blocks in the game board
	// initial game board RAM has 768 addresses
		// each address is a block
		// each address holds info about what type of block it should be
	board_RAM mem_board (.address(block_y * 32 + block_x), .clock(CLOCK_50), .data(1'b0), .wren(1'b0), .q(block_type));

	// type_rom_address = block_type * 400 + (local_y * 20 + local_x)
	// output of type_rom is pixel color {r, g, b}
	type_rom mem_type (.address(block_type * 400 + (local_y * 20 + local_x)), .clock(CLOCK_50), .q({r, g, b})); 

	pac_man_behavior pac (.clk(CLOCK_50), .reset(reset), .up(up), .down(down), .left(left), .right(right), .canMove(), 
							.curr_block(pac_loc), .temp_next(pac_temp_next), .next_block(pac_next), .initial_block());

	enum {update_pac, update_blinky, update_clyde, update_inky, update_pinky} ps, ns;

	always_comb begin
		case (ps)
			update_pac: begin
				ns <= update_blinky;
				writeAddress <= pac_loc;
			end 
			update_blinky: begin
				ns <= update_clyde;
				writeAddress <= blinky_loc;
			end 
			update_clyde: begin
				ns <= update_inky;
				writeAddress <= clyde_loc;
			end 
			update_inky: begin
				ns <= update_pinky;
				writeAddress <= inky_loc;
			end 
			update_pinky: begin
				ns <= update_pac;
				writeAddress <= pinky_loc;
			end 
		endcase
	end 

	always_ff @(posedge CLOCK_50) begin
		if (reset) ps <= update_pac;
		else ps <= ns;
	end

	// use enabled dff (if ALL are done, the update)
	always_ff @(posedge clk) begin
		if (reset) 
		else begin
			pac_loc <= pac_next;
			blinky_loc <= blinky_next;
			clyde_loc <= clyde_next;
			inky_loc <= inky_next;
			pinky_loc <= pinky_next;
		end
	end
	
	
endmodule  // DE1_SoC


`timescale 1 ps / 1 ps
module DE1_SoC_testbench ();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR, SW;
	logic [3:0] KEY;
	logic CLOCK_50;
	logic [7:0] VGA_R, VGA_G, VGA_B;
	logic VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;
	
	// instantiate module
	DE1_SoC dut (.*);
	
	// create simulated clock
	parameter T = 20;
	initial begin
		CLOCK_50 <= 0;
		forever #(T/2) CLOCK_50 <= ~CLOCK_50;
	end  // clock initial
	
	// simulated inputs
	initial begin
		
		$stop();
	end  // inputs initial
	
endmodule  // DE1_SoC_testbench

