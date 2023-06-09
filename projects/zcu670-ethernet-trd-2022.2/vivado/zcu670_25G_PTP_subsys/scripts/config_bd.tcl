
################################################################
# This is a generated script based on design: xxv_ptp_subsys
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source xxv_ptp_subsys_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
   set_property BOARD_PART xilinx.com:zcu102:part0:3.4 [current_project]
}

# CHANGE DESIGN NAME HERE
variable design_name
set design_name xxv_ptp_subsys

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES:
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: TX_HW_MASTER
proc create_hier_cell_TX_HW_MASTER { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_TX_HW_MASTER() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_sts

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_cntrl


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 data_ready
  create_bd_pin -dir O -from 0 -to 0 data_valid
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I -from 0 -to 0 m_axis_mm2s_tvalid
  create_bd_pin -dir I m_axis_s2mm_tready
  create_bd_pin -dir I s_axis_mm2s_tlast
  create_bd_pin -dir I s_axis_s2mm_tlast
  create_bd_pin -dir I s_axis_s2mm_tvalid
  create_bd_pin -dir I -type clk tx_clk_out
  create_bd_pin -dir O -from 1 -to 0 tx_ptp_1588op_in
  create_bd_pin -dir I -from 79 -to 0 tx_ptp_tstamp_out
  create_bd_pin -dir I -from 15 -to 0 tx_ptp_tstamp_tag_out
  create_bd_pin -dir O -from 15 -to 0 tx_ptp_tstamp_tag_out1
  create_bd_pin -dir I tx_ptp_tstamp_valid_out
  create_bd_pin -dir I -type rst tx_user_rst
  create_bd_pin -dir I -from 0 -to 0 xxv_tready

  # Create instance: axi_register_slice_0, and set properties
  set axi_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice axi_register_slice_0 ]
  set_property -dict [list \
    CONFIG.ADDR_WIDTH {64} \
    CONFIG.AWUSER_WIDTH {4} \
    CONFIG.ID_WIDTH {1} \
  ] $axi_register_slice_0


  # Create instance: hw_master_top_1, and set properties
  set hw_master_top_1 [ create_bd_cell -type ip -vlnv user.org:XUP:hw_master_top hw_master_top_1 ]

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_0 ]
  set_property CONFIG.C_SIZE {1} $util_vector_logic_0


  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_1 ]
  set_property CONFIG.C_SIZE {1} $util_vector_logic_1


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_register_slice_0/M_AXI]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins s_axis_cntrl] [get_bd_intf_pins hw_master_top_1/s_axis_cntrl]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_sts] [get_bd_intf_pins hw_master_top_1/m_axis_sts]
  connect_bd_intf_net -intf_net hw_master_top_1_m00_axi [get_bd_intf_pins axi_register_slice_0/S_AXI] [get_bd_intf_pins hw_master_top_1/m00_axi]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins xxv_tready] [get_bd_pins hw_master_top_1/mrmac_tx_tready] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net axi_mcdma_0_s_axis_s2mm_tready [get_bd_pins m_axis_s2mm_tready] [get_bd_pins hw_master_top_1/m_axis_s2mm_tready]
  connect_bd_net -net axi_resetn_1 [get_bd_pins tx_user_rst] [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins hw_master_top_1/m00_axi_aresetn] [get_bd_pins hw_master_top_1/s_axis_resetn]
  connect_bd_net -net axis_txd_fifo_m_axis_tlast [get_bd_pins s_axis_mm2s_tlast] [get_bd_pins hw_master_top_1/s_axis_mm2s_tlast]
  connect_bd_net -net axis_txd_fifo_m_axis_tvalid [get_bd_pins m_axis_mm2s_tvalid] [get_bd_pins hw_master_top_1/s_axis_mm2s_tvalid] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net hw_master_top_1_data_ready [get_bd_pins hw_master_top_1/data_ready] [get_bd_pins util_vector_logic_0/Op2]
  connect_bd_net -net hw_master_top_1_data_valid [get_bd_pins hw_master_top_1/data_valid] [get_bd_pins util_vector_logic_1/Op2]
  connect_bd_net -net hw_master_top_1_interrupt [get_bd_pins interrupt] [get_bd_pins hw_master_top_1/interrupt]
  connect_bd_net -net hw_master_top_1_tx_ptp_1588op_in [get_bd_pins tx_ptp_1588op_in] [get_bd_pins hw_master_top_1/tx_ptp_1588op_in]
  connect_bd_net -net hw_master_top_1_tx_ptp_tstamp_tag_out [get_bd_pins tx_ptp_tstamp_tag_out1] [get_bd_pins hw_master_top_1/tx_ptp_tstamp_tag_out]
  connect_bd_net -net tdest_mapper_0_m_axis_s2mm_tlast [get_bd_pins s_axis_s2mm_tlast] [get_bd_pins hw_master_top_1/s_axis_s2mm_tlast]
  connect_bd_net -net tdest_mapper_0_m_axis_s2mm_tvalid [get_bd_pins s_axis_s2mm_tvalid] [get_bd_pins hw_master_top_1/s_axis_s2mm_tvalid]
  connect_bd_net -net tx_clk_out_2 [get_bd_pins tx_clk_out] [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins hw_master_top_1/m00_axi_aclk] [get_bd_pins hw_master_top_1/s_axis_clk]
  connect_bd_net -net tx_ptp_tstamp_out_1 [get_bd_pins tx_ptp_tstamp_out] [get_bd_pins hw_master_top_1/tx_timestamp_tod]
  connect_bd_net -net tx_ptp_tstamp_tag_out_1 [get_bd_pins tx_ptp_tstamp_tag_out] [get_bd_pins hw_master_top_1/tx_ptp_tstamp_tag_in]
  connect_bd_net -net tx_ptp_tstamp_valid_out_1 [get_bd_pins tx_ptp_tstamp_valid_out] [get_bd_pins hw_master_top_1/tx_timestamp_tod_valid]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins data_ready] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins data_valid] [get_bd_pins util_vector_logic_1/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: PTP_PKT_Detect_TS_Prepend
proc create_hier_cell_PTP_PKT_Detect_TS_Prepend { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_PTP_PKT_Detect_TS_Prepend() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis


  # Create pins
  create_bd_pin -dir I fifo_full
  create_bd_pin -dir I -from 63 -to 0 m_axis_rxd_tdata
  create_bd_pin -dir I -from 7 -to 0 m_axis_rxd_tkeep
  create_bd_pin -dir I m_axis_rxd_tlast
  create_bd_pin -dir O m_axis_rxd_tready
  create_bd_pin -dir I m_axis_rxd_tvalid
  create_bd_pin -dir I -type clk rx_clk_out
  create_bd_pin -dir I -from 79 -to 0 rx_ptp_tstamp_out
  create_bd_pin -dir I -from 0 -to 0 rx_ptp_tstamp_valid_out
  create_bd_pin -dir I -from 63 -to 0 s_axis_rxd_tdata
  create_bd_pin -dir I -from 7 -to 0 s_axis_rxd_tkeep
  create_bd_pin -dir I s_axis_rxd_tlast
  create_bd_pin -dir I s_axis_rxd_tready
  create_bd_pin -dir O -from 0 -to 0 s_axis_rxd_tvaild
  create_bd_pin -dir I -from 0 -to 0 s_axis_tvalid
  create_bd_pin -dir I user_rx_reset
  create_bd_pin -dir I -type rst user_rx_reset_n

  # Create instance: RX_PTP_PKT_DETECT_on_0, and set properties
  set RX_PTP_PKT_DETECT_on_0 [ create_bd_cell -type ip -vlnv user.org:user:RX_PTP_PKT_DETECT_one_step RX_PTP_PKT_DETECT_on_0 ]

  # Create instance: RX_PTP_TS_PREPEND_0, and set properties
  set RX_PTP_TS_PREPEND_0 [ create_bd_cell -type ip -vlnv user.org:user:RX_PTP_TS_PREPEND RX_PTP_TS_PREPEND_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator fifo_generator_0 ]
  set_property -dict [list \
    CONFIG.Input_Data_Width {80} \
    CONFIG.Input_Depth {512} \
    CONFIG.Performance_Options {First_Word_Fall_Through} \
    CONFIG.Programmable_Full_Type {Single_Programmable_Full_Threshold_Constant} \
  ] $fifo_generator_0


  # Create instance: fifo_generator_1, and set properties
  set fifo_generator_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator fifo_generator_1 ]
  set_property -dict [list \
    CONFIG.Input_Data_Width {16} \
    CONFIG.Input_Depth {512} \
    CONFIG.Performance_Options {First_Word_Fall_Through} \
    CONFIG.Programmable_Full_Type {Single_Programmable_Full_Threshold_Constant} \
  ] $fifo_generator_1


  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_2 ]
  set_property CONFIG.C_SIZE {1} $util_vector_logic_2


  # Create instance: util_vector_logic_3, and set properties
  set util_vector_logic_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_3 ]
  set_property CONFIG.C_SIZE {1} $util_vector_logic_3


  # Create interface connections
  connect_bd_intf_net -intf_net RX_PTP_TS_PREPEND_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins RX_PTP_TS_PREPEND_0/m_axis]

  # Create port connections
  connect_bd_net -net Net1 [get_bd_pins s_axis_rxd_tready] [get_bd_pins RX_PTP_PKT_DETECT_on_0/s_axis_tready] [get_bd_pins RX_PTP_PKT_DETECT_on_0/s_axis_tready_fifo]
  connect_bd_net -net RX_PTP_PKT_DETECT_on_0_wr_data [get_bd_pins RX_PTP_PKT_DETECT_on_0/wr_data] [get_bd_pins fifo_generator_1/din]
  connect_bd_net -net RX_PTP_PKT_DETECT_on_0_wr_en [get_bd_pins RX_PTP_PKT_DETECT_on_0/wr_en] [get_bd_pins fifo_generator_1/wr_en]
  connect_bd_net -net RX_PTP_TS_PREPEND_0_fifo_valid [get_bd_pins RX_PTP_TS_PREPEND_0/fifo_valid] [get_bd_pins util_vector_logic_2/Op2] [get_bd_pins util_vector_logic_3/Op2]
  connect_bd_net -net RX_PTP_TS_PREPEND_0_rd_en [get_bd_pins RX_PTP_TS_PREPEND_0/rd_en] [get_bd_pins fifo_generator_0/rd_en] [get_bd_pins fifo_generator_1/rd_en]
  connect_bd_net -net RX_PTP_TS_PREPEND_0_s_axis_tready [get_bd_pins m_axis_rxd_tready] [get_bd_pins RX_PTP_TS_PREPEND_0/s_axis_tready]
  connect_bd_net -net fifo_full_1 [get_bd_pins fifo_full] [get_bd_pins RX_PTP_TS_PREPEND_0/fifo_full]
  connect_bd_net -net fifo_generator_0_dout [get_bd_pins RX_PTP_TS_PREPEND_0/rx_timestamp_tod] [get_bd_pins fifo_generator_0/dout]
  connect_bd_net -net fifo_generator_1_dout [get_bd_pins RX_PTP_TS_PREPEND_0/rd_data] [get_bd_pins fifo_generator_1/dout]
  connect_bd_net -net fifo_generator_1_empty [get_bd_pins RX_PTP_TS_PREPEND_0/empty] [get_bd_pins fifo_generator_1/empty]
  connect_bd_net -net rx_clk_out_2 [get_bd_pins rx_clk_out] [get_bd_pins RX_PTP_PKT_DETECT_on_0/rx_axis_clk_in] [get_bd_pins RX_PTP_TS_PREPEND_0/rx_axis_clk_in] [get_bd_pins fifo_generator_0/clk] [get_bd_pins fifo_generator_1/clk]
  connect_bd_net -net rx_ptp_tstamp_out_1 [get_bd_pins rx_ptp_tstamp_out] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net rx_ptp_tstamp_valid_out_1 [get_bd_pins rx_ptp_tstamp_valid_out] [get_bd_pins util_vector_logic_3/Op1]
  connect_bd_net -net rx_reset_n_Res [get_bd_pins user_rx_reset_n] [get_bd_pins RX_PTP_PKT_DETECT_on_0/rx_axis_reset_in] [get_bd_pins RX_PTP_TS_PREPEND_0/rx_axis_reset_in]
  connect_bd_net -net s_axis_tdata1_1 [get_bd_pins m_axis_rxd_tdata] [get_bd_pins RX_PTP_TS_PREPEND_0/s_axis_tdata]
  connect_bd_net -net s_axis_tdata_1 [get_bd_pins s_axis_rxd_tdata] [get_bd_pins RX_PTP_PKT_DETECT_on_0/s_axis_tdata]
  connect_bd_net -net s_axis_tkeep1_1 [get_bd_pins m_axis_rxd_tkeep] [get_bd_pins RX_PTP_TS_PREPEND_0/s_axis_tkeep]
  connect_bd_net -net s_axis_tkeep_1 [get_bd_pins s_axis_rxd_tkeep] [get_bd_pins RX_PTP_PKT_DETECT_on_0/s_axis_tkeep]
  connect_bd_net -net s_axis_tlast1_1 [get_bd_pins m_axis_rxd_tlast] [get_bd_pins RX_PTP_TS_PREPEND_0/s_axis_tlast]
  connect_bd_net -net s_axis_tlast_1 [get_bd_pins s_axis_rxd_tlast] [get_bd_pins RX_PTP_PKT_DETECT_on_0/s_axis_tlast] [get_bd_pins RX_PTP_TS_PREPEND_0/mrmac_last]
  connect_bd_net -net s_axis_tvalid1_1 [get_bd_pins m_axis_rxd_tvalid] [get_bd_pins RX_PTP_TS_PREPEND_0/s_axis_tvalid]
  connect_bd_net -net s_axis_tvalid_1 [get_bd_pins s_axis_tvalid] [get_bd_pins RX_PTP_TS_PREPEND_0/mrmac_valid] [get_bd_pins util_vector_logic_2/Op1]
  connect_bd_net -net user_rx_reset_1 [get_bd_pins user_rx_reset] [get_bd_pins fifo_generator_0/srst] [get_bd_pins fifo_generator_1/srst]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins s_axis_rxd_tvaild] [get_bd_pins RX_PTP_PKT_DETECT_on_0/s_axis_tvalid] [get_bd_pins util_vector_logic_2/Res]
  connect_bd_net -net util_vector_logic_3_Res [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins util_vector_logic_3/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_dma_hier
proc create_hier_cell_axi_dma_hier { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_axi_dma_hier() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_SG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite_dma


  # Create pins
  create_bd_pin -dir I -type clk clk_156_25
  create_bd_pin -dir O -from 0 -to 0 dma_rx_reset
  create_bd_pin -dir O -from 0 -to 0 dma_tx_reset
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir O -from 63 -to 0 m_axis_tdata
  create_bd_pin -dir O -from 7 -to 0 m_axis_tkeep
  create_bd_pin -dir O m_axis_tlast
  create_bd_pin -dir O -from 15 -to 0 m_axis_tuser
  create_bd_pin -dir O -from 0 -to 0 m_axis_txd
  create_bd_pin -dir O -type intr mm2s_introut
  create_bd_pin -dir I -type rst perph_aresetn_156_25
  create_bd_pin -dir I -type clk rx_clk_out
  create_bd_pin -dir I -from 79 -to 0 rx_ptp_tstamp_out
  create_bd_pin -dir I -from 0 -to 0 rx_ptp_tstamp_valid_out
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I -from 63 -to 0 s_axis_tdata
  create_bd_pin -dir I -from 7 -to 0 s_axis_tkeep
  create_bd_pin -dir I s_axis_tlast
  create_bd_pin -dir I -from 0 -to 0 s_axis_tuser
  create_bd_pin -dir I s_axis_tvalid
  create_bd_pin -dir I -type clk tx_clk_out
  create_bd_pin -dir O -from 1 -to 0 tx_ptp_1588op_in
  create_bd_pin -dir I -from 79 -to 0 tx_ptp_tstamp_out
  create_bd_pin -dir I -from 15 -to 0 tx_ptp_tstamp_tag_out
  create_bd_pin -dir O -from 15 -to 0 tx_ptp_tstamp_tag_out1
  create_bd_pin -dir I tx_ptp_tstamp_valid_out
  create_bd_pin -dir I user_rx_reset
  create_bd_pin -dir O -from 0 -to 0 user_rx_reset_n
  create_bd_pin -dir I -type rst user_tx_reset
  create_bd_pin -dir I -from 0 -to 0 xxv_tready

  # Create instance: Default_mcdma_chn, and set properties
  set Default_mcdma_chn [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant Default_mcdma_chn ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0x0} \
    CONFIG.CONST_WIDTH {4} \
  ] $Default_mcdma_chn


  # Create instance: Enable_TDest, and set properties
  set Enable_TDest [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant Enable_TDest ]
  set_property -dict [list \
    CONFIG.CONST_VAL {1} \
    CONFIG.CONST_WIDTH {1} \
  ] $Enable_TDest


  # Create instance: PTP_PKT_Detect_TS_Prepend
  create_hier_cell_PTP_PKT_Detect_TS_Prepend $hier_obj PTP_PKT_Detect_TS_Prepend

  # Create instance: TX_HW_MASTER
  create_hier_cell_TX_HW_MASTER $hier_obj TX_HW_MASTER

  # Create instance: axi_mcdma_0, and set properties
  set axi_mcdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_mcdma axi_mcdma_0 ]
  set_property -dict [list \
    CONFIG.c_group1_mm2s {1111111111111111} \
    CONFIG.c_group1_s2mm {1111111111111111} \
    CONFIG.c_include_mm2s_dre {1} \
    CONFIG.c_include_s2mm_dre {1} \
    CONFIG.c_m_axi_mm2s_data_width {64} \
    CONFIG.c_m_axi_s2mm_data_width {64} \
    CONFIG.c_m_axis_mm2s_tdata_width {64} \
    CONFIG.c_mm2s_burst_size {64} \
    CONFIG.c_mm2s_scheduler {1} \
    CONFIG.c_num_mm2s_channels {16} \
    CONFIG.c_num_s2mm_channels {16} \
    CONFIG.c_prmry_is_aclk_async {1} \
    CONFIG.c_s2mm_burst_size {64} \
    CONFIG.c_sg_include_stscntrl_strm {1} \
    CONFIG.c_sg_length_width {23} \
  ] $axi_mcdma_0


  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo_0 ]
  set_property -dict [list \
    CONFIG.FIFO_MODE {2} \
    CONFIG.HAS_WR_DATA_COUNT {0} \
    CONFIG.TDATA_NUM_BYTES {4} \
  ] $axis_data_fifo_0


  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo_1 ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {16384} \
    CONFIG.HAS_PROG_FULL {0} \
    CONFIG.HAS_WR_DATA_COUNT {0} \
    CONFIG.IS_ACLK_ASYNC {1} \
  ] $axis_data_fifo_1


  # Create instance: axis_rxd_fifo, and set properties
  set axis_rxd_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_rxd_fifo ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {16384} \
    CONFIG.FIFO_MODE {2} \
    CONFIG.HAS_PROG_FULL {1} \
    CONFIG.HAS_TKEEP {1} \
    CONFIG.HAS_WR_DATA_COUNT {0} \
    CONFIG.IS_ACLK_ASYNC {0} \
    CONFIG.PROG_FULL_THRESH {15000} \
    CONFIG.TDATA_NUM_BYTES {8} \
    CONFIG.TUSER_WIDTH {1} \
  ] $axis_rxd_fifo


  # Create instance: axis_txd_fifo, and set properties
  set axis_txd_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_txd_fifo ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {16384} \
    CONFIG.FIFO_MODE {2} \
    CONFIG.HAS_TKEEP {1} \
    CONFIG.IS_ACLK_ASYNC {0} \
    CONFIG.TUSER_WIDTH {16} \
  ] $axis_txd_fifo


  # Create instance: dma_rx_reset, and set properties
  set dma_rx_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic dma_rx_reset ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $dma_rx_reset


  # Create instance: dma_tx_reset, and set properties
  set dma_tx_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic dma_tx_reset ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $dma_tx_reset


  # Create instance: rx_reset_n, and set properties
  set rx_reset_n [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic rx_reset_n ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $rx_reset_n


  # Create instance: tdest_mapper_1, and set properties
  set tdest_mapper_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:tdest_mapper tdest_mapper_1 ]

  # Create instance: tx_reset_n, and set properties
  set tx_reset_n [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic tx_reset_n ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $tx_reset_n


  # Create instance: util_reduced_logic_0, and set properties
  set util_reduced_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic util_reduced_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {or} \
    CONFIG.C_SIZE {16} \
  ] $util_reduced_logic_0


  # Create instance: util_reduced_logic_1, and set properties
  set util_reduced_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic util_reduced_logic_1 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {or} \
    CONFIG.C_SIZE {16} \
  ] $util_reduced_logic_1


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {16} $xlconcat_0


  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_1 ]
  set_property CONFIG.NUM_PORTS {16} $xlconcat_1


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins TX_HW_MASTER/M_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins axis_rxd_fifo/S_AXIS]
  connect_bd_intf_net -intf_net RX_PTP_TS_PREPEND_0_m_axis [get_bd_intf_pins PTP_PKT_Detect_TS_Prepend/m_axis] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net axi_mcdma_0_M_AXIS_CNTRL [get_bd_intf_pins axi_mcdma_0/M_AXIS_CNTRL] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_mcdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_mcdma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_txd_fifo/S_AXIS]
  connect_bd_intf_net -intf_net axi_mcdma_0_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_mcdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_mcdma_0_M_AXI_S2MM [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_mcdma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_mcdma_0_M_AXI_SG [get_bd_intf_pins M_AXI_SG] [get_bd_intf_pins axi_mcdma_0/M_AXI_SG]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins TX_HW_MASTER/s_axis_cntrl] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins TX_HW_MASTER/m_axis_sts] [get_bd_intf_pins axi_mcdma_0/S_AXIS_STS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS1 [get_bd_intf_pins axis_data_fifo_1/M_AXIS] [get_bd_intf_pins tdest_mapper_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axi_lite_dma_1 [get_bd_intf_pins s_axi_lite_dma] [get_bd_intf_pins axi_mcdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net tdest_mapper_1_M_AXIS [get_bd_intf_pins axi_mcdma_0/S_AXIS_S2MM] [get_bd_intf_pins tdest_mapper_1/M_AXIS]

  # Create port connections
  connect_bd_net -net Default_mcdma_chn_dout [get_bd_pins Default_mcdma_chn/dout] [get_bd_pins tdest_mapper_1/default_mcdma_ch]
  connect_bd_net -net Enable_TDest_dout [get_bd_pins Enable_TDest/dout] [get_bd_pins tdest_mapper_1/tdest_mapper_en]
  connect_bd_net -net Op1_1 [get_bd_pins xxv_tready] [get_bd_pins TX_HW_MASTER/xxv_tready]
  connect_bd_net -net PTP_PKT_Detect_TS_Prepend_Res [get_bd_pins PTP_PKT_Detect_TS_Prepend/s_axis_rxd_tvaild] [get_bd_pins axis_rxd_fifo/s_axis_tvalid]
  connect_bd_net -net PTP_PKT_Detect_TS_Prepend_s_axis_tready1 [get_bd_pins PTP_PKT_Detect_TS_Prepend/m_axis_rxd_tready] [get_bd_pins axis_rxd_fifo/m_axis_tready]
  connect_bd_net -net TX_HW_MASTER_Res [get_bd_pins m_axis_txd] [get_bd_pins TX_HW_MASTER/data_valid]
  connect_bd_net -net TX_HW_MASTER_Res1 [get_bd_pins TX_HW_MASTER/data_ready] [get_bd_pins axis_txd_fifo/m_axis_tready]
  connect_bd_net -net TX_HW_MASTER_interrupt [get_bd_pins interrupt] [get_bd_pins TX_HW_MASTER/interrupt]
  connect_bd_net -net TX_HW_MASTER_tx_ptp_tstamp_tag_out1 [get_bd_pins tx_ptp_tstamp_tag_out1] [get_bd_pins TX_HW_MASTER/tx_ptp_tstamp_tag_out1]
  connect_bd_net -net axi_mcdma_0_mm2s_ch10_introut [get_bd_pins axi_mcdma_0/mm2s_ch10_introut] [get_bd_pins xlconcat_0/In9]
  connect_bd_net -net axi_mcdma_0_mm2s_ch11_introut [get_bd_pins axi_mcdma_0/mm2s_ch11_introut] [get_bd_pins xlconcat_0/In10]
  connect_bd_net -net axi_mcdma_0_mm2s_ch12_introut [get_bd_pins axi_mcdma_0/mm2s_ch12_introut] [get_bd_pins xlconcat_0/In11]
  connect_bd_net -net axi_mcdma_0_mm2s_ch13_introut [get_bd_pins axi_mcdma_0/mm2s_ch13_introut] [get_bd_pins xlconcat_0/In12]
  connect_bd_net -net axi_mcdma_0_mm2s_ch14_introut [get_bd_pins axi_mcdma_0/mm2s_ch14_introut] [get_bd_pins xlconcat_0/In13]
  connect_bd_net -net axi_mcdma_0_mm2s_ch15_introut [get_bd_pins axi_mcdma_0/mm2s_ch15_introut] [get_bd_pins xlconcat_0/In14]
  connect_bd_net -net axi_mcdma_0_mm2s_ch16_introut [get_bd_pins axi_mcdma_0/mm2s_ch16_introut] [get_bd_pins xlconcat_0/In15]
  connect_bd_net -net axi_mcdma_0_mm2s_ch1_introut [get_bd_pins axi_mcdma_0/mm2s_ch1_introut] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net axi_mcdma_0_mm2s_ch2_introut [get_bd_pins axi_mcdma_0/mm2s_ch2_introut] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net axi_mcdma_0_mm2s_ch3_introut [get_bd_pins axi_mcdma_0/mm2s_ch3_introut] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net axi_mcdma_0_mm2s_ch4_introut [get_bd_pins axi_mcdma_0/mm2s_ch4_introut] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net axi_mcdma_0_mm2s_ch5_introut [get_bd_pins axi_mcdma_0/mm2s_ch5_introut] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net axi_mcdma_0_mm2s_ch6_introut [get_bd_pins axi_mcdma_0/mm2s_ch6_introut] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net axi_mcdma_0_mm2s_ch7_introut [get_bd_pins axi_mcdma_0/mm2s_ch7_introut] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net axi_mcdma_0_mm2s_ch8_introut [get_bd_pins axi_mcdma_0/mm2s_ch8_introut] [get_bd_pins xlconcat_0/In7]
  connect_bd_net -net axi_mcdma_0_mm2s_ch9_introut [get_bd_pins axi_mcdma_0/mm2s_ch9_introut] [get_bd_pins xlconcat_0/In8]
  connect_bd_net -net axi_mcdma_0_mm2s_prmry_reset_out_n [get_bd_pins axi_mcdma_0/mm2s_prmry_reset_out_n] [get_bd_pins dma_tx_reset/Op1]
  connect_bd_net -net axi_mcdma_0_s2mm_ch10_introut [get_bd_pins axi_mcdma_0/s2mm_ch10_introut] [get_bd_pins xlconcat_1/In9]
  connect_bd_net -net axi_mcdma_0_s2mm_ch11_introut [get_bd_pins axi_mcdma_0/s2mm_ch11_introut] [get_bd_pins xlconcat_1/In10]
  connect_bd_net -net axi_mcdma_0_s2mm_ch12_introut [get_bd_pins axi_mcdma_0/s2mm_ch12_introut] [get_bd_pins xlconcat_1/In11]
  connect_bd_net -net axi_mcdma_0_s2mm_ch13_introut [get_bd_pins axi_mcdma_0/s2mm_ch13_introut] [get_bd_pins xlconcat_1/In12]
  connect_bd_net -net axi_mcdma_0_s2mm_ch14_introut [get_bd_pins axi_mcdma_0/s2mm_ch14_introut] [get_bd_pins xlconcat_1/In13]
  connect_bd_net -net axi_mcdma_0_s2mm_ch15_introut [get_bd_pins axi_mcdma_0/s2mm_ch15_introut] [get_bd_pins xlconcat_1/In14]
  connect_bd_net -net axi_mcdma_0_s2mm_ch16_introut [get_bd_pins axi_mcdma_0/s2mm_ch16_introut] [get_bd_pins xlconcat_1/In15]
  connect_bd_net -net axi_mcdma_0_s2mm_ch1_introut [get_bd_pins axi_mcdma_0/s2mm_ch1_introut] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net axi_mcdma_0_s2mm_ch2_introut [get_bd_pins axi_mcdma_0/s2mm_ch2_introut] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net axi_mcdma_0_s2mm_ch3_introut [get_bd_pins axi_mcdma_0/s2mm_ch3_introut] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net axi_mcdma_0_s2mm_ch4_introut [get_bd_pins axi_mcdma_0/s2mm_ch4_introut] [get_bd_pins xlconcat_1/In3]
  connect_bd_net -net axi_mcdma_0_s2mm_ch5_introut [get_bd_pins axi_mcdma_0/s2mm_ch5_introut] [get_bd_pins xlconcat_1/In4]
  connect_bd_net -net axi_mcdma_0_s2mm_ch6_introut [get_bd_pins axi_mcdma_0/s2mm_ch6_introut] [get_bd_pins xlconcat_1/In5]
  connect_bd_net -net axi_mcdma_0_s2mm_ch7_introut [get_bd_pins axi_mcdma_0/s2mm_ch7_introut] [get_bd_pins xlconcat_1/In6]
  connect_bd_net -net axi_mcdma_0_s2mm_ch8_introut [get_bd_pins axi_mcdma_0/s2mm_ch8_introut] [get_bd_pins xlconcat_1/In7]
  connect_bd_net -net axi_mcdma_0_s2mm_ch9_introut [get_bd_pins axi_mcdma_0/s2mm_ch9_introut] [get_bd_pins xlconcat_1/In8]
  connect_bd_net -net axi_mcdma_0_s2mm_prmry_reset_out_n [get_bd_pins axi_mcdma_0/s2mm_prmry_reset_out_n] [get_bd_pins dma_rx_reset/Op1]
  connect_bd_net -net axi_mcdma_0_s_axis_s2mm_tready [get_bd_pins TX_HW_MASTER/m_axis_s2mm_tready] [get_bd_pins axi_mcdma_0/s_axis_s2mm_tready] [get_bd_pins tdest_mapper_1/m_axis_s2mm_tready]
  connect_bd_net -net axi_resetn_1 [get_bd_pins TX_HW_MASTER/tx_user_rst] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_txd_fifo/s_axis_aresetn] [get_bd_pins tdest_mapper_1/reset] [get_bd_pins tx_reset_n/Res]
  connect_bd_net -net axis_rxd_fifo_m_axis_tdata [get_bd_pins PTP_PKT_Detect_TS_Prepend/m_axis_rxd_tdata] [get_bd_pins axis_rxd_fifo/m_axis_tdata]
  connect_bd_net -net axis_rxd_fifo_m_axis_tkeep [get_bd_pins PTP_PKT_Detect_TS_Prepend/m_axis_rxd_tkeep] [get_bd_pins axis_rxd_fifo/m_axis_tkeep]
  connect_bd_net -net axis_rxd_fifo_m_axis_tlast [get_bd_pins PTP_PKT_Detect_TS_Prepend/m_axis_rxd_tlast] [get_bd_pins axis_rxd_fifo/m_axis_tlast]
  connect_bd_net -net axis_rxd_fifo_m_axis_tvalid [get_bd_pins PTP_PKT_Detect_TS_Prepend/m_axis_rxd_tvalid] [get_bd_pins axis_rxd_fifo/m_axis_tvalid]
  connect_bd_net -net axis_rxd_fifo_prog_full [get_bd_pins PTP_PKT_Detect_TS_Prepend/fifo_full] [get_bd_pins axis_rxd_fifo/prog_full]
  connect_bd_net -net axis_rxd_fifo_s_axis_tready [get_bd_pins PTP_PKT_Detect_TS_Prepend/s_axis_rxd_tready] [get_bd_pins axis_rxd_fifo/s_axis_tready]
  connect_bd_net -net axis_txd_fifo_m_axis_tdata [get_bd_pins m_axis_tdata] [get_bd_pins axis_txd_fifo/m_axis_tdata]
  connect_bd_net -net axis_txd_fifo_m_axis_tkeep [get_bd_pins m_axis_tkeep] [get_bd_pins axis_txd_fifo/m_axis_tkeep]
  connect_bd_net -net axis_txd_fifo_m_axis_tlast [get_bd_pins m_axis_tlast] [get_bd_pins TX_HW_MASTER/s_axis_mm2s_tlast] [get_bd_pins axis_txd_fifo/m_axis_tlast]
  connect_bd_net -net axis_txd_fifo_m_axis_tuser [get_bd_pins m_axis_tuser] [get_bd_pins axis_txd_fifo/m_axis_tuser]
  connect_bd_net -net axis_txd_fifo_m_axis_tvalid [get_bd_pins TX_HW_MASTER/m_axis_mm2s_tvalid] [get_bd_pins axis_txd_fifo/m_axis_tvalid]
  connect_bd_net -net clk_156_25_1 [get_bd_pins clk_156_25] [get_bd_pins axi_mcdma_0/m_axi_sg_aclk] [get_bd_pins axi_mcdma_0/s_axi_lite_aclk]
  connect_bd_net -net dma_rx_reset_Res [get_bd_pins dma_rx_reset] [get_bd_pins dma_rx_reset/Res]
  connect_bd_net -net dma_tx_reset_Res [get_bd_pins dma_tx_reset] [get_bd_pins dma_tx_reset/Res]
  connect_bd_net -net hw_master_top_1_tx_ptp_1588op_in [get_bd_pins tx_ptp_1588op_in] [get_bd_pins TX_HW_MASTER/tx_ptp_1588op_in]
  connect_bd_net -net perph_aresetn_156_25_1 [get_bd_pins perph_aresetn_156_25] [get_bd_pins axi_mcdma_0/axi_resetn]
  connect_bd_net -net rx_clk_out_2 [get_bd_pins rx_clk_out] [get_bd_pins PTP_PKT_Detect_TS_Prepend/rx_clk_out] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_rxd_fifo/s_axis_aclk]
  connect_bd_net -net rx_ptp_tstamp_out_1 [get_bd_pins rx_ptp_tstamp_out] [get_bd_pins PTP_PKT_Detect_TS_Prepend/rx_ptp_tstamp_out]
  connect_bd_net -net rx_ptp_tstamp_valid_out_1 [get_bd_pins rx_ptp_tstamp_valid_out] [get_bd_pins PTP_PKT_Detect_TS_Prepend/rx_ptp_tstamp_valid_out]
  connect_bd_net -net rx_reset_n_Res [get_bd_pins user_rx_reset_n] [get_bd_pins PTP_PKT_Detect_TS_Prepend/user_rx_reset_n] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_rxd_fifo/s_axis_aresetn] [get_bd_pins rx_reset_n/Res]
  connect_bd_net -net s_axis_tdata_1 [get_bd_pins s_axis_tdata] [get_bd_pins PTP_PKT_Detect_TS_Prepend/s_axis_rxd_tdata] [get_bd_pins axis_rxd_fifo/s_axis_tdata]
  connect_bd_net -net s_axis_tkeep_1 [get_bd_pins s_axis_tkeep] [get_bd_pins PTP_PKT_Detect_TS_Prepend/s_axis_rxd_tkeep] [get_bd_pins axis_rxd_fifo/s_axis_tkeep]
  connect_bd_net -net s_axis_tlast_1 [get_bd_pins s_axis_tlast] [get_bd_pins PTP_PKT_Detect_TS_Prepend/s_axis_rxd_tlast] [get_bd_pins axis_rxd_fifo/s_axis_tlast]
  connect_bd_net -net s_axis_tuser_1 [get_bd_pins s_axis_tuser] [get_bd_pins axis_rxd_fifo/s_axis_tuser]
  connect_bd_net -net s_axis_tvalid_1 [get_bd_pins s_axis_tvalid] [get_bd_pins PTP_PKT_Detect_TS_Prepend/s_axis_tvalid]
  connect_bd_net -net tdest_mapper_0_m_axis_s2mm_tlast [get_bd_pins TX_HW_MASTER/s_axis_s2mm_tlast] [get_bd_pins axi_mcdma_0/s_axis_s2mm_tlast] [get_bd_pins tdest_mapper_1/m_axis_s2mm_tlast]
  connect_bd_net -net tdest_mapper_0_m_axis_s2mm_tvalid [get_bd_pins TX_HW_MASTER/s_axis_s2mm_tvalid] [get_bd_pins axi_mcdma_0/s_axis_s2mm_tvalid] [get_bd_pins tdest_mapper_1/m_axis_s2mm_tvalid]
  connect_bd_net -net tdest_mapper_1_m_axis_s2mm_tdata [get_bd_pins axi_mcdma_0/s_axis_s2mm_tdata] [get_bd_pins tdest_mapper_1/m_axis_s2mm_tdata]
  connect_bd_net -net tdest_mapper_1_m_axis_s2mm_tdest [get_bd_pins axi_mcdma_0/s_axis_s2mm_tdest] [get_bd_pins tdest_mapper_1/m_axis_s2mm_tdest]
  connect_bd_net -net tdest_mapper_1_m_axis_s2mm_tkeep [get_bd_pins axi_mcdma_0/s_axis_s2mm_tkeep] [get_bd_pins tdest_mapper_1/m_axis_s2mm_tkeep]
  connect_bd_net -net tdest_mapper_1_m_axis_s2mm_tuser [get_bd_pins axi_mcdma_0/s_axis_s2mm_tuser] [get_bd_pins tdest_mapper_1/m_axis_s2mm_tuser]
  connect_bd_net -net tx_clk_out_1 [get_bd_pins tx_clk_out] [get_bd_pins TX_HW_MASTER/tx_clk_out] [get_bd_pins axi_mcdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_mcdma_0/m_axi_s2mm_aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/m_axis_aclk] [get_bd_pins axis_txd_fifo/s_axis_aclk] [get_bd_pins tdest_mapper_1/clk]
  connect_bd_net -net tx_ptp_tstamp_out_1 [get_bd_pins tx_ptp_tstamp_out] [get_bd_pins TX_HW_MASTER/tx_ptp_tstamp_out]
  connect_bd_net -net tx_ptp_tstamp_tag_out_1 [get_bd_pins tx_ptp_tstamp_tag_out] [get_bd_pins TX_HW_MASTER/tx_ptp_tstamp_tag_out]
  connect_bd_net -net tx_ptp_tstamp_valid_out_1 [get_bd_pins tx_ptp_tstamp_valid_out] [get_bd_pins TX_HW_MASTER/tx_ptp_tstamp_valid_out]
  connect_bd_net -net user_rx_reset_1 [get_bd_pins user_rx_reset] [get_bd_pins PTP_PKT_Detect_TS_Prepend/user_rx_reset] [get_bd_pins rx_reset_n/Op1]
  connect_bd_net -net user_tx_reset_1 [get_bd_pins user_tx_reset] [get_bd_pins tx_reset_n/Op1]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins mm2s_introut] [get_bd_pins util_reduced_logic_0/Res]
  connect_bd_net -net util_reduced_logic_1_Res [get_bd_pins s2mm_introut] [get_bd_pins util_reduced_logic_1/Res]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins util_reduced_logic_0/Op1] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins util_reduced_logic_1/Op1] [get_bd_pins xlconcat_1/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: bram
proc create_hier_cell_bram { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_bram() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I -from 0 -to 0 -type rst ARESETN
  create_bd_pin -dir I -type clk M00_ACLK

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl axi_bram_ctrl_0 ]

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen axi_bram_ctrl_0_bram ]
  set_property -dict [list \
    CONFIG.EN_SAFETY_CKT {false} \
    CONFIG.Enable_B {Use_ENB_Pin} \
    CONFIG.Memory_Type {True_Dual_Port_RAM} \
    CONFIG.Port_B_Clock {100} \
    CONFIG.Port_B_Enable_Rate {100} \
    CONFIG.Port_B_Write_Rate {50} \
    CONFIG.Use_RSTB_Pin {true} \
  ] $axi_bram_ctrl_0_bram


  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_mem_intercon ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {1} \
  ] $axi_mem_intercon


  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_mem_intercon/S00_AXI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTB [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_mem_intercon/M00_AXI]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins ARESETN] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins M00_ACLK] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: rx_clk_led
