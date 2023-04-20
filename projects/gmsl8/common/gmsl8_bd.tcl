# gmsl8 common bd file

source $ad_hdl_dir/projects/scripts/adi_pd.tcl

create_bd_port -dir I mipi_csi_ch0_clk_p
create_bd_port -dir I mipi_csi_ch0_clk_n
create_bd_port -dir I -from 1 -to 0 mipi_csi_ch0_data_p
create_bd_port -dir I -from 1 -to 0 mipi_csi_ch0_data_n

#create_bd_port -dir I mipi_csi_ch1_clk_p
#create_bd_port -dir I mipi_csi_ch1_clk_n
#create_bd_port -dir I -from 3 -to 0 mipi_csi_ch1_data_p
#create_bd_port -dir I -from 3 -to 0 mipi_csi_ch1_data_n

#create_bd_port -dir I bg3_pin0_nc
create_bd_port -dir I bg3_pin6_nc

ad_ip_parameter sys_ps8 CONFIG.PSU__USE__VIDEO {1}
#ad_ip_parameter sys_ps8 CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {0}
ad_ip_parameter sys_ps8 CONFIG.PSU__DP__LANE_SEL {Single Lower}

# mipi rx subsystem instances

ad_ip_instance mipi_csi2_rx_subsystem mipi_csi_ch0
ad_ip_parameter mipi_csi_ch0 CONFIG.C_CSI_EN_CRC {false}
ad_ip_parameter mipi_csi_ch0 CONFIG.CMN_PXL_FORMAT {YUV422_8bit}
ad_ip_parameter mipi_csi_ch0 CONFIG.CMN_INC_VFB {true}
ad_ip_parameter mipi_csi_ch0 CONFIG.CMN_NUM_LANES {2}
ad_ip_parameter mipi_csi_ch0 CONFIG.VFB_TU_WIDTH {1}
ad_ip_parameter mipi_csi_ch0 CONFIG.CMN_NUM_PIXELS {1}
ad_ip_parameter mipi_csi_ch0 CONFIG.DPY_LINE_RATE {456}
ad_ip_parameter mipi_csi_ch0 CONFIG.C_EN_CSI_V2_0 {false}
ad_ip_parameter mipi_csi_ch0 CONFIG.DPY_EN_REG_IF {true}
ad_ip_parameter mipi_csi_ch0 CONFIG.CSI_EMB_NON_IMG {false}

# config for bank 66
#set_property -dict [list \
#  CONFIG.CLK_LANE_IO_LOC {AB4} \
#  CONFIG.DATA_LANE0_IO_LOC {AC2} \
#  CONFIG.DATA_LANE1_IO_LOC {AB3} \
#  CONFIG.DATA_LANE2_IO_LOC {W5} \
#  CONFIG.DATA_LANE3_IO_LOC {W2} \
#  CONFIG.HP_IO_BANK_SELECTION {66} \
#] [get_bd_cells mipi_csi_ch0]

set_property -dict [list \
  CONFIG.CLK_LANE_IO_LOC {AJ6} \
  CONFIG.DATA_LANE0_IO_LOC {AH2} \
  CONFIG.DATA_LANE1_IO_LOC {AG3} \
  CONFIG.HP_IO_BANK_SELECTION {65} \
] [get_bd_cells mipi_csi_ch0]

#  CONFIG.DATA_LANE2_IO_LOC {AH4} \
#  CONFIG.DATA_LANE3_IO_LOC {AE2} \

ad_ip_parameter mipi_csi_ch0 CONFIG.SupportLevel {1}
ad_ip_parameter mipi_csi_ch0 CONFIG.C_HS_SETTLE_NS {143}
ad_ip_parameter mipi_csi_ch0 CONFIG.C_CSI_FILTER_USERDATATYPE {false}

#ad_ip_instance mipi_csi2_rx_subsystem mipi_csi_ch1
#ad_ip_parameter mipi_csi_ch1 CONFIG.C_CSI_EN_CRC {false}
#ad_ip_parameter mipi_csi_ch1 CONFIG.CMN_PXL_FORMAT {YUV422_8bit}
#ad_ip_parameter mipi_csi_ch1 CONFIG.CMN_INC_VFB {true}
#ad_ip_parameter mipi_csi_ch1 CONFIG.CMN_NUM_LANES {4}
#ad_ip_parameter mipi_csi_ch1 CONFIG.VFB_TU_WIDTH {1}
#ad_ip_parameter mipi_csi_ch1 CONFIG.CMN_NUM_PIXELS {2}
#ad_ip_parameter mipi_csi_ch1 CONFIG.DPY_LINE_RATE {148}
#ad_ip_parameter mipi_csi_ch1 CONFIG.C_EN_CSI_V2_0 {false}
#ad_ip_parameter mipi_csi_ch1 CONFIG.DPY_EN_REG_IF {true}
#ad_ip_parameter mipi_csi_ch1 CONFIG.CSI_EMB_NON_IMG {false}
#ad_ip_parameter mipi_csi_ch1 CONFIG.SupportLevel {1}
#ad_ip_parameter mipi_csi_ch1 CONFIG.C_HS_SETTLE_NS {143}
#ad_ip_parameter mipi_csi_ch1 CONFIG.C_CSI_FILTER_USERDATATYPE {false}

