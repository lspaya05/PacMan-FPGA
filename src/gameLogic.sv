
module gameLogic(
    input logic clk, reset, 
);  

// Status Signals (from control):
logic ready, userWon, gameOver;

// Status Signals (from datapath):
logic boardLoaded, start, all_next_pos_ready, board_fully_written, checkWin, checkLoss, playagain;

//----------------------------------------- Control -----------------------------------------------

    enum {s_beginLoadBoard, s_loadBoard, s_gameLoaded, s_beginDetNextPos, s_detNextPos,
            s_beginWrite2Board, s_write2Board, s_gameEnd} ps, ns;

    always_comb begin : stateLogic
        case (ps)
            s_beginLoadBoard: begin
                ns = s_loadBoard;
            end

            s_loadBoard: begin
                if (boardLoaded)
                    ns = s_gameLoaded;
            end

            s_gameLoaded: begin
                ready = 1;

                if (start)
                    ns = s_beginDetNextPos;
            end

            s_beginDetNextPos: begin
                ns = s_detNextPos;
            end

            s_detNextPos: begin
                if (all_next_pos_ready)
                    ns = s_beginWrite2Board;
            end

            s_beginWrite2Board: begin
                ns = s_beginWrite2Board;
            end

            s_write2Board: begin
                if (board_fully_written) begin
                    if(checkWin) begin
                        userWon = 1;
                        ns = s_gameEnd;
                    end else if (checkLoss) begin
                        ns = s_gameEnd;
                    end else 
                        ns = s_detNextPos;
                end
            end

            s_gameEnd: begin
                gameOver = 1;

                if (playAgain)
                    ns = s_beginLoadBoard;
            end

        endcase
    end //always_comb


//----------------------------------------- Datapath ----------------------------------------------
    // Character Positions:
    logic [9:0] posPacman, posPacman_next;
    logic [9:0] posBlinky, posBlinky_next;
    //logic [9:0] posPinky, posPinky_next;
    //logic [9:0] posInky, posInky_next;
    //logic [9:0] posClyde, posClyde_next;

    //Process Start Signals:
    logic beginLoad, beginLoadPos, beginWriteBoard
    
    always_ff @(posedge clk) begin : DelayedControlSignals
        if (s_beginLoadBoard) 
            beginLoad <= 1;
        else 
            beginLoad <= 0;

        if (s_beginDetNextPos)
            beginLoadPos <= 1;
        else 
            beginLoadPos <= 0;
        
        if (s_beginWrite2Board)
            beginWriteBoard = 1;
        else 
            beginwriteBoard = 0;
    end //always_ff

    // s_loadBoard: -------------------------------------------------------------------------------
    always_ff @(posedge clk) begin : resetCharPos
        if (beginLoad) begin
            posPacman <= 10'd495;
            posBlinky <= 10'd366;
            //posPinky <= 10'd369;
            //posInky <= 10'd430;
            //posClyde <= 10'd433;
        end
    end

        //TODO: RESET BOARD

    // s_detNextPos: ------------------------------------------------------------------------------
        logic blinkyDone, pinkyDone, inkyDone, clydeDone, pacmanDone;
        logic blinkyReady, pinkyReady, inkyReady, clydeReady; // For Testing.

        //TODO: PACMAN

        blinky_behavior blinky (
            .clk, .reset .start(beginLoadPos),
            .currPos(posBlinky), .targetPos(posPacman), nextPos(posBlinky_next),
            .done(blinkyDone), .ready(blinkyReady);
        );

        assign all_next_pos_ready = blinkyDone & pinkyDone & inkyDone & clydeDone & pacmanDone;

    // s_writeBoard: ------------------------------------------------------------------------------

        //TODO: FSM for writing
        writingToBoardLogic

        //TODO: CheckWin

        //TODO: CheckLoss

endmodule //gameLogic