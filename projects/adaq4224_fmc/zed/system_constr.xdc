# adaq4224_fmc SPI interface

set_property -dict {PACKAGE_PIN L22 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports adaq4224_spi_sdo]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports adaq4224_spi_sclk]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS25}          [get_ports adaq4224_spi_cs]

set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS25} [get_ports adaq4224_echo_sclk]
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS25} [get_ports adaq4224_resetn]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS25} [get_ports adaq4224_busy]
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS25} [get_ports adaq4224_cnv]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS25} [get_ports adaq4224_ext_clk]

set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS25} [get_ports max17687_rst]                   ; ## H13     FMC_LA07_P
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS25} [get_ports max17687_en]                    ; ## H14     FMC_LA07_N
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS25} [get_ports adaq4224_pgia_gain_ctrl[0]]
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS25} [get_ports adaq4224_pgia_gain_ctrl[1]]

set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS25 PULLTYPE PULLUP} [get_ports iic_tscl]       ; ## D11  FMC_LPC_LA05_P
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS25 PULLTYPE PULLUP} [get_ports iic_tsda]       ; ## D12  FMC_LPC_LA05_N

# external clock, that drives the CNV generator, must have a maximum 100 MHz frequency
create_clock -period 10.000 -name cnv_ext_clk [get_ports adaq4224_ext_clk]

# SCLK echod clock, tuned to 80 MHz //, phase shifted with 30% (aprox. 4ns)
create_clock -period 12.500 -name ECHOSCLK_clk [get_ports adaq4224_echo_sclk]

# rename auto-generated clock for SPIEngine to spi_clk - 160MHz
# NOTE: clk_fpga_0 is the first PL fabric clock, also called $sys_cpu_clk
create_generated_clock -name spi_clk -source [get_pins -filter name=~*CLKIN1 -of [get_cells -hier -filter name=~*spi_clkgen*i_mmcm]] -master_clock clk_fpga_0 [get_pins -filter name=~*CLKOUT0 -of [get_cells -hier -filter name=~*spi_clkgen*i_mmcm]]

# create a generated clock for SCLK - fSCLK=spi_clk/2 - 80MHz
create_generated_clock -name SCLK_clk -source [get_pins -hier -filter name=~*sclk_reg/C] -edges {1 3 5} [get_ports adaq4224_spi_sclk]

# output delay for MOSI line (SDI for the device)
#
# tHSDI and tSSDI is 1.5ns
set_output_delay -clock [get_clocks SCLK_clk] -max 1.500 [get_ports adaq4224_spi_sdo]
set_output_delay -clock [get_clocks SCLK_clk] -min 1.500 [get_ports adaq4224_spi_sdo]

# relax the SDO path to help closing timing at high frequencies
set_multicycle_path -setup -from [get_clocks spi_clk] -to [get_cells -hierarchical -filter {NAME=~*/data_sdo_shift_reg[*]}] 8
set_multicycle_path -hold  -from [get_clocks spi_clk] -to [get_cells -hierarchical -filter {NAME=~*/data_sdo_shift_reg[*]}] 7

set_multicycle_path -setup -from [get_clocks spi_clk] -to [get_cells -hierarchical -filter NAME=~*/spi_adaq4224_execution/inst/left_aligned_reg*] 8
set_multicycle_path -hold  -from [get_clocks spi_clk] -to [get_cells -hierarchical -filter NAME=~*/spi_adaq4224_execution/inst/left_aligned_reg*] 7

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {adaq4224_spi_sdi[0]}]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {adaq4224_spi_sdi[1]}]
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS25} [get_ports {adaq4224_spi_sdi[2]}]
set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS25} [get_ports {adaq4224_spi_sdi[3]}]

# input delays for MISO lines (SDO for the device)
# data is latched on negative edge

set tsetup 5.6
set thold 1.4

set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max $tsetup [get_ports {adaq4224_spi_sdi[0]}]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min $thold [get_ports {adaq4224_spi_sdi[0]}]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max $tsetup [get_ports {adaq4224_spi_sdi[1]}]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min $thold [get_ports {adaq4224_spi_sdi[1]}]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max $tsetup [get_ports {adaq4224_spi_sdi[2]}]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min $thold [get_ports {adaq4224_spi_sdi[2]}]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max $tsetup [get_ports {adaq4224_spi_sdi[3]}]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min $thold [get_ports {adaq4224_spi_sdi[3]}]
