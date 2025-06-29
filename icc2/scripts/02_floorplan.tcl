source scripts/00_common_initial_settings.tcl

### variables
set current_step "02_icc2_floorplan"
set before_step  "01_icc2_import"

### open database
file mkdir $nlib_dir
file delete -force $nlib_dir/${design}_${current_step}.nlib
copy_lib -from_lib ${nlib_dir}/${design}_${before_step}.nlib -to_lib ${nlib_dir}/${design}_${current_step}.nlib -force
current_lib ${design}_${current_step}.nlib

### get blocks -all
open_block ${design}

### initialize tool
source ../scripts/initialization_settings.tcl

### create scenarios
set scenarios_list $default_scenarios
source ../scripts/scenarios_setup.tcl

### create floorplan
initialize_floorplan -boundary {{0 0} {20.064 20.064}} -core_offset {1.672 1.672}

### place ports
if { [get_terminals * -quiet] != "" } { remove_terminals * }
remove_individual_pin_constraints
set input_ports [get_ports -filter direction==in]
set_individual_pin_constraints -ports $input_ports -allowed_layers [get_layers {M5}] -side 1 -offset {4 16}

set output_ports [get_ports -filter direction==out]
set_individual_pin_constraints -ports $output_ports -allowed_layers [get_layers {M5}] -side 3 -offset {4 16}
place_pins -self -ports [get_ports *]

### create boundary cells : check and set up corner cells
remove_boundary_cell_rules -all 
set_boundary_cell_rules -left_boundary_cell $endcap_left -right_boundary_cell $endcap_right -top_boundary_cell $endcap_top -bottom_boundary_cell $endcap_bottom
compile_boundary_cells 

### create tap cells
create_tap_cells -lib_cell $tapcell_ref -pattern stagger -distance 30 -skip_fixed_cells

### connect pg
connect_pg_net -automatic

### save design
save_block -force
save_lib
