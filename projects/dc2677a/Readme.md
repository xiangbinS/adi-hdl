# DC2677A HDL Project

Here are some pointers to help you:
  * [Board Product Page](https://www.analog.com/en/design-center/evaluation-hardware-and-software/evaluation-boards-kits/dc2677a.html)
  * Parts : [Buffered Octal, 18-Bit, 200ksps/Ch Differential ±10.24V ADC with 30VP-P Common Mode Range](https://www.analog.com/en/products/ltc2358-18.html)
  * Project Doc: https://wiki.analog.com/resources/eval/user-guides/dc2677a
  * HDL Doc: https://wiki.analog.com/resources/fpga/docs/axi_ltc235x
  * Linux Drivers:

Project Parameters
LVDS_CMOS_N:
  * 0 - CMOS (default)
  * 1 - LVDS
LTC235X_FAMILY:
  * 0 = 2358-18 (default)
  * 1 = 2358-16
  * 2 = 2357-18
  * 3 = 2357-16
  * 4 = 2353-18
  * 5 = 2353-16

How to build: e.g, "make LVDS_CMOS_N=0 LTC235X_FAMILY=0"
