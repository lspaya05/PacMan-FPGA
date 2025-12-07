
// there are 768 blocks in the game board
	// initial game board RAM has 768 addresses
		// each address is a block
		// each address holds info about what type of block it should be

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

	// For Clock Divider:
    parameter whichClock = 20;
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

	wire up;
    wire down;
    wire left;
    wire right;
    wire b1;

    wire latch;
    wire pulse;
    
    assign V_GPIO[27] = pulse;
    assign V_GPIO[26] = latch;
	logic start;
	logic select;

	n8_driver driver(
        .clk(CLOCK_50),
        .data_in(V_GPIO[28]),
        .latch(latch),
        .pulse(pulse),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .select(select),
        .start(start),
        .a(reset),
        .b(b1)
    );

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

//-------------------------------------------- Non-Driver Logic -----------------------------------
	logic [9:0] out_posPacman_next
	logic [3:0] data_fromPacman_next;
	// VGA read from:
	Board_RAM mem_board (.data(write_data), .rdaddress(block_y * 32 + block_x), .rdclock(CLOCK_50), .wraddress(write_addr), .wrclock(CLOCK_50), .wren(wren), .q(block_type));

	// gameLogic (PacmanNextLoc) Reads from:
	Board_RAM win_condition_board (.data(write_data), .rdaddress(out_posPacman_next), .rdclock(CLOCK_50), .wraddress(write_addr), .wrclock(CLOCK_50), .wren(wren), .q(data_fromPacman_next));

	// type_rom_address = block_type * 400 + (local_y * 20 + local_x)
	// output of type_rom is pixel color {r, g, b}
	type_rom mem_type (.address(block_type * 400 + (local_y * 20 + local_x)), .clock(CLOCK_50), .q({r, g, b})); 

	gameLogic gl (
    .clk(/*TODO*/), .reset,
    .pacInUp(up), .pacInDown(down), .pacInLeft(left), .pacInRight(right),
    .data_fromPacman_next,

    // For Win Condition:
    .out_posPacman_next,

    // Status Signals (from control) - Not Neccessary:
    //.ready, .userWon, .gameOver,

    // Logic for GameBoard:
    .data2Write(write_data),
    .writeAddr(write_addr),
    .writeEn(wren)
);  
	
	
endmodule  // DE1_SoC