onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pac_man_behavior_tb/dut/clk
add wave -noupdate /pac_man_behavior_tb/dut/reset
add wave -noupdate /pac_man_behavior_tb/dut/up
add wave -noupdate /pac_man_behavior_tb/dut/down
add wave -noupdate /pac_man_behavior_tb/dut/left
add wave -noupdate /pac_man_behavior_tb/dut/right
add wave -noupdate -radix unsigned /pac_man_behavior_tb/dut/curr_block
add wave -noupdate -radix unsigned /pac_man_behavior_tb/dut/next_block
add wave -noupdate -radix unsigned /pac_man_behavior_tb/dut/temp_next
add wave -noupdate -radix unsigned /pac_man_behavior_tb/dut/temp_block_addr
add wave -noupdate /pac_man_behavior_tb/dut/data_from_rom
add wave -noupdate /pac_man_behavior_tb/dut/canMove
add wave -noupdate -radix unsigned /pac_man_behavior_tb/dut/temp_next_reg
add wave -noupdate -radix unsigned /pac_man_behavior_tb/dut/curr_block_reg
add wave -noupdate /pac_man_behavior_tb/dut/done
add wave -noupdate /pac_man_behavior_tb/dut/ready
add wave -noupdate /pac_man_behavior_tb/dut/start
add wave -noupdate /pac_man_behavior_tb/dut/ps
add wave -noupdate /pac_man_behavior_tb/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {243 ps} 0}
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
WaveRestoreZoom {0 ps} {1864 ps}
