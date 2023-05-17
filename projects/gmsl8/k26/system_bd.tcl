source $ad_hdl_dir/projects/common/kv260/kv260_system_bd.tcl
source $ad_hdl_dir/projects/scripts/adi_pd.tcl

create_bd_port -dir I mipi_csi1_clk_p
create_bd_port -dir I mipi_csi1_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi1_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi1_data_n

create_bd_port -dir I mipi_csi2_clk_p
create_bd_port -dir I mipi_csi2_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi2_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi2_data_n

create_bd_port -dir I mipi_csi3_clk_p
create_bd_port -dir I mipi_csi3_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi3_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi3_data_n

create_bd_port -dir I mipi_csi4_clk_p
create_bd_port -dir I mipi_csi4_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi4_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi4_data_n

create_bd_port -dir I mipi_csi5_clk_p
create_bd_port -dir I mipi_csi5_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi5_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi5_data_n

create_bd_port -dir I mipi_csi6_clk_p
create_bd_port -dir I mipi_csi6_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi6_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi6_data_n

create_bd_port -dir I mipi_csi7_clk_p
create_bd_port -dir I mipi_csi7_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi7_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi7_data_n

create_bd_port -dir I mipi_csi8_clk_p
create_bd_port -dir I mipi_csi8_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi8_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi8_data_n

set mipi_csi2_rx_subsyst_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_1 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {W8} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L1P_T0L_N0_DBC_65} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {U9} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L2P_T0L_N2_65} \
   CONFIG.DATA_LANE1_IO_LOC {U8} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L3P_T0L_N4_AD15P_65} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {65} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsyst_1

set mipi_csi2_rx_subsyst_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_2 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {L1} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L7P_T1L_N0_QBC_AD13P_65} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {J1} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L8P_T1L_N2_AD5P_65} \
   CONFIG.DATA_LANE1_IO_LOC {K2} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L9P_T1L_N4_AD12P_65} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {65} \
   CONFIG.SupportLevel {0} \
 ] $mipi_csi2_rx_subsyst_2

set mipi_csi2_rx_subsyst_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_3 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {L7} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L13P_T2L_N0_GC_QBC_65} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {M6} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L14P_T2L_N2_GC_65} \
   CONFIG.DATA_LANE1_IO_LOC {N7} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L15P_T2L_N4_AD11P_65} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {65} \
   CONFIG.SupportLevel {0} \
 ] $mipi_csi2_rx_subsyst_3

set mipi_csi2_rx_subsyst_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_4 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {J5} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L19P_T3L_N0_DBC_AD9P_65} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {J7} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L21P_T3L_N4_AD8P_65} \
   CONFIG.DATA_LANE1_IO_LOC {K8} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L22P_T3U_N6_DBC_AD0P_65} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {65} \
   CONFIG.SupportLevel {0} \
 ] $mipi_csi2_rx_subsyst_4

set mipi_csi2_rx_subsyst_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_5 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AC9} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L1P_T0L_N0_DBC_64} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {AE9} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L2P_T0L_N2_64} \
   CONFIG.DATA_LANE1_IO_LOC {AB8} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L3P_T0L_N4_AD15P_64} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {64} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsyst_5

set mipi_csi2_rx_subsyst_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_6 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AG9} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L7P_T1L_N0_QBC_AD13P_64} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {AF8} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L8P_T1L_N2_AD5P_64} \
   CONFIG.DATA_LANE1_IO_LOC {AH8} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L9P_T1L_N4_AD12P_64} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {64} \
   CONFIG.SupportLevel {0} \
 ] $mipi_csi2_rx_subsyst_6

set mipi_csi2_rx_subsyst_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_7 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AD5} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L13P_T2L_N0_GC_QBC_64} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {AC4} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L14P_T2L_N2_GC_64} \
   CONFIG.DATA_LANE1_IO_LOC {AB4} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L15P_T2L_N4_AD11P_64} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {64} \
   CONFIG.SupportLevel {0} \
 ] $mipi_csi2_rx_subsyst_7

