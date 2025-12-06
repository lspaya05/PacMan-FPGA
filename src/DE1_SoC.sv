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
	Board_RAM mem_board (.data(write_data), .rdaddress(block_y * 32 + block_x), .rdclock(CLOCK_50), .wraddress(write_addr), .wrclock(CLOCK_50), .wren(wren), .q(block_type));

	// type_rom_address = block_type * 400 + (local_y * 20 + local_x)
	// output of type_rom is pixel color {r, g, b}
	type_rom mem_type (.address(block_type * 400 + (local_y * 20 + local_x)), .clock(CLOCK_50), .q({r, g, b})); 

	// slower clock?
	pac_man_behavior pac (.clk(CLOCK_50), .reset(reset), .up(up), .down(down), .left(left), .right(right), 
							.curr_block(pac_loc), .next_block(pac_next), .start(start));

	logic ghost_eats_pac;
	// implement logic where ghost and pac are in same block
	// assign ghost_eats_pac = 

	enum {idle, clear_old, draw_pac, update} ps, ns;

	assign LEDR[0] = reset;
	assign LEDR[1] = start;
	assign LEDR[2] = (pac_loc != pac_next);
	assign LEDR[3] = pac_loc[2];
	assign LEDR[4] = pac_loc[1];
	assign LEDR[5] = pac_loc[0];

	always_comb begin
		case (ps) 
			idle: if (pac_loc != pac_next) ns = clear_old;
					else ns = idle;
			clear_old: 
				ns = draw_pac;
			draw_pac: ns = update;
			update: 
				ns = idle;
		endcase
	end 

	always_ff @(posedge clk[whichClock]) begin
		if (reset) begin 
			ps <= idle;
		end
		else ps <= ns;
	end

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
	end
	
endmodule  // DE1_SoC