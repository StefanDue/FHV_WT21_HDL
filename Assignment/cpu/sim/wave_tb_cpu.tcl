onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_cpu/instr
add wave -noupdate -radix binary /tb_cpu/outM
add wave -noupdate -radix binary -childformat {{{/tb_cpu/addressM[14]} -radix hexadecimal} {{/tb_cpu/addressM[13]} -radix hexadecimal} {{/tb_cpu/addressM[12]} -radix hexadecimal} {{/tb_cpu/addressM[11]} -radix hexadecimal} {{/tb_cpu/addressM[10]} -radix hexadecimal} {{/tb_cpu/addressM[9]} -radix hexadecimal} {{/tb_cpu/addressM[8]} -radix hexadecimal} {{/tb_cpu/addressM[7]} -radix hexadecimal} {{/tb_cpu/addressM[6]} -radix hexadecimal} {{/tb_cpu/addressM[5]} -radix hexadecimal} {{/tb_cpu/addressM[4]} -radix hexadecimal} {{/tb_cpu/addressM[3]} -radix hexadecimal} {{/tb_cpu/addressM[2]} -radix hexadecimal} {{/tb_cpu/addressM[1]} -radix hexadecimal} {{/tb_cpu/addressM[0]} -radix hexadecimal}} -subitemconfig {{/tb_cpu/addressM[14]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[13]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[12]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[11]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[10]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[9]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[8]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[7]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[6]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[5]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[4]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[3]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[2]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[1]} {-height 15 -radix hexadecimal} {/tb_cpu/addressM[0]} {-height 15 -radix hexadecimal}} /tb_cpu/addressM
add wave -noupdate -radix binary /tb_cpu/pc
add wave -noupdate /tb_cpu/clk50m
add wave -noupdate /tb_cpu/writeM
add wave -noupdate /tb_cpu/dut/dload
add wave -noupdate /tb_cpu/dut/alu_out
add wave -noupdate /tb_cpu/dut/d
add wave -noupdate /tb_cpu/dut/y
add wave -noupdate /tb_cpu/dut/a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {73545 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {325500 ps}
