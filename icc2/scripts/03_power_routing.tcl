source scripts/00_common_initial_settings.tcl

### variables
set current_step "03_icc2_pgrouting"
set before_step  "02_icc2_floorplan"

### open database
file mkdir $nlib_dir
file delete -force $nlib_dir/${design}_${current_step}.nlib
copy_lib -from_lib ${nlib_dir}/${design}_${before_step}.nlib -to_lib ${nlib_dir}/${design}_${current_step}.nlib -force
current_lib ${design}_${current_step}.nlib
open_block ${design}

### initialize tool
source ../scripts/initialization_settings.tcl

### create scenarios
set scenarios_list $default_scenarios
source ../scripts/scenarios_setup.tcl

### remove power settings
remove_pg_patterns -all
remove_pg_strategies -all
remove_pg_via_master_rules -all
remove_pg_strategy_via_rules -all

### remove all pg routes
remove_routes -net_types {power ground} -ring -stripe -macro_pin_connect -lib_cell_pin_connect

### create pg regions for all macros
remove_pg_regions -all

### create power ring 
if {[get_nets -quiet VDD] == ""} {create_net -power VDD}
if {[get_nets -quiet VSS] == ""} {create_net -ground VSS}
connect_pg_net -net VDD [get_pins -physical_context -filter "name==VDD"]
connect_pg_net -net VSS [get_pins -physical_context -filter "name==VSS"]

create_pg_ring_pattern  ring_VDD -nets  {VDD}  -horizontal_layer M7 -vertical_layer M8 -horizontal_width 0.448 -vertical_width 0.448
create_pg_ring_pattern  ring_VSS -nets  {VSS}  -horizontal_layer M7 -vertical_layer M8 -horizontal_width 0.448 -vertical_width 0.448
set_pg_strategy s_VDD -core -pattern {{name: ring_VDD} {nets: VDD} {offset: {0.896 0.896}}}
set_pg_strategy s_VSS -core -pattern {{name: ring_VSS} {nets: VSS} {offset: {0.224 0.224}}}

### create basic patterns
## rail pattern
create_pg_std_cell_conn_pattern pattern_pg_rail -layers M1 -rail_width {@w} -parameters {w}
## stripe pattern with 5 parameters
create_pg_wire_pattern pattern_stripe -layer @l -direction @d -width @w -spacing @s -pitch @p -track_alignment @t -parameters {l d w s p t} 
## wire based pattern with 5 parameters
create_pg_wire_pattern pattern_wire_based_on_track -layer @l -direction @d -width @w -spacing @s -pitch @p -parameters {l d w s p} -track_alignment track 

### create pg rails strategies : check rails at keepout boundary
set_pg_strategy strategy_pg_rail_top -pattern "{name: pattern_pg_rail} {nets: VDD VSS} {parameters: 0.06}" -core
compile_pg -strategies {strategy_pg_rail_top } -tag pg_rail

### create power stripes strategies
create_pg_composite_pattern pattern_core_m6_mesh -nets {VDD VSS} -add_patterns {{{pattern: pattern_wire_based_on_track} {nets: {VDD VSS}} {parameters: {M6 vertical   0.224 0.112 6.72 }}{offset: 6 }}} 
create_pg_composite_pattern pattern_core_m7_mesh -nets {VDD VSS} -add_patterns {{{pattern: pattern_wire_based_on_track} {nets: {VDD VSS}} {parameters: {M7 horizontal 0.224 0.112 6.72 }}{offset: 6 }}} 
create_pg_composite_pattern pattern_core_m8_mesh -nets {VDD VSS} -add_patterns {{{pattern: pattern_wire_based_on_track} {nets: {VDD VSS}} {parameters: {M8 vertical   0.224 0.112 6.72 }}{offset: 6 }}} 

set_pg_strategy strategy_m6_pg_mesh -pattern {{name: pattern_core_m6_mesh} {nets: {VDD VSS}}} -core
set_pg_strategy strategy_m7_pg_mesh -pattern {{name: pattern_core_m7_mesh} {nets: {VDD VSS}}} -core
set_pg_strategy strategy_m8_pg_mesh -pattern {{name: pattern_core_m8_mesh} {nets: {VDD VSS}}} -extension {{stop: outermost_ring}} -core


### create via rules stripes
#set_pg_via_master_rule pgvia_array_8x10 -via_array_dimension {8 10}
set_pg_strategy_via_rule via_pg_core -via_rule { \
{{{strategies: strategy_m8_pg_mesh}{layers: M8}}{{strategies: strategy_m7_pg_mesh}{layers: M7}}{via_master:default} } \
{{{strategies: strategy_m7_pg_mesh}{layers: M7}}{{strategies: strategy_m6_pg_mesh}{layers: M6}}{via_master:default} } \
{{{existing : std_conn }}{{strategies: strategy_m6_pg_mesh}{layers: M6}}{via_master:default} } \
{{intersection: adjacent}{via_master: default}} } 


# {{{existing : std_conn }}{{strategies: strategy_m6_pg_mesh}{layers: M6}}{via_master:default} } \
#compile_pg -strategies {strategy_m6_pg_mesh} -tag pg_stripes -via_rule {via_pg_core} -ignore_via_drc
compile_pg -strategies {s_VDD s_VSS strategy_m6_pg_mesh strategy_m7_pg_mesh strategy_m8_pg_mesh} -tag pg_stripes -via_rule {via_pg_core} -ignore_via_drc

### save design
save_block -force
save_lib
