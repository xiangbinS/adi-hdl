# --(C) Copyright 2020 - 2021 Xilinx, Inc.
# --Copyright (C) 2022, Advanced Micro Devices, Inc
# --SPDX-License-Identifier: Apache-2.0

#######################################################
##                                                   ##
## Design Constraints                                ##
## Date: 04 MAY 2021                                 ##
##                                                   ##
#######################################################
## enable tx by forcing 0 from design. sfp0,1,2,3 => a12, a13, b13, c13
#set_property PACKAGE_PIN K16 [get_ports sfp_tx_dis]
#set_property IOSTANDARD LVCMOS18 [get_ports sfp_tx_dis]

#set_property PACKAGE_PIN K11 [get_ports SI53340_MUX_GT_SEL]
#set_property IOSTANDARD LVCMOS18 [get_ports SI53340_MUX_GT_SEL]
#sfp2
#set_property PACKAGE_PIN J30 [get_ports sfp2_1x_gtx_p]
#set_property PACKAGE_PIN K33 [get_ports sfp2_1x_grx_p]
set_property PACKAGE_PIN D2 [get_ports sfp2_1x_grx_p]
set_property PACKAGE_PIN E4 [get_ports sfp2_1x_gtx_p]

#USER_MGT_SI570_CLOCK2_C_P
create_clock -period 6.4 [get_ports user_idt_clock_clk_p]
set_property PACKAGE_PIN C8 [get_ports user_idt_clock_clk_p]
#set_property IOSTANDARD LVDS [get_ports default_sysclk_c0_300mhz_clk_n]
#set_property IOSTANDARD LVDS [get_ports default_sysclk_c0_300mhz_clk_p]
#set_property PACKAGE_PIN AR20 [get_ports default_sysclk_c0_300mhz_clk_p]
#set_property PACKAGE_PIN AR19 [get_ports default_sysclk_c0_300mhz_clk_n]
#create_clock -name default_sysclk_c0_300mhz_clk_p -period 3.333 [get_ports default_sysclk_c0_300mhz_clk_p]

#create_clock -period 4 [get_ports CLK_IN_D_ts_clk_clk_p]
#set_property PACKAGE_PIN E12 [get_ports CLK_IN_D_ts_clk_clk_p]
#set_property IOSTANDARD  LVDS  [get_ports CLK_IN_D_ts_clk_clk_p]
#set_property PACKAGE_PIN D12 [get_ports CLK_IN_D_ts_clk_clk_n]
#set_property IOSTANDARD  LVDS  [get_ports CLK_IN_D_ts_clk_clk_n]

#create_clock -period 4 [get_ports One_pps_in_clk_p]
#set_property PACKAGE_PIN F10 [get_ports One_pps_in_clk_p]
#set_property IOSTANDARD  LVDS_25 [get_ports One_pps_in_clk_p]
#set_property PACKAGE_PIN F9 [get_ports One_pps_in_clk_n]
#set_property IOSTANDARD LVDS_25  [get_ports One_pps_in_clk_n]

#LED 2 and 3
# led 0 .. 7 =>
set_property IOSTANDARD LVCMOS25 [get_ports {axi_lite_clk_led}]
set_property IOSTANDARD LVCMOS25 [get_ports {rx_clk_led}]
set_property IOSTANDARD LVCMOS25 [get_ports {axil_reset_led}]
set_property PACKAGE_PIN AF13 [get_ports {axil_reset_led}]
set_property PACKAGE_PIN AJ14 [get_ports {axi_lite_clk_led}]
set_property PACKAGE_PIN AH14 [get_ports {rx_clk_led}]

#set_property PACKAGE_PIN A9 [get_ports one_pps]
#set_property IOSTANDARD LVCMOS18 [get_ports one_pps]
#set_false_path -to [get_ports one_pps]

