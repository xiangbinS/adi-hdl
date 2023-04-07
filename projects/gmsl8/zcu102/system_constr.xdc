## MIPI ch0 - 4-lane data and clk - Bank 66
# bank 66 connections
#set_property -dict {PACKAGE_PIN AC1 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[0]]; #C11 FMC CH0_D0 FMC_HPC0_LA06_N AC1
#set_property -dict {PACKAGE_PIN AC2 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[0]]; #C10 FMC CH0_D0 FMC_HPC0_LA06_P AC2
#set_property -dict {PACKAGE_PIN AC3 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[1]]; #D12 FMC CH0_D1 FMC_HPC0_LA05_N AC3 
#set_property -dict {PACKAGE_PIN AB3 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[1]]; #D11 FMC CH0_D1 FMC_HPC0_LA05_P AB3
#set_property -dict {PACKAGE_PIN W4  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[2]]; #C15 FMC_HPC0_LA10_N W4
#set_property -dict {PACKAGE_PIN W5  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[2]]; #C14 FMC_HPC0_LA10_P W5
#set_property -dict {PACKAGE_PIN W1  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[3]]; #D15 FMC_HPC0_LA09_N W1
#set_property -dict {PACKAGE_PIN W2  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[3]]; #D14 FMC_HPC0_LA09_P W2
#set_property -dict {PACKAGE_PIN AC4 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_clk_n]; #D9 FMC_HPC0_LA01_CC_N AB4
#set_property -dict {PACKAGE_PIN AB4 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_clk_p]; #D8 FMC_HPC0_LA01_CC_P AC4

# Bank 65 connections - VRP pin enabled in bank 65
# C11 FMC CH0_D0 FMC_HPC0_LA06_N AC1
# C10 FMC CH0_D0 FMC_HPC0_LA06_P AC2
# D12 FMC CH0_D1 FMC_HPC0_LA05_N AC3 
# D11 FMC CH0_D1 FMC_HPC0_LA05_P AB3
# C15 FMC_HPC0_LA10_N W4
# C14 FMC_HPC0_LA10_P W5
# D15 FMC_HPC0_LA09_N W1
# D14 FMC_HPC0_LA09_P W2
# D9 FMC_HPC0_LA01_CC_N AB4
# D8 FMC_HPC0_LA01_CC_P AC4

set_property -dict {PACKAGE_PIN AJ2 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[0]];
set_property -dict {PACKAGE_PIN AH2 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[0]];
set_property -dict {PACKAGE_PIN AH3 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[1]];
set_property -dict {PACKAGE_PIN AG3 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[1]];
set_property -dict {PACKAGE_PIN AJ4 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[2]];
set_property -dict {PACKAGE_PIN AH4 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[2]];
set_property -dict {PACKAGE_PIN AE1 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_n[3]];
set_property -dict {PACKAGE_PIN AE2 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_data_p[3]];
set_property -dict {PACKAGE_PIN AJ5 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_clk_n];
set_property -dict {PACKAGE_PIN AJ6 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch0_clk_p];
# RX bitslice pins
set_property -dict {PACKAGE_PIN AH1 IOSTANDARD LVCMOS12        DATA_RATE DDR}          [get_ports bg3_pin6_nc_0];
#set_property PACKAGE_PIN AE10 [get_ports bg3_pin0_nc_0];
#set_property DATA_RATE DDR [get_ports  bg3_pin0_nc_0];

## MIPI ch1 - 4-lane data and clk - Bank 66

#set_property -dict {PACKAGE_PIN V1  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[0]]; #H8 FMC_HPC0_LA02_N V1
#set_property -dict {PACKAGE_PIN V2  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[0]]; #H7 FMC_HPC0_LA02_P V2
#set_property -dict {PACKAGE_PIN Y1  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[1]]; #G10 FMC_HPC0_LA03_N Y1
#set_property -dict {PACKAGE_PIN Y2  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[1]]; #G9 FMC_HPC0_LA03_P Y2
#set_property -dict {PACKAGE_PIN AA1 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[2]]; #H11 FMC_HPC0_LA04_N AA1
#set_property -dict {PACKAGE_PIN AA2 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[2]]; #H10 FMC_HPC0_LA04_P AA2
#set_property -dict {PACKAGE_PIN V3  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[3]]; #G13 FMC_HPC0_LA08_N V3
#set_property -dict {PACKAGE_PIN V4  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[3]]; #G12 FMC_HPC0_LA08_P V4
#set_property -dict {PACKAGE_PIN Y3  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_clk_n]; #G7 FMC_HPC0_LA00_CC_N Y3 
#set_property -dict {PACKAGE_PIN Y4  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_clk_p]; #G6 FMC_HPC0_LA00_CC_P Y4

# Bank 65 pins - VRP pin enabled
# H8 FMC_HPC0_LA02_N V1
# H7 FMC_HPC0_LA02_P V2
# G10 FMC_HPC0_LA03_N Y1
# G9 FMC_HPC0_LA03_P Y2
# H11 FMC_HPC0_LA04_N AA1
# H10 FMC_HPC0_LA04_P AA2
# G13 FMC_HPC0_LA08_N V3
# G12 FMC_HPC0_LA08_P V4
# G7 FMC_HPC0_LA00_CC_N Y3 
# G6 FMC_HPC0_LA00_CC_P Y4
 
#set_property -dict {PACKAGE_PIN AD1 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[0]];
#set_property -dict {PACKAGE_PIN AD2 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[0]];
#set_property -dict {PACKAGE_PIN AJ1 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[1]];
#set_property -dict {PACKAGE_PIN AH1 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[1]];
#set_property -dict {PACKAGE_PIN AF1 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[2]];
#set_property -dict {PACKAGE_PIN AF2 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[2]];
#set_property -dict {PACKAGE_PIN AF3 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_n[3]];
#set_property -dict {PACKAGE_PIN AE3 IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_data_p[3]];
#set_property -dict {PACKAGE_PIN AF5  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_clk_n];
#set_property -dict {PACKAGE_PIN AE5  IOSTANDARD MIPI_DPHY_DCI   DIFF_TERM_ADV TERM_100} [get_ports mipi_ch1_clk_p];

