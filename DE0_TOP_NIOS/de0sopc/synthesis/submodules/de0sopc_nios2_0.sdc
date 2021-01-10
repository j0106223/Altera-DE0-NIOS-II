# Legal Notice: (C)2021 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	de0sopc_nios2_0 	de0sopc_nios2_0:*
set 	de0sopc_nios2_0_oci 	de0sopc_nios2_0_nios2_oci:the_de0sopc_nios2_0_nios2_oci
set 	de0sopc_nios2_0_oci_break 	de0sopc_nios2_0_nios2_oci_break:the_de0sopc_nios2_0_nios2_oci_break
set 	de0sopc_nios2_0_ocimem 	de0sopc_nios2_0_nios2_ocimem:the_de0sopc_nios2_0_nios2_ocimem
set 	de0sopc_nios2_0_oci_debug 	de0sopc_nios2_0_nios2_oci_debug:the_de0sopc_nios2_0_nios2_oci_debug
set 	de0sopc_nios2_0_wrapper 	de0sopc_nios2_0_jtag_debug_module_wrapper:the_de0sopc_nios2_0_jtag_debug_module_wrapper
set 	de0sopc_nios2_0_jtag_tck 	de0sopc_nios2_0_jtag_debug_module_tck:the_de0sopc_nios2_0_jtag_debug_module_tck
set 	de0sopc_nios2_0_jtag_sysclk 	de0sopc_nios2_0_jtag_debug_module_sysclk:the_de0sopc_nios2_0_jtag_debug_module_sysclk
set 	de0sopc_nios2_0_oci_path 	 [format "%s|%s" $de0sopc_nios2_0 $de0sopc_nios2_0_oci]
set 	de0sopc_nios2_0_oci_break_path 	 [format "%s|%s" $de0sopc_nios2_0_oci_path $de0sopc_nios2_0_oci_break]
set 	de0sopc_nios2_0_ocimem_path 	 [format "%s|%s" $de0sopc_nios2_0_oci_path $de0sopc_nios2_0_ocimem]
set 	de0sopc_nios2_0_oci_debug_path 	 [format "%s|%s" $de0sopc_nios2_0_oci_path $de0sopc_nios2_0_oci_debug]
set 	de0sopc_nios2_0_jtag_tck_path 	 [format "%s|%s|%s" $de0sopc_nios2_0_oci_path $de0sopc_nios2_0_wrapper $de0sopc_nios2_0_jtag_tck]
set 	de0sopc_nios2_0_jtag_sysclk_path 	 [format "%s|%s|%s" $de0sopc_nios2_0_oci_path $de0sopc_nios2_0_wrapper $de0sopc_nios2_0_jtag_sysclk]
set 	de0sopc_nios2_0_jtag_sr 	 [format "%s|*sr" $de0sopc_nios2_0_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$de0sopc_nios2_0_oci_break_path|break_readreg*] -to [get_keepers *$de0sopc_nios2_0_jtag_sr*]
set_false_path -from [get_keepers *$de0sopc_nios2_0_oci_debug_path|*resetlatch]     -to [get_keepers *$de0sopc_nios2_0_jtag_sr[33]]
set_false_path -from [get_keepers *$de0sopc_nios2_0_oci_debug_path|monitor_ready]  -to [get_keepers *$de0sopc_nios2_0_jtag_sr[0]]
set_false_path -from [get_keepers *$de0sopc_nios2_0_oci_debug_path|monitor_error]  -to [get_keepers *$de0sopc_nios2_0_jtag_sr[34]]
set_false_path -from [get_keepers *$de0sopc_nios2_0_ocimem_path|*MonDReg*] -to [get_keepers *$de0sopc_nios2_0_jtag_sr*]
set_false_path -from *$de0sopc_nios2_0_jtag_sr*    -to *$de0sopc_nios2_0_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$de0sopc_nios2_0_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$de0sopc_nios2_0_oci_debug_path|monitor_go
