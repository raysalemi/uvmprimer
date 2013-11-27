if [file exists "work"] {vdel -all}
vlib work
vlog ram.sv top.sv
vsim -c -voptargs="+acc" top
run -all
quit
