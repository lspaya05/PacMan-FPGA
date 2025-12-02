// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// implement done signal
module pac_man_behavior (clk, reset, up, down, left, right, canMove, curr_block, temp_next, next_block, initial_block);
    
    input logic clk, reset;
    input logic up, down, left, right, canMove;
    input logic [9:0] curr_block;
    input logic [9:0] initial_block;
    output logic [9:0] next_block;
    output logic [9:0] temp_next;

    always_comb begin
        // default, if up, down, left, right are all low, stay in the same place
        temp_next = curr_block;

        case ({up, down, left, right})
            2'b0001: 
                temp_block = curr_block + 1;
            2'b0010: 
                temp_block = curr_block - 1;
            2'b0100: 
                temp_block = curr_block + 32;
            2'b1000: 
                temp_block = curr_block - 32;
        endcase
    end


    always_ff @(posedge clk) begin
        if (reset) next_block <= initial_block;

        else begin
            if (canMove)
                next_block <= temp_next;
        end
    end 

endmodule