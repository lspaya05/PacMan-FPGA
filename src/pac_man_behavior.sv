// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module pac_man_behavior (clk, reset, up, down, left, right, curr_block, next_block, start, done);
    
    input logic clk, reset, start;
    input logic up, down, left, right;
    input logic [9:0] curr_block;
    output logic [9:0] next_block;
    output logic done;
    logic [9:0] temp_next;
    logic [4:0] temp_block_addr;
    logic [31:0] data_from_rom;
    logic canMove;
    logic [9:0] temp_next_reg;
    logic [9:0] curr_block_reg;

    // combinational logic to determine if the next block is valid
    assign temp_block_addr = temp_next_reg / 32;
    assign canMove = !(data_from_rom[31 - (temp_next_reg % 32)]);

    romFile_pac #(.DATA_WIDTH(32), .ADDR_WIDTH(5)) validSpace (.clk(clk), .r_addr(temp_block_addr), .r_data(data_from_rom));

    enum {s_idle, s_curr, s_temp, s_delay, s_check} ps, ns;

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
    end

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
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            ps <= s_idle;
        end
        else ps <= ns;
    end

    always_ff @(posedge clk) begin
        if (ps == s_curr) begin
            curr_block_reg <= curr_block;
            done <= 0;
        end

        if (ps == s_temp) temp_next_reg <= temp_next;

        // might want to register canMove
        if (ps == s_check) begin
            if (canMove)
                next_block <= temp_next_reg;
                done <= 1;
            else
                next_block <= next_block;
        end
    end 

endmodule