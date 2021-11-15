# Create sim environment
vlib work
vmap work work

# Compile the design files
vlog ../src/maj_vote.sv

# Compile the testbench
vlog tb_maj_vote.sv

# Init the simulation --> module name
vsim tb_maj_vote

log -r * 
do wave_tb_maj_vote.tcl

# Run the simulation
run -all

# Open wave window
view wave