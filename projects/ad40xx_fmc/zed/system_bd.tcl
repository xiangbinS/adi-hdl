source $ad_hdl_dir/projects/common/zed/zed_system_bd.tcl
source $ad_hdl_dir/projects/scripts/adi_pd.tcl

# specify the spi reference clock frequency in MHz
set spi_clk_ref_frequency 166

# specify ADC resolution -- supported resolutions 16/18/20 bits
set ADC_RESOLUTION [get_env_param ADC_RESOLUTION 20]

# specify ADC sampling rate in samples/seconds

# NOTE: This rate can be set just in turbo mode -- if turbo mode is not used
# the max rate should be 1.6 MSPS
# supported sampling rates: 2/1.8/1/0.5 MSPS depending on the board
set ADC_SAMPLING_RATE [get_env_param ADC_SAMPLING_RATE 1800000]

source ../common/ad40xx_bd.tcl

set mem_init_sys_path [get_env_param ADI_PROJECT_DIR ""]mem_init_sys.txt;

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/$mem_init_sys_path"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9

set AD40XX_ADAQ400X_N [get_env_param AD40XX_ADAQ400X_N 1]
if {$AD40XX_ADAQ400X_N == 0} {
    set sys_cstring "ADAQ400X"
} else {
    set sys_cstring "AD40XX"
}
set sys_cstring $sys_cstring "ADC_SAMPLING_RATE=$ADC_SAMPLING_RATE\
ADC_RESOLUTION=$ADC_RESOLUTION"

sysid_gen_sys_init_file $sys_cstring
