// IC Compiler II Version T-2022.03 Verilog Writer
// Generated on 6/29/2025 at 21:2:34
// Library Name: spi_rx_09_icc2_chipfinish.nlib
// Block Name: spi_rx
// User Label: 
// Write Command: write_verilog -exclude { well_tap_cells filler_cells } ../../results/spi_rx_lvs.v
module SNPS_CLOCK_GATE_HIGH_spi_rx_1 ( CLK , EN , ENCLK , TE , VDD , VSS , 
    n2 ) ;
input  CLK ;
input  EN ;
output ENCLK ;
input  TE ;
input  VDD ;
input  VSS ;
output n2 ;

wire net51 ;
supply1 VDD ;
supply0 VSS ;
wire SYNOPSYS_UNCONNECTED_1 ;

AND2X1_RVT main_gate ( .A1 ( net51 ) , .A2 ( CLK ) , .Y ( ENCLK ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
LATCHX1_RVT latch ( .CLK ( n2 ) , .D ( EN ) , .Q ( net51 ) , 
    .QN ( SYNOPSYS_UNCONNECTED_1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX1_RVT U2 ( .A ( CLK ) , .Y ( n2 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module SNPS_CLOCK_GATE_HIGH_spi_rx_0 ( CLK , EN , ENCLK , TE , VDD , VSS , 
    cts0 ) ;
input  CLK ;
input  EN ;
output ENCLK ;
input  TE ;
input  VDD ;
input  VSS ;
input  cts0 ;

wire net51 ;
supply1 VDD ;
supply0 VSS ;
wire SYNOPSYS_UNCONNECTED_1 ;

AND2X1_RVT main_gate ( .A1 ( net51 ) , .A2 ( CLK ) , .Y ( ENCLK ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
LATCHX1_RVT latch ( .CLK ( cts0 ) , .D ( EN ) , .Q ( net51 ) , 
    .QN ( SYNOPSYS_UNCONNECTED_1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module spi_rx ( clk , reset_n , sck , cs_n , mosi , rx_data , rx_valid , VDD , 
    VSS ) ;
input  clk ;
input  reset_n ;
input  sck ;
input  cs_n ;
input  mosi ;
output [7:0] rx_data ;
output rx_valid ;
input  VDD ;
input  VSS ;

wire cts0 ;
wire sck_sync1 ;
wire cs_sync1 ;
wire N32 ;
wire N33 ;
wire N34 ;
wire N38 ;
wire net59 ;
wire net65 ;
wire n14 ;
wire n15 ;
wire n16 ;
wire n17 ;
wire n18 ;
wire CTS_ZCTSNET_0 ;
wire n21 ;
wire n24 ;
wire n25 ;
wire n26 ;
wire n27 ;
wire n28 ;
wire n29 ;
wire n30 ;
wire [1:0] state ;
wire [2:0] bit_count ;
wire [6:0] shift_reg ;
supply1 VDD ;
supply0 VSS ;
wire SYNOPSYS_UNCONNECTED_1 ;
wire SYNOPSYS_UNCONNECTED_2 ;
wire SYNOPSYS_UNCONNECTED_3 ;
wire SYNOPSYS_UNCONNECTED_4 ;
wire SYNOPSYS_UNCONNECTED_5 ;
wire SYNOPSYS_UNCONNECTED_6 ;
wire SYNOPSYS_UNCONNECTED_7 ;
wire SYNOPSYS_UNCONNECTED_8 ;
wire SYNOPSYS_UNCONNECTED_9 ;
wire SYNOPSYS_UNCONNECTED_10 ;
wire SYNOPSYS_UNCONNECTED_11 ;
wire SYNOPSYS_UNCONNECTED_12 ;
wire SYNOPSYS_UNCONNECTED_13 ;
wire SYNOPSYS_UNCONNECTED_14 ;
wire SYNOPSYS_UNCONNECTED_15 ;
wire SYNOPSYS_UNCONNECTED_16 ;
wire SYNOPSYS_UNCONNECTED_17 ;
wire SYNOPSYS_UNCONNECTED_18 ;
wire SYNOPSYS_UNCONNECTED_19 ;
wire SYNOPSYS_UNCONNECTED_20 ;
wire SYNOPSYS_UNCONNECTED_21 ;
wire SYNOPSYS_UNCONNECTED_22 ;
wire SYNOPSYS_UNCONNECTED_23 ;

SNPS_CLOCK_GATE_HIGH_spi_rx_0 clk_gate_bit_count_reg ( .CLK ( clk ) , 
    .EN ( n16 ) , .ENCLK ( net59 ) , .TE ( VSS ) , .VDD ( VDD ) , 
    .VSS ( VSS ) , .cts0 ( cts0 ) ) ;
SNPS_CLOCK_GATE_HIGH_spi_rx_1 clk_gate_rx_data_r_reg ( .CLK ( clk ) , 
    .EN ( N38 ) , .ENCLK ( net65 ) , .TE ( VSS ) , .VDD ( VDD ) , 
    .VSS ( VSS ) , .n2 ( cts0 ) ) ;
DFFARX1_RVT sck_sync1_reg ( .D ( sck ) , .CLK ( clk ) , .RSTB ( reset_n ) , 
    .Q ( sck_sync1 ) , .QN ( SYNOPSYS_UNCONNECTED_1 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT sck_sync2_reg ( .D ( sck_sync1 ) , .CLK ( clk ) , 
    .RSTB ( reset_n ) , .Q ( SYNOPSYS_UNCONNECTED_2 ) , .QN ( n29 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \bit_count_reg[0] ( .D ( N32 ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( bit_count[0] ) , .QN ( SYNOPSYS_UNCONNECTED_3 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT rx_valid_r_reg ( .D ( N38 ) , .CLK ( clk ) , .RSTB ( reset_n ) , 
    .Q ( rx_valid ) , .QN ( SYNOPSYS_UNCONNECTED_4 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \state_reg[0] ( .D ( n14 ) , .CLK ( clk ) , .RSTB ( reset_n ) , 
    .Q ( state[0] ) , .QN ( n30 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \state_reg[1] ( .D ( n15 ) , .CLK ( clk ) , .RSTB ( reset_n ) , 
    .Q ( state[1] ) , .QN ( n27 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \bit_count_reg[1] ( .D ( N33 ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( bit_count[1] ) , .QN ( SYNOPSYS_UNCONNECTED_5 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \bit_count_reg[2] ( .D ( N34 ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( bit_count[2] ) , .QN ( SYNOPSYS_UNCONNECTED_6 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \shift_reg_reg[0] ( .D ( mosi ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( shift_reg[0] ) , .QN ( SYNOPSYS_UNCONNECTED_7 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \shift_reg_reg[1] ( .D ( shift_reg[0] ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( shift_reg[1] ) , .QN ( SYNOPSYS_UNCONNECTED_8 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \shift_reg_reg[2] ( .D ( shift_reg[1] ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( shift_reg[2] ) , .QN ( SYNOPSYS_UNCONNECTED_9 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \shift_reg_reg[3] ( .D ( shift_reg[2] ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( shift_reg[3] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_10 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \shift_reg_reg[4] ( .D ( shift_reg[3] ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( shift_reg[4] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_11 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \shift_reg_reg[5] ( .D ( shift_reg[4] ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( shift_reg[5] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_12 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \shift_reg_reg[6] ( .D ( shift_reg[5] ) , .CLK ( CTS_ZCTSNET_0 ) , 
    .RSTB ( reset_n ) , .Q ( shift_reg[6] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_13 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[7] ( .D ( shift_reg[6] ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[7] ) , .QN ( SYNOPSYS_UNCONNECTED_14 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[6] ( .D ( shift_reg[5] ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[6] ) , .QN ( SYNOPSYS_UNCONNECTED_15 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[5] ( .D ( shift_reg[4] ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[5] ) , .QN ( SYNOPSYS_UNCONNECTED_16 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[4] ( .D ( shift_reg[3] ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[4] ) , .QN ( SYNOPSYS_UNCONNECTED_17 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[3] ( .D ( shift_reg[2] ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[3] ) , .QN ( SYNOPSYS_UNCONNECTED_18 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[2] ( .D ( shift_reg[1] ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[2] ) , .QN ( SYNOPSYS_UNCONNECTED_19 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[1] ( .D ( shift_reg[0] ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[1] ) , .QN ( SYNOPSYS_UNCONNECTED_20 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \rx_data_r_reg[0] ( .D ( mosi ) , .CLK ( net65 ) , 
    .RSTB ( reset_n ) , .Q ( rx_data[0] ) , .QN ( SYNOPSYS_UNCONNECTED_21 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFASX1_RVT cs_sync1_reg ( .D ( cs_n ) , .CLK ( clk ) , .SETB ( reset_n ) , 
    .Q ( cs_sync1 ) , .QN ( SYNOPSYS_UNCONNECTED_22 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFASX1_RVT cs_sync2_reg ( .D ( cs_sync1 ) , .CLK ( clk ) , 
    .SETB ( reset_n ) , .Q ( SYNOPSYS_UNCONNECTED_23 ) , .QN ( n28 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U24 ( .A1 ( bit_count[1] ) , .A2 ( bit_count[0] ) , .Y ( n21 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX1_RVT U25 ( .A ( n21 ) , .Y ( n18 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U26 ( .A1 ( n27 ) , .A2 ( n29 ) , .A3 ( sck_sync1 ) , .Y ( n26 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND4X0_RVT U27 ( .A1 ( state[0] ) , .A2 ( n18 ) , .A3 ( bit_count[2] ) , 
    .A4 ( n26 ) , .Y ( n24 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX1_RVT U28 ( .A ( n24 ) , .Y ( N38 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U29 ( .A1 ( bit_count[1] ) , .A2 ( bit_count[0] ) , 
    .A3 ( bit_count[2] ) , .Y ( n17 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_LVT CTS_ZCTSBUF_92_181 ( .A ( net59 ) , .Y ( CTS_ZCTSNET_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA221X1_LVT CLKOPT_ctmTdsLR_1_290 ( .A1 ( n21 ) , .A2 ( n21 ) , 
    .A3 ( bit_count[1] ) , .A4 ( bit_count[0] ) , .A5 ( n27 ) , .Y ( N33 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NOR2X0_RVT U37 ( .A1 ( state[1] ) , .A2 ( bit_count[0] ) , .Y ( N32 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA21X1_RVT U38 ( .A1 ( state[0] ) , .A2 ( n28 ) , .A3 ( n26 ) , .Y ( n16 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA221X1_RVT U39 ( .A1 ( N38 ) , .A2 ( state[1] ) , .A3 ( n24 ) , .A4 ( n28 ) , 
    .A5 ( state[0] ) , .Y ( n15 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA21X1_RVT U40 ( .A1 ( state[1] ) , .A2 ( n28 ) , .A3 ( n24 ) , .Y ( n25 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA222X1_RVT U41 ( .A1 ( state[0] ) , .A2 ( n26 ) , .A3 ( state[0] ) , 
    .A4 ( n28 ) , .A5 ( n25 ) , .A6 ( n30 ) , .Y ( n14 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
OA221X1_LVT CLKOPT_ctmTdsLR_1_291 ( .A1 ( n17 ) , .A2 ( n17 ) , 
    .A3 ( bit_count[2] ) , .A4 ( n18 ) , .A5 ( n27 ) , .Y ( N34 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


