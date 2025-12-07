// Name: Leonard Paya, Rhiannon Garnier
// ID: 2200906, 2336462
// Due Date: 12/07/2025
// Class: EE 371


module check_done (clk, reset, read_addr, read_data, game_over, count);
    
    input logic clk, reset;
    input logic [9:0] read_addr;
    input logic [3:0] read_data;
    output logic game_over;
    logic [8:0] num_food_total;
    output logic [8:0] count;

    assign game_over = (num_food_total == 0);
    
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 0;
            num_food_total <= 9'b111111111;
        end
        if (read_addr == 10'b1011111110) begin
            num_food_total <= count;
        end
        if (read_addr == 1011111111) begin
            count <= 0;
        end
        if (read_data == 2) begin
            count <= count + 1;
        end
    end

endmodule