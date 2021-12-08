onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart_rx/tx_idle
add wave -noupdate /tb_uart_rx/tx_start
add wave -noupdate -radix hexadecimal /tb_uart_rx/tx_data
add wave -noupdate -radix hexadecimal /tb_uart_rx/rx_data
add wave -noupdate /tb_uart_rx/rx_idle
add wave -noupdate /tb_uart_rx/rx_ready
add wave -noupdate /tb_uart_rx/rx_error
add wave -noupdate /tb_uart_rx/rx
add wave -noupdate -format Analog-Step -height 74 -max 433.0 -radix unsigned /tb_uart_rx/uart_rx/widthcnt
add wave -noupdate -format Analog-Step -height 74 -max 7.0 -radix unsigned /tb_uart_rx/uart_rx/bitcnt
add wave -noupdate /tb_uart_rx/uart_tx/state
add wave -noupdate /tb_uart_rx/uart_tx/state_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {240683661 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
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
WaveRestoreZoom {0 ps} {694218 ns}
