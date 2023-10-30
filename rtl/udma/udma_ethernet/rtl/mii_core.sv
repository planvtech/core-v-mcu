/*

Copyright (c) 2014-2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

/*
 * FPGA core logic
 */
module mii_core #
(
    parameter TARGET = "GENERIC" //mkdigitals altered this line, org: parameter TARGET = "XILINX"
)
(
    /*
     * Clock: 125MHz
     * Synchronous reset
     */
    input wire         clk,
    input wire         rst,

    /*
     * Ethernet: 1000BASE-T RGMII
     */
    input  wire        phy_rx_clk,
    input  wire [3:0]  phy_rxd,
    input  wire        phy_rx_dv,
    input  wire        phy_rx_er,
    input  wire        phy_tx_clk,
    output wire [3:0]  phy_txd,
    output wire        phy_tx_en,
    output wire        phy_tx_er,

       /*
        * AXI input
        */
 
    input wire         tx_axis_tvalid,
    input wire         tx_axis_tlast,
    input wire [7:0]   tx_axis_tdata,
    output wire        tx_axis_tready,
    input wire         tx_axis_tuser,
   
       /*
        * AXI output
        */
 
    output wire [7:0]  rx_axis_tdata,
    output wire        rx_axis_tvalid,
    output wire        rx_axis_tlast,
    output wire        rx_axis_tuser,

    /*
     * Status
     */

    output wire        tx_fifo_overflow,
    output wire        tx_fifo_bad_frame,
    output wire        tx_fifo_good_frame,
    output wire        rx_error_bad_frame,
    output wire        rx_error_bad_fcs,
    output wire        rx_fifo_overflow,
    output wire        rx_fifo_bad_frame,
    output wire        rx_fifo_good_frame

);

assign phy_reset_n = !rst;

eth_mac_mii_fifo #(
    .TARGET(TARGET),
    .CLOCK_INPUT_STYLE("BUFR"),
    .AXIS_DATA_WIDTH(8),
    .ENABLE_PADDING(1),
    .MIN_FRAME_LENGTH(8), ////mkdigitals altered this line, org: .MIN_FRAME_LENGTH(64),
    .TX_FIFO_DEPTH(4096),
    .TX_FRAME_FIFO(1),
    .RX_FIFO_DEPTH(4096),
    .RX_FRAME_FIFO(1)
)
eth_mac_inst (
    .rst(rst),
    .logic_clk(clk),
    .logic_rst(rst),

    .tx_axis_tdata(tx_axis_tdata),
    .tx_axis_tvalid(tx_axis_tvalid),
    .tx_axis_tready(tx_axis_tready),
    .tx_axis_tlast(tx_axis_tlast),
    .tx_axis_tuser(tx_axis_tuser),

    .rx_axis_tdata(rx_axis_tdata),
    .rx_axis_tvalid(rx_axis_tvalid),
    .rx_axis_tready(1'b1),
    .rx_axis_tlast(rx_axis_tlast),
    .rx_axis_tuser(rx_axis_tuser),

    .mii_rx_clk(phy_rx_clk),
    .mii_rxd(phy_rxd),
    .mii_rx_dv(phy_rx_dv),
    .mii_rx_er(phy_rx_er),
    .mii_tx_clk(phy_tx_clk),
    .mii_txd(phy_txd),
    .mii_tx_en(phy_tx_en),
    .mii_tx_er(phy_tx_er),

    .tx_fifo_overflow(tx_fifo_overflow),
    .tx_fifo_bad_frame(tx_fifo_bad_frame),
    .tx_fifo_good_frame(tx_fifo_good_frame),
    .rx_error_bad_frame(rx_error_bad_frame),
    .rx_error_bad_fcs(rx_error_bad_fcs),
    .rx_fifo_overflow(rx_fifo_overflow),
    .rx_fifo_bad_frame(rx_fifo_bad_frame),
    .rx_fifo_good_frame(rx_fifo_good_frame),

    .ifg_delay(12)
);

endmodule
