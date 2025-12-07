// Name: Leonard Paya
// Date: 11/28/2025

// TODO
// Parameters: 
//      - DATA_WIDTH: Represents the number of data bits stored in each address.
//      - ADDR_WIDTH: The number of address bits. Correlates to word size when this number is
//          the exponent to the number 2.
//      - NUM_READ: Number of read data ports the register file has.
// Inputs:
//      - r_addr: NUM_WRITE number of read addresses, each with ADDR_WIDTH number of bits.
//              Read addresses to read data from.

// Output:
//      - r_data: NUM_READ number of data read signals, each with DATA_WIDTH number of bits.
//              Data to read from the register file.
module romFile_ghost #(
    parameter int DATA_WIDTH = 32, 
    parameter int ADDR_WIDTH = 5
) (
    input logic clk,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_up,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_down,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_left,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_right,

	output logic [DATA_WIDTH - 1 : 0] r_data_up,
    output logic [DATA_WIDTH - 1 : 0] r_data_down,
	output logic [DATA_WIDTH - 1 : 0] r_data_left,
	output logic [DATA_WIDTH - 1 : 0] r_data_right
);
    // The D Flip Flops:
    logic [DATA_WIDTH - 1 : 0] mem [0:2**ADDR_WIDTH-1];
    
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
    end 

    // Read Data (Ends up being a bunch of Muxes): 
    always_ff @(posedge clk) begin
        r_data_up <= mem[r_addr_up];
        r_data_down <= mem[r_addr_down];
        r_data_left <= mem[r_addr_left];
        r_data_right <= mem[r_addr_right]; 
    end

endmodule