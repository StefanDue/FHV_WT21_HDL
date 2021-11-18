# Create sim environment
vlib work
vmap work work

# Compile the design file
# Must always be a file
vlog ../src/instr_demux.sv

# Compile the testbench
# Must always be a file
vlog tb_instr_demux.sv

# Init the simulation
# Must always be the module name
vsim tb_instr_demux

log -r *

# Open exactly the same wave-window when starting the simulation
do wave_tb_instr_demux.tcl

# Run the simulation
run -all

# Open wave window
view wave 