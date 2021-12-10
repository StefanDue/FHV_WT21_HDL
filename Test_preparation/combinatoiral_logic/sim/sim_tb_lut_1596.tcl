# Creat sim environment
vlib work
vmap work work

# Compile the design file
# Must always be a file with path
vlog ../src/lut_1596.sv

# Compile the testbench
# Must always be a file
vlog tb_lut_1596.sv

# Initialize the simulation
# Must be the testbench module name
vsim tb_lut_1596

log -r *

# Open always the same wave window when stating the simulation
do wave_tb_lut_1596.tcl

# Run the simulation
run -all

# Open the wave window
view wave