vlib work
vmap work work

vlog ../src/lut_1596.sv

vlog tb_lut_1596.sv


vsim tb_lut_1596

log -r *

do wave_tb_lut_1596.tcl

run -all

view wave