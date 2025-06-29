source scripts/00_common_initial_settings.tcl

### variables
set current_step "09_icc2_chipfinish"
set before_step  "08_icc2_routeopt"

### open database
file mkdir $nlib_dir
file delete -force $nlib_dir/${design}_${current_step}.nlib
copy_lib -from_lib ${nlib_dir}/${design}_${before_step}.nlib -to_lib ${nlib_dir}/${design}_${current_step}.nlib -force
current_lib ${design}_${current_step}.nlib
open_block ${design}

### initialize setting
source scripts/initialization_settings.tcl

### insert decap/fillers
#create_stdcell_fillers -lib_cells $decap_ref
#remove_stdcell_fillers_with_violation
create_stdcell_fillers -lib_cells $fillers_ref

### connect pg
connect_pg_net -all_blocks -automatic

### save
save_block
save_lib -all


set gds_file "data/${design}_${current_step}.oas"
set_app_options -as_user_default -name file.oasis.contact_prefix -value $design
set_app_options -as_user_default -name file.gds.contact_prefix -value $design
set_app_options -as_user_default -name file.verilog.write_internal_pins -value true
if { [get_routing_blockages * -quiet] != "" } {
    remove_routing_blockages *
}
write_gds -long_names -design $design -hierarchy design_lib -lib_cell_view frame -compress -keep_data_type -output_pin geometry -fill exclude $gds_file
write_oasis -design $design -hierarchy design_lib -lib_cell_view frame -compress 9 -keep_data_type -output_pin geometry -fill exclude $gds_file


write_verilog -exclude {well_tap_cells filler_cells pg_objects} ../../results/spi_rx_pr.v 
write_verilog -exclude {well_tap_cells filler_cells} ../../results/spi_rx_lvs.v 
write_sdf ../../results/spi_rx.sdf
write_parasitics -compress -format spef -output ../../results/spi_rx_icc2.spef
write_lef ../../results/spi_rx.lef 
write_def ../../results/spi_rx.def 

create_shape -shape_type text -layer M8 -height 0.1 -text "VDD" -origin {-1.1 -1.1}
create_shape -shape_type text -layer M8 -height 0.1 -text "VSS" -origin {-0.4 -0.4}
                                                                                     