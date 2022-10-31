source $ad_hdl_dir/projects/common/zed/zed_system_bd.tcl
source $ad_hdl_dir/projects/scripts/adi_pd.tcl

set mem_init_sys_path [get_env_param ADI_PROJECT_DIR ""]mem_init_sys.txt;

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/$mem_init_sys_path"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9

set sys_cstring "ADC_SAMPLING_RATE=$adc_sampling_rate"

sysid_gen_sys_init_file $sys_cstring

# specify ADC sampling rate in samples/seconds -- default is 1 MSPS
set adc_sampling_rate 1000000

source ../common/adaq7980_bd.tcl
