/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP2
// Date      : Sun Jun 29 20:16:22 2025
/////////////////////////////////////////////////////////////


module SNPS_CLOCK_GATE_HIGH_spi_rx_0 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;
  wire   net43, net45, net47, net48, net51, net54, n1;
  assign net43 = EN;
  assign net45 = CLK;
  assign ENCLK = net47;
  assign net54 = TE;

  AND2X1_RVT main_gate ( .A1(net51), .A2(net45), .Y(net47) );
  OR2X1_RVT test_or ( .A1(net43), .A2(net54), .Y(net48) );
  LATCHX1_RVT latch ( .CLK(n1), .D(net48), .Q(net51) );
  INVX1_RVT U2 ( .A(net45), .Y(n1) );
endmodule


module SNPS_CLOCK_GATE_HIGH_spi_rx_1 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;
  wire   net43, net45, net47, net48, net51, net54, n2;
  assign net43 = EN;
  assign net45 = CLK;
  assign ENCLK = net47;
  assign net54 = TE;

  AND2X1_RVT main_gate ( .A1(net51), .A2(net45), .Y(net47) );
  OR2X1_RVT test_or ( .A1(net43), .A2(net54), .Y(net48) );
  LATCHX1_RVT latch ( .CLK(n2), .D(net48), .Q(net51) );
  INVX1_RVT U2 ( .A(net45), .Y(n2) );
endmodule


