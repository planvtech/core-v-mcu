### Constraint File for the KR260 board


#######################################
#  _______ _           _              #
# |__   __(_)         (_)             #
#    | |   _ _ __ ___  _ _ __   __ _  #
#    | |  | | '_ ` _ \| | '_ \ / _` | #
#    | |  | | | | | | | | | | | (_| | #
#    |_|  |_|_| |_| |_|_|_| |_|\__, | #
#                               __/ | #
#                              |___/  #
#######################################

#Create constraint for the clock input of the nexys board
#create_clock -period 10.000 -name ref_clk [get_ports sys_clk]

#I2S and CAM interface are not used in this FPGA port. Set constraints to
#disable the clock
#set_case_analysis 0 i_core_v_mcu/safe_domain_i/cam_pclk_o
#set_case_analysis 0 i_core_v_mcu/safe_domain_i/i2s_slave_sck_o
#set_input_jitter tck 1.000

## JTAG
create_clock -period 100.000 -name tck -waveform {0.000 50.000} [get_ports xilinx_io[0]]
set_input_jitter tck 1.000
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets xilinx_io[8]]; # was tck_int


# minimize routing delay
set_input_delay -clock tck -clock_fall 5.000 [get_ports xilinx_io[1]]
set_input_delay -clock tck -clock_fall 5.000 [get_ports xilinx_io[3]]
set_output_delay -clock tck 5.000 [get_ports xilinx_io[2]]


set_max_delay -to [get_ports xilinx_io[2]] 20.000
set_max_delay -from [get_ports xilinx_io[3]] 20.000
set_max_delay -from [get_ports xilinx_io[1]] 20.000


##set_max_delay -datapath_only -from [get_pins i_core_v_mcu/i_soc_domain_i/i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_src/data_src_q_reg/C] -to [get_pins i_core_v_mcu/i_soc_domain_i/i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_dst/data_dst_q_reg*/D] 20.000
##set_max_delay -datapath_only -from [get_pins i_core_v_mcu/i_soc_domain_i/i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_src/req_src_q_reg/C] -to [get_pins i_core_v_mcu/i_soc_domain_i/i_dmi_jtag/i_dmi_cdc/i_cdc_resp/i_dst/req_dst_q_reg/D] 20.000
##set_max_delay -datapath_only -from [get_pins i_core_v_mcu/i_soc_domain_i/i_dmi_jtag/i_dmi_cdc/i_cdc_req/i_dst/ack_dst_q_reg/C] -to [get_pins i_core_v_mcu/i_soc_domain_i/i_dmi_jtag/i_dmi_cdc/i_cdc_req/i_src/ack_src_q_reg/D] 20.000


# reset signal
set_false_path -from [get_ports xilinx_io[8]]

# Set ASYNC_REG attribute for ff synchronizers to place them closer together and
# increase MTBF
set_property ASYNC_REG TRUE [get_cells i_core_v_mcu/i_soc_domain/soc_peripherals_i/i_apb_adv_timer/u_tim0/u_in_stage/r_ls_clk_sync_reg*]
set_property ASYNC_REG TRUE [get_cells i_core_v_mcu/i_soc_domain/soc_peripherals_i/i_apb_adv_timer/u_tim1/u_in_stage/r_ls_clk_sync_reg*]
set_property ASYNC_REG TRUE [get_cells i_core_v_mcu/i_soc_domain/soc_peripherals_i/i_apb_adv_timer/u_tim2/u_in_stage/r_ls_clk_sync_reg*]
set_property ASYNC_REG TRUE [get_cells i_core_v_mcu/i_soc_domain/soc_peripherals_i/i_apb_adv_timer/u_tim3/u_in_stage/r_ls_clk_sync_reg*]
set_property ASYNC_REG TRUE [get_cells i_core_v_mcu/i_soc_domain/soc_peripherals_i/i_apb_timer_unit/s_ref_clk*]
set_property ASYNC_REG TRUE [get_cells i_core_v_mcu/i_soc_domain/soc_peripherals_i/i_ref_clk_sync/i_pulp_sync/r_reg_reg*]
set_property ASYNC_REG TRUE [get_cells i_core_v_mcu/i_soc_domain/soc_peripherals_i/u_evnt_gen/r_ls_sync_reg*]

# Create asynchronous clock group between slow-clk and SoC clock, per clock and eFPGA clock  . Those clocks
# are considered asynchronously and proper synchronization regs are in place
#set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins i_slow_clk_gen/ref_clk_o]] -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out*]]

## mkdigitals : slow clock is not recognized as clock
# Create asynchronous clock group between slow-clk and eth clocks. Those clocks 
# are considered asynchronously and proper synchronization regs are in place
#set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins i_slow_clk_gen/ref_clk_o]] -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out*]]

# Create asynchronous clock group between Per Clock  and SoC clock. Those clocks
# are considered asynchronously and proper synchronization regs are in place
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out2]] -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out1]]

# Create asynchronous clock group between eFPGA Clock  and SoC clock. Those clocks
# are considered asynchronously and proper synchronization regs are in place
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out3]] -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out1]]

# Create asynchronous clock group between SoC domain Clocks  and Eth clocks. Those clocks
# are considered asynchronously and proper synchronization regs are in place
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out*]] -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_eth_clk_manager/clk_out*]]


# Create asynchronous clock group between JTAG TCK and Generated clocks.
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_ports xilinx_io[0]]] -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_clk_manager/clk_out*]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_ports xilinx_io[0]]] -group [get_clocks -of_objects [get_pins i_core_v_mcu/i_soc_domain/i_clk_rst_gen/clk_gen_i/i_eth_clk_manager/clk_out*]]

#set_multicycle_path -from [get_ports {xilinx_io[6]}] -to [get_pins {*}] 1