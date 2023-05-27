source ../../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl
# The get_env_param procedure retrieves parameter value from the environment if exists,
# other case returns the default value specified in its second parameter field.
#
#   How to use over-writable parameters from the environment:
#
#    e.g.
#      make NUM_OF_SDI=4  CAPTURE_ZONE=2
#
#
# Parameter description:
#
# CLK_MODE : Clocking mode of the device's digital interface
#
#   0 - SPI Mode
#   1 - Echo-clock or Master clock mode
#
# NUM_OF_SDI : the number of MOSI lines of the SPI interface
#
#    1 - 1 lane per channel
#    2 - 2 lanes per channel
#    4 - 4 lanes per channel
#
# CAPTURE_ZONE : the capture zone of the next sample
# There are two capture zones for AD4030-24
#
#   1 - from negative edge of the BUSY line until the next CNV positive edge -20ns
#   2 - from the next consecutive CNV positive edge +20ns until the second next
#   consecutive CNV positive edge -20ns
#
# DDR_EN : in echo and master clock mode the SDI lines can have Single or Double
# Data Rates
#
#   0 - MISO runs on SDR
#   1 - MISO runs on DDR
#
# Example:
#
#   make CLK_MODE=0 NUM_OF_SDI=1 CAPTURE_ZONE=2 DDR_EN=0
#   make CLK_MODE=0 NUM_OF_SDI=2 CAPTURE_ZONE=2 DDR_EN=0
#   make CLK_MODE=0 NUM_OF_SDI=4 CAPTURE_ZONE=2 DDR_EN=0
#   make CLK_MODE=1 NUM_OF_SDI=1 CAPTURE_ZONE=2 DDR_EN=0
#   make CLK_MODE=1 NUM_OF_SDI=2 CAPTURE_ZONE=2 DDR_EN=0
#   make CLK_MODE=1 NUM_OF_SDI=4 CAPTURE_ZONE=2 DDR_EN=0
#   make CLK_MODE=0 NUM_OF_SDI=1 CAPTURE_ZONE=2 DDR_EN=1
#   make CLK_MODE=0 NUM_OF_SDI=2 CAPTURE_ZONE=2 DDR_EN=1
#   make CLK_MODE=0 NUM_OF_SDI=4 CAPTURE_ZONE=2 DDR_EN=1
#   make CLK_MODE=1 NUM_OF_SDI=1 CAPTURE_ZONE=2 DDR_EN=1
#   make CLK_MODE=1 NUM_OF_SDI=2 CAPTURE_ZONE=2 DDR_EN=1
#   make CLK_MODE=1 NUM_OF_SDI=4 CAPTURE_ZONE=2 DDR_EN=1

adi_project adaq4224_fmc_zed 0 [list \
  CLK_MODE     [get_env_param CLK_MODE      0] \
  NUM_OF_SDI   [get_env_param NUM_OF_SDI    4] \
  CAPTURE_ZONE [get_env_param CAPTURE_ZONE  2] \
  DDR_EN       [get_env_param DDR_EN  0] ]

adi_project_files adaq4224_fmc_zed [list \
  "$ad_hdl_dir/library/common/ad_iobuf.v" \
  "$ad_hdl_dir/library/xilinx/common/ad_data_clk.v" \
  "$ad_hdl_dir/projects/common/zed/zed_system_constr.xdc" \
  "system_constr.xdc" \
  "system_top.v" ]

adi_project_run adaq4224_fmc_zed
