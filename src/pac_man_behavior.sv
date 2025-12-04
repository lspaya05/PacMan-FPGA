// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// implement done signal
module pac_man_behavior (clk, reset, up, down, left, right, curr_block, next_block);
    
    input logic clk, reset;
    input logic up, down, left, right;
    input logic [9:0] curr_block;
    output logic [9:0] next_block;
    logic temp_next;
    logic [4:0] temp_block_addr [0:0];
    logic [31:0] data_from_rom [0:0];
    logic canMove;

    // combinational logic to determine if the next block is valid
    assign temp_block_addr[0] = temp_next / 32;
    assign canMove = !(data_from_rom[0] % 32);

    romFile #(.DATA_WIDTH(32), .ADDR_WIDTH(5), .NUM_READ(1)) validSpace (.r_addr(temp_block_addr), .r_data(data_from_rom));

    always_comb begin
        // default, if up, down, left, right are all low, stay in the same place
        temp_next = curr_block;

        case ({up, down, left, right})
            2'b0001: 
                temp_next = curr_block + 1;
            2'b0010: 
                temp_next = curr_block - 1;
            2'b0100: 
                temp_next = curr_block + 32;
            2'b1000: 
                temp_next = curr_block - 32;
        endcase
    end


    always_ff @(posedge clk) begin
        if (reset) next_block <= 495;

        else begin
            if (canMove)
                next_block <= temp_next;
        end
    end 

endmodule