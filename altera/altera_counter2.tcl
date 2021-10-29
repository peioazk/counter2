# ----------------------------------------------------------------------------------------------------------------------
# counter.tcl
# Script example to create project, assign files, assign PIN IOs, assign device. For use with ipfpga and Intel quartus.
# This script is called from ipcpl and reveive 3 parameters:
#   Parameter 0: command        Reserved for future use.
#   Parameter 1: device         Device name to assign FPGA device.
#   Parameter 2: ip_list        Project IPs data lists. Each list with 3 items:
#                               item 0: Lists of project IPs. Eaach list contains project name, version,...
#                               item 1: Project directory path.
#                               item 2: List of couples with source filename/library, of all projects source files.
# ----------------------------------------------------------------------------------------------------------------------
package require ::quartus::project
package require ::quartus::flow
package require ::quartus::report
package require ::quartus::device 1.0

# +----------------------------------------------------
# | set_sourcefile_assignments
# +----------------------------------------------------
proc set_sourcefiles_assignment {ip_list} {
    set ipnumber [llength $ip_list]
    foreach item $ip_list {
        set ipl [lindex $item 0]
        set ip_d [lindex $item 1]
        set srcl [lindex $item 2]
        foreach item $srcl {
            set src [lindex $item 0]
            # # VERILOG_FILE/VHDL_FILE
            puts "set_global_assignment -name VHDL_FILE $ip_d/$src"
            set_global_assignment -name VHDL_FILE $ip_d/$src
        }
    }
}

# +----------------------------------------------------
# | set_assignments
# +----------------------------------------------------
proc set_assignments {device} {
    set_global_assignment -name DEVICE $device

    set sdc_filename "../counter2.sdc"
	set_global_assignment -name SDC_FILE $sdc_filename

	set_instance_assignment -name "CLOCK_SETTINGS" -to clk_i clk_i
    set_instance_assignment -name "GLOBAL_SIGNAL" ON -to clk_i
    set_instance_assignment -name "GLOBAL_SIGNAL" ON -to arst_i
    #
  	set_location_assignment PIN_88 -to clk_i
	set_location_assignment PIN_90 -to arst_i
	set_location_assignment PIN_115 -to en_i
    set_location_assignment PIN_68 -to q_o[0]
   	set_location_assignment PIN_67 -to q_o[1]
	set_location_assignment PIN_66 -to q_o[2]
	set_location_assignment PIN_65 -to q_o[3]
	set_location_assignment PIN_60 -to q_o[4]
	set_location_assignment PIN_59 -to q_o[5]
	set_location_assignment PIN_58 -to q_o[6]
 	set_location_assignment PIN_55 -to q_o[7]
    #
    set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk_i
    set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to arst_i
    set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to en_i
    set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to q_o*
    set_instance_assignment -name CURRENT_STRENGTH_NEW 8MA -to clk_i
    set_instance_assignment -name CURRENT_STRENGTH_NEW 8MA -to arst_i
    set_instance_assignment -name CURRENT_STRENGTH_NEW 8MA -to en_i
	set_instance_assignment -name CURRENT_STRENGTH_NEW 8MA -to q_o*
}

# --------------------------------------------------------------------------------------------------------------------
# | main
# ----------------------------------------------------------------------------------------------------------------------
# Get parameters from ipcpl
set command [lindex $argv 0]
set device [lindex $argv 1]
set ip_list [lindex $argv 2]
set device [string tolower $device]

# Create Quartus project
set project_ip_list [lindex $ip_list 0]
set project_data [lindex $project_ip_list 0]
set project_name [lindex $project_data 0]

puts "File: altera_counter2.tcl"
puts "Intel/Altera Quartus Compilation: "
puts "Project Name: $project_name"
puts "Device: $device"
project_new $project_name -overwrite
# Quartus source file assignment
set_sourcefiles_assignment $ip_list
# Quartus FPGA Pinout/Device/... assignments
set_assignments $device
export_assignments
project_close
return
