onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_pcount/cnt_in
add wave -noupdate -format Analog-Step -height 74 -max 2453.0 -radix unsigned /tb_pcount/cnt
add wave -noupdate /tb_pcount/clk50m
add wave -noupdate /tb_pcount/rst_n
add wave -noupdate /tb_pcount/load
add wave -noupdate /tb_pcount/inc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4124360 ps} 0}
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
WaveRestoreZoom {0 ps} {14112 ns}
