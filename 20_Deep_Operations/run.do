if [file exists "work"] {vdel -all}
vlib work
vlog deep.sv
vsim -c -voptargs="+acc" top
run -all
quit
