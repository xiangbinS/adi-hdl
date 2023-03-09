source ../../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip_xilinx.tcl

adi_ip_create axi_ltc2387

# ILA instance for ad_datafmt

create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name my_ila_fmt
    set_property -dict [list CONFIG.C_MONITOR_TYPE {Native}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_NUM_OF_PROBES {7}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_DATA_DEPTH {4096}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_TRIGIN_EN {false}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_PROBE0_WIDTH  {1}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_PROBE1_WIDTH  {18}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_PROBE2_WIDTH  {1}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_PROBE3_WIDTH  {18}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_PROBE4_WIDTH  {1}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_PROBE5_WIDTH  {1}] [get_ips my_ila_fmt]
    set_property -dict [list CONFIG.C_PROBE6_WIDTH  {1}] [get_ips my_ila_fmt]
    generate_target {all} [get_files axi_ltc2387.srcs/sources_1/ip/my_ila_fmt/my_ila_fmt.xci]

adi_ip_files axi_ltc2387 [list \
  "$ad_hdl_dir/library/xilinx/common/ad_data_clk.v" \
  "$ad_hdl_dir/library/xilinx/common/ad_data_in.v" \
  "$ad_hdl_dir/library/common/up_adc_common.v" \
  "$ad_hdl_dir/library/common/up_adc_channel.v" \
  "$ad_hdl_dir/library/common/up_xfer_cntrl.v" \
  "$ad_hdl_dir/library/common/up_xfer_status.v" \
  "$ad_hdl_dir/library/common/up_clock_mon.v" \
  "$ad_hdl_dir/library/common/ad_datafmt.v" \
  "$ad_hdl_dir/library/common/ad_rst.v" \
  "$ad_hdl_dir/library/common/up_delay_cntrl.v" \
  "$ad_hdl_dir/library/common/up_axi.v" \
  "$ad_hdl_dir/library/xilinx/common/up_xfer_cntrl_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/ad_rst_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/ad_rst_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/up_clock_mon_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/up_xfer_status_constr.xdc" \
  "axi_ltc2387_if.v" \
  "axi_ltc2387_channel.v" \
  "axi_ltc2387.v" ]

adi_ip_properties axi_ltc2387

# customize XGUI layout

ipx::infer_bus_interface ref_clk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface dco_p xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface dco_n xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]

set cc [ipx::current_core]
set page0 [ipgui::get_pagespec -name "Page 0" -component $cc]

# link to IP documentation

set_property company_url {https://wiki.analog.com/resources/fpga/docs/axi_ltc2387} [ipx::current_core]

ipgui::add_param -name "ADC_RES" -component $cc -parent $page0
set_property -dict [list \
  "display_name" "ADC resolution" \
  "tooltip" "ADC resolution" \
] [ipgui::get_guiparamspec -name "ADC_RES" -component $cc]

set_property -dict [list \
	"value_validation_type" "list" \
	"value_validation_list" "16 18" \
 ] \
[ipx::get_user_parameters ADC_RES -of_objects $cc]

ipgui::add_param -name "OUT_RES" -component $cc -parent $page0
set_property -dict [list \
  "display_name" "Output data width" \
  "tooltip" "Memory interface" \
] [ipgui::get_guiparamspec -name "OUT_RES" -component $cc]

set_property -dict [list \
	"value_validation_type" "list" \
	"value_validation_list" "16 32" \
 ] \
[ipx::get_user_parameters OUT_RES -of_objects $cc]

#ipgui::add_param -name "TWOLANES" -component $cc -parent $page0
#set_property -dict [list \
#  "display_name" "Configuration mode for lanes" \
#  "tooltip" "Memory interface" \
#] [ipgui::get_guiparamspec -name "TWOLANES" -component $cc]
#
#set_property -dict [list \
#	"value_validation_type" "list" \
#	"value_validation_list" "0 1" \
# ] \
#[ipx::get_user_parameters TWOLANES -of_objects $cc]




set_property -dict [list \
  value_validation_type pairs \
  value_validation_pairs {ONE-LANE 0 TWO-LANES 1 } \
] [ipx::get_user_parameters TWOLANES -of_objects $cc]

# if TWOLANES = 0, then activate only DA+/-
set_property enablement_dependency { $TWOLANES == 0 } \
  [ipx::get_ports *da* -of_objects $cc]

# if TWOLANES = 1, then activate both ports
set_property enablement_dependency { $TWOLANES == 1 } \
  [ipx::get_ports *da* *db* -of_objects $cc]
#set_property enablement_dependency { $TWOLANES == 1 } \
#  [ipx::get_ports *db* -of_objects $cc]

#set_property enablement_tcl_expr {$TWOLANES == 1} \
#  [ipx::get_user_parameters ADC_RES OUT_RES -of_objects $cc]

ipx::save_core [ipx::current_core]
