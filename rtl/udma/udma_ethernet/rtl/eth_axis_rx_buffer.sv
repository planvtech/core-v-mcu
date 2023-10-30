///////////////////////////////////////////////////////////////////////////////
//
// Description: AXIS_Buffer for 8 to 32 data width
//
///////////////////////////////////////////////////////////////////////////////
//
// Authors    : mkdigitals (mustafa.karadayi@planv.tech)
//
///////////////////////////////////////////////////////////////////////////////
//  
//      The goal is to transmit 8 bit stream to 32 bit one, the transition 
//      should be done on the write data of the fifo so that the read can be continuous, since it is designed 
//      for a fast write clock and a slow read clock.
//      The logic should listen the data to be written and concatanate it to 32 bit as the stream goes,
//      In case of a tlast, the write count data should be set accordingly and the write signal should go up.
//      Tuser should be passed transparently, tready is driven directly from the fifo, the operation depends on
//      both tready and tvalid to be high!
//
//      note: altering this module quickly for single byte operation, will return word operation as soon as possible 

module eth_axis_rx_buffer 
(
    input   logic           s_clk_i,
    input   logic           s_rstn_i,
    input   logic   [7:0]   s_axis_tdata,
    input   logic           s_axis_tvalid,
    input   logic           s_axis_tuser,
    input   logic           s_axis_tlast,
    output  logic           s_axis_tready,

    input   logic           m_clk_i,
    input   logic           m_rstn_i,
    output  logic   [31:0]  m_axis_tdata,
    output  logic   [1:0]   m_axis_byte_count,
    output  logic           m_axis_tvalid,
    output  logic           m_axis_tuser,
    output  logic           m_axis_tlast,
    input   logic           m_axis_tready
    );

    logic           buffer_wr_en;
    logic   [35:0]  buffer_data_o;
    logic   [35:0]  buffer_data_i;
    logic   [1:0]   queue = 2'h0;
    logic   [1:0]   read_data_byte_count = 2'b00;
    logic           fifo_full;
    xilinx_dc_fifo dc_fifo_rx(
    .wr_clk(s_clk_i),    //input  logic                  
    .wr_rst(~s_rstn_i),   //input  logic                  
    .din(buffer_data_i),   //input  logic [DATA_WIDTH-1:0] 
    .wr_en(buffer_wr_en),  //input  logic                  
    .full(fifo_full),  //output logic                  
    .rd_clk(m_clk_i),    //input  logic                  
    .rd_rst(~m_rstn_i),   //input  logic
    .empty(),                 
    .dout(buffer_data_o[35:0]),   //output logic [DATA_WIDTH-1:0] 
    .valid(m_axis_tvalid),  //output logic                  
    .rd_en(m_axis_tready)   //input  logic                  
    );
    assign s_axis_tready = ~fifo_full;
    logic [7:0] byte_n_0 = 8'h0;
    logic [7:0] byte_n_1 = 8'h0;
    logic [7:0] byte_n_2 = 8'h0;
    logic       tuser_reg   =   1'b0;

    assign m_axis_tdata[31:0] = buffer_data_o[31:0];
    assign m_axis_tuser = buffer_data_o[35];
    assign m_axis_tlast = buffer_data_o[34];
    assign m_axis_byte_count[1:0] = buffer_data_o[33:32];

    // always_ff @( posedge s_clk_i or negedge s_rstn_i ) begin : count_and_shift
    //     if(!s_rstn_i)
    //     begin
    //         read_data_byte_count[1:0]   <=  2'h0;
    //         byte_n_0[7:0]               <=  8'h0;
    //         byte_n_1[7:0]               <=  8'h0;
    //         byte_n_2[7:0]               <=  8'h0;  
    //         tuser_reg                   <=  1'b0;
    //     end
    //     else
    //     begin
    //         if(s_axis_tready & s_axis_tvalid)
    //         begin
    //             tuser_reg <= s_axis_tuser ? 1'b1 : tuser_reg;

    //             if(s_axis_tlast)
    //             begin
    //                 read_data_byte_count <= 2'h0;
    //                 tuser_reg <= 1'b0;
    //             end
    //             else
    //             begin
    //                 if(read_data_byte_count == 2'h3)
    //                 begin
    //                     read_data_byte_count <= 2'h0;
    //                     tuser_reg <= 1'b0;
    //                 end
    //                 else
    //                 begin
    //                     read_data_byte_count <= read_data_byte_count + 2'h1;
    //                 end
    //             end

    //             //byte_n_0[7:0] <= read_data_byte_count[1:0] == 2'h0 ? s_axis_tdata[7:0] : byte_n_0[7:0];
    //             //byte_n_1[7:0] <= read_data_byte_count[1:0] == 2'h1 ? s_axis_tdata[7:0] : byte_n_1[7:0];
    //             //byte_n_2[7:0] <= read_data_byte_count[1:0] == 2'h2 ? s_axis_tdata[7:0] : byte_n_2[7:0];
    //         end
    //     end
    // end

    always_comb begin : set_data_and_valid

        buffer_data_i <= {(tuser_reg | s_axis_tuser), 
                            s_axis_tlast, 
                            read_data_byte_count[1:0], 
                            byte_n_2, byte_n_1, byte_n_0, s_axis_tdata};

        buffer_wr_en <= s_axis_tready & s_axis_tvalid; // & (read_data_byte_count == 2'h3 | s_axis_tlast);
    end
endmodule