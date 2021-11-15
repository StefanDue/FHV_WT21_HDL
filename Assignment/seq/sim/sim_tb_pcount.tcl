# Create sim environment
vlib work
vmap work work

# Compile the design file
# Must always be a file
vlog ../src/pcount.sv

# Compile the testbench
# Must always be a file
vlog tb_pcount.sv

# Init the simulation
# Must always be the module name
vsim tb_pcount

log -r *

# Open exactly the same wave-window when starting the simulation
do wave_tb_pcount.tcl

# Run the simulation
run -all

# Open wave window
view wave 