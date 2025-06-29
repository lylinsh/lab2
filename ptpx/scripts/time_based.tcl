#################################################################################
### Time-Based Power Analysis Model Script:
### Create by Liyu Lin
### Date: 2024/12/12
#################################################################################
set power_enable_analysis TRUE
set power_analysis_mode time_based

### read and link the netlist
set link_library " * ../../library/tech/dc/saed32hvt_tt0p85v25c.db ../../library/tech/dc/saed32rvt_tt0p85v25c.db ../../library/tech/dc/saed32lvt_tt0p85v25c.db"
read_verilog ../../results/spi_rx_pr.v
current_design spi_rx
link


### read sdc
read_sdc ../../results/spi_rx.sdc
#set_disable_timing [get_lib_pins ssc_core_type/*/G]
read_parasitics ../../results/spi_rx.spef.nominal


### check, update, report timing
check_timing
update_timing
report_timing

### read switching activity file
read_vcd -strip_path spi_rx_tb/uut ../../results/spi_rx.vcd

### check or update or report power
check_power
set_power_analysis_options -waveform_format fsdb -waveform_output vcd
update_power
report_power -hierarchy

quit
