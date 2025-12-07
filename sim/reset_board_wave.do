onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /reset_board_tb/dut/clk
add wave -noupdate /reset_board_tb/dut/reset
add wave -noupdate /reset_board_tb/dut/hold
add wave -noupdate -radix unsigned /reset_board_tb/dut/overwrite_addr
add wave -noupdate -radix unsigned /reset_board_tb/dut/initial_data
add wave -noupdate /reset_board_tb/dut/load
add wave -noupdate /reset_board_tb/dut/get_data
add wave -noupdate /reset_board_tb/dut/unhold
add wave -noupdate /reset_board_tb/dut/incr
add wave -noupdate /reset_board_tb/dut/last_addr_reached
add wave -noupdate /reset_board_tb/dut/ctrl/ps
add wave -noupdate /reset_board_tb/dut/ctrl/ns
add wave -noupdate /reset_board_tb/dut/ctrl/start
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {169 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4595 ps}