proc create_hier_cell_rx_clk_led { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rx_clk_led() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -from 0 -to 0 Dout

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.Output_Width {32} \
    CONFIG.Restrict_Count {false} \
  ] $c_counter_binary_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {24} \
    CONFIG.DIN_TO {24} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_0


  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins c_counter_binary_0/CLK]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mgt_tx_clk_led
proc create_hier_cell_mgt_tx_clk_led { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mgt_tx_clk_led() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -from 0 -to 0 Dout

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.Output_Width {32} \
    CONFIG.Restrict_Count {false} \
  ] $c_counter_binary_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {24} \
    CONFIG.DIN_TO {24} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_0


  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins c_counter_binary_0/CLK]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_clk_led
proc create_hier_cell_axi_clk_led { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_axi_clk_led() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -from 0 -to 0 Dout

  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.Output_Width {32} \
    CONFIG.Restrict_Count {false} \
  ] $c_counter_binary_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {24} \
    CONFIG.DIN_TO {24} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_0


  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins c_counter_binary_0/CLK]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: PTP_support
proc create_hier_cell_PTP_support { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_PTP_support() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi2


  # Create pins
  create_bd_pin -dir I -from 63 -to 0 core_rx0_period_0
  create_bd_pin -dir I -from 63 -to 0 core_tx0_period_0
  create_bd_pin -dir O -from 79 -to 0 ctl_rx_systemtimerout
  create_bd_pin -dir O -from 79 -to 0 ctl_tx_systemtimerout
#  create_bd_pin -dir O one_pps
  create_bd_pin -dir I -type clk rx_phy_clk
  create_bd_pin -dir I -from 0 -to 0 rx_phy_rst
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I tod_1pps_in_0
  create_bd_pin -dir O tod_intr
  create_bd_pin -dir I -type clk ts_clk
  create_bd_pin -dir I ts_rst
  create_bd_pin -dir I -type clk tx_phy_clk
  create_bd_pin -dir I tx_phy_rst

  # Create instance: concat_rx_ns_s, and set properties
  set concat_rx_ns_s [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat concat_rx_ns_s ]
  set_property -dict [list \
    CONFIG.IN0_WIDTH {32} \
    CONFIG.IN1_WIDTH {48} \
  ] $concat_rx_ns_s


  # Create instance: concat_tx_ns_s, and set properties
  set concat_tx_ns_s [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat concat_tx_ns_s ]
  set_property -dict [list \
    CONFIG.IN0_WIDTH {32} \
    CONFIG.IN1_WIDTH {48} \
  ] $concat_tx_ns_s


  # Create instance: ptp_1588_timer_syncer_0, and set properties
  set ptp_1588_timer_syncer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ptp_1588_timer_syncer ptp_1588_timer_syncer_0 ]
  set_property -dict [list \
    CONFIG.AXI4LITE_FREQ {156.25} \
    CONFIG.CORE_CONFIGURATION {1} \
    CONFIG.CORE_MODE {Timer_Syncer} \
    CONFIG.ENABLE_HIGH_ACCURACY_MODE {0} \
    CONFIG.RESYNC_CLK_PERIOD {2560} \
    CONFIG.TIMER_FORMAT {Time_of_Day} \
    CONFIG.TOD_SEC_CLK_FREQ {100.00} \
    CONFIG.TS_CLK_PERIOD {4.0000} \
  ] $ptp_1588_timer_syncer_0

