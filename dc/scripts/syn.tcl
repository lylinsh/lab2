set DESIGN_NAME spi_rx 

set RTL_PATH ../../src
set search_path "$search_path \
                 ../../library/tech/dc/ \
                "

set target_library "saed32rvt_tt0p85v25c.db "
set symbol_library "saed32rvt_tt0p85v25c.db "
set link_library   "* saed32rvt_tt0p85v25c.db "

analyze -format sverilog -define { ASIC_CLOCK_GATING} $RTL_PATH/spi_rx.sv
elaborate $DESIGN_NAME 
current_design $DESIGN_NAME 
link 

create_clock -name "clk" -period 5 [get_ports clk]

set_clock_uncertainty -setup 0.1 [all_clocks] 
set_clock_transition 0.1 [all_clocks] 
set_clock_latency 0.2 [all_clocks] 
set_timing_derate -early 0.9 
set_timing_derate -late 1.1 

set_clock_gating_style -control_point before -control_signal scan_enable 
set_max_transition 0.4 [current_design]
set_max_fanout 60 [current_design]
set_max_area 0

set_fix_hold [all_clocks] 
set_fix_multiple_port_nets -buffer_constants -all 

compile_ultra -no_autoungroup -gate_clock 

set REPORTS reports_$DESIGN_NAME 
set SYN_FILES syn_files_$DESIGN_NAME
file delete -force $REPORTS 
file delete -force $SYN_FILES
file mkdir $REPORTS 
file mkdir $SYN_FILES 

report_power -hierarchy > $REPORTS/$DESIGN_NAME.hierarchy.power 
report_power > $REPORTS/$DESIGN_NAME.power 
report_area -hierarchy > $REPORTS/$DESIGN_NAME.area 
report_timing -delay_type max > $REPORTS/$DESIGN_NAME.max.timing
report_timing -delay_type min > $REPORTS/$DESIGN_NAME.min.timing
report_constraint -verbose > $REPORTS/$DESIGN_NAME.constraint
report_constraint -all_violators > $REPORTS/$DESIGN_NAME.violation

# Ouptut the results
write -h $DESIGN_NAME -output ./$SYN_FILES/$DESIGN_NAME.db
write_file -format ddc -hierarchy -output ./$SYN_FILES/$DESIGN_NAME.ddc
# Delays in SDF format for Verilog simulation
write_sdf -context verilog -version 1.0 ../../results/$DESIGN_NAME.syn.sdf
# The post-syn Verilog netlist
write -h -f verilog $DESIGN_NAME -output ../../results/$DESIGN_NAME.syn.v -pg
# Constraints in SDC format, for APR
write_sdc ../../results/$DESIGN_NAME.sdc

