source ../scripts/00_common_initial_settings.tcl

### variables
set current_step "08_icc2_routeopt"
set before_step  "07_icc2_route"

### open database
file mkdir $nlib_dir
file delete -force $nlib_dir/${design}_${current_step}.nlib
copy_lib -from_lib ${nlib_dir}/${design}_${before_step}.nlib -to_lib ${nlib_dir}/${design}_${current_step}.nlib -force
current_lib ${design}_${current_step}.nlib
open_block ${design}

### temporarily removed below layers to fix starrc-in-design errors
remove_layers PO
remove_layers CO

### initialize setting
source ../scripts/initialization_settings.tcl

### scenario setup
set scenarios_list $routeopt_scenarios
source ../scripts/scenarios_setup.tcl
foreach scenario [get_att [all_scenarios] name] {
    echo "YFT-Information: Setting propagated clock on scenario $scenario"
    current_scenario $scenario
    set_propagated_clock [get_clocks -filter "is_virtual==false"]
}

### routing layer
set_ignored_layers -min_routing_layer M3 -max_routing_layer M6

### lib cell selection (tie, cts cells, hold fix)
set_dont_touch [get_lib_cells */*TIE*] false
set_attribute [get_lib_cells */*TIE*] dont_use false
set_lib_cell_purpose -include {optimization} [get_lib_cells */*TIE*]
set cts_cells "*/NBUFFX16_LVT */NBUFFX4_LVT */NBUFFX8_LVT */INVX16_LVT */INVX4_LVT */INVX8_LVT */*CG* */*DFF*"
set cts_cells_more "saed32_lvt|saed32_lvt_std/NBUFFX16_LVT saed32_lvt|saed32_lvt_std/NBUFFX2_LVT saed32_lvt|saed32_lvt_std/NBUFFX32_LVT saed32_lvt|saed32_lvt_std/NBUFFX4_LVT saed32_lvt|saed32_lvt_std/NBUFFX8_LVT saed32_rvt|saed32_rvt_std/NBUFFX16_RVT saed32_rvt|saed32_rvt_std/NBUFFX2_RVT saed32_rvt|saed32_rvt_std/NBUFFX32_RVT saed32_rvt|saed32_rvt_std/NBUFFX4_RVT saed32_rvt|saed32_rvt_std/NBUFFX8_RVT saed32_lvt|saed32_lvt_std/AOBUFX2_LVT saed32_lvt|saed32_lvt_std/AOBUFX4_LVT saed32_rvt|saed32_rvt_std/AOBUFX2_RVT saed32_rvt|saed32_rvt_std/AOBUFX4_RVT saed32_lvt|saed32_lvt_std/IBUFFX16_LVT saed32_lvt|saed32_lvt_std/IBUFFX2_LVT saed32_lvt|saed32_lvt_std/IBUFFX4_LVT saed32_lvt|saed32_lvt_std/IBUFFX8_LVT saed32_lvt|saed32_lvt_std/INVX0_LVT saed32_lvt|saed32_lvt_std/INVX16_LVT saed32_lvt|saed32_lvt_std/INVX2_LVT saed32_lvt|saed32_lvt_std/INVX4_LVT saed32_lvt|saed32_lvt_std/INVX8_LVT saed32_rvt|saed32_rvt_std/IBUFFX16_RVT saed32_rvt|saed32_rvt_std/IBUFFX2_RVT saed32_rvt|saed32_rvt_std/IBUFFX4_RVT saed32_rvt|saed32_rvt_std/IBUFFX8_RVT saed32_rvt|saed32_rvt_std/INVX0_RVT saed32_rvt|saed32_rvt_std/INVX16_RVT saed32_rvt|saed32_rvt_std/INVX2_RVT saed32_rvt|saed32_rvt_std/INVX4_RVT saed32_rvt|saed32_rvt_std/INVX8_RVT saed32_lvt|saed32_lvt_std/AOINVX4_LVT saed32_rvt|saed32_rvt_std/AOINVX4_RVT"

set_dont_touch [get_lib_cells $cts_cells] false
set_att [get_lib_cells $cts_cells] dont_use false
set_lib_cell_purpose -exclude cts [get_lib_cells */*]
set_lib_cell_purpose -include cts [get_lib_cells {*/*BUF* */*INV*}]

### CTS NDR (Reminder: )
if { [get_routing_rule ndr_2w2s -quiet] == "" } {
    create_routing_rule ndr_2w2s -default_reference_rule -multiplier_width 2 -multiplier_spacing 2
}
if { [get_routing_rule ndr_2w2s_manual -quiet] == "" } {
    create_routing_rule ndr_2w2s_manual -default_reference_rule \
        -widths { M1 0.1 M2 0.112 M3 0.112 M4 0.112 M5 0.112 M6 0.112 M7 0.112 M8 0.112 M9 0.32 } \
        -spacings { M1 0.1 M2 0.112 M3 0.112 M4 0.112 M5 0.112 M6 0.112 M7 0.112 M8 0.112 M9 0.32 } \
        -spacing_weight_levels { M1 {medium} M2 {medium} M3 {medium} M4 {medium} M5 {hard} M6 {hard} M7 {hard} M8 {hard} M9 {medium} }
}
set all_master_clocks [get_clocks -filter "is_virtual==false&&is_generated==false"]
set all_real_clocks [get_clocks -filter "is_virtual==false"]
set_clock_routing_rules -min_routing_layer M5 -max_routing_layer M8 -clocks $all_master_clocks -rules ndr_2w2s_manual

### post cts app option
set_app_options -name clock_opt.flow.enable_ccd -value false
set_app_options -name clock_opt.hold.effort -value high
set_app_options -name clock_opt.place.congestion_effort -value high
set_app_options -name clock_opt.place.effort -value high
set_app_options -name cts.common.user_instance_name_prefix -value "CCDOPT_"

set_app_options -name opt.common.user_instance_name_prefix -value "ROPT_"

### route app options
# global route
set_app_options -name route.global.crosstalk_driven -value true
set_app_options -name route.global.timing_driven -value true
set_app_options -name route.global.effort_level -value high
set_app_options -name route.global.timing_driven_effort_level -value high

# track assignment
set_app_options -name route.track.crosstalk_driven -value true
set_app_options -name route.track.timing_driven -value true

# detail route
set_app_options -name route.detail.antenna -value true
set_app_options -name route.detail.antenna_fixing_preference -value use_diodes
set_app_options -name route.detail.diode_libcell_names -value */ANTENNA_LVT
set_app_options -name route.detail.timing_driven -value true
#set_app_options -name route.detail.save_after_iterations -value 2

### update design latency
compute_clock_latency -verbose

### routeopt app options
set_app_options -name route_opt.flow.enable_ccd -value false
set_app_options -name route_opt.flow.enable_ccd_clock_drc_fixing -value auto
set_app_options -name route_opt.flow.enable_clock_power_recovery -value false
set_app_options -name route_opt.flow.enable_irdrivenopt -value false
set_app_options -name route_opt.flow.enable_power -value true
set_app_options -name time.si_enable_analysis -value true

### run routeot command
### power opt/ crosstalk(xtalk) opt/ hold + setup/ ccd enable
route_opt

### connect pg
connect_pg_net -all_blocks -automatic

### save
save_block
save_lib -all

### report
set reports_dir "./reports/${current_step}"
file mkdir $reports_dir
check_legality -verbose > ${reports_dir}/check_legality.rpt
check_mv_design > ${reports_dir}/check_mv_design.rpt
report_qor -summary -significant_digits 4 > ${reports_dir}/report_qor.summary.rpt
report_timing -nosplit -transition_time -capacitance -input_pins -nets -derate -delay_type max -path_type full_clock_expanded -voltage -significant_digits 4 -nworst 1 -physical -max_paths 100 > ${reports_dir}/report_timing.full.rpt
report_timing -nosplit -transition_time -capacitance -input_pins -nets -derate -delay_type max -voltage -significant_digits 4 -nworst 1 -physical -max_paths 100 > ${reports_dir}/report_timing.data.rpt
foreach_in_col scenario [all_scenario] {
    set sce_name [get_att $scenario name]
    report_constraints -scenarios $sce_name -max_transition -all_violators -significant_digits 3 -verbose > reports/${current_step}/report_constraints.max_transition.${sce_name}.rpt
    report_constraints -scenarios $sce_name -max_capacitance -all_violators -significant_digits 3 -verbose > reports/${current_step}/report_constraints.max_capacitance.${sce_name}.rpt
}
# postroute reports/check
check_routes > ${reports_dir}/check_routes.rpt
check_lvs > ${reports_dir}/check_lvs.rpt