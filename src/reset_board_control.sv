// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module reset_board_control (clk, reset, last_addr_reached, load, get_data, hold, incr);
    
    input logic clk, reset;
    input logic last_addr_reached;
    output logic hold;
    // control signals:
    output logic load, get_data, incr;
    logic start;

    enum {s_idle, s_delay, s_reset, s_done} ps, ns;

    always_comb begin
        case (ps)
            s_idle: if (start) ns = s_delay;
                        else ns = s_idle;
            s_delay: ns = s_reset;
            s_reset: if (last_addr_reached) ns = s_done;
                        else ns = s_delay;
            s_done: ns = s_idle;
        endcase
    end

    assign hold = ((ps == s_delay) | (ps == s_reset));
    assign load = (start && (ps == s_idle));
    assign get_data = (ps == s_reset);
    assign incr = ((ps == s_reset) && ~(last_addr_reached));

    always_ff @(posedge clk) begin
        if (reset) begin
            ps <= s_idle;
            start <= 1;
        end else begin
            ps <= ns;
            start <= 0;
        end
    end 

endmodule