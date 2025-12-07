onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /ghostNextLoc_tb/dut/clk
add wave -noupdate -radix binary /ghostNextLoc_tb/dut/reset
add wave -noupdate -radix binary /ghostNextLoc_tb/dut/start
add wave -noupdate -expand -group ghostNextLoc -radix unsigned /ghostNextLoc_tb/dut/currPos
add wave -noupdate -expand -group ghostNextLoc -radix unsigned /ghostNextLoc_tb/dut/targetPos
add wave -noupdate -expand -group ghostNextLoc -radix unsigned /ghostNextLoc_tb/dut/nextPos
add wave -noupdate -expand -group ghostNextLoc /ghostNextLoc_tb/dut/done
add wave -noupdate -expand -group ghostNextLoc /ghostNextLoc_tb/dut/ready
add wave -noupdate -expand -group ghostNextLoc -radix unsigned /ghostNextLoc_tb/dut/ghostPosX
add wave -noupdate -expand -group ghostNextLoc -radix unsigned /ghostNextLoc_tb/dut/ghostPosY
add wave -noupdate -expand -group ghostNextLoc -group shouldMove /ghostNextLoc_tb/dut/shouldMoveU
add wave -noupdate -expand -group ghostNextLoc -group shouldMove /ghostNextLoc_tb/dut/shouldMoveR
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/canMoveD
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/canMoveL
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/canMoveR
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/canMoveU
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/posUp
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/posRight
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/posDown
add wave -noupdate -expand -group ghostNextLoc -expand -group PossibleDirToMove /ghostNextLoc_tb/dut/posLeft
add wave -noupdate -group pullGhostData -radix unsigned /ghostNextLoc_tb/dut/gdata/r_addr_up
add wave -noupdate -group pullGhostData -radix unsigned /ghostNextLoc_tb/dut/gdata/r_addr_down
add wave -noupdate -group pullGhostData -radix unsigned /ghostNextLoc_tb/dut/gdata/r_addr_left
add wave -noupdate -group pullGhostData -radix unsigned /ghostNextLoc_tb/dut/gdata/r_addr_right
add wave -noupdate -group pullGhostData /ghostNextLoc_tb/dut/gdata/start
add wave -noupdate -group pullGhostData /ghostNextLoc_tb/dut/gdata/r_data_up
add wave -noupdate -group pullGhostData /ghostNextLoc_tb/dut/gdata/r_data_down
add wave -noupdate -group pullGhostData /ghostNextLoc_tb/dut/gdata/r_data_left
add wave -noupdate -group pullGhostData /ghostNextLoc_tb/dut/gdata/r_data_right
add wave -noupdate -group pullGhostData /ghostNextLoc_tb/dut/gdata/ready
add wave -noupdate -group pullGhostData /ghostNextLoc_tb/dut/gdata/done
add wave -noupdate -group romFile_ghost -radix unsigned /ghostNextLoc_tb/dut/gdata/gRom/r_addr_up
add wave -noupdate -group romFile_ghost -radix unsigned /ghostNextLoc_tb/dut/gdata/gRom/r_addr_down
add wave -noupdate -group romFile_ghost -radix unsigned /ghostNextLoc_tb/dut/gdata/gRom/r_addr_left
add wave -noupdate -group romFile_ghost -radix unsigned /ghostNextLoc_tb/dut/gdata/gRom/r_addr_right
add wave -noupdate -group romFile_ghost /ghostNextLoc_tb/dut/gdata/gRom/r_data_up
add wave -noupdate -group romFile_ghost /ghostNextLoc_tb/dut/gdata/gRom/r_data_down
add wave -noupdate -group romFile_ghost /ghostNextLoc_tb/dut/gdata/gRom/r_data_left
add wave -noupdate -group romFile_ghost /ghostNextLoc_tb/dut/gdata/gRom/r_data_right
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1523 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {6400 ps}
