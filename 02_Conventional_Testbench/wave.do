onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/clk
add wave -noupdate -radix hexadecimal /top/DUT/A
add wave -noupdate -radix hexadecimal /top/DUT/B
add wave -noupdate -radix hexadecimal /top/DUT/clk
add wave -noupdate -radix hexadecimal /top/op_set
add wave -noupdate -radix hexadecimal /top/DUT/op
add wave -noupdate -radix hexadecimal /top/DUT/reset_n
add wave -noupdate -radix hexadecimal /top/DUT/start
add wave -noupdate -radix hexadecimal /top/DUT/done
add wave -noupdate -radix hexadecimal /top/DUT/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50316229 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {212795720 ns}
