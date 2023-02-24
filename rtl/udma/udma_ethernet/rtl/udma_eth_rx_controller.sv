///////////////////////////////////////////////////////////////////////////////
//
// Description: ETHERNET rx operations controller for single byte transfers
//
///////////////////////////////////////////////////////////////////////////////
//
// Author    : Mustafa Karadayi(PlanV    -   mustafa.karadayi@planv.tech)
//
///////////////////////////////////////////////////////////////////////////////
module udma_eth_rx_controller #(
    parameter L2_AWIDTH_NOAL = 12,
    parameter TRANS_SIZE     = 16
)
(
    //////////////// system clk and its associated reset
    input   logic                      sys_clk_i,
    input   logic                      sys_rstn_i,
    //////////////// 125MHz clk and its associated reset
    input   logic                      eth_clk_i,
    input   logic                      eth_rstn_i,
    ////////////// interface to core //////////////////////////
    output  logic [L2_AWIDTH_NOAL-1:0]  cfg_rx_startaddr_o,
    output  logic     [TRANS_SIZE-1:0]  cfg_rx_size_o,
    output  logic                [1:0]  cfg_rx_datasize_o,
    output  logic                       cfg_rx_continuous_o,
    output  logic                       cfg_rx_en_o,
    output  logic                       cfg_rx_clr_o,
    input   logic                       cfg_rx_en_i,
    input   logic                       cfg_rx_pending_i,
    input   logic [L2_AWIDTH_NOAL-1:0]  cfg_rx_curr_addr_i,
    input   logic     [TRANS_SIZE-1:0]  cfg_rx_bytes_left_i,

    ////////////// interface with the register control ////////

    input   logic [L2_AWIDTH_NOAL-1:0]  reg_rx_startaddr_i,
    input   logic                       reg_rx_continuous_i,
    input   logic                       reg_rx_clr_i,
    output  logic                       reg_rx_en_o,
    output  logic                       reg_rx_pending_o,
    output  logic [L2_AWIDTH_NOAL-1:0]  reg_rx_curr_addr_o,
    output  logic     [TRANS_SIZE-1:0]  reg_rx_bytes_left_o,

    ///////////// udma data channel control  /////////////////////
    
    input   logic   rx_buffer_ready_i,
    output  logic   rx_buffer_rd_en_o,
    input   logic   rx_buffer_valid_i,
    ////////////// eth axis channel monitor///////////////////////

    input  logic                      s_axis_tvalid_i,
    input  logic                      s_axis_tlast_i,
    input  logic                      s_axis_tready_i,

    //////////////  rx_interrupt        //////////////////////////////
    output logic                       eth_rx_event,
    output logic                       eth_error_event,
    //////////////  packet_queue_ready    //////////////////////////////
    output logic                       packet_queue_ready_o
);

///////////////////////////////// eth ip side /////////////////////////
logic [10:0]    size_cnt            = 'h0;
logic [10:0]    eth_packet_size     = 'h0;
logic           eth_packet_valid    =  1'b0;

always_ff @(posedge eth_clk_i or negedge eth_rstn_i ) begin : size_detect
    if(!eth_rstn_i)
    begin
            size_cnt <= 'h0;
            eth_packet_size <= 'h0;
            eth_packet_valid <= 'h0;
    end
    else
    begin
        if(s_axis_tvalid_i & s_axis_tready_i)
        begin
            
            if(s_axis_tlast_i)
            begin
                eth_packet_size <= size_cnt + 1;
                eth_packet_valid <= 1'b1;
                size_cnt <= 11'h0;
            end
            else
            begin
                size_cnt <= size_cnt + 11'h1;
                eth_packet_valid <= 1'b0;
            end
        end
        else
        begin
            eth_packet_valid <= 1'b0;
        end
    end
end
///////////////////////////////////////////////////////////////////////
/////////////////////// udma read channel side/////////////////////////
localparam  STATE_IDLE   = 2'b00,
            STATE_STREAM = 2'b01;

logic        [1:0]  state = STATE_IDLE;
logic               packet_queue_out_ready = 1'b0;
logic       [10:0]  packet_queue_out_data;
logic       [10:0]  udma_rx_count = 11'h0;
logic               packet_queue_out_valid;
always_ff @( posedge sys_clk_i or negedge sys_rstn_i ) begin : receive_control
    if(!sys_rstn_i)
    begin
        udma_rx_count <= 11'h0;
    end
    else
    begin
        case(state)
            STATE_IDLE:
            begin
                eth_rx_event <= 1'b0;
                if(packet_queue_out_valid)
                begin
                    if(packet_queue_out_data != 11'h0)
                    begin
                        cfg_rx_en_o <= 1'b1;
                        cfg_rx_size_o <= packet_queue_out_data;
                        state <= STATE_STREAM;
                        rx_buffer_rd_en_o <= 1'b1;
                        udma_rx_count <= 11'h1;
                    end
                    packet_queue_out_ready <= 1'b1;
                end
                else
                begin
                    packet_queue_out_ready <= 1'b0;
                    cfg_rx_en_o <= 1'b0;
                    rx_buffer_rd_en_o <= 1'b0;    
                end
            end

            STATE_STREAM:
            begin
                packet_queue_out_ready <= 1'b0;
                if(rx_buffer_ready_i & rx_buffer_valid_i)
                begin
                    if(udma_rx_count == cfg_rx_size_o) 
                    begin
                        udma_rx_count <= 11'h0;
                        rx_buffer_rd_en_o <= 1'b0;
                        state <= STATE_IDLE;
                        eth_rx_event <= 1'b1;
                    end
                    else
                    begin
                        udma_rx_count <= udma_rx_count + 11'h1;
                    end
                end
            end
        endcase
    end
end
///////////////////////////////////////////////////////////////////////
udma_dc_fifo #(
.DATA_WIDTH(11),
.BUFFER_DEPTH(32)
) packet_queue(
.src_clk_i(eth_clk_i),    //input  logic                  
.src_rstn_i(eth_rstn_i),   //input  logic                  
.src_data_i(eth_packet_size),   //input  logic [DATA_WIDTH-1:0] 
.src_valid_i(eth_packet_valid),  //input  logic                  
.src_ready_o(packet_queue_ready_o),  //output logic                  
.dst_clk_i(sys_clk_i),    //input  logic                  
.dst_rstn_i(sys_rstn_i),   //input  logic                  
.dst_data_o(packet_queue_out_data),   //output logic [DATA_WIDTH-1:0] 
.dst_valid_o(packet_queue_out_valid),  //output logic                  
.dst_ready_i(packet_queue_out_ready)   //input  logic                  
);

/////////////////////////////// signal reroutings ////////////////////

assign cfg_rx_startaddr_o = reg_rx_startaddr_i;
assign cfg_rx_continuous_o = reg_rx_continuous_i;
assign cfg_rx_clr_o = reg_rx_clr_i;
assign reg_rx_en_o = cfg_rx_en_i;
assign reg_rx_pending_o = cfg_rx_pending_i;
assign reg_rx_curr_addr_o = cfg_rx_curr_addr_i;
assign reg_rx_bytes_left_o = cfg_rx_bytes_left_i;
assign cfg_rx_datasize_o = 2'b00;
endmodule