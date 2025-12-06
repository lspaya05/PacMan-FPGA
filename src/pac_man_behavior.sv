// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// implement done signal
module pac_man_behavior (clk, reset, up, down, left, right, curr_block, next_block, start);
    
    input logic clk, reset, start;
    input logic up, down, left, right;
    input logic [9:0] curr_block;
    output logic [9:0] next_block;
    logic [9:0] temp_next;
    logic [4:0] temp_block_addr;
    logic [31:0] data_from_rom;
    logic canMove;

    // combinational logic to determine if the next block is valid
    assign temp_block_addr = temp_next / 32;
    assign canMove = !(data_from_rom[31 - (temp_next % 32)]);

    romFile_pac #(.DATA_WIDTH(32), .ADDR_WIDTH(5)) validSpace (.clk(clk), .r_addr(temp_block_addr), .r_data(data_from_rom));

    always_comb begin
        // default, if up, down, left, right are all low, stay in the same place
        temp_next = curr_block;

        case ({up, down, left, right})
            4'b0001: 
                temp_next = curr_block + 1;
            4'b0010: 
                temp_next = curr_block - 1;
            4'b0100: 
                temp_next = curr_block + 32;
            4'b1000: 
                temp_next = curr_block - 32;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset) next_block <= 495;
        else if (start) next_block <= 495;
        else begin
            if (canMove)
                next_block <= temp_next;
            else
                next_block <= next_block;
        end
    end 

endmodule