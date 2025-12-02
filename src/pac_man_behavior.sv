// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

// we can probs use this module for the ghost behavior too
module pac_man_behavior (clk, reset, up, down, left, right, curr_block, next_block, initial_block);
    
    input logic clk, reset;
    input logic up, down, left, right;
    input logic [9:0] curr_block;
    input logic [9:0] initial_block;
    output logic [9:0] next_block;
    logic temp_next;

    // to move right: +1
    // to move left: -1
    // to move up: -32
    // to move down: +32
    always_comb begin
        // default, if up, down, left, right are all low, stay in the same place
        temp_block = curr_block;
        
    end


    always_ff @(posedge clk) begin
        if (reset) next_block <= initial_block;

        else begin
            next_block <= temp_next;
        end
    end 

endmodule