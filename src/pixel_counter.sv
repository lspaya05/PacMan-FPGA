// continuously iterates through all pixels (x and y values) in the VGA display

module pixel_counter (clk, reset, x, y);
	input logic clk, reset;
	output logic [9:0] x;
	output logic [8:0] y;

	always_ff @(posedge clk) begin 
		if (reset) begin
			x <= 0;
			y <= 0;
		end else begin
			if (x == 639) begin
				x <= 0;
				if (y == 479)
					y <= 0; // start from the beginning (0, 0)
				else
					y <= y + 1;
			end else begin
				x <= x + 1;
			end
		end
	end 

endmodule  // pixel_counter


