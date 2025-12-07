
// Object Codes:
//  - 0: black
//  - 1: wall
//  - 2: food
//  - 3: pac
//  - 4: blinky
//  - 5: inky
//  - 6: pinky
//  - 7: clyde
//  - 8: superPower

module writingToBoardLogic (
    input logic clk, reset, start,
    input logic [9:0] posPacman, posPacman_next,
    input logic [9:0] posBlinky, posBlinky_next,
    input logic [9:0] posPinky, posPinky_next,
    input logic [9:0] posInky, posInky_next,
    input logic [9:0] posClyde, posClyde_next,

    output logic [3:0] data2Write,
    output logic [9:0] writeAddr,
    output logic writeEn, finished
);

    enum {idle, write0Pac, writePac, write0Inky, writeInky, write0Clyde, writeClyde, 
                write0Pinky, writePinky, write0Blinky, writeBlinky, done} ps, ns;

    always_ff @(posedge clk) begin
        if (reset)
            ps <= idle;
        else 
            ps <= ns;
    end //always_ff

    always_comb begin
        case (ps)
            idle: begin
                if (start) 
                    ns <= write0Pac;

                finished = 0;

                writeEn = 0;
                data2Write = 0;
                writeAddr = 0;
            end

            write0Pac: begin
                ns <= writePac;

                finished = 0;

                writeEn = 1;
                data2Write = 0;
                writeAddr = posPacman;
            end

            writePac: begin
                ns = write0Inky;

                finished = 0;

                writeEn = 1;
                data2Write = 4'd3;
                writeAddr = posPacman_next;
            end

            write0Inky: begin
                ns = writeInky;

                finished = 0;

                writeEn = 1;
                data2Write = 0;
                writeAddr = posInky;
            end

            writeInky: begin
                ns = write0Clyde;

                finished = 0;

                writeEn = 1;
                data2Write = 4'd5;
                writeAddr = posInky_next;
            end

            write0Clyde: begin
                ns = writeClyde;

                finished = 0;

                writeEn = 1;
                data2Write = 0;
                writeAddr = posClyde;
            end

            writeClyde: begin
                ns = write0Pinky;

                finished = 0;

                writeEn = 1;
                data2Write = 4'd7;
                writeAddr = posClyde_next;
            end

            write0Pinky: begin
                ns = writePinky;

                finished = 0;

                writeEn = 1;
                data2Write = 0;
                writeAddr = posPinky;
            end

            writePinky: begin
                ns = write0Blinky;

                finished = 0;

                writeEn = 1;
                data2Write = 4'd6;
                writeAddr = posPinky_next;
            end

            write0Blinky: begin
                ns = writeBlinky;

                finished = 0;

                writeEn = 1;
                data2Write = 0;
                writeAddr = posBlinky;
            end

            writeBlinky: begin
                ns = done;

                finished = 0;

                writeEn = 1;
                data2Write = 4'd4;
                writeAddr = posBlinky_next;
            end

            done: begin
                ns = idle;

                finished = 1;

                writeEn = 0;
                data2Write = 0;
                writeAddr = 0;
                
            end
        endcase
    end //always_comb
endmodule //writingToBoardLogic