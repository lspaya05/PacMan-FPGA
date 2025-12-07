// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371

//  This module represents an FSM that determines if pacman can move to a new neighboring coordinate.
//      it takes a variable amount of clock cycle till the next allowed position for pacman is valid.

// Inputs:
//      - clk: 1 bit clock signal.
//      - reset: 1 bit reset signal.
//      - start: 1 bit start FSM signal.
//      - up: 1-bit signal from controler to move pacman up.
//      - down: 1-bit signal from controler to move pacman down.
//      - left: 1-bit signal from controler to move pacman left.
//      - right: 1-bit signal from controler to move pacman right.
//      - curr_block: This is a 10 bit address that should be connected to the register, that 
//                      holds pacmans current location in address.
// Outputs: 
//      - next_block: This is a 10 bit address that outputs the next location that pacman should
//                      be moved to.

module pac_man_behavior (clk, reset, up, down, left, right, curr_block, next_block, start);
    
    input logic clk, reset, start;
    input logic up, down, left, right;
    input logic [9:0] curr_block;
    output logic [9:0] next_block;

    logic [9:0] temp_next;
    logic [4:0] temp_block_addr;
    logic [31:0] data_from_rom;
    logic canMove;
    logic [9:0] temp_next_reg;
    logic [9:0] curr_block_reg;

    // combinational logic to determine if the next block is valid
    assign temp_block_addr = temp_next_reg / 32;
    assign canMove = !(data_from_rom[31 - (temp_next_reg % 32)]);

    // This is the custom ROM file that contains the valid spaces that pacman can move. Invalid is represented by a 1.
    romFile_pac validSpace (.clk(clk), .r_addr(temp_block_addr), .r_data(data_from_rom));

    enum {s_idle, s_curr, s_temp, s_delay, s_check} ps, ns;

    // Next state logic:
    always_comb begin
        case (ps)
            s_idle: begin
                if (start) ns = s_curr;
                else ns = s_idle;
            end
            s_curr: ns = s_temp;
            s_temp: ns = s_delay;
            s_delay: ns = s_check;
            s_check: ns = s_curr;
        endcase
    end // always_comb 

    // Map user input into the next location to check if valid to move:
    always_comb begin
        // default, if up, down, left, right are all low, stay in the same place
        temp_next = curr_block_reg;

        case ({up, down, left, right})
            4'b0001: 
                temp_next = curr_block_reg + 1;
            4'b0010: 
                temp_next = curr_block_reg - 1;
            4'b0100: 
                temp_next = curr_block_reg + 32;
            4'b1000: 
                temp_next = curr_block_reg - 32;
        endcase
    end // always_comb

    // Controls Next state updating.
    always_ff @(posedge clk) begin
        if (reset) begin
            ps <= s_idle;
        end else 
            ps <= ns;
    end //always_ff

    // If the direction the user wants to move is valid. This moves them their, if not pacman
    //      does not move.
    always_ff @(posedge clk) begin
        if (ps == s_curr) curr_block_reg <= curr_block;

        if (ps == s_temp) temp_next_reg <= temp_next;

        // TODO: might want to register canMove
        if (ps == s_check) begin
            if (canMove)
                next_block <= temp_next_reg;
            else
                next_block <= next_block;
        end
    end // always_ff

endmodule // pac_man_behavior