#    CONFIG.ENABLE_EXT_TOD_BUS {1} \

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi2] [get_bd_intf_pins ptp_1588_timer_syncer_0/s_axi]

  # Create port connections
  connect_bd_net -net axi_resetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins ptp_1588_timer_syncer_0/s_axi_aresetn]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins ts_clk] [get_bd_pins ptp_1588_timer_syncer_0/ts_clk]
  connect_bd_net -net concat_tx_ns_s_dout [get_bd_pins ctl_tx_systemtimerout] [get_bd_pins concat_tx_ns_s/dout]
  connect_bd_net -net core_rx0_period_0_1 [get_bd_pins core_rx0_period_0] [get_bd_pins ptp_1588_timer_syncer_0/core_rx0_period_0]
  connect_bd_net -net m_axi_mm2s_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins ptp_1588_timer_syncer_0/s_axi_aclk]
  connect_bd_net -net ptp_1588_timer_syncer_0_rx_tod_ns_0 [get_bd_pins concat_rx_ns_s/In0] [get_bd_pins ptp_1588_timer_syncer_0/rx_tod_ns_0]
  connect_bd_net -net ptp_1588_timer_syncer_0_rx_tod_sec_0 [get_bd_pins concat_rx_ns_s/In1] [get_bd_pins ptp_1588_timer_syncer_0/rx_tod_sec_0]
#  connect_bd_net -net ptp_1588_timer_syncer_0_tod_1pps_out [get_bd_pins one_pps] [get_bd_pins ptp_1588_timer_syncer_0/tod_1pps_out]
  connect_bd_net -net ptp_1588_timer_syncer_0_tod_intr [get_bd_pins tod_intr] [get_bd_pins ptp_1588_timer_syncer_0/tod_intr]
  connect_bd_net -net ptp_1588_timer_syncer_0_tx_tod_ns_0 [get_bd_pins concat_tx_ns_s/In0] [get_bd_pins ptp_1588_timer_syncer_0/tx_tod_ns_0]
  connect_bd_net -net ptp_1588_timer_syncer_0_tx_tod_sec_0 [get_bd_pins concat_tx_ns_s/In1] [get_bd_pins ptp_1588_timer_syncer_0/tx_tod_sec_0]
  connect_bd_net -net rx_clk_out_1 [get_bd_pins rx_phy_clk] [get_bd_pins ptp_1588_timer_syncer_0/rx_phy_clk_0]
  connect_bd_net -net tod_1pps_in_0_1 [get_bd_pins tod_1pps_in_0] [get_bd_pins ptp_1588_timer_syncer_0/tod_1pps_in]
  connect_bd_net -net tx_clk_out_1 [get_bd_pins tx_phy_clk] [get_bd_pins ptp_1588_timer_syncer_0/tx_phy_clk_0]
  connect_bd_net -net user_rx_reset_1 [get_bd_pins rx_phy_rst] [get_bd_pins ptp_1588_timer_syncer_0/rx_phy_rst_0]
  connect_bd_net -net user_tx_reset_1 [get_bd_pins tx_phy_rst] [get_bd_pins ptp_1588_timer_syncer_0/tx_phy_rst_0]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins ctl_rx_systemtimerout] [get_bd_pins concat_rx_ns_s/dout]
  connect_bd_net -net xxv_ethernet_0_tx_period_ns_0 [get_bd_pins core_tx0_period_0] [get_bd_pins ptp_1588_timer_syncer_0/core_tx0_period_0]
  connect_bd_net -net zynq_ps_peripheral_reset [get_bd_pins ts_rst] [get_bd_pins ptp_1588_timer_syncer_0/ts_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Ethernet_stream_subsystem
proc create_hier_cell_Ethernet_stream_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_Ethernet_stream_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_SG

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 gt_serial_port

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite_dma

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 user_idt_clock


  # Create pins
  create_bd_pin -dir I -from 0 -to 0 axi_gpio_qpll
  create_bd_pin -dir I -from 0 -to 0 -type rst axi_resetn
  create_bd_pin -dir I -from 79 -to 0 ctl_rx_systemtimerin_0
  create_bd_pin -dir I -from 79 -to 0 ctl_tx_systemtimerin_0
  create_bd_pin -dir I -type clk dclk
  create_bd_pin -dir O -from 0 -to 0 dma_rx_reset
  create_bd_pin -dir O -from 0 -to 0 dma_tx_reset
  create_bd_pin -dir O -type clk gt_refclk_out
  create_bd_pin -dir O gtpowergood_out
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir O -type intr mm2s_introut
  create_bd_pin -dir O -type clk rx_clk_out
  create_bd_pin -dir O -from 63 -to 0 rx_period_ns
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir O stat_rx_block_lock
  create_bd_pin -dir O stat_rx_internal_local_fault_0
  create_bd_pin -dir O stat_rx_local_fault
  create_bd_pin -dir O stat_rx_status
  create_bd_pin -dir O stat_tx_bad_fcs
  create_bd_pin -dir O stat_tx_local_fault
  create_bd_pin -dir I -type rst sys_reset
  create_bd_pin -dir O -type clk tx_clk_out
  create_bd_pin -dir O -from 63 -to 0 tx_period_ns
  create_bd_pin -dir O user_rx_reset
  create_bd_pin -dir O -from 0 -to 0 user_rx_reset_n
  create_bd_pin -dir O user_tx_reset

  # Create instance: axi_dma_hier
  create_hier_cell_axi_dma_hier $hier_obj axi_dma_hier

  # Create instance: tie_gnd, and set properties
  set tie_gnd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant tie_gnd ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {56} \
  ] $tie_gnd


  # Create instance: tie_gnd_1, and set properties
  set tie_gnd_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant tie_gnd_1 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {1} \
  ] $tie_gnd_1


  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_1 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {or} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_1


  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_2 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {5} \
    CONFIG.CONST_WIDTH {3} \
  ] $xlconstant_2


  # Create instance: xxv_ethernet_0, and set properties
  set xxv_ethernet_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xxv_ethernet xxv_ethernet_0 ]