# config for bank 66
#set_property -dict [list \
#  CONFIG.CLK_LANE_IO_LOC {Y4} \
#  CONFIG.DATA_LANE0_IO_LOC {V2} \
#  CONFIG.DATA_LANE1_IO_LOC {Y2} \
#  CONFIG.DATA_LANE2_IO_LOC {AA2} \
#  CONFIG.DATA_LANE3_IO_LOC {V4} \
#  CONFIG.HP_IO_BANK_SELECTION {66} \
#] [get_bd_cells mipi_csi_ch1]

#set_property -dict [list \
#  CONFIG.CLK_LANE_IO_LOC {AE5} \
#  CONFIG.DATA_LANE0_IO_LOC {AD2} \
#  CONFIG.DATA_LANE1_IO_LOC {AH1} \
#  CONFIG.DATA_LANE2_IO_LOC {AF2} \
#  CONFIG.DATA_LANE3_IO_LOC {AE3} \
#  CONFIG.HP_IO_BANK_SELECTION {65} \
#] [get_bd_cells mipi_csi_ch1]

# Line rate  - 148 Mbps - 1920 x 1080 camera at 30 fps and MIPI with 4 lanes
# video_aclk min = min 37 MHz
#


# dphy_clk_200M generator

ad_ip_instance clk_wiz dphy_clk_generator
ad_ip_parameter dphy_clk_generator CONFIG.PRIMITIVE PLL
ad_ip_parameter dphy_clk_generator CONFIG.RESET_TYPE ACTIVE_LOW
ad_ip_parameter dphy_clk_generator CONFIG.USE_LOCKED false
ad_ip_parameter dphy_clk_generator CONFIG.CLKOUT1_REQUESTED_OUT_FREQ 200.000
ad_ip_parameter dphy_clk_generator CONFIG.CLKOUT1_REQUESTED_PHASE 0.000
ad_ip_parameter dphy_clk_generator CONFIG.CLKOUT1_REQUESTED_DUTY_CYCLE 50.000
ad_ip_parameter dphy_clk_generator CONFIG.PRIM_SOURCE Global_buffer
ad_ip_parameter dphy_clk_generator CONFIG.CLKIN1_UI_JITTER 0
ad_ip_parameter dphy_clk_generator CONFIG.PRIM_IN_FREQ 250.000

# VDMA instance

ad_ip_instance axi_vdma axi_vdma
ad_ip_parameter axi_vdma CONFIG.C_ADDR_WIDTH {32}
ad_ip_parameter axi_vdma CONFIG.C_INCLUDE_S2MM {1}
ad_ip_parameter axi_vdma CONFIG.C_M_AXI_S2MM_DATA_WIDTH {64}
#set_property  CONFIG.c_include_mm2s {0}  [get_bd_cells axi_vdma]
ad_ip_parameter axi_vdma CONFIG.C_S2MM_MAX_BURST_LENGTH {64}
ad_ip_parameter axi_vdma CONFIG.C_S_AXIS_S2MM_TDATA_WIDTH {16}
ad_ip_parameter axi_vdma CONFIG.C_PRMRY_IS_ACLK_ASYNC {1}
ad_ip_parameter axi_vdma CONFIG.C_USE_S2MM_FSYNC {2}
ad_ip_parameter axi_vdma CONFIG.C_S2MM_GENLOCK_MODE {2}
ad_ip_parameter axi_vdma CONFIG.C_INCLUDE_S2MM_DRE {0}
ad_ip_parameter axi_vdma CONIFG.C_ENABLE_VERT_FLIP {0}
ad_ip_parameter axi_vdma CONIFG.C_INCLUDE_MM2S {1}
ad_ip_parameter axi_vdma CONFIG.C_M_AXIS_MM2S_TDATA_WIDTH {16}
ad_ip_parameter axi_vdma CONIFG.C_USE_MM2S_FSYNC {0}

