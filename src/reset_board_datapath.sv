// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module reset_board_datapath (clk, reset, overwrite_addr, initial_data, last_addr_reached, load, get_data, incr);
    
    input logic clk, reset;
    output logic [9:0] overwrite_addr;
    output logic [3:0] initial_data;
    output logic last_addr_reached;
    // control signals:
    input logic load, get_data, incr;
    logic [3:0] data_from_rom;

    assign last_addr_reached = (overwrite_addr == 768);

    resetting_rom rom (.address(overwrite_addr), .clock(clk), .q(data_from_rom));

    always_ff @(posedge clk) begin
        if (load) begin
            overwrite_addr <= 0;
        end

        if (get_data) begin
            initial_data <= data_from_rom;
        end

        if (incr) begin
            overwrite_addr <= overwrite_addr + 1;
        end
    end

endmodule