module joystick_example(CLOCK_50, LEDR, HEX0, HEX2, HEX3, HEX4, HEX5, V_GPIO);
 
input CLOCK_50;
inout [35:0] V_GPIO;
output [0:9] LEDR;
output [0:6] HEX0;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;

reg  [0:9] LEDR;
reg  [0:6] HEX0;
reg [7:0] positionX;
reg [7:0] positionY;

wire latch;
wire pulse;

assign V_GPIO[27] = pulse;
assign LEDR[8] = pulse;

assign V_GPIO[26] = latch;
assign LEDR[9] = latch;

// switches 0..4 are LEDs 3..7
assign LEDR[3] = V_GPIO[10];
assign LEDR[4] = V_GPIO[11];
assign LEDR[5] = V_GPIO[12];
assign LEDR[6] = V_GPIO[13];
assign LEDR[7] = V_GPIO[14];


joystick_driver jdriver(
    .clk(CLOCK_50),
    .data_in(V_GPIO[28]),
    .latch(latch),
    .pulse(pulse),
    .positionX(positionX),
    .positionY(positionY)
);

always @ (*)

begin
    LEDR[0] <= V_GPIO[28]; // gpio 18 de RPico (data in)
    LEDR[1] <= V_GPIO[29]; // gpio 19 of RPico
    LEDR[2] <= V_GPIO[30]; // gpio 20 of RPico
    case( V_GPIO[13:10] )
        4'B0001: HEX0 = 7'B0000001;
        4'B0010: HEX0 = 7'B1001111;
        4'B0100: HEX0 = 7'B0010010;
        4'B1000: HEX0 = 7'B0000110;
        default: HEX0 = 7'B1111111;
    endcase
    
    if (positionX == 8'b00000000) begin
        // zero: turn 7-segment off
        HEX3 = 7'b1111111;
        HEX2 = 7'b1111111;
    end else if (positionX[7] == 1) begin
        // Negative number (left)
        HEX3 = 7'b1000111;
        HEX2 = 7'b0000110;
    end else begin
        // Positive number (right)
        HEX3 = 7'b1001110;
        HEX2 = 7'b1001111;
    end
    
    if (positionY == 8'b00000000) begin
        // zero: turn 7-segment off
        HEX5 = 7'b1111111;
        HEX4 = 7'b1111111;
    end else if (positionY[7] == 1) begin
        // Negative number (down)
        HEX5 = 7'b0100001;
        HEX4 = 7'b0100011;
    end else begin
        // Positive number (up)
        HEX5 = 7'b1000001;
        HEX4 = 7'b0001100;
    end
end

endmodule