///////////////////////////////////////////////////////////////////////////////
//
// Description: SMI top level
//
///////////////////////////////////////////////////////////////////////////////
//
// Authors    : Mustafa Karadayi (mustafa.karadayi@planv.tech)
//
///////////////////////////////////////////////////////////////////////////////

module udma_smi_top
(
    input  logic                      sys_clk_i,
	input  logic   	                  rstn_i,

	input  logic                      mdi_i,
    output logic			          mdo_o,
    output logic			          md_oen_o,
    output logic 			          mdc_o,
    output wire                       phy_reset_n,

	input  logic               [31:0] cfg_data_i,
	input  logic                [4:0] cfg_addr_i,
	input  logic                      cfg_valid_i,
	input  logic                      cfg_rwn_i,
	output logic                      cfg_ready_o,
    output logic               [31:0] cfg_data_o
);

    logic           s_start;
    logic           s_busy;
    logic           s_nd;
    logic           s_rw;
    logic   [4:0]   s_phy_addr;
    logic   [4:0]   s_reg_addr;
    logic   [15:0]  s_wr_data;
    logic   [15:0]  s_rd_data;

    udma_smi_reg_if u_reg_if 
    (
        .clk_i              ( sys_clk_i           ),
        .rstn_i             ( rstn_i              ),

        .cfg_data_i         ( cfg_data_i          ),
        .cfg_addr_i         ( cfg_addr_i          ),
        .cfg_valid_i        ( cfg_valid_i         ),
        .cfg_rwn_i          ( cfg_rwn_i           ),
        .cfg_ready_o        ( cfg_ready_o         ),
        .cfg_data_o         ( cfg_data_o          ),
        .start_o(s_start),
        .busy_i(s_busy),
        .nd_i(s_nd),
        .rw_o(s_rw),
        .phy_reset_n(phy_reset_n),
        .phy_addr_o(s_phy_addr),
        .reg_addr_o(s_reg_addr),
        .wr_data_o(s_wr_data),
        .rd_data_i(s_rd_data)
    );

    udma_smi_ctrl u_ctrl
    (
        .clk_i(sys_clk_i),
        .rstn_i(rstn_i),
        .mdi_i(mdi_i),
        .mdo_o(mdo_o),
        .md_oen_o(md_oen_o),
        .mdc_o(mdc_o),
        .start_i(s_start),
        .busy_o(s_busy),
        .nd_o(s_nd),
        .rw_i(s_rw),
        .phy_addr_i(s_phy_addr),
        .reg_addr_i(s_reg_addr),
        .wr_data_i(s_wr_data),
        .rd_data_o(s_rd_data)
    );
    

endmodule // udma_uart_top
