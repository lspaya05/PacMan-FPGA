// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

module gameLogic_tb ();
    parameter int CLOCK_PERIOD = 50;

    logic clk, reset,
    logic pacInUp, pacInDown, pacInLeft, pacInRight,
    logic [3:0] data_fromPacman_next,

    // For Win Condition:
    logic [9:0] out_posPacman_next,
    // Status Signals (from control):
    logic ready, userWon, gameOver,

    // Logic for GameBoard:
    logic [3:0] data2Write,
    logic [9:0] writeAddr,
    logic writeEn,

    gameLogic dut (.*);

    //Sets up the clock 
    initial begin 
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end //initial

    initial begin
                                         @(posedge CLOCK_50);
        repeat (1000) @(posedge CLOCK_50)

        $stop;
    end

endmodule