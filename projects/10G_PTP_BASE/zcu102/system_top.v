// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  input       [12:0]      gpio_bd_i,
  output      [ 7:0]      gpio_bd_o,

  output                  pps_out,

  input                   sfp_rx_n,
  input                   sfp_rx_p,
  output                  sfp_tx_n,
  output                  sfp_tx_p,

//  inout                   pl_i2c1_scl,
//  inout                   pl_i2c1_sda,

  input                   sfp_ref_clk_p,
  input                   sfp_ref_clk_n);

  // internal signals

  wire        [94:0]      gpio_i;
  wire        [94:0]      gpio_o;
  wire        [94:0]      gpio_t;
  wire        [20:0]      gpio_bd;
  wire        [ 2:0]      spi_csn;

//  wire        [47:0]      tx_tod_sec_0;
//  wire        [31:0]      tx_tod_ns_0;
//  wire        [47:0]      rx_tod_sec_0;
//  wire        [31:0]      rx_tod_ns_0;

  assign gpio_i[94:21] = gpio_o[94:21];

  assign gpio_i[ 7: 0] = gpio_o[ 7: 0];
  assign gpio_i[20: 8] = gpio_bd_i;
  assign gpio_bd_o = gpio_o[ 7: 0];

  system_wrapper i_system_wrapper (
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .pps_out (pps_out),
    .sfp_txr_grx_n (sfp_rx_n),
    .sfp_txr_grx_p (sfp_rx_p),
    .sfp_txr_gtx_n (sfp_tx_n),
    .sfp_txr_gtx_p (sfp_tx_p),

    .sfp_ref_clk_0_clk_n (sfp_ref_clk_n),
    .sfp_ref_clk_0_clk_p (sfp_ref_clk_p),

//    .ctl_tx_systemtimerin_0 ({tx_tod_sec_0, tx_tod_ns_0}),
//    .ctl_rx_systemtimerin_0 ({rx_tod_sec_0, rx_tod_ns_0}),
//    .tx_tod_sec_0 (tx_tod_sec_0),
//    .tx_tod_ns_0 (tx_tod_ns_0),
//    .rx_tod_sec_0 (rx_tod_sec_0),
//    .rx_tod_ns_0 (rx_tod_ns_0),

//    .pl_iic_scl_io (pl_i2c1_scl),
//    .pl_iic_sda_io (pl_i2c1_sda),

    .spi0_sclk (),
    .spi0_csn (spi_csn),
    .spi0_miso (1'b0),
    .spi0_mosi (),
    .spi1_sclk (),
    .spi1_csn (),
    .spi1_miso (1'b0),
    .spi1_mosi ());

endmodule
