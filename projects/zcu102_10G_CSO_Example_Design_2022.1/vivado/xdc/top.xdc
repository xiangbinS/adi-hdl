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

## enable tx by forcing 0 from design. sfp0,1,2,3 => a12, a13, b13, c13
set_property PACKAGE_PIN A12 [get_ports {sfp_tx_dis[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sfp_tx_dis[0]}]

#sfp0
set_property LOC GTHE4_CHANNEL_X1Y12 [get_cells {xxv_subsys_i/xxv_ethernet_0/inst/i_xxv_subsys_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gthe4_top.xxv_subsys_xxv_ethernet_0_0_gt_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[1].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN D2 [get_ports {gt_serial_grx_p[0]}]
set_property PACKAGE_PIN E4 [get_ports {gt_serial_gtx_p[0]}]

#USER_MGT_SI570_CLOCK2_C_P
set_property PACKAGE_PIN C8 [get_ports gt_refclk_p]
#create_clock -period 6.400 -name gt_ref_clk [get_ports gt_refclk_p]

#LED 2 and 3
# led 0 .. 7 => ag14, af13, ae13, aj14, aj15, ah13, ah14, al12
set_property IOSTANDARD LVCMOS25 [get_ports {axi_lite_clk_led[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {mgt_clk_led[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rx_clk_led[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports axil_reset_led]
set_property PACKAGE_PIN AF13 [get_ports axil_reset_led]
set_property PACKAGE_PIN AJ14 [get_ports {axi_lite_clk_led[0]}]
set_property PACKAGE_PIN AH13 [get_ports {mgt_clk_led[0]}]
set_property PACKAGE_PIN AH14 [get_ports {rx_clk_led[0]}]


set_false_path -to [get_cells -hierarchical -filter {NAME =~ */i_*_axi_if_top/*/i_*_syncer/*meta_reg*}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ */i_*_SYNC*/*stretch_reg*}]


set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] 6.400
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] 6.400

set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks clk_pl_0] 6.400
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks clk_pl_0] 6.400
set_max_delay -datapath_only -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] 8.000
set_max_delay -datapath_only -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] 8.000

set_max_delay -datapath_only -from [get_clocks clk_pl_0] -to [get_clocks clk_pl_1] 8.000
set_max_delay -datapath_only -from [get_clocks clk_pl_1] -to [get_clocks clk_pl_0] 10.000

set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks clk_pl_1] 6.400
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks clk_pl_1] 6.400
set_max_delay -datapath_only -from [get_clocks clk_pl_1] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] 10.000
set_max_delay -datapath_only -from [get_clocks clk_pl_1] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] 10.000

set_max_delay -from [get_clocks -of_objects [get_pins xxv_subsys_i/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins xxv_subsys_i/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT0]] 3.300



