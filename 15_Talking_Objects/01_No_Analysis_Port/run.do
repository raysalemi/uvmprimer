if [file exists "work"] {vdel -all}
vlib work

vlog dice_pkg.sv;
vlog top.sv;

vsim -c top
run -all
exit