# video timing controller instance
#
ad_ip_instance v_tc axi_v_timing
ad_ip_parameter axi_v_timing CONFIG.HAS_AXI4_LITE {false}
ad_ip_parameter axi_v_timing CONFIG.HAS_INTC_IF {false}
ad_ip_parameter axi_v_timing CONFIG.INTERLACE_EN {false}
ad_ip_parameter axi_v_timing CONFIG.SYNC_EN {false}
ad_ip_parameter axi_v_timing CONFIG.VIDEO_MODE {1080p}
ad_ip_parameter axi_v_timing CONFIG.active_chroma_generation {false}
ad_ip_parameter axi_v_timing CONFIG.active_video_generation {true}
ad_ip_parameter axi_v_timing CONFIG.enable_detection {false}
ad_ip_parameter axi_v_timing CONFIG.frame_syncs {1}
ad_ip_parameter axi_v_timing CONFIG.horizontal_blank_generation {true}
ad_ip_parameter axi_v_timing CONFIG.horizontal_sync_generation {true}
ad_ip_parameter axi_v_timing CONFIG.vertical_blank_generation {true}
ad_ip_parameter axi_v_timing CONFIG.vertical_sync_generation {true}
ad_ip_parameter axi_v_timing CONFIG.INTERLACE_EN {true}
ad_ip_parameter axi_v_timing CONFIG.GEN_FIELDID_EN {true}

ad_ip_instance v_axi4s_vid_out axi_v_out
ad_ip_parameter axi_v_out CONFIG.C_S_AXIS_VIDEO_FORMAT {0}
ad_ip_parameter axi_v_out CONFIG.C_VTG_MASTER_SLAVE {0}

ad_ip_instance xlconstant xlconstant_0
ad_ip_parameter xlconstant_0 CONFIG.CONST_VAL {0}

ad_ip_instance xlconstant xlconstant_1
ad_ip_parameter xlconstant_1 CONFIG.CONST_VAL {1}

# MIPI receivers' connections

ad_connect mipi_csi_ch0/mipi_phy_if_clk_n mipi_csi_ch0_clk_n
ad_connect mipi_csi_ch0/mipi_phy_if_clk_p mipi_csi_ch0_clk_p
ad_connect mipi_csi_ch0/mipi_phy_if_data_n mipi_csi_ch0_data_n
ad_connect mipi_csi_ch0/mipi_phy_if_data_p mipi_csi_ch0_data_p

#ad_connect mipi_csi_ch1/mipi_phy_if_clk_n mipi_csi_ch1_clk_n
#ad_connect mipi_csi_ch1/mipi_phy_if_clk_p mipi_csi_ch1_clk_p
#ad_connect mipi_csi_ch1/mipi_phy_if_data_n mipi_csi_ch1_data_n
#ad_connect mipi_csi_ch1/mipi_phy_if_data_p mipi_csi_ch1_data_p

ad_connect mipi_csi_ch0/video_out axi_vdma/S_AXIS_S2MM
ad_connect axi_vdma/M_AXIS_MM2S axi_v_out/video_in

ad_connect dphy_clk_generator/clk_in1 $sys_dma_clk
ad_connect dphy_clk_generator/resetn $sys_dma_resetn

# shared resources between ch0 - acts as master ss with shared logic inside core and ch1 - shared logic outside core
#ad_connect mipi_csi_ch0/clkoutphy_out mipi_csi_ch1/clkoutphy_in
#ad_connect mipi_csi_ch0/pll_lock_out mipi_csi_ch1/pll_lock_in

ad_connect mipi_csi_ch0/video_aclk $sys_cpu_clk
ad_connect mipi_csi_ch0/video_aresetn $sys_cpu_resetn
ad_connect mipi_csi_ch0/lite_aclk $sys_cpu_clk
ad_connect mipi_csi_ch0/lite_aresetn $sys_cpu_resetn
ad_connect mipi_csi_ch0/dphy_clk_200M dphy_clk_generator/clk_out1
ad_connect mipi_csi_ch0/bg3_pin6_nc bg3_pin6_nc

#ad_connect mipi_csi_ch1/video_aclk $sys_cpu_clk
#ad_connect mipi_csi_ch1/video_aresetn $sys_cpu_resetn
#ad_connect mipi_csi_ch1/lite_aclk $sys_cpu_clk
#ad_connect mipi_csi_ch1/lite_aresetn $sys_cpu_resetn
#ad_connect mipi_csi_ch1/dphy_clk_200M dphy_clk_generator/clk_out1
#ad_connect mipi_csi_ch1/bg3_pin0_nc bg3_pin0_nc

ad_connect axi_vdma/s_axi_lite_aclk $sys_cpu_clk
ad_connect axi_vdma/m_axi_s2mm_aclk $sys_cpu_clk
ad_connect axi_vdma/m_axi_mm2s_aclk $sys_cpu_clk
ad_connect axi_vdma/s_axis_s2mm_aclk $sys_cpu_clk
ad_connect axi_vdma/m_axis_mm2s_aclk $sys_cpu_clk
ad_connect axi_vdma/axi_resetn $sys_cpu_resetn