#  set_property -dict [list \
    CONFIG.ADD_GT_CNTRL_STS_PORTS {0} \
    CONFIG.BASE_R_KR {BASE-R} \
    CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
    CONFIG.ENABLE_PIPELINE_REG {0} \
    CONFIG.ENABLE_TIME_STAMPING {1} \
    CONFIG.ETHERNET_BOARD_INTERFACE {sfp3_1x} \
    CONFIG.GT_REF_CLK_FREQ {156.25} \
    CONFIG.INCLUDE_AXI4_INTERFACE {1} \
    CONFIG.LANE1_GT_LOC {X0Y8} \
    CONFIG.LINE_RATE {25} \
    CONFIG.PTP_OPERATION_MODE {2} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $xxv_ethernet_0

 set_property -dict [ list \
   CONFIG.ADD_GT_CNTRL_STS_PORTS {0} \
   CONFIG.BASE_R_KR {BASE-R} \
   CONFIG.ENABLE_PIPELINE_REG {0} \
   CONFIG.ENABLE_TIME_STAMPING {1} \
   CONFIG.GT_REF_CLK_FREQ {156.25} \
   CONFIG.INCLUDE_AXI4_INTERFACE {1} \
   CONFIG.SYS_CLK {10000} \
   CONFIG.ENABLE_TIME_STAMPING {1} \
   CONFIG.PTP_OPERATION_MODE {2} \
 ] $xxv_ethernet_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_dma_hier/M_AXI]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_dma_hier/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_S2MM [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_dma_hier/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_SG [get_bd_intf_pins M_AXI_SG] [get_bd_intf_pins axi_dma_hier/M_AXI_SG]
  connect_bd_intf_net -intf_net s_axi_lite_dma_1 [get_bd_intf_pins s_axi_lite_dma] [get_bd_intf_pins axi_dma_hier/s_axi_lite_dma]
  connect_bd_intf_net -intf_net user_mgt_si570_clock_1 [get_bd_intf_pins user_idt_clock] [get_bd_intf_pins xxv_ethernet_0/gt_ref_clk]
  connect_bd_intf_net -intf_net xxv_ethernet_0_axis_rx_0 [get_bd_intf_pins axi_dma_hier/S_AXIS] [get_bd_intf_pins xxv_ethernet_0/axis_rx_0]
  connect_bd_intf_net -intf_net xxv_ethernet_0_gt_serial_port [get_bd_intf_pins gt_serial_port] [get_bd_intf_pins xxv_ethernet_0/gt_serial_port]
  connect_bd_intf_net -intf_net zynq_ps_M01_AXI [get_bd_intf_pins s_axi_0] [get_bd_intf_pins xxv_ethernet_0/s_axi_0]

  # Create port connections
  connect_bd_net -net Op2_1 [get_bd_pins axi_gpio_qpll] [get_bd_pins util_vector_logic_1/Op2]
  connect_bd_net -net axi_dma_hier_Res [get_bd_pins user_rx_reset_n] [get_bd_pins axi_dma_hier/user_rx_reset_n]
  connect_bd_net -net axi_dma_hier_Res1 [get_bd_pins axi_dma_hier/m_axis_txd] [get_bd_pins xxv_ethernet_0/tx_axis_tvalid_0]
  connect_bd_net -net axi_dma_hier_dma_rx_reset [get_bd_pins dma_rx_reset] [get_bd_pins axi_dma_hier/dma_rx_reset] [get_bd_pins xxv_ethernet_0/rx_reset_0]
  connect_bd_net -net axi_dma_hier_dma_tx_reset [get_bd_pins dma_tx_reset] [get_bd_pins axi_dma_hier/dma_tx_reset] [get_bd_pins xxv_ethernet_0/tx_reset_0]
  connect_bd_net -net axi_dma_hier_interrupt [get_bd_pins interrupt] [get_bd_pins axi_dma_hier/interrupt]
  connect_bd_net -net axi_dma_hier_m_axis_tdata [get_bd_pins axi_dma_hier/m_axis_tdata] [get_bd_pins xxv_ethernet_0/tx_axis_tdata_0]
  connect_bd_net -net axi_dma_hier_m_axis_tkeep [get_bd_pins axi_dma_hier/m_axis_tkeep] [get_bd_pins xxv_ethernet_0/tx_axis_tkeep_0]
  connect_bd_net -net axi_dma_hier_m_axis_tlast [get_bd_pins axi_dma_hier/m_axis_tlast] [get_bd_pins xxv_ethernet_0/tx_axis_tlast_0]
  connect_bd_net -net axi_dma_hier_m_axis_tuser [get_bd_pins axi_dma_hier/m_axis_tuser] [get_bd_pins xxv_ethernet_0/tx_axis_tuser_0]
  connect_bd_net -net axi_dma_hier_mm2s_introut [get_bd_pins mm2s_introut] [get_bd_pins axi_dma_hier/mm2s_introut]
  connect_bd_net -net axi_dma_hier_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_dma_hier/s2mm_introut]
  connect_bd_net -net axi_dma_hier_tx_ptp_1588op_in [get_bd_pins axi_dma_hier/tx_ptp_1588op_in] [get_bd_pins xxv_ethernet_0/tx_ptp_1588op_in_0]
  connect_bd_net -net axi_dma_hier_tx_ptp_tstamp_tag_out1 [get_bd_pins axi_dma_hier/tx_ptp_tstamp_tag_out1] [get_bd_pins xxv_ethernet_0/tx_ptp_tag_field_in_0]
  connect_bd_net -net axi_resetn_1 [get_bd_pins axi_resetn] [get_bd_pins axi_dma_hier/perph_aresetn_156_25] [get_bd_pins xxv_ethernet_0/s_axi_aresetn_0]
  connect_bd_net -net concat_tx_ns_s_dout [get_bd_pins ctl_tx_systemtimerin_0] [get_bd_pins xxv_ethernet_0/ctl_tx_systemtimerin_0]
  connect_bd_net -net m_axi_mm2s_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_dma_hier/clk_156_25] [get_bd_pins xxv_ethernet_0/s_axi_aclk_0]
  connect_bd_net -net rx_clk_out_1 [get_bd_pins rx_clk_out] [get_bd_pins axi_dma_hier/rx_clk_out] [get_bd_pins xxv_ethernet_0/rx_clk_out_0] [get_bd_pins xxv_ethernet_0/rx_core_clk_0]
  connect_bd_net -net tie_gnd_1_dout [get_bd_pins tie_gnd_1/dout] [get_bd_pins util_vector_logic_1/Op1] [get_bd_pins xxv_ethernet_0/ctl_tx_send_idle_0] [get_bd_pins xxv_ethernet_0/ctl_tx_send_lfi_0] [get_bd_pins xxv_ethernet_0/ctl_tx_send_rfi_0] [get_bd_pins xxv_ethernet_0/gtwiz_reset_rx_datapath_0] [get_bd_pins xxv_ethernet_0/gtwiz_reset_tx_datapath_0] [get_bd_pins xxv_ethernet_0/pm_tick_0]
  connect_bd_net -net tie_gnd_dout [get_bd_pins tie_gnd/dout] [get_bd_pins xxv_ethernet_0/tx_preamblein_0]
  connect_bd_net -net tx_clk_out_1 [get_bd_pins tx_clk_out] [get_bd_pins axi_dma_hier/tx_clk_out] [get_bd_pins xxv_ethernet_0/tx_clk_out_0]
  connect_bd_net -net user_rx_reset_1 [get_bd_pins user_rx_reset] [get_bd_pins axi_dma_hier/user_rx_reset] [get_bd_pins xxv_ethernet_0/user_rx_reset_0]
  connect_bd_net -net user_tx_reset_1 [get_bd_pins user_tx_reset] [get_bd_pins axi_dma_hier/user_tx_reset] [get_bd_pins xxv_ethernet_0/user_tx_reset_0]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins util_vector_logic_1/Res] [get_bd_pins xxv_ethernet_0/qpllreset_in_0]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins ctl_rx_systemtimerin_0] [get_bd_pins xxv_ethernet_0/ctl_rx_systemtimerin_0]
  connect_bd_net -net xlconstant_2_dout1 [get_bd_pins xlconstant_2/dout] [get_bd_pins xxv_ethernet_0/rxoutclksel_in_0] [get_bd_pins xxv_ethernet_0/txoutclksel_in_0]
  connect_bd_net -net xxv_ethernet_0_gt_refclk_out [get_bd_pins gt_refclk_out] [get_bd_pins xxv_ethernet_0/gt_refclk_out]
  connect_bd_net -net xxv_ethernet_0_gtpowergood_out_0 [get_bd_pins gtpowergood_out] [get_bd_pins xxv_ethernet_0/gtpowergood_out_0]
  connect_bd_net -net xxv_ethernet_0_rx_axis_tdata_0 [get_bd_pins axi_dma_hier/s_axis_tdata] [get_bd_pins xxv_ethernet_0/rx_axis_tdata_0]
  connect_bd_net -net xxv_ethernet_0_rx_axis_tkeep_0 [get_bd_pins axi_dma_hier/s_axis_tkeep] [get_bd_pins xxv_ethernet_0/rx_axis_tkeep_0]
  connect_bd_net -net xxv_ethernet_0_rx_axis_tlast_0 [get_bd_pins axi_dma_hier/s_axis_tlast] [get_bd_pins xxv_ethernet_0/rx_axis_tlast_0]
  connect_bd_net -net xxv_ethernet_0_rx_axis_tuser_0 [get_bd_pins axi_dma_hier/s_axis_tuser] [get_bd_pins xxv_ethernet_0/rx_axis_tuser_0]
  connect_bd_net -net xxv_ethernet_0_rx_axis_tvalid_0 [get_bd_pins axi_dma_hier/s_axis_tvalid] [get_bd_pins xxv_ethernet_0/rx_axis_tvalid_0]
  connect_bd_net -net xxv_ethernet_0_rx_period_ns_0 [get_bd_pins rx_period_ns] [get_bd_pins xxv_ethernet_0/rx_period_ns_0]
  connect_bd_net -net xxv_ethernet_0_rx_ptp_tstamp_out_0 [get_bd_pins axi_dma_hier/rx_ptp_tstamp_out] [get_bd_pins xxv_ethernet_0/rx_ptp_tstamp_out_0]
  connect_bd_net -net xxv_ethernet_0_rx_ptp_tstamp_valid_out_0 [get_bd_pins axi_dma_hier/rx_ptp_tstamp_valid_out] [get_bd_pins xxv_ethernet_0/rx_ptp_tstamp_valid_out_0]
  connect_bd_net -net xxv_ethernet_0_stat_rx_block_lock_0 [get_bd_pins stat_rx_block_lock] [get_bd_pins xxv_ethernet_0/stat_rx_block_lock_0]
  connect_bd_net -net xxv_ethernet_0_stat_rx_internal_local_fault_0 [get_bd_pins stat_rx_internal_local_fault_0] [get_bd_pins xxv_ethernet_0/stat_rx_internal_local_fault_0]
  connect_bd_net -net xxv_ethernet_0_stat_rx_local_fault_0 [get_bd_pins stat_rx_local_fault] [get_bd_pins xxv_ethernet_0/stat_rx_local_fault_0]
  connect_bd_net -net xxv_ethernet_0_stat_rx_status_0 [get_bd_pins stat_rx_status] [get_bd_pins xxv_ethernet_0/stat_rx_status_0]
  connect_bd_net -net xxv_ethernet_0_stat_tx_bad_fcs_0 [get_bd_pins stat_tx_bad_fcs] [get_bd_pins xxv_ethernet_0/stat_tx_bad_fcs_0]
  connect_bd_net -net xxv_ethernet_0_stat_tx_local_fault_0 [get_bd_pins stat_tx_local_fault] [get_bd_pins xxv_ethernet_0/stat_tx_local_fault_0]
  connect_bd_net -net xxv_ethernet_0_tx_axis_tready_0 [get_bd_pins axi_dma_hier/xxv_tready] [get_bd_pins xxv_ethernet_0/tx_axis_tready_0]
  connect_bd_net -net xxv_ethernet_0_tx_period_ns_0 [get_bd_pins tx_period_ns] [get_bd_pins xxv_ethernet_0/tx_period_ns_0]
  connect_bd_net -net xxv_ethernet_0_tx_ptp_tstamp_out_0 [get_bd_pins axi_dma_hier/tx_ptp_tstamp_out] [get_bd_pins xxv_ethernet_0/tx_ptp_tstamp_out_0]
  connect_bd_net -net xxv_ethernet_0_tx_ptp_tstamp_tag_out_0 [get_bd_pins axi_dma_hier/tx_ptp_tstamp_tag_out] [get_bd_pins xxv_ethernet_0/tx_ptp_tstamp_tag_out_0]
  connect_bd_net -net xxv_ethernet_0_tx_ptp_tstamp_valid_out_0 [get_bd_pins axi_dma_hier/tx_ptp_tstamp_valid_out] [get_bd_pins xxv_ethernet_0/tx_ptp_tstamp_valid_out_0]
  connect_bd_net -net zynq_ps_clk_100 [get_bd_pins dclk] [get_bd_pins xxv_ethernet_0/dclk]
  connect_bd_net -net zynq_ps_peripheral_reset [get_bd_pins sys_reset] [get_bd_pins xxv_ethernet_0/sys_reset]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: zynq_ps
