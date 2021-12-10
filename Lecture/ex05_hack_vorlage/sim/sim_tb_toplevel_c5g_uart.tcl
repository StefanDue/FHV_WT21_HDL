vlib work
vmap work work


vlog ../src/alu.sv
vlog ../src/cpu.sv
vlog ../src/data_mem.sv
vlog ../src/dreg.sv
vlog ../src/instr_demux.sv
vlog ../src/jmp_ctrl.sv
vlog ../src/mem_slice.sv
vlog ../src/pcount.sv
vlog ../src/sevenseg.sv
vlog ../src/toplevel_c5g_hex4_uart.sv
vlog ../src/uc.sv
vlog ../ip/ram16k.v
vlog ../ip/rom32k.v

vlog tb_toplevel_c5g_hex4_uart.sv

vsim -L altera_mf_ver    tb_toplevel_c5g_hex4_uart

log -r *
do wave_tb_toplevel_c5g_uart.tcl
run -all

view wave