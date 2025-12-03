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

module romFile_tb();
    parameter int DATA_WIDTH = 22;
    parameter int ADDR_WIDTH = 5;
    parameter int NUM_READ = 4;

    logic [ADDR_WIDTH - 1 : 0] r_addr [NUM_READ - 1 : 0];
	logic [DATA_WIDTH - 1 : 0] r_data [NUM_READ - 1 : 0];

    romFile #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .NUM_READ(NUM_READ)) validSpaces (.*);

    int i;
    initial begin
        for (i = 0; i < 32; i++) begin
            r_addr[0] = i;
            r_addr[1] = i - 1;
            r_addr[2] = i + 2;
            r_addr[3] = i;
            #50;
        end
    end 
endmodule