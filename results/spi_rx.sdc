###################################################################

# Created by write_sdc on Sun Jun 29 20:16:22 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_max_transition 0.4 [current_design]
set_max_fanout 60 [current_design]
set_max_area 0
set_timing_derate -late -net_delay  1.1 
set_timing_derate -early -net_delay  0.9 
set_timing_derate -late -cell_delay 1.1 
set_timing_derate -early -cell_delay 0.9 
create_clock [get_ports clk]  -period 5  -waveform {0 2.5}
set_clock_latency 0.2  [get_clocks clk]
set_clock_uncertainty -setup 0.1  [get_clocks clk]
set_clock_transition -max -rise 0.1 [get_clocks clk]
set_clock_transition -max -fall 0.1 [get_clocks clk]
set_clock_transition -min -rise 0.1 [get_clocks clk]
set_clock_transition -min -fall 0.1 [get_clocks clk]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_rx_data_r_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_rx_data_r_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_rx_data_r_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_rx_data_r_reg/main_gate]
set_clock_gating_check -rise -setup 0 [get_cells                               \
clk_gate_bit_count_reg/main_gate]
set_clock_gating_check -fall -setup 0 [get_cells                               \
clk_gate_bit_count_reg/main_gate]
set_clock_gating_check -rise -hold 0 [get_cells                                \
clk_gate_bit_count_reg/main_gate]
set_clock_gating_check -fall -hold 0 [get_cells                                \
clk_gate_bit_count_reg/main_gate]
