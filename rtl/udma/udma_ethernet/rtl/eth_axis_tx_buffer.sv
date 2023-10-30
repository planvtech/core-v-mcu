///////////////////////////////////////////////////////////////////////////////
//
// Description: AXIS_Buffer for 32 to 8 data width
//
///////////////////////////////////////////////////////////////////////////////
//
// Authors    : mkdigitals (mustafa.karadayi@planv.tech)
//
///////////////////////////////////////////////////////////////////////////////

module eth_axis_tx_buffer 
(
    input   logic           s_clk_i,
    input   logic           s_rstn_i,
    input   logic   [31:0]  s_axis_tdata,
    input   logic   [1:0]   s_axis_byte_count,
    input   logic           s_axis_tvalid,
    input   logic           s_axis_tuser,
    input   logic           s_axis_tlast,
    output  logic           s_axis_tready,

    input   logic           m_clk_i,
    input   logic           m_rstn_i,
    output  logic   [7:0]   m_axis_tdata,
    output  logic           m_axis_tvalid,
    output  logic           m_axis_tuser,
    output  logic           m_axis_tlast,
    input   logic           m_axis_tready
    );

    logic           buffer_valid_o;
    logic           buffer_rd_en;
    logic   [35:0]  buffer_data_o;
    logic   [1:0]   queue = 2'h0;
    logic   [1:0]   read_data_byte_count;
    logic fifo_full;
    xilinx_dc_fifo dc_fifo_tx(
    .wr_clk(s_clk_i),    //input  logic                  
    .wr_rst(~s_rstn_i),   //input  logic                  
    .din({s_axis_tuser,s_axis_tlast,s_axis_byte_count[1:0],s_axis_tdata[31:0]}),   //input  logic [DATA_WIDTH-1:0] 
    .wr_en(s_axis_tvalid),  //input  logic                  
    .full(fifo_full),  //output logic                  
    .rd_clk(m_clk_i),    //input  logic                  
    .rd_rst(~m_rstn_i),   //input  logic
    .empty(),                  
    .dout(buffer_data_o[35:0]),   //output logic [DATA_WIDTH-1:0] 
    .valid(buffer_valid_o),  //output logic                  
    .rd_en(buffer_rd_en)   //input  logic                  
    );
    assign s_axis_tready = ~fifo_full;
    assign  read_data_byte_count = buffer_data_o[33:32];
    //operation :
    // 32 bits is written in the fifo, we read 8 bits at a time,
    // we have to raise dst_ready_i every 4th clock cycle .
    // when queue is 0 ve raise dst_ready_i and start shifting the output.
    // queue is counting upwards as long as the m_axis_tready signal is high or buffer_valid_o signal is high
    // when queue is 0.
    //
    // 

    assign buffer_rd_en = queue == 2'h0 & m_axis_tready == 1'b1;

    always_ff @(posedge m_clk_i or negedge m_rstn_i) begin : queuing
        if(!m_rstn_i)
        begin
            queue   <=  2'h0;
        end
        else
        begin
            if(m_axis_tready)
            begin
                if(queue == 2'h3)
                begin
                    if(buffer_valid_o)
                    begin
                        queue <= 2'h0;
                    end
                end
                else
                begin
                    queue <= queue + 2'h1;
                end
            end
        end
    end

    always_comb begin : data_routing
        case(queue)
        2'h0:   m_axis_tdata[7:0] <= buffer_data_o[7:0];
        2'h1:   m_axis_tdata[7:0] <= buffer_data_o[15:8];
        2'h2:   m_axis_tdata[7:0] <= buffer_data_o[23:16];
        2'h3:   m_axis_tdata[7:0] <= buffer_data_o[31:24];
        endcase

        m_axis_tuser <= queue == 2'h0 ? buffer_data_o[35] & buffer_valid_o : 1'b0;
        m_axis_tlast <= queue == read_data_byte_count ? buffer_data_o[34] : 1'b0;
        m_axis_tvalid <= queue == 2'h0 ? buffer_valid_o : (queue < read_data_byte_count ? 1'b1 : 1'b0);
    end


endmodule