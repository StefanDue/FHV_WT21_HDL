vlib work
vmap work work

vlog ..src/fsm_door_1596.sv

vlog .. tb_fsm_door_1596.sv

vsim tb_fsm_door_1596


log -r *

do wave_tb_fsm_door_1596.tcl

run -all

view wave
