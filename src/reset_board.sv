// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module reset_board (clk, reset, hold, overwrite_addr, initial_data);
    
    input logic clk, reset;
    output logic hold;
    output logic [9:0] overwrite_addr;
    output logic [3:0] initial_data;
    logic load, get_data, incr, last_addr_reached;

    reset_board_control ctrl (.*);

    reset_board_datapath dat (.*);

endmodule