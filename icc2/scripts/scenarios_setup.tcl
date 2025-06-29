remove_scenarios -all
remove_corners -all
remove_modes -all 

### create modes, corners and scenarios : check errors
## func_ss0p75v125c_cmax
    create_mode func
    create_corner tt0p85v25
    create_scenario -mode func -corner tt0p85v25 -name func_tt0p85v25
    current_scenario func_tt0p85v25
    read_parasitic_tech -layermap $itf_tluplus_map -tlup $icc2rc_tech(cmax) -name maxTLU
    remove_sdc -scenarios [current_scenario]
    source ../../results/spi_rx.sdc

    set_parasitic_parameters -early_spec maxTLU -late_spec maxTLU
    set_temperature 25
    set_process_number 0.99
    set_process_label normal
    set_voltage 0.85  -object_list VDD
    set_voltage 0.00  -object_list VSS
    set_timing_derate -early 0.93 -cell_delay -net_delay
    
    # set clock uncertainty
    if { [regexp {place} $current_step] } {
        set_clock_uncertainty -setup 0.200 [get_clocks clk]
    } elseif { [regexp {clock} $current_step] } {
        set_clock_uncertainty -setup 0.200 [get_clocks clk]
    } elseif { [regexp {route} $current_step] } {
        set_clock_uncertainty -setup 0.200 [get_clocks clk]
    }
    set_max_transition 0.15 [get_clock *] -clock_path
    set_max_transition 0.25 [get_clock *] -data_path
    set_max_capacitance 0.15 [current_design]
    set_scenario_status func_tt0p85v25 -active true -setup true -hold true -max_capacitance true -max_transition true -min_capacitance true -leakage_power false -dynamic_power false

