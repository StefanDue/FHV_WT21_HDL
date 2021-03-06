onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_toplevel_c5g_hex4_uart/CLOCK_50_B5B
add wave -noupdate /tb_toplevel_c5g_hex4_uart/LEDG
add wave -noupdate /tb_toplevel_c5g_hex4_uart/LEDR
add wave -noupdate /tb_toplevel_c5g_hex4_uart/CPU_RESET_n
add wave -noupdate /tb_toplevel_c5g_hex4_uart/KEY
add wave -noupdate /tb_toplevel_c5g_hex4_uart/SW
add wave -noupdate /tb_toplevel_c5g_hex4_uart/HEX0
add wave -noupdate /tb_toplevel_c5g_hex4_uart/HEX1
add wave -noupdate /tb_toplevel_c5g_hex4_uart/HEX2
add wave -noupdate /tb_toplevel_c5g_hex4_uart/HEX3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28840493 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 234
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
WaveRestoreZoom {0 ps} {118744500 ps}
