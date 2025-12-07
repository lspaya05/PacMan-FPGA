# NOTES:
#  - The most important thing is locating where all of the files
#    are and specifying the correct paths (absolute or relative)
#    in the commands below.
#  - You will also need to make sure that your current directory
#    (cd) in ModelSim is the directory containing this .do file.


# Create work library
vlib work


# Compile Verilog
#  - All Verilog files that are part of this design should have
#    their own "vlog" line below.

# Source: vlog "../src/" 
vlog "../src/ghostBehavior/blinky_behavior.sv"
vlog "../src/ghostBehavior/ghostNextLoc.sv"
vlog "../src/ghostBehavior/pullGhostData.sv"
vlog "../src/ghostBehavior/romFile_ghost.sv"
vlog "../src/checkWinLogic.sv"
vlog "../src/clock_divider.sv"
#vlog "../src/DE1_SoC.sv"
vlog "../src/gameLogic.sv"
vlog "../src/pac_man_behavior.sv"
vlog "../src/romFile_pac.sv"
vlog "../src/writingToBoardLogic.sv"

# Testbench: vlog "../tb/"
vlog "../tb/ghostNextLoc_tb.sv"
vlog "../tb/gameLogic_tb.sv"

# Call vsim to invoke simulator
#  - Make sure the last item on the line is the correct name of
#    the testbench module you want to execute.
#  - If you need the altera_mf_ver library, add "-Lf altera_mf_lib"
#    (no quotes) to the end of the vsim command
vsim -voptargs="+acc" -t 1ps -lib work gameLogic_tb -Lf altera_mf_ver 



# Source the wave do file
#  - This should be the file that sets up the signal window for
#    the module you are testing.
do gameLogic_wave.do


# Set the window types
view wave
view structure
view signals


# Run the simulation
run -all


# End
