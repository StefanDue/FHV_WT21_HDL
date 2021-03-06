onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart_tx/data_i
add wave -noupdate /tb_uart_tx/tx_start_i
add wave -noupdate /tb_uart_tx/tx_o
add wave -noupdate /tb_uart_tx/idle_o
add wave -noupdate /tb_uart_tx/rst_n_i
add wave -noupdate /tb_uart_tx/clk_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88909382 ps} 0}
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
WaveRestoreZoom {0 ps} {93355500 ps}
