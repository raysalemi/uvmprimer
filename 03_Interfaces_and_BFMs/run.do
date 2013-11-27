if [file exists "work"] {vdel -all}
vlib work
vcom -f dut.f
vlog -f tb.f
vopt top -o top_optimized  +acc +cover=sbfec+tinyalu(rtl).
 vsim top_optimized -coverage
 set NoQuitOnFinish 1
 onbreak {resume}
 log /* -r
 run -all
 coverage exclude -src ../../tinyalu_dut/single_cycle_add_and_xor.vhd -line 49 -code s
 coverage exclude -src ../../tinyalu_dut/single_cycle_add_and_xor.vhd -scope /top/DUT/add_and_xor -line 49 -code b
 coverage save tinyalu.ucdb
 vcover report tinyalu.ucdb 
 vcover report tinyalu.ucdb -cvg -details
quit
