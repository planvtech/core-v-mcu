///////////////////////////////////////////////////////////////////////////////
//
// Description: ETHERNET tx operations controller for utilizing 4 bytes
//              transfers combined with single byte transfers
//
///////////////////////////////////////////////////////////////////////////////
//
// Author    : Mustafa Karadayi(PlanV    -   mustafa.karadayi@planv.tech)
//
///////////////////////////////////////////////////////////////////////////////
module udma_eth_tx_controller #(
    parameter L2_AWIDTH_NOAL = 12,
    parameter TRANS_SIZE     = 16
)
(
    input   logic                      clk_i,
    input   logic                      rstn_i,
    ////////////// interface to core //////////////////////////
    output  logic [L2_AWIDTH_NOAL-1:0]  cfg_tx_startaddr_o,
    output  logic     [TRANS_SIZE-1:0]  cfg_tx_size_o,
    output  logic                [1:0]  cfg_tx_datasize_o,
    output  logic                       cfg_tx_continuous_o,
    output  logic                       cfg_tx_en_o,
    output  logic                       cfg_tx_clr_o,
    input   logic                       cfg_tx_en_i,
    input   logic                       cfg_tx_pending_i,
    input   logic [L2_AWIDTH_NOAL-1:0]  cfg_tx_curr_addr_i,
    input   logic     [TRANS_SIZE-1:0]  cfg_tx_bytes_left_i,

    ////////////// interface with the register control ////////

    input   logic [L2_AWIDTH_NOAL-1:0]  reg_tx_startaddr_i,
    input   logic     [TRANS_SIZE-1:0]  reg_tx_size_i,
    input   logic                       reg_tx_continuous_i,
    input   logic                       reg_tx_en_i,
    input   logic                       reg_tx_clr_i,
    output  logic                       reg_tx_en_o,
    output  logic                       reg_tx_pending_o,
    output  logic [L2_AWIDTH_NOAL-1:0]  reg_tx_curr_addr_o,
    output  logic     [TRANS_SIZE-1:0]  reg_tx_bytes_left_o,

    output  logic                       busy_o,

    ///////////// udma data channel /////////////////////
    
    output  logic                      data_tx_req_o,
    input   logic                      data_tx_gnt_i,
    output  logic                [1:0] data_tx_datasize_o,
    input   logic               [31:0] data_tx_i,
    input   logic                      data_tx_valid_i,
    output  logic                      data_tx_ready_o,

    ////////////// eth axis channel ///////////////////////

    output  logic               [31:0] m_axis_tdata_o,
    output  logic                [1:0] m_axis_tsize_o,
    output  logic                      m_axis_tvalid_o,
    output  logic                      m_axis_tuser_o,
    output  logic                      m_axis_tlast_o,
    input   logic                      m_axis_tready_i 
);

logic [1:0] state = 2'b00;
logic [1:0] remainder = 2'b00;
localparam STATE_IDLE           =   2'b00,
           STATE_WAIT_GNT       =   2'b01,
           STATE_TRANSMIT_WORDS =   2'b10,
           STATE_TRANSMIT_BYTES =   2'b11;

assign busy_o   = state != STATE_IDLE & reg_tx_en_o;            

always_ff @( posedge clk_i or negedge rstn_i ) begin : state_machine
    if(!rstn_i)
    begin
        state <= STATE_IDLE;
        remainder <= 2'b00;
    end
    else
    begin
        case(state)
        STATE_IDLE:     // fetch the instruction and raise the data_tx_req_o
        begin
            if(reg_tx_en_o)
            begin
                if(reg_tx_size_i > 'h3)
                begin
                    cfg_tx_size_o <= {reg_tx_size_i[TRANS_SIZE-1:2], 2'b00};
                    cfg_tx_datasize_o <= 2'h3;
                    data_tx_datasize_o <= 2'h3;
                end
                else
                begin
                    cfg_tx_size_o <= reg_tx_size_i;
                    cfg_tx_datasize_o <= 2'h0;
                    data_tx_datasize_o <= 2'h0;
                end
                cfg_tx_en_o <= 1'b1;
                state <= STATE_WAIT_GNT;
                remainder <= reg_tx_size_i[1:0];
                data_tx_req_o <= 1'b1;
                cfg_tx_startaddr_o <= reg_tx_startaddr_i;
                m_axis_tuser_o <= 1'b1;
            end

            
        end

        STATE_WAIT_GNT: 
        begin
            cfg_tx_en_o <= 1'b0;
            if(data_tx_gnt_i)
            begin
                data_tx_req_o <= 1'b0;
                if(cfg_tx_datasize_o <= 2'h3)
                begin
                    state <= STATE_TRANSMIT_WORDS;
                end
                else
                begin
                    state <= STATE_TRANSMIT_BYTES;    
                end
            end
        end

        STATE_TRANSMIT_WORDS:
        begin
            
            if(cfg_tx_bytes_left_i == 'h0) //exit condition
            begin
                if(remainder == 2'h0)
                begin
                    state <= STATE_IDLE;
                end
                else
                begin
                    cfg_tx_size_o[TRANS_SIZE-1 : 2] <= 'h0;
                    cfg_tx_datasize_o <= 2'h0;
                    data_tx_datasize_o <= 2'h0;
                    cfg_tx_en_o <= 1'b1;
                    state <= STATE_WAIT_GNT;
                    data_tx_req_o <= 1'b1;
                    cfg_tx_startaddr_o <= cfg_tx_startaddr_o + cfg_tx_size_o;
                end
            end

            m_axis_tuser_o <= data_tx_valid_i ? 1'b0 : m_axis_tuser_o;

        end

        STATE_TRANSMIT_BYTES:
        begin

            remainder <= 2'h0;

            if(cfg_tx_bytes_left_i == 'h0) //exit condition
            begin
                state <= STATE_IDLE;
            end

            m_axis_tuser_o <= data_tx_valid_i ? 1'b0 : m_axis_tuser_o;
        end
        endcase
    end //end of reset if
end //end of state_machine

always_comb begin : data_and_indicator_connections
    m_axis_tdata_o[31:0] <= data_tx_i[31:0];
    m_axis_tsize_o <= cfg_tx_datasize_o;
    m_axis_tvalid_o <= data_tx_valid_i;
    data_tx_ready_o <= m_axis_tready_i;
    m_axis_tlast_o <= remainder == 2'b00 &  cfg_tx_bytes_left_i == 'h0 & data_tx_valid_i;

    cfg_tx_continuous_o <=  reg_tx_continuous_i;
    cfg_tx_clr_o        <=  reg_tx_clr_i;
    reg_tx_en_o         <=  cfg_tx_en_i;
    reg_tx_pending_o    <=  cfg_tx_pending_i;
    reg_tx_curr_addr_o  <=  cfg_tx_curr_addr_i;
    reg_tx_bytes_left_o <=  cfg_tx_bytes_left_i;
end

endmodule