set mipi_csi2_rx_subsyst_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.2 mipi_csi2_rx_subsyst_8 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AG4} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L19P_T3L_N0_DBC_AD9P_64} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_PXL_FORMAT {YUV422_8bit} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_HS_SETTLE_NS {153} \
   CONFIG.DATA_LANE0_IO_LOC {AG3} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L20P_T3L_N2_AD1P_64} \
   CONFIG.DATA_LANE1_IO_LOC {AE3} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L21P_T3L_N4_AD8P_64} \
   CONFIG.DPY_LINE_RATE {576} \
   CONFIG.C_EN_CSI_V2_0 {false} \
   CONFIG.CMN_INC_VFB {true} \
   CONFIG.DPY_EN_REG_IF {true} \
   CONFIG.CSI_EMB_NON_IMG {false} \
   CONFIG.VFB_TU_WIDTH {2} \
   CONFIG.HP_IO_BANK_SELECTION {64} \
   CONFIG.SupportLevel {0} \
 ] $mipi_csi2_rx_subsyst_8

ad_ip_instance clk_wiz dphy_clk_generator
ad_ip_parameter dphy_clk_generator CONFIG.PRIMITIVE PLL
ad_ip_parameter dphy_clk_generator CONFIG.RESET_TYPE ACTIVE_LOW
ad_ip_parameter dphy_clk_generator CONFIG.USE_LOCKED false
ad_ip_parameter dphy_clk_generator CONFIG.CLKOUT1_REQUESTED_OUT_FREQ 200.000
ad_ip_parameter dphy_clk_generator CONFIG.CLKOUT1_REQUESTED_PHASE 0.000
ad_ip_parameter dphy_clk_generator CONFIG.CLKOUT1_REQUESTED_DUTY_CYCLE 50.000
ad_ip_parameter dphy_clk_generator CONFIG.PRIM_SOURCE Global_buffer
ad_ip_parameter dphy_clk_generator CONFIG.CLKIN1_UI_JITTER 0

ad_ip_instance clk_wiz dphy_clk_generator1
ad_ip_parameter dphy_clk_generator1 CONFIG.PRIMITIVE PLL
ad_ip_parameter dphy_clk_generator1 CONFIG.RESET_TYPE ACTIVE_LOW
ad_ip_parameter dphy_clk_generator1 CONFIG.USE_LOCKED false
ad_ip_parameter dphy_clk_generator1 CONFIG.CLKOUT1_REQUESTED_OUT_FREQ 200.000
ad_ip_parameter dphy_clk_generator1 CONFIG.CLKOUT1_REQUESTED_PHASE 0.000
ad_ip_parameter dphy_clk_generator1 CONFIG.CLKOUT1_REQUESTED_DUTY_CYCLE 50.000
ad_ip_parameter dphy_clk_generator1 CONFIG.PRIM_SOURCE Global_buffer
ad_ip_parameter dphy_clk_generator1 CONFIG.CLKIN1_UI_JITTER 0
ad_ip_parameter dphy_clk_generator1 CONFIG.PRIM_IN_FREQ 250.000
ad_ip_parameter dphy_clk_generator1 CONFIG.PRIM_IN_FREQ 250.000

ad_connect dphy_clk_generator/clk_in1 $sys_dma_clk
ad_connect dphy_clk_generator/resetn $sys_dma_resetn

ad_connect dphy_clk_generator1/clk_in1 $sys_dma_clk
ad_connect dphy_clk_generator1/resetn $sys_dma_resetn

ad_connect mipi_csi2_rx_subsyst_1/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_1/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_1/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_1/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_1/dphy_clk_200M dphy_clk_generator/clk_out1
ad_connect mipi_csi2_rx_subsyst_1/clkoutphy_out mipi_csi2_rx_subsyst_2/clkoutphy_in
ad_connect mipi_csi2_rx_subsyst_1/pll_lock_out mipi_csi2_rx_subsyst_2/pll_lock_in
ad_connect mipi_csi2_rx_subsyst_1/clkoutphy_out mipi_csi2_rx_subsyst_3/clkoutphy_in
ad_connect mipi_csi2_rx_subsyst_1/pll_lock_out mipi_csi2_rx_subsyst_3/pll_lock_in
ad_connect mipi_csi2_rx_subsyst_1/clkoutphy_out mipi_csi2_rx_subsyst_4/clkoutphy_in
ad_connect mipi_csi2_rx_subsyst_1/pll_lock_out mipi_csi2_rx_subsyst_4/pll_lock_in