proc create_hier_cell_zynq_ps { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_zynq_ps() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S02_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S03_AXI


  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I In0
  create_bd_pin -dir I In1
  create_bd_pin -dir I In2
  create_bd_pin -dir I In3
  create_bd_pin -dir I -type intr In4
  create_bd_pin -dir O -type clk clk_100
  create_bd_pin -dir O -type clk clk_156_25
  create_bd_pin -dir O -type clk clk_250
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_reset_250
  create_bd_pin -dir O -from 0 -to 0 -type rst perph_aresetn_156_25

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {4} \
  ] $axi_interconnect_0


  # Create instance: bram
  create_hier_cell_bram $hier_obj bram

  # Create instance: ps_axi_periph, and set properties
  set ps_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect ps_axi_periph ]
  set_property CONFIG.NUM_MI {5} $ps_axi_periph


  # Create instance: ps_irq_concat, and set properties
  set ps_irq_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat ps_irq_concat ]
  set_property CONFIG.NUM_PORTS {5} $ps_irq_concat


  # Create instance: ps_rst_100, and set properties
  set ps_rst_100 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset ps_rst_100 ]

  # Create instance: ps_rst_156_25, and set properties
  set ps_rst_156_25 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset ps_rst_156_25 ]

  # Create instance: ps_rst_250, and set properties
  set ps_rst_250 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset ps_rst_250 ]

  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0 ]
  set_property -dict [list \
    CONFIG.CAN0_BOARD_INTERFACE {custom} \
    CONFIG.CAN1_BOARD_INTERFACE {custom} \
    CONFIG.CSU_BOARD_INTERFACE {custom} \
    CONFIG.DP_BOARD_INTERFACE {custom} \
    CONFIG.GEM0_BOARD_INTERFACE {custom} \
    CONFIG.GEM1_BOARD_INTERFACE {custom} \
    CONFIG.GEM2_BOARD_INTERFACE {custom} \
    CONFIG.GEM3_BOARD_INTERFACE {custom} \
    CONFIG.GPIO_BOARD_INTERFACE {custom} \
    CONFIG.IIC0_BOARD_INTERFACE {custom} \
    CONFIG.IIC1_BOARD_INTERFACE {custom} \
    CONFIG.NAND_BOARD_INTERFACE {custom} \
    CONFIG.PCIE_BOARD_INTERFACE {custom} \
    CONFIG.PJTAG_BOARD_INTERFACE {custom} \
    CONFIG.PMU_BOARD_INTERFACE {custom} \
    CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
    CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS33} \
    CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
    CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
    CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
    CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {1} \
    CONFIG.PSU_IMPORT_BOARD_PRESET {} \
    CONFIG.PSU_MIO_0_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_0_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_0_SLEW {fast} \
    CONFIG.PSU_MIO_10_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_10_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_10_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_10_SLEW {fast} \
    CONFIG.PSU_MIO_11_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_11_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_11_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_11_SLEW {fast} \
    CONFIG.PSU_MIO_12_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_12_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_12_SLEW {fast} \
    CONFIG.PSU_MIO_13_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_13_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_13_POLARITY {Default} \
    CONFIG.PSU_MIO_13_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_13_SLEW {fast} \
    CONFIG.PSU_MIO_14_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_14_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_14_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_14_SLEW {fast} \
    CONFIG.PSU_MIO_15_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_15_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_15_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_15_SLEW {fast} \
    CONFIG.PSU_MIO_16_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_16_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_16_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_16_SLEW {fast} \
    CONFIG.PSU_MIO_17_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_17_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_17_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_17_SLEW {fast} \
    CONFIG.PSU_MIO_18_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_18_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_19_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_19_SLEW {fast} \
    CONFIG.PSU_MIO_1_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_1_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_1_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_1_SLEW {fast} \
    CONFIG.PSU_MIO_20_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_20_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_20_POLARITY {Default} \
    CONFIG.PSU_MIO_20_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_20_SLEW {fast} \
    CONFIG.PSU_MIO_21_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_21_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_21_POLARITY {Default} \
    CONFIG.PSU_MIO_21_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_21_SLEW {fast} \
    CONFIG.PSU_MIO_22_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_22_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_22_POLARITY {Default} \
    CONFIG.PSU_MIO_22_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_22_SLEW {fast} \
    CONFIG.PSU_MIO_23_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_23_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_23_POLARITY {Default} \
    CONFIG.PSU_MIO_23_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_23_SLEW {fast} \
    CONFIG.PSU_MIO_24_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_24_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_24_POLARITY {Default} \
    CONFIG.PSU_MIO_24_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_24_SLEW {fast} \
    CONFIG.PSU_MIO_25_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_25_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_25_POLARITY {Default} \
    CONFIG.PSU_MIO_25_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_25_SLEW {fast} \
    CONFIG.PSU_MIO_26_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_26_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_26_POLARITY {Default} \
    CONFIG.PSU_MIO_26_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_26_SLEW {fast} \
    CONFIG.PSU_MIO_27_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_27_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_27_POLARITY {Default} \
    CONFIG.PSU_MIO_27_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_27_SLEW {fast} \
    CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_28_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_28_POLARITY {Default} \
    CONFIG.PSU_MIO_28_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_28_SLEW {fast} \
    CONFIG.PSU_MIO_29_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_29_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_29_POLARITY {Default} \
    CONFIG.PSU_MIO_29_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_29_SLEW {fast} \
    CONFIG.PSU_MIO_2_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_2_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_2_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_2_SLEW {fast} \
    CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_30_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_30_POLARITY {Default} \
    CONFIG.PSU_MIO_30_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_30_SLEW {fast} \
    CONFIG.PSU_MIO_31_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_31_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_31_POLARITY {Default} \
    CONFIG.PSU_MIO_31_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_31_SLEW {fast} \
    CONFIG.PSU_MIO_32_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_32_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_32_SLEW {fast} \
    CONFIG.PSU_MIO_33_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_33_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_33_SLEW {fast} \
    CONFIG.PSU_MIO_34_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_34_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_34_SLEW {fast} \
    CONFIG.PSU_MIO_35_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_35_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_35_SLEW {fast} \
    CONFIG.PSU_MIO_36_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_36_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_36_SLEW {fast} \
    CONFIG.PSU_MIO_37_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_37_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_37_SLEW {fast} \
    CONFIG.PSU_MIO_38_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_38_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_38_POLARITY {Default} \
    CONFIG.PSU_MIO_38_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_38_SLEW {fast} \
    CONFIG.PSU_MIO_39_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_39_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_39_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_39_SLEW {fast} \
    CONFIG.PSU_MIO_3_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_3_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_3_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_3_SLEW {fast} \
    CONFIG.PSU_MIO_40_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_40_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_40_POLARITY {Default} \
    CONFIG.PSU_MIO_40_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_40_SLEW {fast} \
    CONFIG.PSU_MIO_41_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_41_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_41_POLARITY {Default} \
    CONFIG.PSU_MIO_41_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_41_SLEW {fast} \
    CONFIG.PSU_MIO_42_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_42_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_42_POLARITY {Default} \
    CONFIG.PSU_MIO_42_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_42_SLEW {fast} \
    CONFIG.PSU_MIO_43_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_43_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_43_POLARITY {Default} \
    CONFIG.PSU_MIO_43_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_43_SLEW {fast} \
    CONFIG.PSU_MIO_44_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_44_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_44_POLARITY {Default} \
    CONFIG.PSU_MIO_44_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_44_SLEW {fast} \
    CONFIG.PSU_MIO_45_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_45_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_46_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_46_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_46_SLEW {fast} \
    CONFIG.PSU_MIO_47_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_47_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_47_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_47_SLEW {fast} \
    CONFIG.PSU_MIO_48_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_48_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_48_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_48_SLEW {fast} \
    CONFIG.PSU_MIO_49_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_49_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_49_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_49_SLEW {fast} \
    CONFIG.PSU_MIO_4_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_4_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_4_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_4_SLEW {fast} \
    CONFIG.PSU_MIO_50_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_50_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_50_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_50_SLEW {fast} \
    CONFIG.PSU_MIO_51_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_51_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_51_SLEW {fast} \
    CONFIG.PSU_MIO_52_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_52_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_53_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_53_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_54_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_54_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_54_SLEW {fast} \
    CONFIG.PSU_MIO_55_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_55_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_56_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_56_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_56_SLEW {fast} \
    CONFIG.PSU_MIO_57_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_57_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_57_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_57_SLEW {fast} \
    CONFIG.PSU_MIO_58_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_58_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_58_SLEW {fast} \
    CONFIG.PSU_MIO_59_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_59_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_59_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_59_SLEW {fast} \
    CONFIG.PSU_MIO_5_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_5_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_5_SLEW {fast} \
    CONFIG.PSU_MIO_60_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_60_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_60_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_60_SLEW {fast} \
    CONFIG.PSU_MIO_61_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_61_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_61_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_61_SLEW {fast} \
    CONFIG.PSU_MIO_62_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_62_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_62_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_62_SLEW {fast} \
    CONFIG.PSU_MIO_63_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_63_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_63_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_63_SLEW {fast} \
    CONFIG.PSU_MIO_64_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_64_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_64_SLEW {fast} \
    CONFIG.PSU_MIO_65_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_65_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_65_SLEW {fast} \
    CONFIG.PSU_MIO_66_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_66_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_66_SLEW {fast} \
    CONFIG.PSU_MIO_67_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_67_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_67_SLEW {fast} \
    CONFIG.PSU_MIO_68_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_68_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_68_SLEW {fast} \
    CONFIG.PSU_MIO_69_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_69_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_69_SLEW {fast} \
    CONFIG.PSU_MIO_6_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_6_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_6_SLEW {fast} \
    CONFIG.PSU_MIO_70_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_70_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_71_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_71_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_72_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_72_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_73_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_73_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_74_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_74_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_75_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_75_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_76_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_76_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_76_SLEW {fast} \
    CONFIG.PSU_MIO_77_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_77_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_77_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_77_SLEW {fast} \
    CONFIG.PSU_MIO_7_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_7_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_7_SLEW {fast} \
    CONFIG.PSU_MIO_8_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_8_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_8_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_8_SLEW {fast} \
    CONFIG.PSU_MIO_9_DRIVE_STRENGTH {12} \
    CONFIG.PSU_MIO_9_INPUT_TYPE {cmos} \
    CONFIG.PSU_MIO_9_PULLUPDOWN {pullup} \
    CONFIG.PSU_MIO_9_SLEW {fast} \
    CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Feedback Clk#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad\
SPI Flash#Quad SPI Flash#GPIO0 MIO#I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#PMU GPO\
0#PMU GPO 1#PMU GPO 2#PMU GPO 3#PMU GPO 4#PMU GPO 5#GPIO1 MIO#SD 1#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB\
0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
    CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#gpio0[13]#scl_out#sda_out#scl_out#sda_out#rxd#txd#gpio0[20]#gpio0[21]#gpio0[22]#gpio0[23]#gpio0[24]#gpio0[25]#gpio1[26]#gpio1[27]#gpio1[28]#gpio1[29]#gpio1[30]#gpio1[31]#gpo[0]#gpo[1]#gpo[2]#gpo[3]#gpo[4]#gpo[5]#gpio1[38]#sdio1_data_out[4]#gpio1[40]#gpio1[41]#gpio1[42]#gpio1[43]#gpio1[44]#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out}\
