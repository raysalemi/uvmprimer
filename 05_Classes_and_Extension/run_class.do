if [file exists "work"] {vdel -all}
vlib work
vlog -f sv.f 
vsim -c -voptargs="+acc" top_class
run -all
quit
