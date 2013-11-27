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
quit
