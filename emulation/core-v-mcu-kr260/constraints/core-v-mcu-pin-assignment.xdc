set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {s_tck}]
## This file is a general .xdc for the KR260
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict { PACKAGE_PIN C3 IOSTANDARD LVCMOS18 } [get_ports { ref_clk }];


##Pmod Headers
##Pmod Header J2
set_property -dict { PACKAGE_PIN H12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[53] }];
set_property -dict { PACKAGE_PIN E10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[54] }];
set_property -dict { PACKAGE_PIN D10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[55] }];
set_property -dict { PACKAGE_PIN C11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[56] }];
set_property -dict { PACKAGE_PIN B10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[57] }];
set_property -dict { PACKAGE_PIN E12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[58] }];
set_property -dict { PACKAGE_PIN D11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[59] }];
set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[60] }];

##Pmod Header J18
#set_property -dict { PACKAGE_PIN J11   IOSTANDARD LVCMOS33 } [get_ports { J18[1] }];
set_property -dict { PACKAGE_PIN J10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[25] }];
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[24] }];
set_property -dict { PACKAGE_PIN K12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[28] }];
set_property -dict { PACKAGE_PIN H11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[3] }];
set_property -dict { PACKAGE_PIN G10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[1] }];
set_property -dict { PACKAGE_PIN F12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[2] }];
set_property -dict { PACKAGE_PIN F11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[0] }];

##Pmod Header J19
set_property -dict { PACKAGE_PIN AE12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[37] }];
set_property -dict { PACKAGE_PIN AF12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[38] }];
set_property -dict { PACKAGE_PIN AG10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[39] }];
set_property -dict { PACKAGE_PIN AH10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[40] }];
set_property -dict { PACKAGE_PIN AF11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[41] }];
set_property -dict { PACKAGE_PIN AG11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[42] }];
set_property -dict { PACKAGE_PIN AH12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[43] }];
set_property -dict { PACKAGE_PIN AH11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[44] }];

##Pmod Header J20
set_property -dict { PACKAGE_PIN AC12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[45] }];
set_property -dict { PACKAGE_PIN AD12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[46] }];
set_property -dict { PACKAGE_PIN AE10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[47] }];
set_property -dict { PACKAGE_PIN AF10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[48] }];
set_property -dict { PACKAGE_PIN AD11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[49] }];
set_property -dict { PACKAGE_PIN AD10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[50] }];
set_property -dict { PACKAGE_PIN AA11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[51] }];
set_property -dict { PACKAGE_PIN AA10 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[52] }];

##Raspberry Pi connector 2x20
set_property -dict { PACKAGE_PIN AG14 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[29] }];
set_property -dict { PACKAGE_PIN AB14 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[30] }];
set_property -dict { PACKAGE_PIN AB9 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[31] }];
set_property -dict { PACKAGE_PIN Y12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[32] }];
set_property -dict { PACKAGE_PIN W14 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[33] }];
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[34] }];
set_property -dict { PACKAGE_PIN Y14 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[35] }];
set_property -dict { PACKAGE_PIN AA12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[36] }];
set_property -dict { PACKAGE_PIN W12 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[61] }];
set_property -dict { PACKAGE_PIN W11 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[4] }];
set_property -dict { PACKAGE_PIN AH14 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[27] }];
set_property -dict { PACKAGE_PIN AG13 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[26] }];
set_property -dict { PACKAGE_PIN AB13 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[62] }];
set_property -dict { PACKAGE_PIN Y13 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[63] }];
set_property -dict { PACKAGE_PIN AA8 IOSTANDARD LVCMOS33 } [get_ports { xilinx_io[6] }]; #J21[22]

set_property -dict { PACKAGE_PIN F8 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[22] }]; #IO_L18P_T2_A24_15 Sch=led[0]
set_property -dict { PACKAGE_PIN E8 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[23] }]; #IO_L24P_T3_RS1_15 Sch=led[1]

set_property -dict { PACKAGE_PIN F3 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[7] }]; #eth_mdio HPA03N C1 - C7
set_property -dict { PACKAGE_PIN G3 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[8] }]; #eth_mdc HPA03P C1 - C6
set_property -dict { PACKAGE_PIN A2 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[9] }]; #eth_tx_clk HPA06P_CLK C1 - A3
set_property -dict { PACKAGE_PIN F1 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[10] }]; #eth_tx_ctrl HPA00_CCN C1 - C4
set_property -dict { PACKAGE_PIN E2 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[11] }]; #eth_tx_d3 HPA02N C1 - D5
set_property -dict { PACKAGE_PIN F2 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[12] }]; #eth_tx_d2 HPA02P C1 - D4
set_property -dict { PACKAGE_PIN D1 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[13] }]; #eth_tx_d1 HPA01N C1 - D8
set_property -dict { PACKAGE_PIN E1 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[14] }]; #eth_tx_d0 HPA01P C1 - D7
set_property -dict { PACKAGE_PIN D4 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[15] }]; #eth_rx_clk HPA09P_CLK C1 - D10
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[16] }]; #eth_rx_ctrl HPA08N C1 - C10
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[17] }]; #eth_rx_d3 HPA08P C1 - C9
set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[18] }]; #eth_rx_d2 HPA07N C1 - B8
set_property -dict { PACKAGE_PIN B3 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[19] }]; #eth_rx_d1 HPA07P C1 - B7
set_property -dict { PACKAGE_PIN A1 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[20] }]; #eth_rx_d0 HPA06N C1 - A4
set_property -dict { PACKAGE_PIN B1 IOSTANDARD LVCMOS18 } [get_ports { xilinx_io[21] }]; #eth_rstb HPA05_CCN C1 - B2

