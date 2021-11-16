# Create simulation environment
vlib work
vmap work work

# Compile the design files
vlog ../src/sevenseg.sv 

# Compile the testbench
vlog tb_sevenseg.sv 

# Initialize the simulation by module name
vsim tb_sevenseg

log -r *
do wave_sevenseg.tcl 

# Run the simulation
run -all

# Open wave window
view wave