# --(C) Copyright 2020 - 2021 Xilinx, Inc. 
# --Copyright (C) 2022, Advanced Micro Devices, Inc 
# --SPDX-License-Identifier: Apache-2.0

set proj_name [get_property NAME [current_project ]]
set proj_dir [get_property DIRECTORY [current_project ]]

puts "PASS_MSG: Block Design Successfully generated"

import_files
puts "PASS_MSG: Importing files to the design Successful"

reset_run synth_1
launch_runs synth_1 -jobs 8
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {   
   puts "ERROR: Synthesis failed"   
} else { puts "PASS_MSG: Synthesis finished Successfully" }

launch_runs impl_1 -to_step write_bitstream -jobs 8

wait_on_run impl_1
#write_dsa -fixed -force ./hw_description.xsa

# Entensible xsa is written 
# file mkdir $proj_dir/${proj_name}.sdk
# write_hw_platform -force -include_bit -file  $proj_dir/${proj_name}_wrapper.xsa
write_hw_platform -fixed -include_bit -force -file $proj_dir/${proj_name}_wrapper.xsa
validate_hw_platform -verbose $proj_dir/${proj_name}_wrapper.xsa
puts "PASS_MSG: Extensible XSA Generated Successfully"

close_project
exit
