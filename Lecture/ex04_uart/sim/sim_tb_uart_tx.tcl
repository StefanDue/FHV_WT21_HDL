vlib work
vmap work work

vlog ../src/uart_tx.sv
vlog tb_uart_tx.sv

vsim tb_uart_tx

log -r *

do wave_tb_uart_tx.tcl

run -all

view wave 