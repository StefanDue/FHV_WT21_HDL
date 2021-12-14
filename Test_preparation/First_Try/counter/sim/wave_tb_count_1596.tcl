onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_count_1596/data_in
add wave -noupdate /tb_count_1596/rst_n
add wave -noupdate /tb_count_1596/load
add wave -noupdate /tb_count_1596/updn
add wave -noupdate /tb_count_1596/en
add wave -noupdate /tb_count_1596/clk5m
add wave -noupdate -format Analog-Step -height 74 -max 50.0 -radix unsigned /tb_count_1596/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7004275 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {18270 ns}
