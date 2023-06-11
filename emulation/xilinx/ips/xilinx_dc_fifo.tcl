# Copyright 2021 OpenHW Group
# Solderpad Hardware License, Version 2.1, see LICENSE.md for details.
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
set ipName xilinx_dc_fifo

create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name $ipName

set_property -dict [list \
  CONFIG.Enable_Reset_Synchronization {false} \
  CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} \
  CONFIG.Input_Data_Width {36} \
  CONFIG.Input_Depth {2048} \
  CONFIG.Output_Data_Width {36} \
  CONFIG.Performance_Options {First_Word_Fall_Through} \
  CONFIG.Valid_Flag {true} \
] [get_ips $ipName]
