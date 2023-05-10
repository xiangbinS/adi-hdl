set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports adaq4224_spi_sdi[0]]       ; ## H07  FMC_LPC_LA02_P
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports adaq4224_spi_sdi[1]]       ; ## H08  FMC_LPC_LA02_N

# input delays for MISO lines (SDO for the device)
# data is latched on negative edge

set tsetup 5.6
set thold 1.4

set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports adaq4224_spi_sdi[0]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports adaq4224_spi_sdi[0]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -max  $tsetup [get_ports adaq4224_spi_sdi[1]]
set_input_delay -clock [get_clocks ECHOSCLK_clk] -clock_fall -min  $thold  [get_ports adaq4224_spi_sdi[1]]
