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
vlog "../src/romFile.sv" 
vlog "../src/pac_man_behavior.sv" 
vlog "../src/DE1_SoC.sv" 
vlog "../src/peripherals/N8_controller/n8_driver.sv" 
vlog "../src/peripherals/N8_controller/serial_driver.sv"
vlog "../src/peripherals/vga_files/CLOCK25_PLL.v"
vlog "../src/peripherals/vga_files/video_driver.sv"
vlog "../src/peripherals/vga_files/altera_up_avalon_video_vga_timing.v"
vlog "../src/peripherals/vga_files/CLOCK25_PLL/CLOCK25_PLL_0002.v"
vlog "../quartus/type_rom.v" 
vlog "../quartus/board_RAM.v"

# Testbench: vlog "../tb/"
vlog "../tb/romFile_tb.sv"
vlog "../tb/pac_man_behavior_tb.sv"
vlog "../tb/DE1_SoC_tb.sv"

# Call vsim to invoke simulator
#  - Make sure the last item on the line is the correct name of
#    the testbench module you want to execute.
#  - If you need the altera_mf_ver library, add "-Lf altera_mf_lib"
#    (no quotes) to the end of the vsim command
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_tb -Lf altera_mf_ver 



# Source the wave do file
#  - This should be the file that sets up the signal window for
#    the module you are testing.
do DE1_SoC_wave.do


# Set the window types
view wave
view structure
view signals


# Run the simulation
run -all


# End
