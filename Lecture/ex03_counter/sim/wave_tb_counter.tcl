onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_counter/WTB
add wave -noupdate /tb_counter/rst_n
add wave -noupdate /tb_counter/clk50m
add wave -noupdate /tb_counter/en
add wave -noupdate /tb_counter/up_dn_n
add wave -noupdate -radix unsigned /tb_counter/cnt
add wave -noupdate -format Analog-Step -height 74 -max 30.999999999999996 -radix unsigned /tb_counter/cnt
add wave -noupdate /tb_counter/run_sim
add wave -noupdate /tb_counter/error_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2119388 ps} 0}
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
WaveRestoreZoom {0 ps} {2226 ns}
