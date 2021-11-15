# Create sim environment
vlib work
vmap work work

# Compile the design files
# It is important that this is always file
vlog ../src/alu.sv

# Compile the testbench
# It is important that this is always file
vlog tb_alu.sv

# Init the simulation
# Make shure to put the module name here (no file)
vsim tb_alu

log -r *

# Open the exactly same wave-window when starting the simulation
do wave_tb_alu.tcl

# Run the simulation
run -all

# Open wave window
view wave 