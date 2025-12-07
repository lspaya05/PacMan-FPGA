// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module check_done (clk, reset, read_addr);
    
    input logic clk, reset;
    input logic [9:0] read_addr;
    input logic [3:0] read_data;
    
    always_ff @(posedge clk) begin
        if (reset) count <= 0;
        else if (count > 767)
    end

endmodule