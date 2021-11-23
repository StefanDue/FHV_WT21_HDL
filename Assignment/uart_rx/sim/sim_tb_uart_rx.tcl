# Create sim environment
vlib work
vmap work work

# Compile the design file
# Must always be a file
vlog ../src/uart_rx.sv 
vlog ../src/uart_tx.sv

# Compile the testbench
# Must always be a file
vlog tb_uart_rx.sv


# Init the simulation
# Must always be the module name
vsim tb_uart_rx

log -r *

# Open exactly the same wave-window when starting the simulation
do wave_tb_uart_rx.tcl

# Run the simulation
run -all

# Open wave window
view wave