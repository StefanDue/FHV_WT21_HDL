onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_instr_demux/instr
add wave -noupdate /tb_instr_demux/instr_v
add wave -noupdate /tb_instr_demux/instr_type
add wave -noupdate /tb_instr_demux/cmd_a
add wave -noupdate /tb_instr_demux/c
add wave -noupdate /tb_instr_demux/d
add wave -noupdate /tb_instr_demux/j
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 192
configure wave -valuecolwidth 116
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {943 ps}