\
    CONFIG.PSU_PERIPHERAL_BOARD_PRESET {} \
    CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
    CONFIG.PSU_SMC_CYCLE_T0 {NA} \
    CONFIG.PSU_SMC_CYCLE_T1 {NA} \
    CONFIG.PSU_SMC_CYCLE_T2 {NA} \
    CONFIG.PSU_SMC_CYCLE_T3 {NA} \
    CONFIG.PSU_SMC_CYCLE_T4 {NA} \
    CONFIG.PSU_SMC_CYCLE_T5 {NA} \
    CONFIG.PSU_SMC_CYCLE_T6 {NA} \
    CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
    CONFIG.PSU_VALUE_SILVERSION {3} \
    CONFIG.PSU__ACPU0__POWER__ON {1} \
    CONFIG.PSU__ACPU1__POWER__ON {1} \
    CONFIG.PSU__ACPU2__POWER__ON {1} \
    CONFIG.PSU__ACPU3__POWER__ON {1} \
    CONFIG.PSU__ACTUAL__IP {1} \
    CONFIG.PSU__ACT_DDR_FREQ_MHZ {1049.989502} \
    CONFIG.PSU__AFI0_COHERENCY {0} \
    CONFIG.PSU__AUX_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__CAN0_LOOP_CAN1__ENABLE {0} \
    CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.988037} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
    CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__ACPU__FRAC_ENABLED {0} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI0_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI1_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI2_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI3_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI4_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__ACT_FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__DIVISOR0 {2} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__FREQMHZ {667} \
    CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__AFI5_REF__ENABLE {0} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__APM_CTRL__ACT_FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__DIVISOR0 {1} \
    CONFIG.PSU__CRF_APB__APM_CTRL__FREQMHZ {1} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {524.994751} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1066} \
    CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {25} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__FREQMHZ {25} \
    CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {27} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__FREQMHZ {27} \
    CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {320} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__FREQMHZ {300} \
    CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
    CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {0} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__ACT_FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__DIVISOR0 {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__FREQMHZ {-1} \
    CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__SRCSEL {NA} \
    CONFIG.PSU__CRF_APB__GTGREF0__ENABLE {NA} \
    CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {524.994751} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
    CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__AFI6__ENABLE {0} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.999500} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__FREQMHZ {50} \
    CONFIG.PSU__CRL_APB__AMS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__ACT_FREQMHZ {180} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__SRCSEL {SysOsc} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__ACT_FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__DIVISOR0 {6} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__FREQMHZ {1000} \
    CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__FREQMHZ {1500} \
    CONFIG.PSU__CRL_APB__DLL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__ACT_FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.998749} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__NAND_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__ACT_FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__DIVISOR0 {3} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__FREQMHZ {500} \
    CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.498123} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {155.554001} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {156.25} \
    CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__PL2_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__PL3_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.998749} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
    CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACFREQ {27.138} \
    CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.498123} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__ACT_FREQMHZ {214} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__FREQMHZ {200} \
    CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__SRCSEL {RPLL} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
    CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__ACT_FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__FREQMHZ {250} \
    CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.999800} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
    CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
    CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
    CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
    CONFIG.PSU__CSU__CSU_TAMPER_0__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_10__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_11__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_12__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_1__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_2__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_3__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_4__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_5__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_6__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_7__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_8__ENABLE {0} \
    CONFIG.PSU__CSU__CSU_TAMPER_9__ENABLE {0} \
    CONFIG.PSU__CSU__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DDRC__AL {0} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
    CONFIG.PSU__DDRC__CL {15} \
    CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
    CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
    CONFIG.PSU__DDRC__CWL {11} \
    CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
    CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
    CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
    CONFIG.PSU__DDRC__DDR4_MAXPWR_SAVING_EN {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
    CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
    CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__ECC_SCRUB {0} \
    CONFIG.PSU__DDRC__ENABLE {1} \
    CONFIG.PSU__DDRC__ENABLE_2T_TIMING {0} \
    CONFIG.PSU__DDRC__ENABLE_DP_SWITCH {0} \
    CONFIG.PSU__DDRC__EN_2ND_CLK {0} \
    CONFIG.PSU__DDRC__FGRM {1X} \
    CONFIG.PSU__DDRC__FREQ_MHZ {1} \
    CONFIG.PSU__DDRC__LPDDR3_DUALRANK_SDP {0} \
    CONFIG.PSU__DDRC__LP_ASR {manual normal} \
    CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
    CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
    CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
    CONFIG.PSU__DDRC__PLL_BYPASS {0} \
    CONFIG.PSU__DDRC__PWR_DOWN_EN {0} \
    CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
    CONFIG.PSU__DDRC__RD_DQS_CENTER {0} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
    CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
    CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
    CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
    CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
    CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
    CONFIG.PSU__DDRC__T_FAW {30.0} \
    CONFIG.PSU__DDRC__T_RAS_MIN {33} \
    CONFIG.PSU__DDRC__T_RC {46.5} \
    CONFIG.PSU__DDRC__T_RCD {15} \
    CONFIG.PSU__DDRC__T_RP {15} \
    CONFIG.PSU__DDRC__VIDEO_BUFFER_SIZE {0} \
    CONFIG.PSU__DDRC__VREF {1} \
    CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
    CONFIG.PSU__DDR_QOS_ENABLE {0} \
    CONFIG.PSU__DDR_QOS_HP0_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP0_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP1_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP2_WRQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_RDQOS {} \
    CONFIG.PSU__DDR_QOS_HP3_WRQOS {} \
    CONFIG.PSU__DDR_SW_REFRESH_ENABLED {1} \
    CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.000} \
    CONFIG.PSU__DEVICE_TYPE {RFSOC} \
    CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__DLL__ISUSED {1} \
    CONFIG.PSU__ENABLE__DDR__REFRESH__SIGNALS {0} \
    CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET2__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
    CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
    CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
    CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
    CONFIG.PSU__ENET3__PTP__ENABLE {0} \
    CONFIG.PSU__ENET3__TSU__ENABLE {0} \
    CONFIG.PSU__EN_AXI_STATUS_PORTS {0} \
    CONFIG.PSU__EN_EMIO_TRACE {0} \
    CONFIG.PSU__EP__IP {0} \
    CONFIG.PSU__EXPAND__CORESIGHT {0} \
    CONFIG.PSU__EXPAND__FPD_SLAVES {0} \
    CONFIG.PSU__EXPAND__GIC {0} \
    CONFIG.PSU__EXPAND__LOWER_LPS_SLAVES {0} \
    CONFIG.PSU__EXPAND__UPPER_LPS_SLAVES {0} \
    CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__FPGA_PL0_ENABLE {1} \
    CONFIG.PSU__FPGA_PL1_ENABLE {1} \
    CONFIG.PSU__FPGA_PL2_ENABLE {1} \
    CONFIG.PSU__FPGA_PL3_ENABLE {0} \
    CONFIG.PSU__FP__POWER__ON {1} \
    CONFIG.PSU__FTM__CTI_IN_0 {0} \
    CONFIG.PSU__FTM__CTI_IN_1 {0} \
    CONFIG.PSU__FTM__CTI_IN_2 {0} \
    CONFIG.PSU__FTM__CTI_IN_3 {0} \
    CONFIG.PSU__FTM__CTI_OUT_0 {0} \
    CONFIG.PSU__FTM__CTI_OUT_1 {0} \
    CONFIG.PSU__FTM__CTI_OUT_2 {0} \
    CONFIG.PSU__FTM__CTI_OUT_3 {0} \
    CONFIG.PSU__FTM__GPI {0} \
    CONFIG.PSU__FTM__GPO {0} \
    CONFIG.PSU__GEM3_COHERENCY {0} \
    CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__GEM__TSU__ENABLE {0} \
    CONFIG.PSU__GEN_IPI_0__MASTER {APU} \
    CONFIG.PSU__GEN_IPI_10__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_1__MASTER {RPU0} \
    CONFIG.PSU__GEN_IPI_2__MASTER {RPU1} \
    CONFIG.PSU__GEN_IPI_3__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_4__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_5__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_6__MASTER {PMU} \
    CONFIG.PSU__GEN_IPI_7__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_8__MASTER {NONE} \
    CONFIG.PSU__GEN_IPI_9__MASTER {NONE} \
    CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
    CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
    CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__GPIO_EMIO_WIDTH {95} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {95} \
    CONFIG.PSU__GPIO_EMIO__WIDTH {[94:0]} \
    CONFIG.PSU__GPU_PP0__POWER__ON {0} \
    CONFIG.PSU__GPU_PP1__POWER__ON {0} \
    CONFIG.PSU__GT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__HPM0_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM0_LPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_READ_THREADS {4} \
    CONFIG.PSU__HPM1_FPD__NUM_WRITE_THREADS {4} \
    CONFIG.PSU__I2C0_LOOP_I2C1__ENABLE {0} \
    CONFIG.PSU__I2C0__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
    CONFIG.PSU__I2C1__GRP_INT__ENABLE {0} \
    CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
    CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.999001} \
    CONFIG.PSU__IRQ_P2F_ADMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_AIB_AXI__INT {0} \
    CONFIG.PSU__IRQ_P2F_AMS__INT {0} \
    CONFIG.PSU__IRQ_P2F_APM_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_COMM__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CPUMNT__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_CTI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_EXTERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_L2ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_PMU__INT {0} \
    CONFIG.PSU__IRQ_P2F_APU_REGS__INT {0} \
    CONFIG.PSU__IRQ_P2F_ATB_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_CLKMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_CSUPMU_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_DDR_SS__INT {0} \
    CONFIG.PSU__IRQ_P2F_DPDMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_EFUSE__INT {0} \
    CONFIG.PSU__IRQ_P2F_ENT3_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_ENT3__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_FPD_ATB_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_FP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_GDMA_CHAN__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPIO__INT {0} \
    CONFIG.PSU__IRQ_P2F_GPU__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C0__INT {0} \
    CONFIG.PSU__IRQ_P2F_I2C1__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APB__INT {0} \
    CONFIG.PSU__IRQ_P2F_LPD_APM__INT {0} \
    CONFIG.PSU__IRQ_P2F_LP_WDT__INT {0} \
    CONFIG.PSU__IRQ_P2F_OCM_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_DMA__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_LEGACY__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSC__INT {0} \
    CONFIG.PSU__IRQ_P2F_PCIE_MSI__INT {0} \
    CONFIG.PSU__IRQ_P2F_PL_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_QSPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE0_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_R5_CORE1_ECC_ERR__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_IPI__INT {0} \
    CONFIG.PSU__IRQ_P2F_RPU_PERMON__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_ALARM__INT {0} \
    CONFIG.PSU__IRQ_P2F_RTC_SECONDS__INT {0} \
    CONFIG.PSU__IRQ_P2F_SATA__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1_WAKE__INT {0} \
    CONFIG.PSU__IRQ_P2F_SDIO1__INT {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC0__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC1__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC2__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_TTC3__INT2 {0} \
    CONFIG.PSU__IRQ_P2F_UART0__INT {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT0 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_OTG__INT1 {0} \
    CONFIG.PSU__IRQ_P2F_USB3_PMU_WAKEUP__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_FPD__INT {0} \
    CONFIG.PSU__IRQ_P2F_XMPU_LPD__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_FPD_SMMU__INT {0} \
    CONFIG.PSU__IRQ_P2F__INTF_PPD_CCI__INT {0} \
    CONFIG.PSU__L2_BANK0__POWER__ON {1} \
    CONFIG.PSU__LPDMA0_COHERENCY {0} \
    CONFIG.PSU__LPDMA1_COHERENCY {0} \
    CONFIG.PSU__LPDMA2_COHERENCY {0} \
    CONFIG.PSU__LPDMA3_COHERENCY {0} \
    CONFIG.PSU__LPDMA4_COHERENCY {0} \
    CONFIG.PSU__LPDMA5_COHERENCY {0} \
    CONFIG.PSU__LPDMA6_COHERENCY {0} \
    CONFIG.PSU__LPDMA7_COHERENCY {0} \
    CONFIG.PSU__LPD_SLCR__CSUPMU_WDT_CLK_SEL__SELECT {APB} \
    CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
    CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
    CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
    CONFIG.PSU__M_AXI_GP0_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP1_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__M_AXI_GP2_SUPPORTS_NARROW_BURST {1} \
    CONFIG.PSU__NAND__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__NAND__READY_BUSY__ENABLE {0} \
    CONFIG.PSU__NUM_FABRIC_RESETS {1} \
    CONFIG.PSU__OCM_BANK0__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK1__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK2__POWER__ON {1} \
    CONFIG.PSU__OCM_BANK3__POWER__ON {1} \
    CONFIG.PSU__OVERRIDE_HPX_QOS {0} \
    CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
    CONFIG.PSU__PCIE__ACS_VIOLAION {0} \
    CONFIG.PSU__PCIE__AER_CAPABILITY {0} \
    CONFIG.PSU__PCIE__CLASS_CODE_BASE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {} \
    CONFIG.PSU__PCIE__CLASS_CODE_SUB {} \
    CONFIG.PSU__PCIE__DEVICE_ID {} \
    CONFIG.PSU__PCIE__INTX_GENERATION {0} \
    CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
    CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {1} \
    CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {0} \
    CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
    CONFIG.PSU__PCIE__REVISION_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_ID {} \
    CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {} \
    CONFIG.PSU__PCIE__VENDOR_ID {} \
    CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__PL_CLK0_BUF {TRUE} \
    CONFIG.PSU__PL_CLK1_BUF {TRUE} \
    CONFIG.PSU__PL_CLK2_BUF {TRUE} \
    CONFIG.PSU__PL__POWER__ON {1} \
    CONFIG.PSU__PMU_COHERENCY {0} \
    CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
    CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
    CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
    CONFIG.PSU__PMU__GPI0__ENABLE {0} \
    CONFIG.PSU__PMU__GPI1__ENABLE {0} \
    CONFIG.PSU__PMU__GPI2__ENABLE {0} \
    CONFIG.PSU__PMU__GPI3__ENABLE {0} \
    CONFIG.PSU__PMU__GPI4__ENABLE {0} \
    CONFIG.PSU__PMU__GPI5__ENABLE {0} \
    CONFIG.PSU__PMU__GPO0__ENABLE {1} \
    CONFIG.PSU__PMU__GPO0__IO {MIO 32} \
    CONFIG.PSU__PMU__GPO1__ENABLE {1} \
    CONFIG.PSU__PMU__GPO1__IO {MIO 33} \
    CONFIG.PSU__PMU__GPO2__ENABLE {1} \
    CONFIG.PSU__PMU__GPO2__IO {MIO 34} \
    CONFIG.PSU__PMU__GPO2__POLARITY {low} \
    CONFIG.PSU__PMU__GPO3__ENABLE {1} \
    CONFIG.PSU__PMU__GPO3__IO {MIO 35} \
    CONFIG.PSU__PMU__GPO3__POLARITY {low} \
    CONFIG.PSU__PMU__GPO4__ENABLE {1} \
    CONFIG.PSU__PMU__GPO4__IO {MIO 36} \
    CONFIG.PSU__PMU__GPO4__POLARITY {low} \
    CONFIG.PSU__PMU__GPO5__ENABLE {1} \
    CONFIG.PSU__PMU__GPO5__IO {MIO 37} \
    CONFIG.PSU__PMU__GPO5__POLARITY {low} \
    CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
    CONFIG.PSU__PRESET_APPLIED {1} \
    CONFIG.PSU__PROTECTION__DDR_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__ENABLE {0} \
    CONFIG.PSU__PROTECTION__FPD_SEGMENTS {SA:0xFD1A0000; SIZE:1280; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD000000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write;\
subsystemId:PMU Firmware| SA:0xFD010000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD020000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU\
Firmware| SA:0xFD030000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD040000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|\
SA:0xFD050000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD610000; SIZE:512; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFD5D0000;\
SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|SA:0xFD1A0000 ; SIZE:1280; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem} \
    CONFIG.PSU__PROTECTION__LPD_SEGMENTS {SA:0xFF980000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFF5E0000; SIZE:2560; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write;\
subsystemId:PMU Firmware| SA:0xFFCC0000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFF180000; SIZE:768; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU\
Firmware| SA:0xFF410000; SIZE:640; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware| SA:0xFFA70000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|\
SA:0xFF9A0000; SIZE:64; UNIT:KB; RegionTZ:Secure; WrAllowed:Read/Write; subsystemId:PMU Firmware|SA:0xFF5E0000 ; SIZE:2560; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem|SA:0xFFCC0000\
; SIZE:64; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem|SA:0xFF180000 ; SIZE:768; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem|SA:0xFF9A0000\
; SIZE:64; UNIT:KB; RegionTZ:Secure ; WrAllowed:Read/Write; subsystemId:Secure Subsystem} \
    CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;1|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;0|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;0|SATA0:NonSecure;0|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;0|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1}\
\
    CONFIG.PSU__PROTECTION__MASTERS_TZ {GEM0:NonSecure|SD1:NonSecure|GEM2:NonSecure|GEM1:NonSecure|GEM3:NonSecure|PCIe:NonSecure|DP:NonSecure|NAND:NonSecure|GPU:NonSecure|USB1:NonSecure|USB0:NonSecure|LDMA:NonSecure|FDMA:NonSecure|QSPI:NonSecure|SD0:NonSecure}\
\
    CONFIG.PSU__PROTECTION__OCM_SEGMENTS {NONE} \
    CONFIG.PSU__PROTECTION__PRESUBSYSTEMS {NONE} \
    CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;0|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;0|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;0|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display\
Port;FD4A0000;FD4AFFFF;0|FPD;DPDMA;FD4C0000;FD4CFFFF;0|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1}\
\
    CONFIG.PSU__PROTECTION__SUBSYSTEMS {PMU Firmware:PMU|Secure Subsystem:} \
    CONFIG.PSU__PSS_ALT_REF_CLK__ENABLE {0} \
    CONFIG.PSU__PSS_ALT_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \
    CONFIG.PSU__QSPI_COHERENCY {0} \
    CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
    CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
    CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
    CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
    CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
    CONFIG.PSU__REPORT__DBGLOG {0} \
    CONFIG.PSU__RPU_COHERENCY {0} \
    CONFIG.PSU__RPU__POWER__ON {1} \
    CONFIG.PSU__SATA__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SAXIGP0__DATA_WIDTH {128} \
    CONFIG.PSU__SD0_COHERENCY {0} \
    CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD0__GRP_CD__ENABLE {0} \
    CONFIG.PSU__SD0__GRP_POW__ENABLE {0} \
    CONFIG.PSU__SD0__GRP_WP__ENABLE {0} \
    CONFIG.PSU__SD0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SD0__RESET__ENABLE {0} \
    CONFIG.PSU__SD1_COHERENCY {0} \
    CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
    CONFIG.PSU__SD1__CLK_100_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_200_SDR_OTAP_DLY {0x3} \
    CONFIG.PSU__SD1__CLK_50_DDR_ITAP_DLY {0x3D} \
    CONFIG.PSU__SD1__CLK_50_DDR_OTAP_DLY {0x4} \
    CONFIG.PSU__SD1__CLK_50_SDR_ITAP_DLY {0x15} \
    CONFIG.PSU__SD1__CLK_50_SDR_OTAP_DLY {0x5} \
    CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
    CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
    CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_POW__IO {MIO 43} \
    CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
    CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \
    CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
    CONFIG.PSU__SD1__RESET__ENABLE {0} \
    CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
    CONFIG.PSU__SPI0_LOOP_SPI1__ENABLE {0} \
    CONFIG.PSU__SPI0__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SPI1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
    CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
    CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__SWDT1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
    CONFIG.PSU__TCM0A__POWER__ON {1} \
    CONFIG.PSU__TCM0B__POWER__ON {1} \
    CONFIG.PSU__TCM1A__POWER__ON {1} \
    CONFIG.PSU__TCM1B__POWER__ON {1} \
    CONFIG.PSU__TESTSCAN__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRACE__INTERNAL_WIDTH {32} \
    CONFIG.PSU__TRACE__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__TRISTATE__INVERTED {1} \
    CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
    CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC0__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC1__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC2__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
    CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__TTC3__PERIPHERAL__IO {NA} \
    CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
    CONFIG.PSU__UART0_LOOP_UART1__ENABLE {0} \
    CONFIG.PSU__UART0__BAUD_RATE {115200} \
    CONFIG.PSU__UART0__MODEM__ENABLE {0} \
    CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
    CONFIG.PSU__UART1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB0_COHERENCY {0} \
    CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
    CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
    CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
    CONFIG.PSU__USB1__PERIPHERAL__ENABLE {0} \
    CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
    CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
    CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
    CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
    CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
    CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
    CONFIG.PSU__USE_DIFF_RW_CLK_GP0 {0} \
    CONFIG.PSU__USE__ADMA {0} \
    CONFIG.PSU__USE__APU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__AUDIO {0} \
    CONFIG.PSU__USE__CLK {0} \
    CONFIG.PSU__USE__CLK0 {0} \
    CONFIG.PSU__USE__CLK1 {0} \
    CONFIG.PSU__USE__CLK2 {0} \
    CONFIG.PSU__USE__CLK3 {0} \
    CONFIG.PSU__USE__CROSS_TRIGGER {0} \
    CONFIG.PSU__USE__DDR_INTF_REQUESTED {0} \
    CONFIG.PSU__USE__DEBUG__TEST {0} \
    CONFIG.PSU__USE__EVENT_RPU {0} \
    CONFIG.PSU__USE__FABRIC__RST {1} \
    CONFIG.PSU__USE__FTM {0} \
    CONFIG.PSU__USE__GDMA {0} \
    CONFIG.PSU__USE__IRQ {0} \
    CONFIG.PSU__USE__IRQ0 {1} \
    CONFIG.PSU__USE__IRQ1 {0} \
    CONFIG.PSU__USE__M_AXI_GP0 {1} \
    CONFIG.PSU__USE__M_AXI_GP1 {0} \
    CONFIG.PSU__USE__M_AXI_GP2 {1} \
    CONFIG.PSU__USE__PROC_EVENT_BUS {0} \
    CONFIG.PSU__USE__RPU_LEGACY_INTERRUPT {0} \
    CONFIG.PSU__USE__RST0 {0} \
    CONFIG.PSU__USE__RST1 {0} \
    CONFIG.PSU__USE__RST2 {0} \
    CONFIG.PSU__USE__RST3 {0} \
    CONFIG.PSU__USE__RTC {0} \
    CONFIG.PSU__USE__STM {0} \
    CONFIG.PSU__USE__S_AXI_ACE {0} \
    CONFIG.PSU__USE__S_AXI_ACP {0} \
    CONFIG.PSU__USE__S_AXI_GP0 {1} \
    CONFIG.PSU__USE__S_AXI_GP1 {0} \
    CONFIG.PSU__USE__S_AXI_GP2 {0} \
    CONFIG.PSU__USE__S_AXI_GP3 {0} \
    CONFIG.PSU__USE__S_AXI_GP4 {0} \
    CONFIG.PSU__USE__S_AXI_GP5 {0} \
    CONFIG.PSU__USE__S_AXI_GP6 {0} \
    CONFIG.PSU__USE__USB3_0_HUB {0} \
    CONFIG.PSU__USE__USB3_1_HUB {0} \
    CONFIG.PSU__USE__VIDEO {0} \
    CONFIG.PSU__VIDEO_REF_CLK__ENABLE {0} \
    CONFIG.PSU__VIDEO_REF_CLK__FREQMHZ {33.333} \
    CONFIG.QSPI_BOARD_INTERFACE {custom} \
    CONFIG.SATA_BOARD_INTERFACE {custom} \
    CONFIG.SD0_BOARD_INTERFACE {custom} \
    CONFIG.SD1_BOARD_INTERFACE {custom} \
    CONFIG.SPI0_BOARD_INTERFACE {custom} \
    CONFIG.SPI1_BOARD_INTERFACE {custom} \
    CONFIG.SUBPRESET1 {Custom} \
    CONFIG.SUBPRESET2 {Custom} \
    CONFIG.SWDT0_BOARD_INTERFACE {custom} \
    CONFIG.SWDT1_BOARD_INTERFACE {custom} \
    CONFIG.TRACE_BOARD_INTERFACE {custom} \
    CONFIG.TTC0_BOARD_INTERFACE {custom} \
    CONFIG.TTC1_BOARD_INTERFACE {custom} \
    CONFIG.TTC2_BOARD_INTERFACE {custom} \
    CONFIG.TTC3_BOARD_INTERFACE {custom} \
    CONFIG.UART0_BOARD_INTERFACE {custom} \
    CONFIG.UART1_BOARD_INTERFACE {custom} \
    CONFIG.USB0_BOARD_INTERFACE {custom} \
    CONFIG.USB1_BOARD_INTERFACE {custom} \
  ] $zynq_ultra_ps_e_0


  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net S02_AXI_1 [get_bd_intf_pins S02_AXI] [get_bd_intf_pins axi_interconnect_0/S02_AXI]
  connect_bd_intf_net -intf_net S03_AXI_1 [get_bd_intf_pins S03_AXI] [get_bd_intf_pins axi_interconnect_0/S03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net ps_axi_periph_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins ps_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net ps_axi_periph_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins ps_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net ps_axi_periph_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins ps_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net ps_axi_periph_M03_AXI [get_bd_intf_pins M03_AXI] [get_bd_intf_pins ps_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net ps_axi_periph_M04_AXI [get_bd_intf_pins M04_AXI] [get_bd_intf_pins ps_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins bram/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_LPD [get_bd_intf_pins ps_axi_periph/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_LPD]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins clk_156_25] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins bram/M00_ACLK] [get_bd_pins ps_axi_periph/ACLK] [get_bd_pins ps_axi_periph/M00_ACLK] [get_bd_pins ps_axi_periph/M01_ACLK] [get_bd_pins ps_axi_periph/M02_ACLK] [get_bd_pins ps_axi_periph/M03_ACLK] [get_bd_pins ps_axi_periph/M04_ACLK] [get_bd_pins ps_axi_periph/S00_ACLK] [get_bd_pins ps_rst_156_25/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_lpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins zynq_ultra_ps_e_0/saxihpc0_fpd_aclk]
  connect_bd_net -net ARESETN_1 [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins ps_axi_periph/ARESETN] [get_bd_pins ps_rst_156_25/interconnect_aresetn]
  connect_bd_net -net In0_1 [get_bd_pins In0] [get_bd_pins ps_irq_concat/In0]
  connect_bd_net -net In1_1 [get_bd_pins In1] [get_bd_pins ps_irq_concat/In1]
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins ps_irq_concat/In2]
  connect_bd_net -net In3_1 [get_bd_pins In3] [get_bd_pins ps_irq_concat/In3]
  connect_bd_net -net In4_1 [get_bd_pins In4] [get_bd_pins ps_irq_concat/In4]
  connect_bd_net -net M00_ARESETN_1 [get_bd_pins perph_aresetn_156_25] [get_bd_pins bram/ARESETN] [get_bd_pins ps_axi_periph/M00_ARESETN] [get_bd_pins ps_axi_periph/M01_ARESETN] [get_bd_pins ps_axi_periph/M02_ARESETN] [get_bd_pins ps_axi_periph/M03_ARESETN] [get_bd_pins ps_axi_periph/M04_ARESETN] [get_bd_pins ps_axi_periph/S00_ARESETN] [get_bd_pins ps_rst_156_25/peripheral_aresetn]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_interconnect_0/S03_ACLK]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axi_interconnect_0/S03_ARESETN]
  connect_bd_net -net ps_irq_concat_dout [get_bd_pins ps_irq_concat/dout] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
  connect_bd_net -net ps_rst_100_peripheral_reset [get_bd_pins peripheral_reset] [get_bd_pins ps_rst_100/peripheral_reset]
  connect_bd_net -net ps_rst_250_peripheral_reset [get_bd_pins peripheral_reset_250] [get_bd_pins ps_rst_250/peripheral_reset]
  connect_bd_net -net zusp_ps_pl_clk1 [get_bd_pins clk_100] [get_bd_pins ps_rst_100/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk1]
  connect_bd_net -net zusp_ps_pl_clk2 [get_bd_pins clk_250] [get_bd_pins ps_rst_250/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk2]
  connect_bd_net -net zusp_ps_pl_resetn0 [get_bd_pins ps_rst_100/ext_reset_in] [get_bd_pins ps_rst_156_25/ext_reset_in] [get_bd_pins ps_rst_250/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]
