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
module romFile #(
    parameter int DATA_WIDTH = 22, 
    parameter int ADDR_WIDTH = 5,
    parameter int NUM_READ = 17
) (
    input logic [ADDR_WIDTH - 1 : 0] r_addr [NUM_READ - 1 : 0],
	output logic [DATA_WIDTH - 1 : 0] r_data [NUM_READ - 1 : 0]
);
    // The D Flip Flops:
    logic [DATA_WIDTH - 1 : 0] mem [0:2**ADDR_WIDTH-1];
    
    int i;
    
    // Memory for the valid position ROM.
    initial begin
        mem[0] = 22'b1111111111111111111111;
        mem[1] = 22'b1000000000110000000001;
        mem[2] = 22'b1011110110110110101011;
        mem[3] = 22'b1010000110110110101011;
        mem[4] = 22'b1010110000000000101011;
        mem[5] = 22'b1010010111111110100001;
        mem[6] = 22'b1011110000000000111101;
        mem[7] = 22'b1000000111001110000001;
        mem[8] = 22'b1010110100000010110101;
        mem[9] = 22'b0010010100000010100100;
        mem[10] = 22'b1010110100000010110101;
        mem[11] = 22'b1000000111111110000001;
        mem[12] = 22'b1010100000000000111101;
        mem[13] = 22'b1010101111011010100001;
        mem[14] = 22'b1011101000011010111011;
        mem[15] = 22'b1010101011011010100001;
        mem[16] = 22'b1010100011011010101111;
        mem[17] = 22'b1000001000000000000001;
        mem[18] = 22'b1111111111111111111111;
    end 
    
    // Read Data (Ends up being a bunch of Muxes): 
    always_comb begin : ReadLogic
        for (i = 0; i < NUM_READ; i++) begin
            r_data[i] = mem[r_addr[i]];
        end 
    end

endmodule