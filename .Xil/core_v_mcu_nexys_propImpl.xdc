set_property SRC_FILE_INFO {cfile:/media/mkdigitals/d/projects/core-v-mcu/build/openhwgroup.org_systems_core-v-mcu_0/nexys-a7-100t-vivado/openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/xilinx_clk_mngr/xilinx_clk_mngr.xdc rfile:../build/openhwgroup.org_systems_core-v-mcu_0/nexys-a7-100t-vivado/openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/xilinx_clk_mngr/xilinx_clk_mngr.xdc id:1 order:EARLY scoped_inst:i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/inst} [current_design]
set_property SRC_FILE_INFO {cfile:/media/mkdigitals/d/projects/core-v-mcu/build/openhwgroup.org_systems_core-v-mcu_0/nexys-a7-100t-vivado/openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/xilinx_eth_clk_mngr/xilinx_eth_clk_mngr.xdc rfile:../build/openhwgroup.org_systems_core-v-mcu_0/nexys-a7-100t-vivado/openhwgroup.org_systems_core-v-mcu_0.gen/sources_1/ip/xilinx_eth_clk_mngr/xilinx_eth_clk_mngr.xdc id:2 order:EARLY scoped_inst:i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_eth_clk_manager/inst} [current_design]
set_property SRC_FILE_INFO {cfile:/media/mkdigitals/d/projects/core-v-mcu/build/openhwgroup.org_systems_core-v-mcu_0/nexys-a7-100t-vivado/src/openhwgroup.org_systems_core-v-mcu_0/emulation/core-v-mcu-nexys/constraints/core-v-mcu-pin-assignment.xdc rfile:../build/openhwgroup.org_systems_core-v-mcu_0/nexys-a7-100t-vivado/src/openhwgroup.org_systems_core-v-mcu_0/emulation/core-v-mcu-nexys/constraints/core-v-mcu-pin-assignment.xdc id:3} [current_design]
current_instance i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.050
current_instance
current_instance i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_eth_clk_manager/inst
set_property src_info {type:SCOPED_XDC file:2 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.050
current_instance
set_property src_info {type:XDC file:3 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {s_tck}]
