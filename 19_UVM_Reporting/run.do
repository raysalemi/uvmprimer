if [file exists "work"] {vdel -all}
vlib work

# Comment out either the SystemVerilog or VHDL DUT.
# There can be only one!

#VHDL DUT
vcom -f dut.f

# SystemVerilog DUT
# vlog ../misc/tinyalu.sv

vlog -f tb.f
vopt top -o top_optim  +acc +cover=sbfec+tinyalu(rtl).


vsim top_optim -coverage +UVM_TESTNAME=random_test


set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

quit
