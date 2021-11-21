# Create sim environment
vlib work
vmap work work

# Compile the design files
# It is important that this is always file
vlog ../src/uart_rx.sv

# Compile the testbench
# It is important that this is always file
vlog tb_uart_rx.sv

# Init the simulation
# Make shure to put the module name here (no file)
vsim tb_uart_rx

log -r *

# Open the exactly same wave-window when starting the simulation
do wave_tb_uart_rx.tcl

# Run the simulation
run -all

# Open wave window
view wave 