#  connect_bd_net -net zusp_ps_pl_resetn1 [get_bd_pins ps_rst_250/ext_reset_in] [get_bd_pins ps_rst_250/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: other_perph
proc create_hier_cell_other_perph { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_other_perph() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 axi_clk_led
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I -type clk mgt_clk
  create_bd_pin -dir O -from 0 -to 0 mgt_tx_clk_led
  create_bd_pin -dir O rst_inv_led
  create_bd_pin -dir I -type clk rx_clk
  create_bd_pin -dir O -from 0 -to 0 rx_clk_led
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn
  create_bd_pin -dir O -from 0 -to 0 tie_high_o

  # Create instance: axi_clk_led
  create_hier_cell_axi_clk_led $hier_obj axi_clk_led

  # Create instance: axi_timer_1, and set properties
  set axi_timer_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer axi_timer_1 ]

  # Create instance: mgt_tx_clk_led
  create_hier_cell_mgt_tx_clk_led $hier_obj mgt_tx_clk_led

  # Create instance: reset_invert_led, and set properties
  set reset_invert_led [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic reset_invert_led ]
  set_property CONFIG.C_SIZE {1} $reset_invert_led


  # Create instance: rx_clk_led
  create_hier_cell_rx_clk_led $hier_obj rx_clk_led

  # Create instance: tie_high, and set properties
  set tie_high [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant tie_high ]
  set_property -dict [list \
    CONFIG.CONST_VAL {1} \
    CONFIG.CONST_WIDTH {1} \
  ] $tie_high


  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_timer_1/S_AXI]

  # Create port connections
  connect_bd_net -net axi_clk_led_Dout [get_bd_pins axi_clk_led] [get_bd_pins axi_clk_led/Dout]
  connect_bd_net -net axi_timer_1_interrupt [get_bd_pins interrupt] [get_bd_pins axi_timer_1/interrupt]
  connect_bd_net -net mgt_clk_1 [get_bd_pins mgt_clk] [get_bd_pins mgt_tx_clk_led/CLK]
  connect_bd_net -net mgt_tx_clk_led_Dout [get_bd_pins mgt_tx_clk_led] [get_bd_pins mgt_tx_clk_led/Dout]
  connect_bd_net -net reset_invert_led_Res [get_bd_pins rst_inv_led] [get_bd_pins reset_invert_led/Res]
  connect_bd_net -net rx_clk_1 [get_bd_pins rx_clk] [get_bd_pins rx_clk_led/CLK]
  connect_bd_net -net rx_clk_led_Dout [get_bd_pins rx_clk_led] [get_bd_pins rx_clk_led/Dout]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_clk_led/CLK] [get_bd_pins axi_timer_1/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_timer_1/s_axi_aresetn] [get_bd_pins reset_invert_led/Op1]
  connect_bd_net -net tie_high_dout [get_bd_pins tie_high_o] [get_bd_pins tie_high/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Ethernet_PTP_subsystem
proc create_hier_cell_Ethernet_PTP_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_Ethernet_PTP_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 GT_Interface

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_SG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_Ethernet_IP

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_MCDMA

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gt_ref_clock_in

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir I -from 0 -to 0 Op2
  create_bd_pin -dir I -type clk axi_clk
  create_bd_pin -dir I -from 0 -to 0 -type rst axi_resetn
  create_bd_pin -dir I -type clk dclk
  create_bd_pin -dir O -type clk gt_refclk_out
  create_bd_pin -dir O gtpowergood_out_0
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir O -from 0 -to 0 mcdma_rx_reset_out
  create_bd_pin -dir O -from 0 -to 0 mcdma_tx_reset_out
  create_bd_pin -dir O -type intr mm2s_introut
#  create_bd_pin -dir O one_pps
  create_bd_pin -dir O -type clk rx_clk_out
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir O stat_rx_block_lock_0
  create_bd_pin -dir O stat_rx_internal_local_fault_0
  create_bd_pin -dir O stat_rx_local_fault_0
  create_bd_pin -dir O stat_rx_status_0
  create_bd_pin -dir O stat_tx_bad_fcs_0
  create_bd_pin -dir O stat_tx_local_fault_0
  create_bd_pin -dir I -type rst sys_reset
  create_bd_pin -dir I -type rst ts_rst
  create_bd_pin -dir I tod_1pps_in_0
  create_bd_pin -dir O tod_intr
  create_bd_pin -dir I -type clk ts_clk
  create_bd_pin -dir O -type clk tx_clk_out
  create_bd_pin -dir O user_rx_reset
  create_bd_pin -dir O -from 0 -to 0 user_rx_resetn
  create_bd_pin -dir O user_tx_reset

  # Create instance: Ethernet_stream_subsystem
  create_hier_cell_Ethernet_stream_subsystem $hier_obj Ethernet_stream_subsystem

  # Create instance: PTP_support
  create_hier_cell_PTP_support $hier_obj PTP_support

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi] [get_bd_intf_pins PTP_support/s_axi2]
  connect_bd_intf_net -intf_net Ethernet_stream_subsystem_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins Ethernet_stream_subsystem/M_AXI]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins Ethernet_stream_subsystem/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_S2MM [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins Ethernet_stream_subsystem/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_SG [get_bd_intf_pins M_AXI_SG] [get_bd_intf_pins Ethernet_stream_subsystem/M_AXI_SG]
  connect_bd_intf_net -intf_net s_axi_lite_dma_1 [get_bd_intf_pins S_AXI_MCDMA] [get_bd_intf_pins Ethernet_stream_subsystem/s_axi_lite_dma]
  connect_bd_intf_net -intf_net user_mgt_si570_clock_1 [get_bd_intf_pins gt_ref_clock_in] [get_bd_intf_pins Ethernet_stream_subsystem/user_idt_clock]
  connect_bd_intf_net -intf_net xxv_ethernet_0_gt_serial_port [get_bd_intf_pins GT_Interface] [get_bd_intf_pins Ethernet_stream_subsystem/gt_serial_port]
  connect_bd_intf_net -intf_net zynq_ps_M01_AXI [get_bd_intf_pins S_AXI_Ethernet_IP] [get_bd_intf_pins Ethernet_stream_subsystem/s_axi_0]

  # Create port connections
  connect_bd_net -net Ethernet_stream_subsystem_interrupt [get_bd_pins interrupt] [get_bd_pins Ethernet_stream_subsystem/interrupt]
  connect_bd_net -net Ethernet_stream_subsystem_rx_period_ns [get_bd_pins Ethernet_stream_subsystem/rx_period_ns] [get_bd_pins PTP_support/core_rx0_period_0]
  connect_bd_net -net Op2_1 [get_bd_pins Op2] [get_bd_pins Ethernet_stream_subsystem/axi_gpio_qpll]
  connect_bd_net -net PTP_support_tod_intr [get_bd_pins tod_intr] [get_bd_pins PTP_support/tod_intr]
  connect_bd_net -net axi_dma_hier_Res [get_bd_pins user_rx_resetn] [get_bd_pins Ethernet_stream_subsystem/user_rx_reset_n]
  connect_bd_net -net axi_dma_hier_dma_rx_reset [get_bd_pins mcdma_rx_reset_out] [get_bd_pins Ethernet_stream_subsystem/dma_rx_reset]
  connect_bd_net -net axi_dma_hier_dma_tx_reset [get_bd_pins mcdma_tx_reset_out] [get_bd_pins Ethernet_stream_subsystem/dma_tx_reset]
  connect_bd_net -net axi_dma_hier_mm2s_introut [get_bd_pins mm2s_introut] [get_bd_pins Ethernet_stream_subsystem/mm2s_introut]
  connect_bd_net -net axi_dma_hier_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins Ethernet_stream_subsystem/s2mm_introut]
  connect_bd_net -net axi_resetn_1 [get_bd_pins axi_resetn] [get_bd_pins Ethernet_stream_subsystem/axi_resetn] [get_bd_pins PTP_support/s_axi_aresetn]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins ts_clk] [get_bd_pins PTP_support/ts_clk]
  connect_bd_net -net concat_tx_ns_s_dout [get_bd_pins Ethernet_stream_subsystem/ctl_tx_systemtimerin_0] [get_bd_pins PTP_support/ctl_tx_systemtimerout]
  connect_bd_net -net m_axi_mm2s_aclk_1 [get_bd_pins axi_clk] [get_bd_pins Ethernet_stream_subsystem/s_axi_aclk] [get_bd_pins PTP_support/s_axi_aclk]
