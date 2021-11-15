# Create sim environment
vlib work
vmap work work

# Compile the design file
# Must always be a file
vlog ../src/ram16k_verilog.sv

# Compile the testbench
# Must always be a file
vlog tb_ram16k_verilog.sv

# Init the simulation
# Must always be the module name
vsim tb_ram16k_verilog

log -r *

# Open exactly the same wave-window when starting the simulation
do wave_tb_ram16k_verilog.tcl

# Run the simulation
run -all

# Open wave window
view wave 