ad_connect axi_v_out/vid_active_video sys_ps8/dp_live_video_in_de

ad_ip_instance xlslice xlslice_cr_b
ad_ip_parameter xlslice_cr_b CONFIG.DIN_WIDTH 16
ad_ip_parameter xlslice_cr_b CONFIG.DIN_FROM 15
ad_ip_parameter xlslice_cr_b CONFIG.DIN_TO 8

ad_ip_instance xlslice xlslice_y_b
ad_ip_parameter xlslice_y_b CONFIG.DIN_WIDTH 16
ad_ip_parameter xlslice_y_b CONFIG.DIN_FROM 7
ad_ip_parameter xlslice_y_b CONFIG.DIN_TO 0

ad_ip_instance xlconcat xlconcat_dp_vd
ad_ip_parameter xlconcat_dp_vd CONFIG.NUM_PORTS 4
ad_ip_parameter xlconcat_dp_vd CONFIG.IN0_WIDTH 8
ad_ip_parameter xlconcat_dp_vd CONFIG.IN1_WIDTH 4
ad_ip_parameter xlconcat_dp_vd CONFIG.IN2_WIDTH 8
ad_ip_parameter xlconcat_dp_vd CONFIG.IN3_WIDTH 16

ad_ip_instance xlconstant xlconstant_0_4b
ad_ip_parameter xlconstant_0_4b CONFIG.CONST_WIDTH 4
ad_ip_parameter xlconstant_0_4b CONFIG.CONST_VAL 0

ad_ip_instance xlconstant xlconstant_0_16b
ad_ip_parameter xlconstant_0_16b CONFIG.CONST_WIDTH 16
ad_ip_parameter xlconstant_0_16b CONFIG.CONST_VAL 0

ad_connect xlslice_cr_b/Din axi_v_out/vid_data
ad_connect xlslice_y_b/Din axi_v_out/vid_data
ad_connect xlconcat_dp_vd/In0 xlslice_cr_b/Dout
ad_connect xlconcat_dp_vd/In1 xlconstant_0_4b/dout
ad_connect xlconcat_dp_vd/In2 xlslice_y_b/Dout
ad_connect xlconcat_dp_vd/In3 xlconstant_0_16b/dout

#ad_connect axi_v_out/vid_data sys_ps8/dp_live_video_in_pixel1
ad_connect xlconcat_dp_vd/dout sys_ps8/dp_live_video_in_pixel1

ad_connect axi_v_out/vid_hsync sys_ps8/dp_live_video_in_hsync
ad_connect axi_v_out/vid_vsync sys_ps8/dp_live_video_in_vsync
ad_connect axi_v_out/vtg_ce axi_v_timing/gen_clken
ad_connect axi_v_out/vtiming_in axi_v_timing/vtiming_out
ad_connect axi_v_out/sof_state_out axi_v_timing/sof_state
ad_connect axi_v_out/fid xlconstant_0/dout
ad_connect axi_v_out/aclk $sys_cpu_clk
ad_connect axi_v_out/aclken xlconstant_1/dout
ad_connect axi_v_out/aresetn $sys_cpu_resetn
ad_connect axi_v_out/vid_io_out_ce xlconstant_1/dout

ad_connect axi_v_timing/clken xlconstant_1/dout
ad_connect axi_v_timing/clk $sys_cpu_clk
ad_connect axi_v_timing/resetn $sys_cpu_resetn

ad_connect sys_ps8/dp_video_in_clk $sys_cpu_clk

# Interconnects

ad_cpu_interconnect 0x44A00000  mipi_csi_ch0
#ad_cpu_interconnect 0x44A10000  mipi_csi_ch1
ad_cpu_interconnect 0x44A20000  axi_vdma

ad_mem_hp1_interconnect $sys_cpu_clk sys_ps7/S_AXI_HP1
ad_mem_hp1_interconnect $sys_cpu_clk axi_vdma/M_AXI_S2MM
ad_mem_hp1_interconnect $sys_cpu_clk axi_vdma/M_AXI_MM2S

# Interrrupts

ad_cpu_interrupt ps-13 mb-12 mipi_csi_ch0/csirxss_csi_irq
#ad_cpu_interrupt ps-12 mb-11 mipi_csi_ch1/csirxss_csi_irq
ad_cpu_interrupt ps-11 mb-6 axi_vdma/s2mm_introut
ad_cpu_interrupt ps-10 mb-5 axi_vdma/mm2s_introut

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/mem_init_sys.txt"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9

sysid_gen_sys_init_file