set_false_path -to [get_cells -hierarchical -filter {NAME =~ */vio_0/inst/PROBE_IN_INST/probe_in_reg_reg[*]}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ */i_*_axi_if_top/*/i_*_syncer/*meta_reg*}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ */i_*_SYNC*/*stretch_reg*}]

#may or may not be a good solution to the methodology warnings
set_max_delay -from [get_clocks clk_pl_0] -to [get_clocks clk] -datapath_only 6.4

#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -datapath_only 6.4
#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -datapath_only 6.4

#set_max_delay -from [get_clocks clk_pl_0] -to [get_clocks clk_pl_1] -datapath_only 6.4
#set_max_delay -from [get_clocks clk_pl_1] -to [get_clocks clk_pl_0] -datapath_only 10

#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks clk_pl_0] -datapath_only 6.4
#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks clk_pl_0] -datapath_only 6.4
#set_max_delay -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -datapath_only 6.4
#set_max_delay -from [get_clocks clk_pl_0] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -datapath_only 6.4

#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks clk_pl_1] -datapath_only 6.4
#set_max_delay -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks clk_pl_1] -datapath_only 6.4
#set_max_delay -from [get_clocks clk_pl_1] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -datapath_only 10
#set_max_delay -from [get_clocks clk_pl_1] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -datapath_only 10

# not needed?
#set_max_delay -from [get_clocks {CLK_IN_D_ts_clk_clk_p[*]}] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -datapath_only 4
#set_max_delay -from [get_clocks {CLK_IN_D_ts_clk_clk_p[*]}] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -datapath_only 4

#set_max_delay -from [get_clocks clk_pl_1] -to [get_clocks {CLK_IN_D_ts_clk_clk_p[*]}] 10.0


#commented by default

#######################################################
##                                                   ##
## ZCU670 Master XDC [ZU67DR]                        ##
## Date: 04 MAY 2021                                 ##
##                                                   ##
#######################################################
#set_property PACKAGE_PIN D12      [get_ports "8A34001_Q3_OUT_N"] ;# Bank  67 VCCO - VCC1V8   - IO_L12N_T1U_N11_GC_67
#set_property IOSTANDARD  LVDS [get_ports "8A34001_Q3_OUT_N"] ;# Bank  67 VCCO - VCC1V8   - IO_L12N_T1U_N11_GC_67
#set_property PACKAGE_PIN E12      [get_ports "8A34001_Q3_OUT_P"] ;# Bank  67 VCCO - VCC1V8   - IO_L12P_T1U_N10_GC_67
#set_property IOSTANDARD  LVDS [get_ports "8A34001_Q3_OUT_P"] ;# Bank  67 VCCO - VCC1V8   - IO_L12P_T1U_N10_GC_67
#set_property PACKAGE_PIN D14      [get_ports "SI5381_CLK_125_N"] ;# Bank  67 VCCO - VCC1V8   - IO_L11N_T1U_N9_GC_67
#set_property IOSTANDARD  LVDS [get_ports "SI5381_CLK_125_N"] ;# Bank  67 VCCO - VCC1V8   - IO_L11N_T1U_N9_GC_67
#set_property PACKAGE_PIN E14      [get_ports "SI5381_CLK_125_P"] ;# Bank  67 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_67
#set_property IOSTANDARD  LVDS [get_ports "SI5381_CLK_125_P"] ;# Bank  67 VCCO - VCC1V8   - IO_L11P_T1U_N8_GC_67
#set_property PACKAGE_PIN A12      [get_ports "SI5381_CLK2_IN_C_N"] ;# Bank  67 VCCO - VCC1V8   - IO_L10N_T1U_N7_QBC_AD4N_67
#set_property IOSTANDARD  LVDS [get_ports "SI5381_CLK2_IN_C_N"] ;# Bank  67 VCCO - VCC1V8   - IO_L10N_T1U_N7_QBC_AD4N_67
#set_property PACKAGE_PIN B12      [get_ports "SI5381_CLK2_IN_C_P"] ;# Bank  67 VCCO - VCC1V8   - IO_L10P_T1U_N6_QBC_AD4P_67
#set_property IOSTANDARD  LVDS [get_ports "SI5381_CLK2_IN_C_P"] ;# Bank  67 VCCO - VCC1V8   - IO_L10P_T1U_N6_QBC_AD4P_67
#set_property PACKAGE_PIN A13      [get_ports "ADCIO_00"] ;# Bank  67 VCCO - VCC1V8   - IO_L9N_T1L_N5_AD12N_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_00"] ;# Bank  67 VCCO - VCC1V8   - IO_L9N_T1L_N5_AD12N_67
#set_property PACKAGE_PIN A14      [get_ports "ADCIO_01"] ;# Bank  67 VCCO - VCC1V8   - IO_L9P_T1L_N4_AD12P_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_01"] ;# Bank  67 VCCO - VCC1V8   - IO_L9P_T1L_N4_AD12P_67
#set_property PACKAGE_PIN B13      [get_ports "ADCIO_02"] ;# Bank  67 VCCO - VCC1V8   - IO_L8N_T1L_N3_AD5N_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_02"] ;# Bank  67 VCCO - VCC1V8   - IO_L8N_T1L_N3_AD5N_67
#set_property PACKAGE_PIN C14      [get_ports "ADCIO_03"] ;# Bank  67 VCCO - VCC1V8   - IO_L8P_T1L_N2_AD5P_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_03"] ;# Bank  67 VCCO - VCC1V8   - IO_L8P_T1L_N2_AD5P_67
#set_property PACKAGE_PIN C13      [get_ports "ADCIO_04"] ;# Bank  67 VCCO - VCC1V8   - IO_L7N_T1L_N1_QBC_AD13N_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_04"] ;# Bank  67 VCCO - VCC1V8   - IO_L7N_T1L_N1_QBC_AD13N_67
#set_property PACKAGE_PIN D13      [get_ports "ADCIO_05"] ;# Bank  67 VCCO - VCC1V8   - IO_L7P_T1L_N0_QBC_AD13P_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_05"] ;# Bank  67 VCCO - VCC1V8   - IO_L7P_T1L_N0_QBC_AD13P_67
#set_property PACKAGE_PIN K20      [get_ports "TDD_TRIGGER_IN"] ;# Bank  67 VCCO - VCC1V8   - IO_T1U_N12_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "TDD_TRIGGER_IN"] ;# Bank  67 VCCO - VCC1V8   - IO_T1U_N12_67
#set_property PACKAGE_PIN L20      [get_ports "VRP_67"] ;# Bank  67 VCCO - VCC1V8   - IO_T0U_N12_VRP_67
#set_property IOSTANDARD  LVCMOSxx [get_ports "VRP_67"] ;# Bank  67 VCCO - VCC1V8   - IO_T0U_N12_VRP_67
#set_property PACKAGE_PIN F12      [get_ports "CLK104_CLK_SPI_MUX_SEL0_LS"] ;# Bank  67 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "CLK104_CLK_SPI_MUX_SEL0_LS"] ;# Bank  67 VCCO - VCC1V8   - IO_L6N_T0U_N11_AD6N_67
#set_property PACKAGE_PIN G12      [get_ports "CLK104_CLK_SPI_MUX_SEL1_LS"] ;# Bank  67 VCCO - VCC1V8   - IO_L6P_T0U_N10_AD6P_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "CLK104_CLK_SPI_MUX_SEL1_LS"] ;# Bank  67 VCCO - VCC1V8   - IO_L6P_T0U_N10_AD6P_67
#set_property PACKAGE_PIN F13      [get_ports "ADCIO_06"] ;# Bank  67 VCCO - VCC1V8   - IO_L5N_T0U_N9_AD14N_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_06"] ;# Bank  67 VCCO - VCC1V8   - IO_L5N_T0U_N9_AD14N_67
#set_property PACKAGE_PIN F14      [get_ports "ADCIO_07"] ;# Bank  67 VCCO - VCC1V8   - IO_L5P_T0U_N8_AD14P_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "ADCIO_07"] ;# Bank  67 VCCO - VCC1V8   - IO_L5P_T0U_N8_AD14P_67
#set_property PACKAGE_PIN G13      [get_ports "DACIO_00"] ;# Bank  67 VCCO - VCC1V8   - IO_L4N_T0U_N7_DBC_AD7N_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_00"] ;# Bank  67 VCCO - VCC1V8   - IO_L4N_T0U_N7_DBC_AD7N_67
#set_property PACKAGE_PIN H13      [get_ports "DACIO_01"] ;# Bank  67 VCCO - VCC1V8   - IO_L4P_T0U_N6_DBC_AD7P_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_01"] ;# Bank  67 VCCO - VCC1V8   - IO_L4P_T0U_N6_DBC_AD7P_67
#set_property PACKAGE_PIN J13      [get_ports "DACIO_02"] ;# Bank  67 VCCO - VCC1V8   - IO_L3N_T0L_N5_AD15N_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_02"] ;# Bank  67 VCCO - VCC1V8   - IO_L3N_T0L_N5_AD15N_67
#set_property PACKAGE_PIN J14      [get_ports "DACIO_03"] ;# Bank  67 VCCO - VCC1V8   - IO_L3P_T0L_N4_AD15P_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_03"] ;# Bank  67 VCCO - VCC1V8   - IO_L3P_T0L_N4_AD15P_67
#set_property PACKAGE_PIN H14      [get_ports "DACIO_04"] ;# Bank  67 VCCO - VCC1V8   - IO_L2N_T0L_N3_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_04"] ;# Bank  67 VCCO - VCC1V8   - IO_L2N_T0L_N3_67
#set_property PACKAGE_PIN H15      [get_ports "DACIO_05"] ;# Bank  67 VCCO - VCC1V8   - IO_L2P_T0L_N2_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_05"] ;# Bank  67 VCCO - VCC1V8   - IO_L2P_T0L_N2_67
#set_property PACKAGE_PIN K14      [get_ports "DACIO_06"] ;# Bank  67 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_06"] ;# Bank  67 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_67
#set_property PACKAGE_PIN K15      [get_ports "DACIO_07"] ;# Bank  67 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_67
#set_property IOSTANDARD  LVCMOS18 [get_ports "DACIO_07"] ;# Bank  67 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_67
#set_property PACKAGE_PIN AF10     [get_ports "PL_DDR4_C0_CKE"] ;# Bank  66 VCCO - VCC1V2   - IO_L24N_T3U_N11_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_CKE"] ;# Bank  66 VCCO - VCC1V2   - IO_L24N_T3U_N11_66
#set_property PACKAGE_PIN AE11     [get_ports "PL_DDR4_C0_RESET_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L24P_T3U_N10_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "PL_DDR4_C0_RESET_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L24P_T3U_N10_66
#set_property PACKAGE_PIN AF11     [get_ports "PL_DDR4_C0_CAS_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L23N_T3U_N9_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_CAS_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L23N_T3U_N9_66
#set_property PACKAGE_PIN AF12     [get_ports "PL_DDR4_C0_CS1_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L23P_T3U_N8_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_CS1_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L23P_T3U_N8_66
#set_property PACKAGE_PIN AJ9      [get_ports "PL_DDR4_C0_WE_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L22N_T3U_N7_DBC_AD0N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_WE_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L22N_T3U_N7_DBC_AD0N_66
#set_property PACKAGE_PIN AJ10     [get_ports "PL_DDR4_C0_ALERT_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L22P_T3U_N6_DBC_AD0P_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "PL_DDR4_C0_ALERT_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L22P_T3U_N6_DBC_AD0P_66
#set_property PACKAGE_PIN AG9      [get_ports "PL_DDR4_C0_BG0"] ;# Bank  66 VCCO - VCC1V2   - IO_L21N_T3L_N5_AD8N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_BG0"] ;# Bank  66 VCCO - VCC1V2   - IO_L21N_T3L_N5_AD8N_66
#set_property PACKAGE_PIN AG10     [get_ports "PL_DDR4_C0_BG1"] ;# Bank  66 VCCO - VCC1V2   - IO_L21P_T3L_N4_AD8P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_BG1"] ;# Bank  66 VCCO - VCC1V2   - IO_L21P_T3L_N4_AD8P_66
#set_property PACKAGE_PIN AH9      [get_ports "PL_DDR4_C0_ACT_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L20N_T3L_N3_AD1N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_ACT_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L20N_T3L_N3_AD1N_66
#set_property PACKAGE_PIN AH10     [get_ports "PL_DDR4_C0_ODT"] ;# Bank  66 VCCO - VCC1V2   - IO_L20P_T3L_N2_AD1P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_ODT"] ;# Bank  66 VCCO - VCC1V2   - IO_L20P_T3L_N2_AD1P_66
#set_property PACKAGE_PIN AG11     [get_ports "PL_DDR4_C0_RAS_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L19N_T3L_N1_DBC_AD9N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_RAS_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L19N_T3L_N1_DBC_AD9N_66
#set_property PACKAGE_PIN AG12     [get_ports "PL_DDR4_C0_A0"] ;# Bank  66 VCCO - VCC1V2   - IO_L19P_T3L_N0_DBC_AD9P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A0"] ;# Bank  66 VCCO - VCC1V2   - IO_L19P_T3L_N0_DBC_AD9P_66
#set_property PACKAGE_PIN AH12     [get_ports "PL_DDR4_C0_PARITY"] ;# Bank  66 VCCO - VCC1V2   - IO_T3U_N12_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_PARITY"] ;# Bank  66 VCCO - VCC1V2   - IO_T3U_N12_66
#set_property PACKAGE_PIN AJ12     [get_ports "PL_DDR4_C0_A1"] ;# Bank  66 VCCO - VCC1V2   - IO_T2U_N12_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A1"] ;# Bank  66 VCCO - VCC1V2   - IO_T2U_N12_66
#set_property PACKAGE_PIN AK11     [get_ports "PL_DDR4_C0_A2"] ;# Bank  66 VCCO - VCC1V2   - IO_L18N_T2U_N11_AD2N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A2"] ;# Bank  66 VCCO - VCC1V2   - IO_L18N_T2U_N11_AD2N_66
#set_property PACKAGE_PIN AJ11     [get_ports "PL_DDR4_C0_A3"] ;# Bank  66 VCCO - VCC1V2   - IO_L18P_T2U_N10_AD2P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A3"] ;# Bank  66 VCCO - VCC1V2   - IO_L18P_T2U_N10_AD2P_66
#set_property PACKAGE_PIN AK9      [get_ports "PL_DDR4_C0_A4"] ;# Bank  66 VCCO - VCC1V2   - IO_L17N_T2U_N9_AD10N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A4"] ;# Bank  66 VCCO - VCC1V2   - IO_L17N_T2U_N9_AD10N_66
#set_property PACKAGE_PIN AK10     [get_ports "PL_DDR4_C0_A5"] ;# Bank  66 VCCO - VCC1V2   - IO_L17P_T2U_N8_AD10P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A5"] ;# Bank  66 VCCO - VCC1V2   - IO_L17P_T2U_N8_AD10P_66
#set_property PACKAGE_PIN AL11     [get_ports "PL_DDR4_C0_A6"] ;# Bank  66 VCCO - VCC1V2   - IO_L16N_T2U_N7_QBC_AD3N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A6"] ;# Bank  66 VCCO - VCC1V2   - IO_L16N_T2U_N7_QBC_AD3N_66
#set_property PACKAGE_PIN AL12     [get_ports "PL_DDR4_C0_A7"] ;# Bank  66 VCCO - VCC1V2   - IO_L16P_T2U_N6_QBC_AD3P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A7"] ;# Bank  66 VCCO - VCC1V2   - IO_L16P_T2U_N6_QBC_AD3P_66
#set_property PACKAGE_PIN AL13     [get_ports "PL_DDR4_C0_A8"] ;# Bank  66 VCCO - VCC1V2   - IO_L15N_T2L_N5_AD11N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A8"] ;# Bank  66 VCCO - VCC1V2   - IO_L15N_T2L_N5_AD11N_66
#set_property PACKAGE_PIN AK13     [get_ports "PL_DDR4_C0_A9"] ;# Bank  66 VCCO - VCC1V2   - IO_L15P_T2L_N4_AD11P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A9"] ;# Bank  66 VCCO - VCC1V2   - IO_L15P_T2L_N4_AD11P_66
#set_property PACKAGE_PIN AM11     [get_ports "PL_DDR4_C0_A10"] ;# Bank  66 VCCO - VCC1V2   - IO_L14N_T2L_N3_GC_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A10"] ;# Bank  66 VCCO - VCC1V2   - IO_L14N_T2L_N3_GC_66
#set_property PACKAGE_PIN AM12     [get_ports "PL_DDR4_C0_A11"] ;# Bank  66 VCCO - VCC1V2   - IO_L14P_T2L_N2_GC_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A11"] ;# Bank  66 VCCO - VCC1V2   - IO_L14P_T2L_N2_GC_66
#set_property PACKAGE_PIN AM9      [get_ports "PL_DDR4_C0_CK0_C"] ;# Bank  66 VCCO - VCC1V2   - IO_L13N_T2L_N1_GC_QBC_66
#set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports "PL_DDR4_C0_CK0_C"] ;# Bank  66 VCCO - VCC1V2   - IO_L13N_T2L_N1_GC_QBC_66
#set_property PACKAGE_PIN AL9      [get_ports "PL_DDR4_C0_CK0_T"] ;# Bank  66 VCCO - VCC1V2   - IO_L13P_T2L_N0_GC_QBC_66
#set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports "PL_DDR4_C0_CK0_T"] ;# Bank  66 VCCO - VCC1V2   - IO_L13P_T2L_N0_GC_QBC_66
#set_property PACKAGE_PIN AN10     [get_ports "USER_SI570_C0_N"] ;# Bank  66 VCCO - VCC1V2   - IO_L12N_T1U_N11_GC_66
#set_property IOSTANDARD  DIFF_SSTL12 [get_ports "USER_SI570_C0_N"] ;# Bank  66 VCCO - VCC1V2   - IO_L12N_T1U_N11_GC_66
#set_property PACKAGE_PIN AM10     [get_ports "USER_SI570_C0_P"] ;# Bank  66 VCCO - VCC1V2   - IO_L12P_T1U_N10_GC_66
#set_property IOSTANDARD  DIFF_SSTL12 [get_ports "USER_SI570_C0_P"] ;# Bank  66 VCCO - VCC1V2   - IO_L12P_T1U_N10_GC_66
#set_property PACKAGE_PIN AP10     [get_ports "SI5381_PL_CLK_N"] ;# Bank  66 VCCO - VCC1V2   - IO_L11N_T1U_N9_GC_66
#set_property IOSTANDARD  DIFF_SSTL12 [get_ports "SI5381_PL_CLK_N"] ;# Bank  66 VCCO - VCC1V2   - IO_L11N_T1U_N9_GC_66
#set_property PACKAGE_PIN AP11     [get_ports "SI5381_PL_CLK_P"] ;# Bank  66 VCCO - VCC1V2   - IO_L11P_T1U_N8_GC_66
#set_property IOSTANDARD  DIFF_SSTL12 [get_ports "SI5381_PL_CLK_P"] ;# Bank  66 VCCO - VCC1V2   - IO_L11P_T1U_N8_GC_66
#set_property PACKAGE_PIN AM7      [get_ports "PL_DDR4_C0_BA0"] ;# Bank  66 VCCO - VCC1V2   - IO_L10N_T1U_N7_QBC_AD4N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_BA0"] ;# Bank  66 VCCO - VCC1V2   - IO_L10N_T1U_N7_QBC_AD4N_66
#set_property PACKAGE_PIN AM8      [get_ports "PL_DDR4_C0_BA1"] ;# Bank  66 VCCO - VCC1V2   - IO_L10P_T1U_N6_QBC_AD4P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_BA1"] ;# Bank  66 VCCO - VCC1V2   - IO_L10P_T1U_N6_QBC_AD4P_66
#set_property PACKAGE_PIN AN7      [get_ports "ADCIO_09_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L9N_T1L_N5_AD12N_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_09_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L9N_T1L_N5_AD12N_66
#set_property PACKAGE_PIN AN8      [get_ports "ADCIO_10_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_10_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_66
#set_property PACKAGE_PIN AN12     [get_ports "PL_DDR4_C0_A12"] ;# Bank  66 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A12"] ;# Bank  66 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_66
#set_property PACKAGE_PIN AN13     [get_ports "PL_DDR4_C0_A13"] ;# Bank  66 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_A13"] ;# Bank  66 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_66
#set_property PACKAGE_PIN AP12     [get_ports "ADCIO_11_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_11_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_66
#set_property PACKAGE_PIN AP13     [get_ports "ADCIO_12_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_12_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_66
#set_property PACKAGE_PIN AN9      [get_ports "ADCIO_08_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_T1U_N12_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_08_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_T1U_N12_66
#set_property PACKAGE_PIN AN3      [get_ports "VRP_66"] ;# Bank  66 VCCO - VCC1V2   - IO_T0U_N12_VRP_66
#set_property IOSTANDARD  LVCMOSxx [get_ports "VRP_66"] ;# Bank  66 VCCO - VCC1V2   - IO_T0U_N12_VRP_66
#set_property PACKAGE_PIN AN1      [get_ports "ADCIO_13_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L6N_T0U_N11_AD6N_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_13_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L6N_T0U_N11_AD6N_66
#set_property PACKAGE_PIN AN2      [get_ports "ADCIO_14_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L6P_T0U_N10_AD6P_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_14_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L6P_T0U_N10_AD6P_66
#set_property PACKAGE_PIN AP2      [get_ports "ADCIO_15_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L5N_T0U_N9_AD14N_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "ADCIO_15_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L5N_T0U_N9_AD14N_66
#set_property PACKAGE_PIN AP3      [get_ports "DACIO_08_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L5P_T0U_N8_AD14P_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_08_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L5P_T0U_N8_AD14P_66
#set_property PACKAGE_PIN AN4      [get_ports "DACIO_09_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L4N_T0U_N7_DBC_AD7N_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_09_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L4N_T0U_N7_DBC_AD7N_66
#set_property PACKAGE_PIN AN5      [get_ports "DACIO_10_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L4P_T0U_N6_DBC_AD7P_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_10_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L4P_T0U_N6_DBC_AD7P_66
#set_property PACKAGE_PIN AM5      [get_ports "DACIO_11_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L3N_T0L_N5_AD15N_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_11_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L3N_T0L_N5_AD15N_66
#set_property PACKAGE_PIN AM6      [get_ports "PL_DDR4_C0_CS2_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L3P_T0L_N4_AD15P_66
#set_property IOSTANDARD  SSTL12_DCI [get_ports "PL_DDR4_C0_CS2_B"] ;# Bank  66 VCCO - VCC1V2   - IO_L3P_T0L_N4_AD15P_66
#set_property PACKAGE_PIN AP5      [get_ports "DACIO_12_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L2N_T0L_N3_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_12_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L2N_T0L_N3_66
#set_property PACKAGE_PIN AP6      [get_ports "DACIO_13_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L2P_T0L_N2_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_13_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L2P_T0L_N2_66
#set_property PACKAGE_PIN AP7      [get_ports "DACIO_14_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L1N_T0L_N1_DBC_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_14_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L1N_T0L_N1_DBC_66
#set_property PACKAGE_PIN AP8      [get_ports "DACIO_15_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L1P_T0L_N0_DBC_66
#set_property IOSTANDARD  LVCMOS12 [get_ports "DACIO_15_LS"] ;# Bank  66 VCCO - VCC1V2   - IO_L1P_T0L_N0_DBC_66
#set_property PACKAGE_PIN AE18     [get_ports "PL_DDR4_C0_DQ16"] ;# Bank  65 VCCO - VCC1V2   - IO_L24N_T3U_N11_PERSTN0_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ16"] ;# Bank  65 VCCO - VCC1V2   - IO_L24N_T3U_N11_PERSTN0_65
#set_property PACKAGE_PIN AD18     [get_ports "PL_DDR4_C0_DQ20"] ;# Bank  65 VCCO - VCC1V2   - IO_L24P_T3U_N10_PERSTN1_I2C_SDA_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ20"] ;# Bank  65 VCCO - VCC1V2   - IO_L24P_T3U_N10_PERSTN1_I2C_SDA_65
#set_property PACKAGE_PIN AD16     [get_ports "PL_DDR4_C0_DQ21"] ;# Bank  65 VCCO - VCC1V2   - IO_L23N_T3U_N9_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ21"] ;# Bank  65 VCCO - VCC1V2   - IO_L23N_T3U_N9_65
#set_property PACKAGE_PIN AC17     [get_ports "PL_DDR4_C0_DQ23"] ;# Bank  65 VCCO - VCC1V2   - IO_L23P_T3U_N8_I2C_SCLK_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ23"] ;# Bank  65 VCCO - VCC1V2   - IO_L23P_T3U_N8_I2C_SCLK_65
#set_property PACKAGE_PIN AC15     [get_ports "PL_DDR4_C0_DQS2_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L22N_T3U_N7_DBC_AD0N_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS2_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L22N_T3U_N7_DBC_AD0N_65
#set_property PACKAGE_PIN AC16     [get_ports "PL_DDR4_C0_DQS2_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L22P_T3U_N6_DBC_AD0P_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS2_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L22P_T3U_N6_DBC_AD0P_65
#set_property PACKAGE_PIN AE15     [get_ports "PL_DDR4_C0_DQ17"] ;# Bank  65 VCCO - VCC1V2   - IO_L21N_T3L_N5_AD8N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ17"] ;# Bank  65 VCCO - VCC1V2   - IO_L21N_T3L_N5_AD8N_65
#set_property PACKAGE_PIN AD15     [get_ports "PL_DDR4_C0_DQ19"] ;# Bank  65 VCCO - VCC1V2   - IO_L21P_T3L_N4_AD8P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ19"] ;# Bank  65 VCCO - VCC1V2   - IO_L21P_T3L_N4_AD8P_65
#set_property PACKAGE_PIN AE13     [get_ports "PL_DDR4_C0_DQ22"] ;# Bank  65 VCCO - VCC1V2   - IO_L20N_T3L_N3_AD1N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ22"] ;# Bank  65 VCCO - VCC1V2   - IO_L20N_T3L_N3_AD1N_65
#set_property PACKAGE_PIN AE14     [get_ports "PL_DDR4_C0_DQ18"] ;# Bank  65 VCCO - VCC1V2   - IO_L20P_T3L_N2_AD1P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ18"] ;# Bank  65 VCCO - VCC1V2   - IO_L20P_T3L_N2_AD1P_65
#set_property PACKAGE_PIN AD13     [get_ports "UART2_RTS_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L19N_T3L_N1_DBC_AD9N_65
#set_property IOSTANDARD  LVCMOS12 [get_ports "UART2_RTS_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L19N_T3L_N1_DBC_AD9N_65
#set_property PACKAGE_PIN AC13     [get_ports "PL_DDR4_C0_DM2_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L19P_T3L_N0_DBC_AD9P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DM2_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L19P_T3L_N0_DBC_AD9P_65
#set_property PACKAGE_PIN AD17     [get_ports "UART2_CTS_B"] ;# Bank  65 VCCO - VCC1V2   - IO_T3U_N12_65
#set_property IOSTANDARD  LVCMOS12 [get_ports "UART2_CTS_B"] ;# Bank  65 VCCO - VCC1V2   - IO_T3U_N12_65
#set_property PACKAGE_PIN AG16     [get_ports "UART2_RXD_FPGA_TXD"] ;# Bank  65 VCCO - VCC1V2   - IO_T2U_N12_65
#set_property IOSTANDARD  LVCMOS12 [get_ports "UART2_RXD_FPGA_TXD"] ;# Bank  65 VCCO - VCC1V2   - IO_T2U_N12_65
#set_property PACKAGE_PIN AF17     [get_ports "PL_DDR4_C0_DQ31"] ;# Bank  65 VCCO - VCC1V2   - IO_L18N_T2U_N11_AD2N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ31"] ;# Bank  65 VCCO - VCC1V2   - IO_L18N_T2U_N11_AD2N_65
#set_property PACKAGE_PIN AF18     [get_ports "PL_DDR4_C0_DQ29"] ;# Bank  65 VCCO - VCC1V2   - IO_L18P_T2U_N10_AD2P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ29"] ;# Bank  65 VCCO - VCC1V2   - IO_L18P_T2U_N10_AD2P_65
#set_property PACKAGE_PIN AF16     [get_ports "PL_DDR4_C0_DQ24"] ;# Bank  65 VCCO - VCC1V2   - IO_L17N_T2U_N9_AD10N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ24"] ;# Bank  65 VCCO - VCC1V2   - IO_L17N_T2U_N9_AD10N_65
#set_property PACKAGE_PIN AE16     [get_ports "PL_DDR4_C0_DQ28"] ;# Bank  65 VCCO - VCC1V2   - IO_L17P_T2U_N8_AD10P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ28"] ;# Bank  65 VCCO - VCC1V2   - IO_L17P_T2U_N8_AD10P_65
#set_property PACKAGE_PIN AH14     [get_ports "PL_DDR4_C0_DQS3_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L16N_T2U_N7_QBC_AD3N_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS3_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L16N_T2U_N7_QBC_AD3N_65
#set_property PACKAGE_PIN AG14     [get_ports "PL_DDR4_C0_DQS3_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L16P_T2U_N6_QBC_AD3P_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS3_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L16P_T2U_N6_QBC_AD3P_65
#set_property PACKAGE_PIN AF13     [get_ports "PL_DDR4_C0_DQ25"] ;# Bank  65 VCCO - VCC1V2   - IO_L15N_T2L_N5_AD11N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ25"] ;# Bank  65 VCCO - VCC1V2   - IO_L15N_T2L_N5_AD11N_65
#set_property PACKAGE_PIN AF14     [get_ports "PL_DDR4_C0_DQ27"] ;# Bank  65 VCCO - VCC1V2   - IO_L15P_T2L_N4_AD11P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ27"] ;# Bank  65 VCCO - VCC1V2   - IO_L15P_T2L_N4_AD11P_65
#set_property PACKAGE_PIN AH17     [get_ports "PL_DDR4_C0_DQ30"] ;# Bank  65 VCCO - VCC1V2   - IO_L14N_T2L_N3_GC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ30"] ;# Bank  65 VCCO - VCC1V2   - IO_L14N_T2L_N3_GC_65
#set_property PACKAGE_PIN AG17     [get_ports "PL_DDR4_C0_DQ26"] ;# Bank  65 VCCO - VCC1V2   - IO_L14P_T2L_N2_GC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ26"] ;# Bank  65 VCCO - VCC1V2   - IO_L14P_T2L_N2_GC_65
#set_property PACKAGE_PIN AH15     [get_ports "UART2_TXD_FPGA_RXD"] ;# Bank  65 VCCO - VCC1V2   - IO_L13N_T2L_N1_GC_QBC_65
#set_property IOSTANDARD  LVCMOS12 [get_ports "UART2_TXD_FPGA_RXD"] ;# Bank  65 VCCO - VCC1V2   - IO_L13N_T2L_N1_GC_QBC_65
#set_property PACKAGE_PIN AG15     [get_ports "PL_DDR4_C0_DM3_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L13P_T2L_N0_GC_QBC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DM3_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L13P_T2L_N0_GC_QBC_65
#set_property PACKAGE_PIN AK16     [get_ports "PL_DDR4_C0_DQ4"] ;# Bank  65 VCCO - VCC1V2   - IO_L12N_T1U_N11_GC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ4"] ;# Bank  65 VCCO - VCC1V2   - IO_L12N_T1U_N11_GC_65
#set_property PACKAGE_PIN AJ17     [get_ports "PL_DDR4_C0_DQ3"] ;# Bank  65 VCCO - VCC1V2   - IO_L12P_T1U_N10_GC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ3"] ;# Bank  65 VCCO - VCC1V2   - IO_L12P_T1U_N10_GC_65
#set_property PACKAGE_PIN AJ15     [get_ports "PL_DDR4_C0_DQ2"] ;# Bank  65 VCCO - VCC1V2   - IO_L11N_T1U_N9_GC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ2"] ;# Bank  65 VCCO - VCC1V2   - IO_L11N_T1U_N9_GC_65
#set_property PACKAGE_PIN AJ16     [get_ports "PL_DDR4_C0_DQ1"] ;# Bank  65 VCCO - VCC1V2   - IO_L11P_T1U_N8_GC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ1"] ;# Bank  65 VCCO - VCC1V2   - IO_L11P_T1U_N8_GC_65
#set_property PACKAGE_PIN AJ18     [get_ports "PL_DDR4_C0_DQS0_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L10N_T1U_N7_QBC_AD4N_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS0_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L10N_T1U_N7_QBC_AD4N_65
#set_property PACKAGE_PIN AH18     [get_ports "PL_DDR4_C0_DQS0_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L10P_T1U_N6_QBC_AD4P_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS0_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L10P_T1U_N6_QBC_AD4P_65
#set_property PACKAGE_PIN AL18     [get_ports "PL_DDR4_C0_DQ7"] ;# Bank  65 VCCO - VCC1V2   - IO_L9N_T1L_N5_AD12N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ7"] ;# Bank  65 VCCO - VCC1V2   - IO_L9N_T1L_N5_AD12N_65
#set_property PACKAGE_PIN AK18     [get_ports "PL_DDR4_C0_DQ5"] ;# Bank  65 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ5"] ;# Bank  65 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_65
#set_property PACKAGE_PIN AK14     [get_ports "PL_DDR4_C0_DQ0"] ;# Bank  65 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ0"] ;# Bank  65 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_65
#set_property PACKAGE_PIN AK15     [get_ports "PL_DDR4_C0_DQ6"] ;# Bank  65 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ6"] ;# Bank  65 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_65
#set_property PACKAGE_PIN AJ13     [get_ports "MSP430_UCA1_RXD_LS"] ;# Bank  65 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_65
#set_property IOSTANDARD  LVCMOS12 [get_ports "MSP430_UCA1_RXD_LS"] ;# Bank  65 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_65
#set_property PACKAGE_PIN AH13     [get_ports "PL_DDR4_C0_DM0_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DM0_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_65
#set_property PACKAGE_PIN AL16     [get_ports "MSP430_UCA1_TXD_LS"] ;# Bank  65 VCCO - VCC1V2   - IO_T1U_N12_65
#set_property IOSTANDARD  LVCMOS12 [get_ports "MSP430_UCA1_TXD_LS"] ;# Bank  65 VCCO - VCC1V2   - IO_T1U_N12_65
#set_property PACKAGE_PIN AL14     [get_ports "VRP_65"] ;# Bank  65 VCCO - VCC1V2   - IO_T0U_N12_VRP_65
#set_property IOSTANDARD  LVCMOSxx [get_ports "VRP_65"] ;# Bank  65 VCCO - VCC1V2   - IO_T0U_N12_VRP_65
#set_property PACKAGE_PIN AP17     [get_ports "PL_DDR4_C0_DQ14"] ;# Bank  65 VCCO - VCC1V2   - IO_L6N_T0U_N11_AD6N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ14"] ;# Bank  65 VCCO - VCC1V2   - IO_L6N_T0U_N11_AD6N_65
#set_property PACKAGE_PIN AN18     [get_ports "PL_DDR4_C0_DQ8"] ;# Bank  65 VCCO - VCC1V2   - IO_L6P_T0U_N10_AD6P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ8"] ;# Bank  65 VCCO - VCC1V2   - IO_L6P_T0U_N10_AD6P_65
#set_property PACKAGE_PIN AN17     [get_ports "PL_DDR4_C0_DQ12"] ;# Bank  65 VCCO - VCC1V2   - IO_L5N_T0U_N9_AD14N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ12"] ;# Bank  65 VCCO - VCC1V2   - IO_L5N_T0U_N9_AD14N_65
#set_property PACKAGE_PIN AM17     [get_ports "PL_DDR4_C0_DQ10"] ;# Bank  65 VCCO - VCC1V2   - IO_L5P_T0U_N8_AD14P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ10"] ;# Bank  65 VCCO - VCC1V2   - IO_L5P_T0U_N8_AD14P_65
#set_property PACKAGE_PIN AM16     [get_ports "PL_DDR4_C0_DQS1_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L4N_T0U_N7_DBC_AD7N_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS1_C"] ;# Bank  65 VCCO - VCC1V2   - IO_L4N_T0U_N7_DBC_AD7N_65
#set_property PACKAGE_PIN AL17     [get_ports "PL_DDR4_C0_DQS1_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L4P_T0U_N6_DBC_AD7P_SMBALERT_65
#set_property IOSTANDARD  DIFF_POD12_DCI [get_ports "PL_DDR4_C0_DQS1_T"] ;# Bank  65 VCCO - VCC1V2   - IO_L4P_T0U_N6_DBC_AD7P_SMBALERT_65
#set_property PACKAGE_PIN AP15     [get_ports "PL_DDR4_C0_DQ11"] ;# Bank  65 VCCO - VCC1V2   - IO_L3N_T0L_N5_AD15N_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ11"] ;# Bank  65 VCCO - VCC1V2   - IO_L3N_T0L_N5_AD15N_65
#set_property PACKAGE_PIN AP16     [get_ports "PL_DDR4_C0_DQ9"] ;# Bank  65 VCCO - VCC1V2   - IO_L3P_T0L_N4_AD15P_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ9"] ;# Bank  65 VCCO - VCC1V2   - IO_L3P_T0L_N4_AD15P_65
#set_property PACKAGE_PIN AN15     [get_ports "PL_DDR4_C0_DQ13"] ;# Bank  65 VCCO - VCC1V2   - IO_L2N_T0L_N3_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ13"] ;# Bank  65 VCCO - VCC1V2   - IO_L2N_T0L_N3_65
#set_property PACKAGE_PIN AM15     [get_ports "PL_DDR4_C0_DQ15"] ;# Bank  65 VCCO - VCC1V2   - IO_L2P_T0L_N2_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DQ15"] ;# Bank  65 VCCO - VCC1V2   - IO_L2P_T0L_N2_65
#set_property PACKAGE_PIN AN14     [get_ports "RSV_U1_AN14"] ;# Bank  65 VCCO - VCC1V2   - IO_L1N_T0L_N1_DBC_65
#set_property IOSTANDARD  LVCMOSxx [get_ports "RSV_U1_AN14"] ;# Bank  65 VCCO - VCC1V2   - IO_L1N_T0L_N1_DBC_65
#set_property PACKAGE_PIN AM14     [get_ports "PL_DDR4_C0_DM1_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L1P_T0L_N0_DBC_65
#set_property IOSTANDARD  POD12_DCI [get_ports "PL_DDR4_C0_DM1_B"] ;# Bank  65 VCCO - VCC1V2   - IO_L1P_T0L_N0_DBC_65
#set_property PACKAGE_PIN J12      [get_ports "SYSMON_SCL_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L12N_AD0N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "SYSMON_SCL_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L12N_AD0N_88
#set_property PACKAGE_PIN K12      [get_ports "SYSMON_SDA_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L12P_AD0P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "SYSMON_SDA_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L12P_AD0P_88
#set_property PACKAGE_PIN H11      [get_ports "CPU_RESET"] ;# Bank  88 VCCO - VCC1V8   - IO_L11N_AD1N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "CPU_RESET"] ;# Bank  88 VCCO - VCC1V8   - IO_L11N_AD1N_88
#set_property PACKAGE_PIN J11      [get_ports "GPIO_SW_PL"] ;# Bank  88 VCCO - VCC1V8   - IO_L11P_AD1P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "GPIO_SW_PL"] ;# Bank  88 VCCO - VCC1V8   - IO_L11P_AD1P_88
#set_property PACKAGE_PIN K10      [get_ports "SI5381_CLK104_MUX_SEL"] ;# Bank  88 VCCO - VCC1V8   - IO_L10N_AD2N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "SI5381_CLK104_MUX_SEL"] ;# Bank  88 VCCO - VCC1V8   - IO_L10N_AD2N_88
#set_property PACKAGE_PIN K11      [get_ports "SI53340_MUX_GT_SEL"] ;# Bank  88 VCCO - VCC1V8   - IO_L10P_AD2P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "SI53340_MUX_GT_SEL"] ;# Bank  88 VCCO - VCC1V8   - IO_L10P_AD2P_88
#set_property PACKAGE_PIN H9       [get_ports "SI53340_MUX_GTR_SEL"] ;# Bank  88 VCCO - VCC1V8   - IO_L9N_AD3N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "SI53340_MUX_GTR_SEL"] ;# Bank  88 VCCO - VCC1V8   - IO_L9N_AD3N_88
#set_property PACKAGE_PIN H10      [get_ports "TDD_TRIGGER_OUT"] ;# Bank  88 VCCO - VCC1V8   - IO_L9P_AD3P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "TDD_TRIGGER_OUT"] ;# Bank  88 VCCO - VCC1V8   - IO_L9P_AD3P_88
#set_property PACKAGE_PIN G10      [get_ports "CLK104_PL_CLK_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L8N_HDGC_AD4N_88
#set_property IOSTANDARD  LVDS_25 [get_ports "CLK104_PL_CLK_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L8N_HDGC_AD4N_88
#set_property PACKAGE_PIN G11      [get_ports "CLK104_PL_CLK_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L8P_HDGC_AD4P_88
#set_property IOSTANDARD  LVDS_25 [get_ports "CLK104_PL_CLK_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L8P_HDGC_AD4P_88
#set_property PACKAGE_PIN F9       [get_ports "8A34001_Q2_OUT_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L7N_HDGC_AD5N_88
#set_property IOSTANDARD  LVDS_25 [get_ports "8A34001_Q2_OUT_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L7N_HDGC_AD5N_88
#set_property PACKAGE_PIN F10      [get_ports "8A34001_Q2_OUT_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L7P_HDGC_AD5P_88
#set_property IOSTANDARD  LVDS_25 [get_ports "8A34001_Q2_OUT_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L7P_HDGC_AD5P_88
#set_property PACKAGE_PIN E9       [get_ports "MUX_PL_SYSREF_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L6N_HDGC_AD6N_88
#set_property IOSTANDARD  LVDS_25 [get_ports "MUX_PL_SYSREF_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L6N_HDGC_AD6N_88
#set_property PACKAGE_PIN E10      [get_ports "MUX_PL_SYSREF_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L6P_HDGC_AD6P_88
#set_property IOSTANDARD  LVDS_25 [get_ports "MUX_PL_SYSREF_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L6P_HDGC_AD6P_88
#set_property PACKAGE_PIN D11      [get_ports "8A34001_CLK6_IN_C_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L5N_HDGC_AD7N_88
#set_property IOSTANDARD  LVDS_25 [get_ports "8A34001_CLK6_IN_C_N"] ;# Bank  88 VCCO - VCC1V8   - IO_L5N_HDGC_AD7N_88
#set_property PACKAGE_PIN E11      [get_ports "8A34001_CLK6_IN_C_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L5P_HDGC_AD7P_88
#set_property IOSTANDARD  LVDS_25 [get_ports "8A34001_CLK6_IN_C_P"] ;# Bank  88 VCCO - VCC1V8   - IO_L5P_HDGC_AD7P_88
#set_property PACKAGE_PIN C9       [get_ports "GPIO_LED0_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L4N_AD8N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "GPIO_LED0_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L4N_AD8N_88
#set_property PACKAGE_PIN D9       [get_ports "GPIO_LED1_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L4P_AD8P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "GPIO_LED1_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L4P_AD8P_88
#set_property PACKAGE_PIN A9       [get_ports "GPIO_LED2_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L3N_AD9N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "GPIO_LED2_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L3N_AD9N_88
#set_property PACKAGE_PIN A10      [get_ports "GPIO_LED3_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L3P_AD9P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "GPIO_LED3_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L3P_AD9P_88
#set_property PACKAGE_PIN B10      [get_ports "MSP430_GPIO_PL_0_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L2N_AD10N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "MSP430_GPIO_PL_0_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L2N_AD10N_88
#set_property PACKAGE_PIN C10      [get_ports "MSP430_GPIO_PL_1_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L2P_AD10P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "MSP430_GPIO_PL_1_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L2P_AD10P_88
#set_property PACKAGE_PIN B11      [get_ports "MSP430_GPIO_PL_2_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L1N_AD11N_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "MSP430_GPIO_PL_2_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L1N_AD11N_88
#set_property PACKAGE_PIN C11      [get_ports "MSP430_GPIO_PL_3_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L1P_AD11P_88
#set_property IOSTANDARD  LVCMOS18 [get_ports "MSP430_GPIO_PL_3_LS"] ;# Bank  88 VCCO - VCC1V8   - IO_L1P_AD11P_88
#set_property PACKAGE_PIN M29      [get_ports "8A34001_CLK1_IN_C_N"] ;# Bank 127 - MGTREFCLK0N_127
#set_property PACKAGE_PIN M28      [get_ports "8A34001_CLK1_IN_C_P"] ;# Bank 127 - MGTREFCLK0P_127
#set_property PACKAGE_PIN K29      [get_ports "USER_MGT_REFCLK_C_N"] ;# Bank 127 - MGTREFCLK1N_127
#set_property PACKAGE_PIN K28      [get_ports "USER_MGT_REFCLK_C_P"] ;# Bank 127 - MGTREFCLK1P_127
#set_property PACKAGE_PIN P34      [get_ports "SFP0_RX_N"] ;# Bank 127 - MGTYRXN0_127
#set_property PACKAGE_PIN M34      [get_ports "SFP1_RX_N"] ;# Bank 127 - MGTYRXN1_127
#set_property PACKAGE_PIN K34      [get_ports "SFP2_RX_N"] ;# Bank 127 - MGTYRXN2_127
#set_property PACKAGE_PIN H34      [get_ports "SFP3_RX_N"] ;# Bank 127 - MGTYRXN3_127
#set_property PACKAGE_PIN P33      [get_ports "SFP0_RX_P"] ;# Bank 127 - MGTYRXP0_127
#set_property PACKAGE_PIN M33      [get_ports "SFP1_RX_P"] ;# Bank 127 - MGTYRXP1_127
#set_property PACKAGE_PIN K33      [get_ports "SFP2_RX_P"] ;# Bank 127 - MGTYRXP2_127
#set_property PACKAGE_PIN H33      [get_ports "SFP3_RX_P"] ;# Bank 127 - MGTYRXP3_127
#set_property PACKAGE_PIN N31      [get_ports "SFP0_TX_N"] ;# Bank 127 - MGTYTXN0_127
#set_property PACKAGE_PIN L31      [get_ports "SFP1_TX_N"] ;# Bank 127 - MGTYTXN1_127
#set_property PACKAGE_PIN J31      [get_ports "SFP2_TX_N"] ;# Bank 127 - MGTYTXN2_127
#set_property PACKAGE_PIN G31      [get_ports "SFP3_TX_N"] ;# Bank 127 - MGTYTXN3_127
#set_property PACKAGE_PIN N30      [get_ports "SFP0_TX_P"] ;# Bank 127 - MGTYTXP0_127
#set_property PACKAGE_PIN L30      [get_ports "SFP1_TX_P"] ;# Bank 127 - MGTYTXP1_127
#set_property PACKAGE_PIN J30      [get_ports "SFP2_TX_P"] ;# Bank 127 - MGTYTXP2_127
#set_property PACKAGE_PIN G30      [get_ports "SFP3_TX_P"] ;# Bank 127 - MGTYTXP3_127
#set_property PACKAGE_PIN H29      [get_ports "8A34001_CLK2_IN_C_N"] ;# Bank 128 - MGTREFCLK0N_128
#set_property PACKAGE_PIN H28      [get_ports "8A34001_CLK2_IN_C_P"] ;# Bank 128 - MGTREFCLK0P_128
#set_property PACKAGE_PIN F29      [get_ports "8A34001_Q11_OUT_C_N"] ;# Bank 128 - MGTREFCLK1N_128
#set_property PACKAGE_PIN F28      [get_ports "8A34001_Q11_OUT_C_P"] ;# Bank 128 - MGTREFCLK1P_128
#set_property PACKAGE_PIN G28      [get_ports "MGTRREF"] ;# Bank 128 - MGTRREF_L
#set_property PACKAGE_PIN F34      [get_ports "FMCP_HSPC_DP0_M2C_N"] ;# Bank 128 - MGTYRXN0_128
#set_property PACKAGE_PIN D34      [get_ports "FMCP_HSPC_DP1_M2C_N"] ;# Bank 128 - MGTYRXN1_128
#set_property PACKAGE_PIN B34      [get_ports "FMCP_HSPC_DP2_M2C_N"] ;# Bank 128 - MGTYRXN2_128
#set_property PACKAGE_PIN A32      [get_ports "FMCP_HSPC_DP3_M2C_N"] ;# Bank 128 - MGTYRXN3_128
#set_property PACKAGE_PIN F33      [get_ports "FMCP_HSPC_DP0_M2C_P"] ;# Bank 128 - MGTYRXP0_128
#set_property PACKAGE_PIN D33      [get_ports "FMCP_HSPC_DP1_M2C_P"] ;# Bank 128 - MGTYRXP1_128
#set_property PACKAGE_PIN B33      [get_ports "FMCP_HSPC_DP2_M2C_P"] ;# Bank 128 - MGTYRXP2_128
#set_property PACKAGE_PIN A31      [get_ports "FMCP_HSPC_DP3_M2C_P"] ;# Bank 128 - MGTYRXP3_128
#set_property PACKAGE_PIN E31      [get_ports "FMCP_HSPC_DP0_C2M_N"] ;# Bank 128 - MGTYTXN0_128
#set_property PACKAGE_PIN D29      [get_ports "FMCP_HSPC_DP1_C2M_N"] ;# Bank 128 - MGTYTXN1_128
#set_property PACKAGE_PIN C31      [get_ports "FMCP_HSPC_DP2_C2M_N"] ;# Bank 128 - MGTYTXN2_128
#set_property PACKAGE_PIN B29      [get_ports "FMCP_HSPC_DP3_C2M_N"] ;# Bank 128 - MGTYTXN3_128
#set_property PACKAGE_PIN E30      [get_ports "FMCP_HSPC_DP0_C2M_P"] ;# Bank 128 - MGTYTXP0_128
#set_property PACKAGE_PIN D28      [get_ports "FMCP_HSPC_DP1_C2M_P"] ;# Bank 128 - MGTYTXP1_128
#set_property PACKAGE_PIN C30      [get_ports "FMCP_HSPC_DP2_C2M_P"] ;# Bank 128 - MGTYTXP2_128
#set_property PACKAGE_PIN B28      [get_ports "FMCP_HSPC_DP3_C2M_P"] ;# Bank 128 - MGTYTXP3_128
