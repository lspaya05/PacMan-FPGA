module update_pac (clk1, clk2, reset, start, up, down, left, right, write_data, write_addr, wren);
	input logic clk1, clk2, reset, start, up, down, left, right;
	output logic [3:0] write_data;
	output logic [9:0] write_addr;
	output logic wren;
	logic [9:0] pac_loc;
	logic [9:0] pac_next;

	// slower clock?
	pac_man_behavior pac (.clk(clk2), .reset(reset), .up(up), .down(down), .left(left), .right(right), 
							.curr_block(pac_loc), .next_block(pac_next), .start(start));

	logic ghost_eats_pac;
	// implement logic where ghost and pac are in same block
	// assign ghost_eats_pac = 

	enum {idle, clear_old, draw_pac, update} ps, ns;

	always_comb begin
		case (ps) 
			idle: if (pac_next != pac_loc) ns = clear_old;
					else ns = idle;
			clear_old: 
				ns = draw_pac;
			draw_pac: ns = update;
			update: 
				ns = idle;
		endcase
	end 

	always_ff @(posedge clk1) begin
		if (reset) begin 
			ps <= idle;
		end
		else ps <= ns;
	end

	always_ff @(posedge clk1) begin 
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
			wren <= 0;
			pac_loc <= pac_next;
		end
	end
	
endmodule  // DE1_SoC