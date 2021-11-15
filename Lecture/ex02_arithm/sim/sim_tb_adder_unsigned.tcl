vlib work
vmap work work

# always the file name
vlog ../src/adder_unsigned.sv

# always the file name
vlog tb_adder_unsigned.sv

# always for the module name
vsim tb_adder_unsigned

log -r *
do wave_tb_adder_unsigned.tcl

run -all

view wave