module checkWinLogic # (
    parameter int NUM_FOOD = 5
) (
    input logic clk, reset
    input logic [3:0] read_data,
    output logic userWon,
    output logic [8:0] count
);

    
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 0;
            userWon <= 0;
        end
        
        if (read_data == 2) begin
            count <= count + 1;
        end

        if (count == NUM_FOOD) begin
            userWon <= 1;
        end
    end

endmodule