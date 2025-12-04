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

	//For Clock Divider:
    parameter whichClock = 15;
	// set up clock 
    logic [31:0] clk;
	clock_divider cdiv (CLOCK_50, clk);

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
    wire a1;
    wire b1;

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
        .a(a1),
        .b(b1)
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

	logic [4:0] block_x; // 0 through 31
	logic [4:0] block_y; // 0 through 23
	logic [4:0] local_x; // 0 through 19, for each pixel in the block
	logic [4:0] local_y; // 0 through 19, for each pixel in the block
	logic [3:0] block_type; // the type of block to draw

	logic wren;
	logic write_data;
	logic [9:0] write_addr;

	// for debugging
	assign LEDR[0] = wren;

	assign block_x  = x / 20;        
	assign block_y  = y / 20;        
	assign local_x = x % 20;        
	assign local_y = y % 20;  
	assign write_addr = block_y * 32 + block_x;

	// there are 768 blocks in the game board
	// initial game board RAM has 768 addresses
		// each address is a block
		// each address holds info about what type of block it should be
	board_RAM mem_board (.address(block_y * 32 + block_x), .clock(CLOCK_50), .data(write_data), .wren(wren), .q(block_type));

	// type_rom_address = block_type * 400 + (local_y * 20 + local_x)
	// output of type_rom is pixel color {r, g, b}
	type_rom mem_type (.address(block_type * 400 + (local_y * 20 + local_x)), .clock(CLOCK_50), .q({r, g, b})); 

	// slower clock?
	pac_man_behavior pac (.clk(CLOCK_50), .reset(reset), .up(up), .down(down), .left(left), .right(right), 
							.curr_block(pac_loc), .next_block(pac_next));

	logic ghost_eats_pac;
	// implement logic where ghost and pac are in same block
	// assign ghost_eats_pac = 

	// will probably need to implement done signal
	always_ff @(posedge CLOCK_50) begin
		if (ghost_eats_pac) begin
			// somehow reset
			wren <= 0;
		end
		//else if (done) begin
		else if (write_addr == pac_next - 1) begin
				wren <= 1;
				write_data <= 4'b0011;
			end else if (write_addr == pac_loc - 1) begin
				wren <= 1;
				write_data <= 4'b0000; // overwrite prev pac location with black
			end
			// else if ghosts
			else wren <= 0;
	end

	
	
	
endmodule  // DE1_SoC




