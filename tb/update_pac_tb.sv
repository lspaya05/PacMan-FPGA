// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module update_pac_tb ();
    
    logic clk, reset, start;
    logic up, down, left, right;
    logic [9:0] write_addr;
    logic [3:0] write_data;
    logic wren;
    parameter int CLOCK_DELAY = 50;

    update_pac dut (.*);

    //Sets up the clock 
    initial begin 
		clk <= 0;
		forever #(CLOCK_DELAY/2) clk <= ~clk;
	end //initial

    initial begin
        reset = 1;                                     @(posedge clk);
        start = 1;
        reset = 0;                                   @(posedge clk);
        start = 0;
        up = 1; down = 0; left = 0; right = 0;         @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        up = 0; down = 0; left = 0; right = 1;         @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 

        $stop;
    end

endmodule