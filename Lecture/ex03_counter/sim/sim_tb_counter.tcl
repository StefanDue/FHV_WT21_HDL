vlib work
vmap work work

vlog ../src/counter.sv
vlog tb_counter.sv

vsim tb_counter

log -r *

do wave_tb_counter.tcl

run -all

view wave 