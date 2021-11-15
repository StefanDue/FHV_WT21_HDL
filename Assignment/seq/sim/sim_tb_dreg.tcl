# Create sim environment
vlib work
vmap work work

# Compile the design files
# It is important that this is always file
vlog ../src/dreg.sv

# Compile the testbench
# It is important that this is always file
vlog tb_dreg.sv

# Init the simulation
# Make shure to put the module name here (no file)
vsim tb_dreg

log -r *

# Open the exactly same wave-window when starting the simulation
do wave_tb_dreg.tcl

# Run the simulation
run -all

# Open wave window
view wave 