
source ../scripts/00_common_initial_settings.tcl

### variables
set current_step "01_icc2_import"

### create nlib
file mkdir $nlib_dir
file delete -force $nlib_dir/${design}_${current_step}.nlib
create_lib -technology $synopsys_tech_tf -ref_libs $ndm_files $nlib_dir/${design}_${current_step}.nlib

### read verilog
read_verilog -library ${design}_${current_step}.nlib -design ${design} -top $design $import_netlists

### initialization script
source ../scripts/initialization_settings.tcl

### connect pg
connect_pg_net -automatic

### save design
save_block
save_lib
