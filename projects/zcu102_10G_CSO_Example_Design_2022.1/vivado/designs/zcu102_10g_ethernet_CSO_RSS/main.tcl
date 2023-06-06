#  -- (c) Copyright [2022] – [2023] Xilinx, Inc. All rights reserved.
#  --
#  -- This file contains confidential and proprietary information
#  -- of Xilinx, Inc. and is protected under U.S. and
#  -- international copyright and other intellectual property
#  -- laws.
#  --
#  -- DISCLAIMER
#  -- This disclaimer is not a license and does not grant any
#  -- rights to the materials distributed herewith. Except as
#  -- otherwise provided in a valid license issued to you by
#  -- Xilinx, and to the maximum extent permitted by applicable
#  -- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
#  -- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
#  -- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
#  -- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
#  -- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#  -- (2) Xilinx shall not be liable (whether in contract or tort,
#  -- including negligence, or under any other theory of
#  -- liability) for any loss or damage of any kind or nature
#  -- related to, arising under or in connection with these
#  -- materials, including for any direct, or any indirect,
#  -- special, incidental, or consequential loss or damage
#  -- (including loss of data, profits, goodwill, or any type of
#  -- loss or damage suffered as a result of any action brought
#  -- by a third party) even if such damage or loss was
#  -- reasonably foreseeable or Xilinx had been advised of the
#  -- possibility of the same.
#  --
#  -- CRITICAL APPLICATIONS
#  -- Xilinx products are not designed or intended to be fail-
#  -- safe, or for use in any application requiring fail-safe
#  -- performance, such as life-support or safety devices or
#  -- systems, Class III medical devices, nuclear facilities,
#  -- applications related to the deployment of airbags, or any
#  -- other applications that could lead to death, personal
#  -- injury, or severe property or environmental damage
#  -- (individually and collectively, "Critical
#  -- Applications"). Customer assumes the sole risk and
#  -- liability of any use of Xilinx products in Critical
#  -- Applications, subject only to applicable laws and
#  -- regulations governing limitations on product liability.
#  --
#  -- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
#  -- PART OF THIS FILE AT ALL TIMES
 

xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]
xhub::install [xhub::get_xitems xilinx.com:xilinx_board_store:zcu102:*] -quiet

# global variables
#set ::platform "zcu102"
#set ::silicon "e-S"

# local variables
set project_dir "project"
set ip_dir "../../iprepo"
set constrs_dir "../../xdc"
#set scripts_dir "scripts"

variable design_name
set design_name xxv_subsys

set part xczu9eg-ffvb1156-2-e
puts "INFO: Target part selected: '$part'"

# set up project

 create_project $design_name $project_dir -part $part -force
 set board_lat [ get_board_parts -latest_file_version  {*zcu102:*} ]
 set_property board_part $board_lat [current_project]


# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild

# set up bd design
create_bd_design $design_name
current_bd_design $design_name

# Set current bd instance as root of current design
set parentCell [get_bd_cells /]
set parentObj [get_bd_cells $parentCell]
current_bd_instance $parentObj

source config_bd.tcl
save_bd_design


set_msg_config -id {IP_Flow 19-4965} -new_severity {WARNING}
set_msg_config -id {BD 41-2383} -new_severity {WARNING}


# add hdl sources to project
make_wrapper -files [get_files ./$project_dir/$design_name.srcs/sources_1/bd/$design_name/xxv_subsys.bd] -top
add_files -norecurse ./$project_dir/$design_name.gen/sources_1/bd/$design_name/hdl/xxv_subsys_wrapper.v
set_property top xxv_subsys_wrapper [current_fileset]

add_files -fileset constrs_1 -norecurse $constrs_dir/top.xdc
update_compile_order -fileset sources_1
add_files -fileset constrs_1 -norecurse $constrs_dir/async.xdc
update_compile_order -fileset sources_1

set_property used_in_synthesis false [get_files $constrs_dir/async.xdc]
set_property strategy Performance_ExtraTimingOpt [get_runs impl_1]

validate_bd_design
save_bd_design
update_compile_order -fileset sources_1
regenerate_bd_layout
save_bd_design


source ../runs.tcl
