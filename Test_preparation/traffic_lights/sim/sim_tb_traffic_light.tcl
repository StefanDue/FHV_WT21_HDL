vlib work
vmap work work

vlog ../src/traffic_light.sv

vlog tb_traffic_light.sv


vsim tb_traffic_light

log -r *

do wave_tb_traffic_light.traffic_light

run -all

view wave