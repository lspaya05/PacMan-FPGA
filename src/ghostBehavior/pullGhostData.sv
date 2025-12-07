
module pullGhostData #(
    parameter int DATA_WIDTH = 32, 
    parameter int ADDR_WIDTH = 5
) (
    input clk, reset,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_up,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_down,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_left,
    input logic [ADDR_WIDTH - 1 : 0] r_addr_right,
    input logic start,
    output logic [DATA_WIDTH - 1 : 0] r_data_up,
    output logic [DATA_WIDTH - 1 : 0] r_data_down,
    output logic [DATA_WIDTH - 1 : 0] r_data_left,
    output logic [DATA_WIDTH - 1 : 0] r_data_right,
    output logic ready, done
);
    

    // Control and Datapath Logic:

    enum {s_idle, s_load, s_done} ps, ns;

    // Control:
    always_comb begin
        case (ps)
            s_idle: begin
                ready = 1;
                done = 0;
            end 

            s_load: begin
                ready = 0;
                done = 0;
            end

            s_done: begin
                ready = 0;
                done = 1;
            end
        endcase
    end //always_comb

    always_ff @(posedge clk) begin
        if (reset) 
            ps <= s_idle;
        else 
            ps <= ns;
    end //always_ff

    //Datapath:
    logic [ADDR_WIDTH - 1 : 0] r_addr_up_h;
    logic [ADDR_WIDTH - 1 : 0] r_addr_down_h;
    logic [ADDR_WIDTH - 1 : 0] r_addr_left_h;
    logic [ADDR_WIDTH - 1 : 0] r_addr_right_h;

    logic [DATA_WIDTH - 1 : 0] r_data_up_ROM;
    logic [DATA_WIDTH - 1 : 0] r_data_down_ROM;
    logic [DATA_WIDTH - 1 : 0] r_data_left_ROM;
    logic [DATA_WIDTH - 1 : 0] r_data_right_ROM;

    // Valid Position for Ghosts ROM File:
    romFile_ghost #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) gRom (
        .clk,
        .r_addr_up(r_addr_up_h), .r_data_up(r_data_up_ROM),
        .r_addr_down(r_addr_down_h), .r_data_down(r_data_down_ROM),
        .r_addr_left(r_addr_left_h), .r_data_left(r_data_left_ROM),
        .r_addr_right(r_addr_right_h), .r_data_right(r_data_right_ROM)
    ); //romFile_ghost

    always_ff @(posedge clk) begin
        if (ps == s_idle) begin
            r_addr_up_h <= r_addr_up % 32;
            r_addr_down_h <= r_addr_down % 32;
            r_addr_left_h <= r_addr_left % 32;
            r_addr_right_h <= r_addr_right % 32;
        end

        if (ps == s_done) begin
            r_data_up <= r_data_up_ROM;
            r_data_down <= r_data_down_ROM;
            r_data_left <= r_data_left_ROM;
            r_data_right <= r_data_right_ROM;
        end 
    end //always_ff

    // Next State Logic:
    always_comb begin
        if((ps == s_idle) && start)
            ns = s_load;
        else if (ps == s_load)
            ns = s_done;
        else if ((ps == s_done) && !start)
            ns = s_idle;
        else 
            ns = ps;
    end //always_comb
endmodule