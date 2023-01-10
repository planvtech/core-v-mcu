// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

///////////////////////////////////////////////////////////////////////////////
//
// Description: ETHERNET top level
//
///////////////////////////////////////////////////////////////////////////////
//
// Authors    : Antonio Pullini (pullinia@iis.ee.ethz.ch)
//
// Edited By    : Mustafa Karadayi(PlanV    -   mustafa.karadayi@planv.tech)
//
///////////////////////////////////////////////////////////////////////////////

module udma_ethernet_top #(
    parameter L2_AWIDTH_NOAL = 12,
    parameter TRANS_SIZE     = 16
) (
    input  logic                      sys_clk_i,
    input  logic                      periph_clk_i, //probably no usage, we will need another clock
	input  logic   	                  rstn_i,

    input   logic                     rgmii_rx_clk,
    input   logic             [3:0]   rgmii_rxd,
    input   logic                     rgmii_rx_ctl,
    output  logic                     rgmii_tx_clk,
    output  logic             [3:0]   rgmii_txd,
    output  logic                     rgmii_tx_ctl,
    output  logic                     mac_gmii_tx_en,

    output logic                      rx_char_event_o,
    output logic                      err_event_o,

	input  logic               [31:0] cfg_data_i,
	input  logic                [4:0] cfg_addr_i,
	input  logic                      cfg_valid_i,
	input  logic                      cfg_rwn_i,
	output logic                      cfg_ready_o,
    output logic               [31:0] cfg_data_o,

    output logic [L2_AWIDTH_NOAL-1:0] cfg_rx_startaddr_o,       // no operational usage !
    output logic     [TRANS_SIZE-1:0] cfg_rx_size_o,            // no operational usage ! 
    output logic                [1:0] cfg_rx_datasize_o,        // no operational usage !
    output logic                      cfg_rx_continuous_o,      // no operational usage !
    output logic                      cfg_rx_en_o,              // no operational usage !
    output logic                      cfg_rx_clr_o,             // no operational usage !
    input  logic                      cfg_rx_en_i,              // no operational usage !
    input  logic                      cfg_rx_pending_i,         // no operational usage !
    input  logic [L2_AWIDTH_NOAL-1:0] cfg_rx_curr_addr_i,       // no operational usage !
    input  logic     [TRANS_SIZE-1:0] cfg_rx_bytes_left_i,      // no operational usage !

    output logic [L2_AWIDTH_NOAL-1:0] cfg_tx_startaddr_o,       // no operational usage !
    output logic     [TRANS_SIZE-1:0] cfg_tx_size_o,            // no operational usage !
    output logic                [1:0] cfg_tx_datasize_o,        // no operational usage !
    output logic                      cfg_tx_continuous_o,      // no operational usage !
    output logic                      cfg_tx_en_o,              // no operational usage !
    output logic                      cfg_tx_clr_o,             // no operational usage !
    input  logic                      cfg_tx_en_i,              // no operational usage !
    input  logic                      cfg_tx_pending_i,         // no operational usage !
    input  logic [L2_AWIDTH_NOAL-1:0] cfg_tx_curr_addr_i,       // no operational usage !
    input  logic     [TRANS_SIZE-1:0] cfg_tx_bytes_left_i,      // no operational usage !

    output logic                      data_tx_req_o,
    input  logic                      data_tx_gnt_i,
    output logic                [1:0] data_tx_datasize_o,
    input  logic               [31:0] data_tx_i,
    input  logic                      data_tx_valid_i,
    output logic                      data_tx_ready_o,

    output logic                [1:0] data_rx_datasize_o,       // no operational usage 
    output logic               [31:0] data_rx_o,
    output logic                      data_rx_valid_o,
    input  logic                      data_rx_ready_i

);

    logic               [7:0]  s_eth_status;
    logic                      s_eth_rx_irq_en;
    logic                      s_eth_err_irq_en;
    logic                      s_eth_en_rx;
    logic                      s_eth_en_tx;
    

    
    assign cfg_tx_datasize_o  = 2'b00;
    assign cfg_rx_datasize_o  = 2'b00;
    assign data_tx_datasize_o = 2'b00;
    assign data_rx_datasize_o = 2'b00;

    /*
     * AXI input
     */
    wire    [7:0]   eth_tx_axis_tdata;
    wire            eth_tx_axis_tvalid;
    wire            eth_tx_axis_tready;
    wire            eth_tx_axis_tlast;
    wire            eth_tx_axis_tuser;

    /*
     * AXI output
     */
    wire    [7:0]  eth_rx_axis_tdata;
    wire           eth_rx_axis_tvalid;
    wire           eth_rx_axis_tready;
    wire           eth_rx_axis_tlast;
    wire           eth_rx_axis_tuser;


    wire            eth_mac_gmii_tx_en;

    /*
     * Status
     */
    wire            eth_tx_fifo_overflow;
    wire            eth_tx_fifo_bad_frame;
    wire            eth_tx_fifo_good_frame;
    wire            eth_rx_error_bad_frame;
    wire            eth_rx_error_bad_fcs;
    wire            eth_rx_fifo_overflow; //tied
    wire            eth_rx_fifo_bad_frame; //tied
    wire            eth_rx_fifo_good_frame; //tied
    wire    [1:0]   eth_speed; //tied
    wire    [31:0]  eth_rx_fcs_reg; //tied
    wire    [31:0]  eth_tx_fcs_reg; //tied
    wire    [7:0]   eth_status = {eth_tx_fifo_overflow, /
                                eth_tx_fifo_bad_frame, /
                                eth_tx_fifo_good_frame, /
                                eth_rx_error_bad_frame, /
                                eth_rx_error_bad_fcs, /
                                eth_rx_fifo_overflow, /
                                eth_rx_fifo_bad_frame, /
                                eth_rx_fifo_good_frame};
    /*
     * Configuration
     */
    wire    [7:0]   eth_ifg_delay = 'h0; //arrange setup for this data within register interface



    udma_uart_ethernet_if #(
        .L2_AWIDTH_NOAL(L2_AWIDTH_NOAL),
        .TRANS_SIZE(TRANS_SIZE)
    ) u_reg_if (
        .clk_i              ( sys_clk_i           ),
        .rstn_i             ( rstn_i              ),

        .cfg_data_i         ( cfg_data_i          ),
        .cfg_addr_i         ( cfg_addr_i          ),
        .cfg_valid_i        ( cfg_valid_i         ),
        .cfg_rwn_i          ( cfg_rwn_i           ),
        .cfg_ready_o        ( cfg_ready_o         ),
        .cfg_data_o         ( cfg_data_o          ),

        .cfg_rx_startaddr_o ( cfg_rx_startaddr_o  ),
        .cfg_rx_size_o      ( cfg_rx_size_o       ),
        .cfg_rx_continuous_o( cfg_rx_continuous_o ),
        .cfg_rx_en_o        ( cfg_rx_en_o         ),
        .cfg_rx_clr_o       ( cfg_rx_clr_o        ),
        .cfg_rx_en_i        ( cfg_rx_en_i         ),
        .cfg_rx_pending_i   ( cfg_rx_pending_i    ),
        .cfg_rx_curr_addr_i ( cfg_rx_curr_addr_i  ),
        .cfg_rx_bytes_left_i( cfg_rx_bytes_left_i ),

        .cfg_tx_startaddr_o ( cfg_tx_startaddr_o  ),
        .cfg_tx_size_o      ( cfg_tx_size_o       ),
        .cfg_tx_continuous_o( cfg_tx_continuous_o ),
        .cfg_tx_en_o        ( cfg_tx_en_o         ),
        .cfg_tx_clr_o       ( cfg_tx_clr_o        ),
        .cfg_tx_en_i        ( cfg_tx_en_i         ),
        .cfg_tx_pending_i   ( cfg_tx_pending_i    ),
        .cfg_tx_curr_addr_i ( cfg_tx_curr_addr_i  ),
        .cfg_tx_bytes_left_i( cfg_tx_bytes_left_i ),

        .status_i           ( eth_status        ),
        .speed_i            ( eth_speed         ),
        .rx_fcs_i           ( eth_rx_fcs_reg    ),
        .tx_fcs_i           ( eth_tx_fcs_reg    ),
        .rx_irq_en_o        ( s_eth_rx_irq_en   ),
        .err_irq_en_o       ( s_eth__err_irq_en ),
        .en_rx_o			( s_eth_en_rx       ),
        .en_tx_o			( s_eth_en_tx       )
    );




    rgmii_soc rgmii_soc1
    (
    .rst_int(rst_int),
    .clk_int(clk_int),
    .clk90_int(clk90_int),
    .clk_200_int(clk_200_int),
    /*
        * Ethernet: 1000BASE-T RGMII
        */
    .phy_rx_clk(phy_rx_clk),
    .phy_rxd(phy_rxd),
    .phy_rx_ctl(phy_rx_ctl),
    .phy_tx_clk(phy_tx_clk),
    .phy_txd(phy_txd),
    .phy_tx_ctl(phy_tx_ctl),
    .phy_reset_n(phy_reset_n),
    .phy_int_n(phy_int_n),
    .phy_pme_n(phy_pme_n),
    .mac_gmii_tx_en(mac_gmii_tx_en),
    .tx_axis_tdata(tx_axis_tdata),
    .tx_axis_tvalid(tx_axis_tvalid),
    .tx_axis_tready(tx_axis_tready),
    .tx_axis_tlast(tx_axis_tlast),
    .tx_axis_tuser(tx_axis_tuser),
    .rx_axis_tdata(rx_axis_tdata),
    .rx_axis_tvalid(rx_axis_tvalid),
    .rx_axis_tlast(rx_axis_tlast),
    .rx_axis_tuser(rx_axis_tuser),
    .rx_fcs_reg(rx_fcs_reg),
    .tx_fcs_reg(tx_fcs_reg)
    );


    assign data_rx_o[31:8] = 'h0;

endmodule // udma_ethernet_top
