#set_property -dict {PACKAGE_PIN B10} [get_ports sfp_ref_clk_p]

create_clock -period 6.4 [get_ports sfp_ref_clk_p]
set_property PACKAGE_PIN C8 [get_ports sfp_ref_clk_p]

set_property -dict {PACKAGE_PIN E4 } [get_ports sfp_tx_p]
set_property -dict {PACKAGE_PIN D2 } [get_ports sfp_rx_p]

set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports pps_out] ;# J3-6 L10N_AD10N_50_N

#set_property -dict {PACKAGE_PIN K20 IOSTANDARD LVCMOS33} [get_ports pl_i2c1_scl]
#set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports pl_i2c1_sda]
