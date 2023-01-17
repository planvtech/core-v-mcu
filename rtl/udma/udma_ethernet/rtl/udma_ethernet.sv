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

module udma_ethernet #(
    parameter L2_AWIDTH_NOAL = 12,
    parameter TRANS_SIZE     = 16,
    parameter DATA_WIDTH     = 8,
    parameter ETHID_WIDTH    = 2
) (
    input  logic                      sys_clk_i,
    input  logic                      periph_clk_i, //probably no usage, we will need another clock
    input  logic                      periph_clk_i_90, //probably no usage, we will need another clock
    input  logic                      ref_clk_i_200, // 200MHz delay gen ref clock
	input  logic   	                  rstn_i,

    /*
     * Ethernet: 1000BASE-T RGMII
     */
    input wire         phy_rx_clk,
    input wire [3:0]   phy_rxd,
    input wire         phy_rx_ctl,
    output wire        phy_tx_clk,
    output wire [3:0]  phy_txd,
    output wire        phy_tx_ctl,
    output wire        phy_reset_n,
    input wire         phy_int_n,
    input wire         phy_pme_n,

    //

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

    input  logic            [DATA_WIDTH-1:0]    ethernet_tx_data_i,
    input  logic                                ethernet_tx_valid_i,
    input  logic                                ethernet_tx_sof_i,
    input  logic                                ethernet_tx_eof_i,
    output logic                                ethernet_tx_ready_o,

    output  logic          [ETHID_WIDTH-1:0]    ethernet_rx_id_o,
    output  logic            [DATA_WIDTH-1:0]   ethernet_rx_data_o,
    output  logic                       [1:0]   ethernet_rx_datasize_o,
    output  logic                               ethernet_rx_valid_o,
    output  logic                               ethernet_rx_sof_o,
    output  logic                               ethernet_rx_eof_o,
    input   logic                               ethernet_rx_ready_i
);

    assign cfg_tx_datasize_o  = 2'b00;
    assign cfg_rx_datasize_o  = 2'b00;

    logic               [7:0]  s_eth_status;
    logic                      s_eth_rx_irq_en;
    logic                      s_eth_err_irq_en;
    logic                      s_eth_en_rx;
    logic                      s_eth_en_tx;
    
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

    /*
     * Status
     */
    wire            eth_tx_fifo_overflow; //tied
    wire            eth_tx_fifo_bad_frame; //tied
    wire            eth_tx_fifo_good_frame; //tied
    wire            eth_rx_error_bad_frame; //tied
    wire            eth_rx_error_bad_fcs; //tied
    wire            eth_rx_fifo_overflow; //tied
    wire            eth_rx_fifo_bad_frame; //tied
    wire            eth_rx_fifo_good_frame; //tied
    wire    [1:0]   eth_speed; //tied
    wire    [31:0]  eth_rx_fcs_reg; //tied
    wire    [31:0]  eth_tx_fcs_reg; //tied
    wire    [7:0]   eth_status = {eth_tx_fifo_overflow,
                                eth_tx_fifo_bad_frame,
                                eth_tx_fifo_good_frame,
                                eth_rx_error_bad_frame,
                                eth_rx_error_bad_fcs,
                                eth_rx_fifo_overflow,
                                eth_rx_fifo_bad_frame,
                                eth_rx_fifo_good_frame};
    //CONFIGURATION
    wire        mac_gmii_tx_en = s_eth_en_tx;

    //TX CHANNEL ASSIGNMENTS
    assign  eth_tx_axis_tdata[7:0]  =   ethernet_tx_data_i[7:0];
    assign  eth_tx_axis_tvalid      =   ethernet_tx_valid_i;
    assign  eth_tx_axis_tuser       =   ethernet_tx_sof_i;
    assign  eth_tx_axis_tlast       =   ethernet_tx_eof_i;
    assign  ethernet_tx_ready_o     =   eth_tx_axis_tready;

    //RX CHANNEL ASSIGNMENTS
    assign  ethernet_rx_data_o[7:0]                 =   eth_rx_axis_tdata;
    assign  ethernet_rx_data_o[DATA_WIDTH - 1 : 8]  =   'h0;
    assign  ethernet_rx_valid_o                     =   eth_rx_axis_tvalid;
    assign  ethernet_rx_sof_o                       =   eth_rx_axis_tuser;
    assign  ethernet_rx_eof_o                       =   eth_rx_axis_tlast;
    assign  eth_rx_axis_tready                      =   ethernet_rx_ready_i;


    udma_ethernet_reg_if #(
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
        .err_irq_en_o       ( s_eth_err_irq_en ),
        .en_rx_o			( s_eth_en_rx       ),
        .en_tx_o			( s_eth_en_tx       )
    );




    rgmii_soc rgmii_soc1
    (
        .rst_int(rst_int),
        .clk_int(periph_clk_i), //125 MHz clock
        .clk90_int(periph_clk_i_90), //125 MHz Clock with 90 degree phase shift
        .clk_200_int(ref_clk_i_200), // 200 MHz clock for inout delays ref_clk
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
        .tx_axis_tdata(eth_tx_axis_tdata),
        .tx_axis_tvalid(eth_tx_axis_tvalid),
        .tx_axis_tready(eth_tx_axis_tready),
        .tx_axis_tlast(eth_tx_axis_tlast),
        .tx_axis_tuser(eth_tx_axis_tuser),
        .rx_axis_tdata(eth_rx_axis_tdata),
        .rx_axis_tvalid(eth_rx_axis_tvalid),
        .rx_axis_tlast(eth_rx_axis_tlast),
        .rx_axis_tuser(eth_rx_axis_tuser),
        .tx_fifo_overflow(eth_tx_fifo_overflow),
        .tx_fifo_bad_frame(eth_tx_fifo_bad_frame),
        .tx_fifo_good_frame(eth_tx_fifo_good_frame),
        .rx_error_bad_frame(eth_rx_error_bad_frame),
        .rx_error_bad_fcs(eth_rx_error_bad_fcs),
        .rx_fcs_reg(eth_rx_fcs_reg),
        .tx_fcs_reg(eth_tx_fcs_reg),
        .rx_fifo_overflow(eth_rx_fifo_overflow),
        .rx_fifo_bad_frame(eth_rx_fifo_bad_frame),
        .rx_fifo_good_frame(eth_rx_fifo_good_frame),
        .speed(eth_speed)
    );

endmodule // udma_ethernet_top
