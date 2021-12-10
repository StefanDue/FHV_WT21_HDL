vlib work
vmap work work

vlog ../src/count_1596.sv

vlog tb_count_1596.sv

vsim tb_count_1596

log -r *

do wave_tb_count_1596.tcl

run -all

view wave