# -------------------------------------------------------------------------------------------------------------------
# File : sim_counter2.tcl
# Projec : counter
# Description : IPCPL Simulation script.
#               This script is called from ipcpl and receive the parameter "1". This parameter is a list of 3 variables:
#                 index 0: the testbench entity name: tb_counter
#                 index 1: fn, it's a general parameter to control simulations.
#                 index 2: gui, switch between command line or gui simulation.
# -------------------------------------------------------------------------------------------------------------------
quietly set tb ""
quietly set fn ""
quietly set gui ""
if {[info exists 1]} {
    quietly set param_lst $1
}
set tb [lindex $param_lst 0]
set fn [lindex $param_lst 1]
set gui [lindex $param_lst 2]
puts "Counter Simulation: tb=$tb fn=$fn gui=$gui"
if {$gui == 1} {
    puts "Add signals to wave"
    add wave -noupdate -divider {COUNTER}
    add wave -noupdate -format Logic /$tb/rst
    add wave -noupdate -format Logic /$tb/clk
    add wave -noupdate -format Logic /$tb/enable
    add wave -noupdate -format Literal -radix hexadecimal /$tb/q
}
puts "Simulate for 5 us"
run 5 us
return 0