ad_connect mipi_csi2_rx_subsyst_2/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_2/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_2/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_2/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_2/dphy_clk_200M dphy_clk_generator/clk_out1

ad_connect mipi_csi2_rx_subsyst_3/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_3/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_3/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_3/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_3/dphy_clk_200M dphy_clk_generator/clk_out1

ad_connect mipi_csi2_rx_subsyst_4/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_4/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_4/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_4/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_4/dphy_clk_200M dphy_clk_generator/clk_out1

ad_connect mipi_csi2_rx_subsyst_5/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_5/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_5/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_5/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_5/dphy_clk_200M dphy_clk_generator1/clk_out1
ad_connect mipi_csi2_rx_subsyst_5/clkoutphy_out mipi_csi2_rx_subsyst_6/clkoutphy_in
ad_connect mipi_csi2_rx_subsyst_5/pll_lock_out mipi_csi2_rx_subsyst_6/pll_lock_in
ad_connect mipi_csi2_rx_subsyst_5/clkoutphy_out mipi_csi2_rx_subsyst_7/clkoutphy_in
ad_connect mipi_csi2_rx_subsyst_5/pll_lock_out mipi_csi2_rx_subsyst_7/pll_lock_in
ad_connect mipi_csi2_rx_subsyst_5/clkoutphy_out mipi_csi2_rx_subsyst_8/clkoutphy_in
ad_connect mipi_csi2_rx_subsyst_5/pll_lock_out mipi_csi2_rx_subsyst_8/pll_lock_in

ad_connect mipi_csi2_rx_subsyst_6/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_6/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_6/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_6/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_6/dphy_clk_200M dphy_clk_generator1/clk_out1

ad_connect mipi_csi2_rx_subsyst_7/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_7/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_7/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_7/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_7/dphy_clk_200M dphy_clk_generator1/clk_out1

ad_connect mipi_csi2_rx_subsyst_8/video_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_8/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_8/lite_aclk $sys_cpu_clk
ad_connect mipi_csi2_rx_subsyst_8/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi2_rx_subsyst_8/dphy_clk_200M dphy_clk_generator1/clk_out1

ad_connect mipi_csi2_rx_subsyst_1/mipi_phy_if_clk_n mipi_csi1_clk_n
ad_connect mipi_csi2_rx_subsyst_1/mipi_phy_if_clk_p mipi_csi1_clk_p
ad_connect mipi_csi2_rx_subsyst_1/mipi_phy_if_data_n mipi_csi1_data_n
ad_connect mipi_csi2_rx_subsyst_1/mipi_phy_if_data_p mipi_csi1_data_p

ad_connect mipi_csi2_rx_subsyst_2/mipi_phy_if_clk_n mipi_csi2_clk_n
ad_connect mipi_csi2_rx_subsyst_2/mipi_phy_if_clk_p mipi_csi2_clk_p
ad_connect mipi_csi2_rx_subsyst_2/mipi_phy_if_data_n mipi_csi2_data_n
ad_connect mipi_csi2_rx_subsyst_2/mipi_phy_if_data_p mipi_csi2_data_p

ad_connect mipi_csi2_rx_subsyst_3/mipi_phy_if_clk_n mipi_csi3_clk_n
ad_connect mipi_csi2_rx_subsyst_3/mipi_phy_if_clk_p mipi_csi3_clk_p
ad_connect mipi_csi2_rx_subsyst_3/mipi_phy_if_data_n mipi_csi3_data_n
ad_connect mipi_csi2_rx_subsyst_3/mipi_phy_if_data_p mipi_csi3_data_p

