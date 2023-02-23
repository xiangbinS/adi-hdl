# load script
source ../../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

# specify number of channels - the design supports one lane/two lanes
set twolanes_param 1

if {[info exists ::env(TWOLANES)]} {
  set twolanes_param $::env(TWOLANES)
} else {
  set env(TWOLANES) $twolanes_param
}

adi_project cn0577_zed 0 [list \
  TWOLANES $twolanes_param \
]
adi_project_files cn0577_zed [list \
  "system_top.v" \
  "system_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/ad_data_clk.v" \
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/zed/zed_system_constr.xdc"]

adi_project_run cn0577_zed
