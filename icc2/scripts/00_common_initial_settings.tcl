set design "spi_rx"

### design data directory
set data_dir "../../results"
file mkdir $data_dir

### nlib data dir
set nlib_dir "./nlib"
file mkdir $nlib_dir

### library dir
set lib_dir "../../library"

### change all paths to absolute paths since some tools don't support relative paths
set lib_dir [file normalize $lib_dir]
set data_dir [file normalize $data_dir]
set nlib_dir [file normalize $nlib_dir]

### gate level netlist files
set import_netlists     ""
lappend import_netlists "${data_dir}/spi_rx.syn.v"

### SDC files (to be added)


### tech files
set synopsys_tech_tf "${lib_dir}/tech/icc2/saed32nm_1p9m_mw.v10.tf"

### library files
set ndm_files ""
lappend ndm_files "${lib_dir}/ndm/saed32_hvt.ndm"
lappend ndm_files "${lib_dir}/ndm/saed32_lvt.ndm"
lappend ndm_files "${lib_dir}/ndm/saed32_rvt.ndm"

set lef_files ""
lappend lef_files "${lib_dir}/lef/saed32nm_hvt_1p9m.lef"
lappend lef_files "${lib_dir}/lef/saed32nm_lvt_1p9m.lef"
lappend lef_files "${lib_dir}/lef/saed32nm_rvt_1p9m.lef"

set icc2rc_tech(cmax)       "${lib_dir}/tech/tluplus/saed32nm_1p9m_Cmax.tluplus"
set icc2rc_tech(cmin)       "${lib_dir}/tech/tluplus/saed32nm_1p9m_Cmin.tluplus"
set icc2rc_tech(nominal)    "${lib_dir}/tech/tluplus/saed32nm_1p9m_nominal.tluplus"
set itf_tluplus_map         "${lib_dir}/tech/tluplus/saed32nm_tf_itf_tluplus.map"

### scenarios of each step
set default_scenarios  "func_tt0p85v25"
set placeopt_scenarios "func_tt0p85v25"
set clock_scenarios    "func_tt0p85v25"
set clockopt_scenarios "func_tt0p85v25"
set routeopt_scenarios "func_tt0p85v25"

### cells type settings
set fillers_ref     "*/SHFILL128_HVT */SHFILL64_HVT */SHFILL3_HVT */SHFILL2_HVT */SHFILL1_HVT"
set endcap_left     "*/SHFILL2_HVT"
set endcap_right    "*/SHFILL2_HVT"
set endcap_top      "*/SHFILL3_HVT */SHFILL2_HVT */SHFILL1_HVT"
set endcap_bottom   "*/SHFILL3_HVT */SHFILL2_HVT */SHFILL1_HVT"
set tapcell_ref     "*/SHFILL3_HVT"
set holdfix_ref     "*/DELLN1X2_HVT */DELLN1X2_RVT */DELLN3X2_HVT */NBUFFX2_HVT */NBUFFX2_LVT */NBUFFX2_RVT */NBUFFX4_HVT */NBUFFX8_HVT"

set_app_var sh_continue_on_error true

