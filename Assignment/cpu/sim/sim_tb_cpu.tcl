# Create sim environment
vlib work
vmap work work

# Compile the design file
# Must always be a file
vlog ../src/alu.sv 
vlog ../src/cpu.sv
vlog ../src/dreg.sv
vlog ../src/instr_demux.sv
vlog ../src/jump_ctrl.sv
vlog ../src/pcount.sv


# Compile the testbench
# Must always be a file
vlog tb_cpu.sv


# Init the simulation
# Must always be the module name
vsim tb_cpu

log -r *

# Open exactly the same wave-window when starting the simulation
do wave_tb_cpu.tcl

# Run the simulation
run -all

# Open wave window
view wave 