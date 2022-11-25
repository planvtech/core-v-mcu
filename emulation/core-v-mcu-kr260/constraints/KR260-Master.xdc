## This file is a general .xdc for the KR260
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
#set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS18 } [get_ports { CLK100MHZ }];
#create_clock -add -name sys_clk_pin -period 40.00 -waveform {0 5} [get_ports { CLK100MHZ }];


## LEDs
#set_property -dict { PACKAGE_PIN F8   IOSTANDARD LVCMOS18 } [get_ports { LED[0] }];
#set_property -dict { PACKAGE_PIN E8   IOSTANDARD LVCMOS18 } [get_ports { LED[1] }];

##Pmod Headers
##Pmod Header J2
#set_property -dict { PACKAGE_PIN H12   IOSTANDARD LVCMOS33 } [get_ports { J2[1] }];
#set_property -dict { PACKAGE_PIN E10   IOSTANDARD LVCMOS33 } [get_ports { J2[3] }];
#set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { J2[5] }];
#set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { J2[7] }];
#set_property -dict { PACKAGE_PIN B10   IOSTANDARD LVCMOS33 } [get_ports { J2[2] }];
#set_property -dict { PACKAGE_PIN E12   IOSTANDARD LVCMOS33 } [get_ports { J2[4] }];
#set_property -dict { PACKAGE_PIN D11   IOSTANDARD LVCMOS33 } [get_ports { J2[6] }];
#set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { J2[8] }];

##Pmod Header J18
#set_property -dict { PACKAGE_PIN J11   IOSTANDARD LVCMOS33 } [get_ports { J18[1] }];
#set_property -dict { PACKAGE_PIN J10   IOSTANDARD LVCMOS33 } [get_ports { J18[3] }];
#set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { J18[5] }];
#set_property -dict { PACKAGE_PIN K12   IOSTANDARD LVCMOS33 } [get_ports { J18[7] }];
#set_property -dict { PACKAGE_PIN H11   IOSTANDARD LVCMOS33 } [get_ports { J18[2] }];
#set_property -dict { PACKAGE_PIN G10   IOSTANDARD LVCMOS33 } [get_ports { J18[4] }];
#set_property -dict { PACKAGE_PIN F12   IOSTANDARD LVCMOS33 } [get_ports { J18[6] }];
#set_property -dict { PACKAGE_PIN F11   IOSTANDARD LVCMOS33 } [get_ports { J18[8] }];

##Pmod Header J19
#set_property -dict { PACKAGE_PIN AE12    IOSTANDARD LVCMOS33 } [get_ports { J19[1] }];
#set_property -dict { PACKAGE_PIN AF12    IOSTANDARD LVCMOS33 } [get_ports { J19[3] }];
#set_property -dict { PACKAGE_PIN AG10    IOSTANDARD LVCMOS33 } [get_ports { J19[5] }];
#set_property -dict { PACKAGE_PIN AH10    IOSTANDARD LVCMOS33 } [get_ports { J19[7] }];
#set_property -dict { PACKAGE_PIN AF11    IOSTANDARD LVCMOS33 } [get_ports { J19[2] }];
#set_property -dict { PACKAGE_PIN AG11    IOSTANDARD LVCMOS33 } [get_ports { J19[4] }];
#set_property -dict { PACKAGE_PIN AH12    IOSTANDARD LVCMOS33 } [get_ports { J19[6] }];
#set_property -dict { PACKAGE_PIN AH11    IOSTANDARD LVCMOS33 } [get_ports { J19[8] }];

##Pmod Header J20
#set_property -dict { PACKAGE_PIN AC12    IOSTANDARD LVCMOS33 } [get_ports { J20[1] }];
#set_property -dict { PACKAGE_PIN AD12    IOSTANDARD LVCMOS33 } [get_ports { J20[3] }];
#set_property -dict { PACKAGE_PIN AE10    IOSTANDARD LVCMOS33 } [get_ports { J20[5] }];
#set_property -dict { PACKAGE_PIN AF10    IOSTANDARD LVCMOS33 } [get_ports { J20[7] }];
#set_property -dict { PACKAGE_PIN AD11    IOSTANDARD LVCMOS33 } [get_ports { J20[2] }];
#set_property -dict { PACKAGE_PIN AD10    IOSTANDARD LVCMOS33 } [get_ports { J20[4] }];
#set_property -dict { PACKAGE_PIN AA11    IOSTANDARD LVCMOS33 } [get_ports { J20[6] }];
#set_property -dict { PACKAGE_PIN AA10    IOSTANDARD LVCMOS33 } [get_ports { J20[8] }];

##Raspberry Pi connector 2x20
#set_property -dict { PACKAGE_PIN AG14   IOSTANDARD LVCMOS33 } [get_ports { J21[7] }];
#set_property -dict { PACKAGE_PIN AB14   IOSTANDARD LVCMOS33 } [get_ports { J21[11] }];
#set_property -dict { PACKAGE_PIN AB9    IOSTANDARD LVCMOS33 } [get_ports { J21[13] }];
#set_property -dict { PACKAGE_PIN Y12    IOSTANDARD LVCMOS33 } [get_ports { J21[15] }];
#set_property -dict { PACKAGE_PIN W14    IOSTANDARD LVCMOS33 } [get_ports { J21[8] }];
#set_property -dict { PACKAGE_PIN W13    IOSTANDARD LVCMOS33 } [get_ports { J21[10] }];
#set_property -dict { PACKAGE_PIN Y14    IOSTANDARD LVCMOS33 } [get_ports { J21[12] }];
#set_property -dict { PACKAGE_PIN AA12   IOSTANDARD LVCMOS33 } [get_ports { J21[16] }];
#set_property -dict { PACKAGE_PIN W12    IOSTANDARD LVCMOS33 } [get_ports { J21[38] }];
#set_property -dict { PACKAGE_PIN W11    IOSTANDARD LVCMOS33 } [get_ports { J21[40] }];
#set_property -dict { PACKAGE_PIN AH14   IOSTANDARD LVCMOS33 } [get_ports { J21[29] }];
#set_property -dict { PACKAGE_PIN AG13   IOSTANDARD LVCMOS33 } [get_ports { J21[31] }];
#set_property -dict { PACKAGE_PIN AB13   IOSTANDARD LVCMOS33 } [get_ports { J21[33] }];
#set_property -dict { PACKAGE_PIN Y13    IOSTANDARD LVCMOS33 } [get_ports { J21[35] }];
#set_property -dict { PACKAGE_PIN AA8    IOSTANDARD LVCMOS33 } [get_ports { CPU_RESETN }]; #J21[22]
