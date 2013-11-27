if [file exists "work"] {vdel -all}
vlib work

vlog modules.sv
vsim -c top 
run -all
exit
