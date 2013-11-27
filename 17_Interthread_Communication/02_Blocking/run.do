if [file exists "work"] {vdel -all}
vlib work

vlog example_pkg.sv
vlog top.sv;

vsim -c top 
run -all
exit