#  connect_bd_net -net ptp_1588_timer_syncer_0_sys_timer_1pps_out [get_bd_pins one_pps] [get_bd_pins PTP_support/one_pps]
  connect_bd_net -net rx_clk_out_1 [get_bd_pins rx_clk_out] [get_bd_pins Ethernet_stream_subsystem/rx_clk_out] [get_bd_pins PTP_support/rx_phy_clk]
  connect_bd_net -net tod_1pps_in_0_1 [get_bd_pins tod_1pps_in_0] [get_bd_pins PTP_support/tod_1pps_in_0]
  connect_bd_net -net tx_clk_out_1 [get_bd_pins tx_clk_out] [get_bd_pins Ethernet_stream_subsystem/tx_clk_out] [get_bd_pins PTP_support/tx_phy_clk]
  connect_bd_net -net user_rx_reset_1 [get_bd_pins user_rx_reset] [get_bd_pins Ethernet_stream_subsystem/user_rx_reset] [get_bd_pins PTP_support/rx_phy_rst]
  connect_bd_net -net user_tx_reset_1 [get_bd_pins user_tx_reset] [get_bd_pins Ethernet_stream_subsystem/user_tx_reset] [get_bd_pins PTP_support/tx_phy_rst]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins Ethernet_stream_subsystem/ctl_rx_systemtimerin_0] [get_bd_pins PTP_support/ctl_rx_systemtimerout]
  connect_bd_net -net xxv_ethernet_0_gt_refclk_out [get_bd_pins gt_refclk_out] [get_bd_pins Ethernet_stream_subsystem/gt_refclk_out]
  connect_bd_net -net xxv_ethernet_0_gtpowergood_out_0 [get_bd_pins gtpowergood_out_0] [get_bd_pins Ethernet_stream_subsystem/gtpowergood_out]
  connect_bd_net -net xxv_ethernet_0_stat_rx_block_lock_0 [get_bd_pins stat_rx_block_lock_0] [get_bd_pins Ethernet_stream_subsystem/stat_rx_block_lock]
  connect_bd_net -net xxv_ethernet_0_stat_rx_internal_local_fault_0 [get_bd_pins stat_rx_internal_local_fault_0] [get_bd_pins Ethernet_stream_subsystem/stat_rx_internal_local_fault_0]
  connect_bd_net -net xxv_ethernet_0_stat_rx_local_fault_0 [get_bd_pins stat_rx_local_fault_0] [get_bd_pins Ethernet_stream_subsystem/stat_rx_local_fault]
  connect_bd_net -net xxv_ethernet_0_stat_rx_status_0 [get_bd_pins stat_rx_status_0] [get_bd_pins Ethernet_stream_subsystem/stat_rx_status]
  connect_bd_net -net xxv_ethernet_0_stat_tx_bad_fcs_0 [get_bd_pins stat_tx_bad_fcs_0] [get_bd_pins Ethernet_stream_subsystem/stat_tx_bad_fcs]
  connect_bd_net -net xxv_ethernet_0_stat_tx_local_fault_0 [get_bd_pins stat_tx_local_fault_0] [get_bd_pins Ethernet_stream_subsystem/stat_tx_local_fault]
  connect_bd_net -net xxv_ethernet_0_tx_period_ns_0 [get_bd_pins Ethernet_stream_subsystem/tx_period_ns] [get_bd_pins PTP_support/core_tx0_period_0]
  connect_bd_net -net zynq_ps_clk_100 [get_bd_pins dclk] [get_bd_pins Ethernet_stream_subsystem/dclk]
  connect_bd_net -net zynq_ps_peripheral_reset [get_bd_pins sys_reset] [get_bd_pins Ethernet_stream_subsystem/sys_reset]
  connect_bd_net -net zynq_ps_peripheral_ts_rst [get_bd_pins ts_rst] [get_bd_pins PTP_support/ts_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
#  set CLK_IN_D_ts_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN_D_ts_clk ]

#  set One_pps_in [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 One_pps_in ]

  set sfp2_1x [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 sfp2_1x ]

  set user_idt_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 user_idt_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $user_idt_clock


  # Create ports
#  set SI53340_MUX_GT_SEL [ create_bd_port -dir O -from 0 -to 0 SI53340_MUX_GT_SEL ]
  set axi_lite_clk_led [ create_bd_port -dir O -from 0 -to 0 axi_lite_clk_led ]
  set axil_reset_led [ create_bd_port -dir O axil_reset_led ]
#  set one_pps [ create_bd_port -dir O one_pps ]
  set rx_clk_led [ create_bd_port -dir O -from 0 -to 0 rx_clk_led ]

  # Create instance: Ethernet_PTP_subsystem
  create_hier_cell_Ethernet_PTP_subsystem [current_bd_instance .] Ethernet_PTP_subsystem

  # Create instance: axi_gpio_0_qpll_rst, and set properties
  set axi_gpio_0_qpll_rst [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0_qpll_rst ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {1} \
  ] $axi_gpio_0_qpll_rst


  # Create instance: other_perph
  create_hier_cell_other_perph [current_bd_instance .] other_perph

  # Create instance: util_ds_buf_0, and set properties
#  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf util_ds_buf_0 ]
#  set_property CONFIG.C_BUF_TYPE {IBUFDS} $util_ds_buf_0


  # Create instance: util_ds_buf_1, and set properties
#  set util_ds_buf_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf util_ds_buf_1 ]
#  set_property CONFIG.C_BUF_TYPE {IBUFDS} $util_ds_buf_1


  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_0


  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio vio_0 ]
  set_property -dict [list \
    CONFIG.C_NUM_PROBE_IN {16} \
    CONFIG.C_NUM_PROBE_OUT {0} \
  ] $vio_0


  # Create instance: zynq_ps
  create_hier_cell_zynq_ps [current_bd_instance .] zynq_ps

  # Create interface connections
#  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports CLK_IN_D_ts_clk] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
#  connect_bd_intf_net -intf_net CLK_IN_D_0_2 [get_bd_intf_ports One_pps_in] [get_bd_intf_pins util_ds_buf_1/CLK_IN_D]
  connect_bd_intf_net -intf_net Ethernet_PTP_subsystem_M_AXI [get_bd_intf_pins Ethernet_PTP_subsystem/M_AXI] [get_bd_intf_pins zynq_ps/S03_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins other_perph/S_AXI] [get_bd_intf_pins zynq_ps/M02_AXI]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_MM2S [get_bd_intf_pins Ethernet_PTP_subsystem/M_AXI_MM2S] [get_bd_intf_pins zynq_ps/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_S2MM [get_bd_intf_pins Ethernet_PTP_subsystem/M_AXI_S2MM] [get_bd_intf_pins zynq_ps/S02_AXI]
  connect_bd_intf_net -intf_net axi_dma_hier_M_AXI_SG [get_bd_intf_pins Ethernet_PTP_subsystem/M_AXI_SG] [get_bd_intf_pins zynq_ps/S00_AXI]
  connect_bd_intf_net -intf_net s_axi_lite_dma_1 [get_bd_intf_pins Ethernet_PTP_subsystem/S_AXI_MCDMA] [get_bd_intf_pins zynq_ps/M00_AXI]
  connect_bd_intf_net -intf_net user_mgt_si570_clock_1 [get_bd_intf_ports user_idt_clock] [get_bd_intf_pins Ethernet_PTP_subsystem/gt_ref_clock_in]
  connect_bd_intf_net -intf_net xxv_ethernet_0_gt_serial_port [get_bd_intf_ports sfp2_1x] [get_bd_intf_pins Ethernet_PTP_subsystem/GT_Interface]
  connect_bd_intf_net -intf_net zynq_ps_M01_AXI [get_bd_intf_pins Ethernet_PTP_subsystem/S_AXI_Ethernet_IP] [get_bd_intf_pins zynq_ps/M01_AXI]
  connect_bd_intf_net -intf_net zynq_ps_M05_AXI [get_bd_intf_pins Ethernet_PTP_subsystem/s_axi] [get_bd_intf_pins zynq_ps/M03_AXI]
  connect_bd_intf_net -intf_net zynq_ps_M06_AXI [get_bd_intf_pins axi_gpio_0_qpll_rst/S_AXI] [get_bd_intf_pins zynq_ps/M04_AXI]

  # Create port connections
  connect_bd_net -net Ethernet_PTP_subsystem_interrupt [get_bd_pins Ethernet_PTP_subsystem/interrupt] [get_bd_pins zynq_ps/In4]
  connect_bd_net -net Ethernet_PTP_subsystem_tod_intr [get_bd_pins Ethernet_PTP_subsystem/tod_intr] [get_bd_pins zynq_ps/In3]
  connect_bd_net -net axi_dma_hier_Res [get_bd_pins Ethernet_PTP_subsystem/user_rx_resetn] [get_bd_pins vio_0/probe_in14]
  connect_bd_net -net axi_dma_hier_dma_rx_reset [get_bd_pins Ethernet_PTP_subsystem/mcdma_rx_reset_out] [get_bd_pins vio_0/probe_in4]
  connect_bd_net -net axi_dma_hier_dma_tx_reset [get_bd_pins Ethernet_PTP_subsystem/mcdma_tx_reset_out] [get_bd_pins vio_0/probe_in5]
  connect_bd_net -net axi_dma_hier_mm2s_introut [get_bd_pins Ethernet_PTP_subsystem/mm2s_introut] [get_bd_pins zynq_ps/In0]
  connect_bd_net -net axi_dma_hier_s2mm_introut [get_bd_pins Ethernet_PTP_subsystem/s2mm_introut] [get_bd_pins zynq_ps/In1]
  connect_bd_net -net axi_gpio_0_qpll_srst_gpio_io_o [get_bd_pins Ethernet_PTP_subsystem/Op2] [get_bd_pins axi_gpio_0_qpll_rst/gpio_io_o]
  connect_bd_net -net axi_resetn_1 [get_bd_pins Ethernet_PTP_subsystem/axi_resetn] [get_bd_pins axi_gpio_0_qpll_rst/s_axi_aresetn] [get_bd_pins other_perph/s_axi_aresetn] [get_bd_pins vio_0/probe_in3] [get_bd_pins zynq_ps/perph_aresetn_156_25]
  connect_bd_net -net m_axi_mm2s_aclk_1 [get_bd_pins Ethernet_PTP_subsystem/axi_clk] [get_bd_pins axi_gpio_0_qpll_rst/s_axi_aclk] [get_bd_pins other_perph/s_axi_aclk] [get_bd_pins zynq_ps/clk_156_25]
  connect_bd_net -net other_perph_axi_clk_led [get_bd_ports axi_lite_clk_led] [get_bd_pins other_perph/axi_clk_led]
  connect_bd_net -net other_perph_interrupt [get_bd_pins other_perph/interrupt] [get_bd_pins zynq_ps/In2]
  connect_bd_net -net other_perph_rst_inv_led [get_bd_ports axil_reset_led] [get_bd_pins other_perph/rst_inv_led]
  connect_bd_net -net other_perph_rx_clk_led [get_bd_ports rx_clk_led] [get_bd_pins other_perph/rx_clk_led]
#  connect_bd_net -net other_perph_tie_high_o [get_bd_ports SI53340_MUX_GT_SEL] [get_bd_pins other_perph/tie_high_o]
#  connect_bd_net -net ptp_1588_timer_syncer_0_sys_timer_1pps_out [get_bd_ports one_pps] [get_bd_pins Ethernet_PTP_subsystem/one_pps] [get_bd_pins vio_0/probe_in7]
  connect_bd_net -net rx_clk_out_1 [get_bd_pins Ethernet_PTP_subsystem/rx_clk_out] [get_bd_pins other_perph/rx_clk] [get_bd_pins vio_0/clk]
#  connect_bd_net -net tod_1pps_in_0_1 [get_bd_pins Ethernet_PTP_subsystem/tod_1pps_in_0] [get_bd_pins util_ds_buf_1/IBUF_OUT] [get_bd_pins vio_0/probe_in15]
  connect_bd_net -net tx_clk_out_1 [get_bd_pins Ethernet_PTP_subsystem/tx_clk_out] [get_bd_pins other_perph/mgt_clk] [get_bd_pins zynq_ps/ACLK]
  connect_bd_net -net user_rx_reset_1 [get_bd_pins Ethernet_PTP_subsystem/user_rx_reset] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net user_tx_reset_1 [get_bd_pins Ethernet_PTP_subsystem/user_tx_reset] [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins vio_0/probe_in0]
#  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins Ethernet_PTP_subsystem/ts_clk] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins util_vector_logic_0/Res] [get_bd_pins zynq_ps/ARESETN]
  connect_bd_net -net xxv_ethernet_0_gtpowergood_out_0 [get_bd_pins Ethernet_PTP_subsystem/gtpowergood_out_0] [get_bd_pins vio_0/probe_in6]
  connect_bd_net -net xxv_ethernet_0_stat_rx_block_lock_0 [get_bd_pins Ethernet_PTP_subsystem/stat_rx_block_lock_0] [get_bd_pins vio_0/probe_in8]
  connect_bd_net -net xxv_ethernet_0_stat_rx_internal_local_fault_0 [get_bd_pins Ethernet_PTP_subsystem/stat_rx_internal_local_fault_0] [get_bd_pins vio_0/probe_in10]
  connect_bd_net -net xxv_ethernet_0_stat_rx_local_fault_0 [get_bd_pins Ethernet_PTP_subsystem/stat_rx_local_fault_0] [get_bd_pins vio_0/probe_in11]
  connect_bd_net -net xxv_ethernet_0_stat_rx_status_0 [get_bd_pins Ethernet_PTP_subsystem/stat_rx_status_0] [get_bd_pins vio_0/probe_in9]
  connect_bd_net -net xxv_ethernet_0_stat_tx_bad_fcs_0 [get_bd_pins Ethernet_PTP_subsystem/stat_tx_bad_fcs_0] [get_bd_pins vio_0/probe_in13]
  connect_bd_net -net xxv_ethernet_0_stat_tx_local_fault_0 [get_bd_pins Ethernet_PTP_subsystem/stat_tx_local_fault_0] [get_bd_pins vio_0/probe_in12]
  connect_bd_net -net zynq_ps_clk_100 [get_bd_pins Ethernet_PTP_subsystem/dclk] [get_bd_pins zynq_ps/clk_100]
  connect_bd_net -net zynq_ps_clk_250 [get_bd_pins zynq_ps/clk_250] [get_bd_pins Ethernet_PTP_subsystem/ts_clk]
  connect_bd_net -net zynq_ps_peripheral_reset [get_bd_pins Ethernet_PTP_subsystem/sys_reset] [get_bd_pins vio_0/probe_in2] [get_bd_pins zynq_ps/peripheral_reset]
  connect_bd_net -net zynq_ps_peripheral_ts_rst [get_bd_pins Ethernet_PTP_subsystem/ts_rst] [get_bd_pins zynq_ps/peripheral_reset_250]

  # Create address segments
  assign_bd_address -offset 0xA0000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces zynq_ps/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs zynq_ps/bram/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x80030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ps/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_gpio_0_qpll_rst/S_AXI/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ps/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x80040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ps/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs other_perph/axi_timer_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x80020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ps/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs Ethernet_PTP_subsystem/PTP_support/ptp_1588_timer_syncer_0/s_axi/Reg] -force
  assign_bd_address -offset 0x80010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ps/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs Ethernet_PTP_subsystem/Ethernet_stream_subsystem/xxv_ethernet_0/s_axi_0/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_MM2S] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_MM2S] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_S2MM] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_S2MM] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_SG] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_SG] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/TX_HW_MASTER/hw_master_top_1/m00_axi] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/TX_HW_MASTER/hw_master_top_1/m00_axi] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/TX_HW_MASTER/hw_master_top_1/m00_axi] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/TX_HW_MASTER/hw_master_top_1/m00_axi] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_MM2S] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_MM2S] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_S2MM] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_S2MM] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_SG] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces Ethernet_PTP_subsystem/Ethernet_stream_subsystem/axi_dma_hier/axi_mcdma_0/Data_SG] [get_bd_addr_segs zynq_ps/zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


