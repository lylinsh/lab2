set DESIGN_NAME spi_rx

# Setup the library
set LIB_PATH ../../library/tech/dc

# #set_units -current mA
set link_library "* $LIB_PATH/saed32rvt_tt0p85v25c.db $LIB_PATH/saed32hvt_tt0p85v25c.db $LIB_PATH/saed32lvt_tt0p85v25c.db"
read_verilog ../../results/spi_rx.syn.v
link_design ${DESIGN_NAME} -verbose
read_sdc ../../results/spi_rx.sdc

read_parasitics -keep_capacitive_coupling ../../results/spi_rx.spef.nominal
complete_net_parasitics

redirect ./report/timing_max.rep  { report_timing -path full_clock -delay max -input_pins -nets -cap -trans -max 10000}

set_propagated_clock [all_clocks]
update_timing -full
set_app_var extract_model_capacitance_limit 5.0
write_sdf ../../results/${DESIGN_NAME}.pt.sdf
extract_model -output ../../results/${DESIGN_NAME} -format {lib}