ad_connect mipi_csi2_rx_subsyst_4/mipi_phy_if_clk_n mipi_csi4_clk_n
ad_connect mipi_csi2_rx_subsyst_4/mipi_phy_if_clk_p mipi_csi4_clk_p
ad_connect mipi_csi2_rx_subsyst_4/mipi_phy_if_data_n mipi_csi4_data_n
ad_connect mipi_csi2_rx_subsyst_4/mipi_phy_if_data_p mipi_csi4_data_p

ad_connect mipi_csi2_rx_subsyst_5/mipi_phy_if_clk_n mipi_csi5_clk_n
ad_connect mipi_csi2_rx_subsyst_5/mipi_phy_if_clk_p mipi_csi5_clk_p
ad_connect mipi_csi2_rx_subsyst_5/mipi_phy_if_data_n mipi_csi5_data_n
ad_connect mipi_csi2_rx_subsyst_5/mipi_phy_if_data_p mipi_csi5_data_p

ad_connect mipi_csi2_rx_subsyst_6/mipi_phy_if_clk_n mipi_csi6_clk_n
ad_connect mipi_csi2_rx_subsyst_6/mipi_phy_if_clk_p mipi_csi6_clk_p
ad_connect mipi_csi2_rx_subsyst_6/mipi_phy_if_data_n mipi_csi6_data_n
ad_connect mipi_csi2_rx_subsyst_6/mipi_phy_if_data_p mipi_csi6_data_p

ad_connect mipi_csi2_rx_subsyst_7/mipi_phy_if_clk_n mipi_csi7_clk_n
ad_connect mipi_csi2_rx_subsyst_7/mipi_phy_if_clk_p mipi_csi7_clk_p
ad_connect mipi_csi2_rx_subsyst_7/mipi_phy_if_data_n mipi_csi7_data_n
ad_connect mipi_csi2_rx_subsyst_7/mipi_phy_if_data_p mipi_csi7_data_p

ad_connect mipi_csi2_rx_subsyst_8/mipi_phy_if_clk_n mipi_csi8_clk_n
ad_connect mipi_csi2_rx_subsyst_8/mipi_phy_if_clk_p mipi_csi8_clk_p
ad_connect mipi_csi2_rx_subsyst_8/mipi_phy_if_data_n mipi_csi8_data_n
ad_connect mipi_csi2_rx_subsyst_8/mipi_phy_if_data_p mipi_csi8_data_p

ad_cpu_interconnect 0x44A00000  mipi_csi2_rx_subsyst_1
ad_cpu_interconnect 0x44A10000  mipi_csi2_rx_subsyst_2
ad_cpu_interconnect 0x44A20000  mipi_csi2_rx_subsyst_3
ad_cpu_interconnect 0x44A30000  mipi_csi2_rx_subsyst_4
ad_cpu_interconnect 0x44A40000  mipi_csi2_rx_subsyst_5
ad_cpu_interconnect 0x44A50000  mipi_csi2_rx_subsyst_6
ad_cpu_interconnect 0x44A60000  mipi_csi2_rx_subsyst_7
ad_cpu_interconnect 0x44A70000  mipi_csi2_rx_subsyst_8

ad_cpu_interrupt ps-13 mb-12 mipi_csi2_rx_subsyst_1/csirxss_csi_irq
ad_cpu_interrupt ps-12 mb-11 mipi_csi2_rx_subsyst_2/csirxss_csi_irq
ad_cpu_interrupt ps-11 mb-10 mipi_csi2_rx_subsyst_3/csirxss_csi_irq
ad_cpu_interrupt ps-10 mb-9 mipi_csi2_rx_subsyst_4/csirxss_csi_irq
ad_cpu_interrupt ps-9 mb-8 mipi_csi2_rx_subsyst_5/csirxss_csi_irq
ad_cpu_interrupt ps-8 mb-7 mipi_csi2_rx_subsyst_6/csirxss_csi_irq
ad_cpu_interrupt ps-7 mb-6 mipi_csi2_rx_subsyst_7/csirxss_csi_irq
ad_cpu_interrupt ps-6 mb-5 mipi_csi2_rx_subsyst_8/csirxss_csi_irq

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/mem_init_sys.txt"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9

sysid_gen_sys_init_file
