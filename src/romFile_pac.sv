// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// This a romFile that contains all possible locations pacman can possibly move. Any coordinates
//      with the value one means that pacman cannot move there. This ROM file has a single read
//      port, where an entire rows data is valid at the next positive edge of the clock.

// Input: 
//      - clk: 1 bit clock signal.
//      - r_addr: an 5 bit signal that represets the address in the rom we want to read a row from.
// Outputs:
//      - r_data: an 32 bit signal that holds all valid positions in a certain row.

module romFile_pac (
    input logic clk,
    input logic [5 - 1 : 0] r_addr,
	output logic [32 - 1 : 0] r_data
);
    // The D Flip Flops:
    logic [32 - 1 : 0] mem [0:2**(5) - 1];
        
    // Memory for the valid position ROM.
    initial begin
        mem[0] = 32'b11111111111111111111111111111111;
        mem[1] = 32'b11111111111111111111111111111111;
        mem[2] = 32'b11111111111111111111111111111111;
        mem[3] = 32'b11111111111111111111111111111111;
        mem[4] = 32'b11111100000000011000000000111111;
        mem[5] = 32'b11111101111011011011010101111111;
        mem[6] = 32'b11111101000011011011010101111111;
        mem[7] = 32'b11111101011000000000010101111111;
        mem[8] = 32'b11111101001011111111010000111111;
        mem[9] = 32'b11111101111000000000011110111111;
        mem[10] = 32'b11111100000011100111000000111111;
        mem[11] = 32'b11111101011010000001011010111111;
        mem[12] = 32'b11111001001010000001010010011111;
        mem[13] = 32'b11111101011010000001011010111111;
        mem[14] = 32'b11111100000011111111000000111111;
        mem[15] = 32'b11111101010000000000011110111111;
        mem[16] = 32'b11111101010111101101010000111111;
        mem[17] = 32'b11111101110100001101011101111111;
        mem[18] = 32'b11111101010101101101010000111111;
        mem[19] = 32'b11111101010001101101010111111111;
        mem[20] = 32'b11111100000100000000000000111111;
        mem[21] = 32'b11111111111111111111111111111111;
        mem[22] = 32'b11111111111111111111111111111111;
        mem[23] = 32'b11111111111111111111111111111111;
    end // initial
    
    // Read Data (Ends up being a bunch of Muxes): 
    always_ff @(posedge clk) begin
        r_data <= mem[r_addr];
    end // always_ff

endmodule //romFile_pac