module spi_rx ( clk, reset_n, sck, cs_n, mosi, rx_data, rx_valid );
  output [7:0] rx_data;
  input clk, reset_n, sck, cs_n, mosi;
  output rx_valid;
  wire   sck_sync1, cs_sync1, N32, N33, N34, N38, net59, net65, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30;
  wire   [1:0] state;
  wire   [2:0] bit_count;
  wire   [6:0] shift_reg;

  SNPS_CLOCK_GATE_HIGH_spi_rx_0 clk_gate_bit_count_reg ( .CLK(clk), .EN(n16), 
        .ENCLK(net59), .TE(1'b0) );
  SNPS_CLOCK_GATE_HIGH_spi_rx_1 clk_gate_rx_data_r_reg ( .CLK(clk), .EN(N38), 
        .ENCLK(net65), .TE(1'b0) );
  DFFARX1_RVT sck_sync1_reg ( .D(sck), .CLK(clk), .RSTB(reset_n), .Q(sck_sync1) );
  DFFARX1_RVT sck_sync2_reg ( .D(sck_sync1), .CLK(clk), .RSTB(reset_n), .QN(
        n29) );
  DFFARX1_RVT \bit_count_reg[0]  ( .D(N32), .CLK(net59), .RSTB(reset_n), .Q(
        bit_count[0]) );
  DFFARX1_RVT rx_valid_r_reg ( .D(N38), .CLK(clk), .RSTB(reset_n), .Q(rx_valid) );
  DFFARX1_RVT \state_reg[0]  ( .D(n14), .CLK(clk), .RSTB(reset_n), .Q(state[0]), .QN(n30) );
  DFFARX1_RVT \state_reg[1]  ( .D(n15), .CLK(clk), .RSTB(reset_n), .Q(state[1]), .QN(n27) );
  DFFARX1_RVT \bit_count_reg[1]  ( .D(N33), .CLK(net59), .RSTB(reset_n), .Q(
        bit_count[1]) );
  DFFARX1_RVT \bit_count_reg[2]  ( .D(N34), .CLK(net59), .RSTB(reset_n), .Q(
        bit_count[2]) );
  DFFARX1_RVT \shift_reg_reg[0]  ( .D(mosi), .CLK(net59), .RSTB(reset_n), .Q(
        shift_reg[0]) );
  DFFARX1_RVT \shift_reg_reg[1]  ( .D(shift_reg[0]), .CLK(net59), .RSTB(
        reset_n), .Q(shift_reg[1]) );
  DFFARX1_RVT \shift_reg_reg[2]  ( .D(shift_reg[1]), .CLK(net59), .RSTB(
        reset_n), .Q(shift_reg[2]) );
  DFFARX1_RVT \shift_reg_reg[3]  ( .D(shift_reg[2]), .CLK(net59), .RSTB(
        reset_n), .Q(shift_reg[3]) );
  DFFARX1_RVT \shift_reg_reg[4]  ( .D(shift_reg[3]), .CLK(net59), .RSTB(
        reset_n), .Q(shift_reg[4]) );
  DFFARX1_RVT \shift_reg_reg[5]  ( .D(shift_reg[4]), .CLK(net59), .RSTB(
        reset_n), .Q(shift_reg[5]) );
  DFFARX1_RVT \shift_reg_reg[6]  ( .D(shift_reg[5]), .CLK(net59), .RSTB(
        reset_n), .Q(shift_reg[6]) );
  DFFARX1_RVT \rx_data_r_reg[7]  ( .D(shift_reg[6]), .CLK(net65), .RSTB(
        reset_n), .Q(rx_data[7]) );
  DFFARX1_RVT \rx_data_r_reg[6]  ( .D(shift_reg[5]), .CLK(net65), .RSTB(
        reset_n), .Q(rx_data[6]) );
  DFFARX1_RVT \rx_data_r_reg[5]  ( .D(shift_reg[4]), .CLK(net65), .RSTB(
        reset_n), .Q(rx_data[5]) );
  DFFARX1_RVT \rx_data_r_reg[4]  ( .D(shift_reg[3]), .CLK(net65), .RSTB(
        reset_n), .Q(rx_data[4]) );
  DFFARX1_RVT \rx_data_r_reg[3]  ( .D(shift_reg[2]), .CLK(net65), .RSTB(
        reset_n), .Q(rx_data[3]) );
  DFFARX1_RVT \rx_data_r_reg[2]  ( .D(shift_reg[1]), .CLK(net65), .RSTB(
        reset_n), .Q(rx_data[2]) );
  DFFARX1_RVT \rx_data_r_reg[1]  ( .D(shift_reg[0]), .CLK(net65), .RSTB(
        reset_n), .Q(rx_data[1]) );
  DFFARX1_RVT \rx_data_r_reg[0]  ( .D(mosi), .CLK(net65), .RSTB(reset_n), .Q(
        rx_data[0]) );
  DFFASX1_RVT cs_sync1_reg ( .D(cs_n), .CLK(clk), .SETB(reset_n), .Q(cs_sync1)
         );
  DFFASX1_RVT cs_sync2_reg ( .D(cs_sync1), .CLK(clk), .SETB(reset_n), .QN(n28)
         );
  NAND2X0_RVT U24 ( .A1(bit_count[1]), .A2(bit_count[0]), .Y(n21) );
  INVX1_RVT U25 ( .A(n21), .Y(n18) );
  AND3X1_RVT U26 ( .A1(n27), .A2(n29), .A3(sck_sync1), .Y(n26) );
  NAND4X0_RVT U27 ( .A1(state[0]), .A2(n18), .A3(bit_count[2]), .A4(n26), .Y(
        n24) );
  INVX1_RVT U28 ( .A(n24), .Y(N38) );
  NAND3X0_RVT U29 ( .A1(bit_count[1]), .A2(bit_count[0]), .A3(bit_count[2]), 
        .Y(n17) );
  AND2X1_RVT U30 ( .A1(n17), .A2(n27), .Y(n20) );
  OR2X1_RVT U31 ( .A1(bit_count[2]), .A2(n18), .Y(n19) );
  AND2X1_RVT U32 ( .A1(n20), .A2(n19), .Y(N34) );
  AND2X1_RVT U33 ( .A1(n21), .A2(n27), .Y(n23) );
  OR2X1_RVT U34 ( .A1(bit_count[0]), .A2(bit_count[1]), .Y(n22) );
  AND2X1_RVT U35 ( .A1(n23), .A2(n22), .Y(N33) );
  NOR2X0_RVT U37 ( .A1(state[1]), .A2(bit_count[0]), .Y(N32) );
  OA21X1_RVT U38 ( .A1(state[0]), .A2(n28), .A3(n26), .Y(n16) );
  OA221X1_RVT U39 ( .A1(N38), .A2(state[1]), .A3(n24), .A4(n28), .A5(state[0]), 
        .Y(n15) );
  OA21X1_RVT U40 ( .A1(state[1]), .A2(n28), .A3(n24), .Y(n25) );
  OA222X1_RVT U41 ( .A1(state[0]), .A2(n26), .A3(state[0]), .A4(n28), .A5(n25), 
        .A6(n30), .Y(n14) );
endmodule

