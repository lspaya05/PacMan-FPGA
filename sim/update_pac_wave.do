onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /update_pac_tb/dut/clk
add wave -noupdate /update_pac_tb/dut/reset
add wave -noupdate /update_pac_tb/dut/start
add wave -noupdate /update_pac_tb/dut/up
add wave -noupdate /update_pac_tb/dut/down
add wave -noupdate /update_pac_tb/dut/left
add wave -noupdate /update_pac_tb/dut/right
add wave -noupdate -radix unsigned /update_pac_tb/dut/write_data
add wave -noupdate -radix unsigned /update_pac_tb/dut/write_addr
add wave -noupdate /update_pac_tb/dut/wren
add wave -noupdate -radix unsigned /update_pac_tb/dut/pac_loc
add wave -noupdate -radix unsigned /update_pac_tb/dut/pac_next
add wave -noupdate /update_pac_tb/dut/ghost_eats_pac
add wave -noupdate /update_pac_tb/dut/ps
add wave -noupdate /update_pac_tb/dut/ns
add wave -noupdate /update_pac_tb/dut/pac/canMove
add wave -noupdate -radix unsigned /update_pac_tb/dut/pac/curr_block
add wave -noupdate -radix unsigned /update_pac_tb/dut/pac/next_block
add wave -noupdate -radix unsigned /update_pac_tb/dut/pac/temp_next
add wave -noupdate -radix unsigned /update_pac_tb/dut/pac/temp_block_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1051 ps} 0}
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
WaveRestoreZoom {0 ps} {1391 ps}
