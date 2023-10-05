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

based on fpga.v
 
*/

// Language: Verilog 2001

/*
 * RGMII top-level module
 */

module rgmii_soc (
    // Internal 125 MHz clock
    input              clk_int,
    input              rst_int,
    input              clk90_int,
    input              clk_200_int,

    /*
     * Ethernet: 1000BASE-T RGMII
     */
    input wire         phy_rx_clk,
    input wire [3:0]   phy_rxd,
    input wire         phy_rx_ctl,
    output wire        phy_tx_clk,
    output wire [3:0]  phy_txd,
    output wire        phy_tx_ctl,
    input wire         phy_int_n,
    input wire         phy_pme_n,
    output wire        mac_gmii_tx_en,

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
    output             rx_axis_tuser,

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
    output wire        rx_fifo_good_frame,
    output wire [1:0]  speed

);

// IODELAY elements for RGMII interface to PHY
wire [3:0] phy_rxd_delay;
wire       phy_rx_ctl_delay;
wire       idelay_ctrl_ref_clk;

BUFGCE BUFGCE_inst
(
    .O(idelay_ctrl_ref_clk),
    .CE(1'b1),
    .I(clk_200_int)
);

IDELAYCTRL #(
      .SIM_DEVICE("ULTRASCALE")  // Set the device version for simulation functionality (ULTRASCALE)
)
idelayctrl_inst
(
    .REFCLK(idelay_ctrl_ref_clk),
    .RST(rst_int),
    .RDY()
);

IDELAYE3 #(
    .CASCADE("NONE"),               // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
    .DELAY_FORMAT("COUNT"),         // Units of the DELAY_VALUE (COUNT, TIME)
    .DELAY_SRC("IDATAIN"),          // Delay input (DATAIN, IDATAIN)
    .DELAY_TYPE("FIXED"),           // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
    .DELAY_VALUE(0),                // Input delay value setting
    .IS_CLK_INVERTED(1'b0),         // Optional inversion for CLK
    .IS_RST_INVERTED(1'b0),         // Optional inversion for RST
    .REFCLK_FREQUENCY(200.0),       // IDELAYCTRL clock input frequency in MHz (200.0-800.0)
    .SIM_DEVICE("ULTRASCALE_PLUS"), // Set the device version for simulation functionality (ULTRASCALE,
                                  // ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
    .UPDATE_MODE("ASYNC")           // Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  // SYNC)
)
phy_rxd_idelay_0
(
    .CASC_OUT(),
    .CNTVALUEOUT(),
    .DATAOUT(phy_rxd_delay[0]),
    .CASC_IN(1'b0),
    .CASC_RETURN(1'b0),
    .CE(1'b0),
    .CLK(1'b0),
    .CNTVALUEIN(9'd0),
    .DATAIN(1'b0),
    .EN_VTC(1'b1),
    .IDATAIN(phy_rxd[0]),
    .INC(1'b0),
    .LOAD(1'b0),
    .RST(1'b0)
);

IDELAYE3 #(
    .CASCADE("NONE"),               // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
    .DELAY_FORMAT("COUNT"),         // Units of the DELAY_VALUE (COUNT, TIME)
    .DELAY_SRC("IDATAIN"),          // Delay input (DATAIN, IDATAIN)
    .DELAY_TYPE("FIXED"),           // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
    .DELAY_VALUE(0),                // Input delay value setting
    .IS_CLK_INVERTED(1'b0),         // Optional inversion for CLK
    .IS_RST_INVERTED(1'b0),         // Optional inversion for RST
    .REFCLK_FREQUENCY(200.0),       // IDELAYCTRL clock input frequency in MHz (200.0-800.0)
    .SIM_DEVICE("ULTRASCALE_PLUS"), // Set the device version for simulation functionality (ULTRASCALE,
                                  // ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
    .UPDATE_MODE("ASYNC")           // Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  // SYNC)
)
phy_rxd_idelay_1
(
    .CASC_OUT(),
    .CNTVALUEOUT(),
    .DATAOUT(phy_rxd_delay[1]),
    .CASC_IN(1'b0),
    .CASC_RETURN(1'b0),
    .CE(1'b0),
    .CLK(1'b0),
    .CNTVALUEIN(9'd0),
    .DATAIN(1'b0),
    .EN_VTC(1'b1),
    .IDATAIN(phy_rxd[1]),
    .INC(1'b0),
    .LOAD(1'b0),
    .RST(1'b0)
);

IDELAYE3 #(
    .CASCADE("NONE"),               // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
    .DELAY_FORMAT("COUNT"),         // Units of the DELAY_VALUE (COUNT, TIME)
    .DELAY_SRC("IDATAIN"),          // Delay input (DATAIN, IDATAIN)
    .DELAY_TYPE("FIXED"),           // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
    .DELAY_VALUE(0),                // Input delay value setting
    .IS_CLK_INVERTED(1'b0),         // Optional inversion for CLK
    .IS_RST_INVERTED(1'b0),         // Optional inversion for RST
    .REFCLK_FREQUENCY(200.0),       // IDELAYCTRL clock input frequency in MHz (200.0-800.0)
    .SIM_DEVICE("ULTRASCALE_PLUS"), // Set the device version for simulation functionality (ULTRASCALE,
                                  // ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
    .UPDATE_MODE("ASYNC")           // Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  // SYNC)
)
phy_rxd_idelay_2
(
    .CASC_OUT(),
    .CNTVALUEOUT(),
    .DATAOUT(phy_rxd_delay[2]),
    .CASC_IN(1'b0),
    .CASC_RETURN(1'b0),
    .CE(1'b0),
    .CLK(1'b0),
    .CNTVALUEIN(9'd0),
    .DATAIN(1'b0),
    .EN_VTC(1'b1),
    .IDATAIN(phy_rxd[2]),
    .INC(1'b0),
    .LOAD(1'b0),
    .RST(1'b0)
);

IDELAYE3 #(
    .CASCADE("NONE"),               // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
    .DELAY_FORMAT("COUNT"),         // Units of the DELAY_VALUE (COUNT, TIME)
    .DELAY_SRC("IDATAIN"),          // Delay input (DATAIN, IDATAIN)
    .DELAY_TYPE("FIXED"),           // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
    .DELAY_VALUE(0),                // Input delay value setting
    .IS_CLK_INVERTED(1'b0),         // Optional inversion for CLK
    .IS_RST_INVERTED(1'b0),         // Optional inversion for RST
    .REFCLK_FREQUENCY(200.0),       // IDELAYCTRL clock input frequency in MHz (200.0-800.0)
    .SIM_DEVICE("ULTRASCALE_PLUS"), // Set the device version for simulation functionality (ULTRASCALE,
                                  // ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
    .UPDATE_MODE("ASYNC")           // Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  // SYNC)
)
phy_rxd_idelay_3
(
    .CASC_OUT(),
    .CNTVALUEOUT(),
    .DATAOUT(phy_rxd_delay[3]),
    .CASC_IN(1'b0),
    .CASC_RETURN(1'b0),
    .CE(1'b0),
    .CLK(1'b0),
    .CNTVALUEIN(9'd0),
    .DATAIN(1'b0),
    .EN_VTC(1'b1),
    .IDATAIN(phy_rxd[3]),
    .INC(1'b0),
    .LOAD(1'b0),
    .RST(1'b0)
);

IDELAYE3 #(
    .CASCADE("NONE"),               // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
    .DELAY_FORMAT("COUNT"),         // Units of the DELAY_VALUE (COUNT, TIME)
    .DELAY_SRC("IDATAIN"),          // Delay input (DATAIN, IDATAIN)
    .DELAY_TYPE("FIXED"),           // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
    .DELAY_VALUE(0),                // Input delay value setting
    .IS_CLK_INVERTED(1'b0),         // Optional inversion for CLK
    .IS_RST_INVERTED(1'b0),         // Optional inversion for RST
    .REFCLK_FREQUENCY(200.0),       // IDELAYCTRL clock input frequency in MHz (200.0-800.0)
    .SIM_DEVICE("ULTRASCALE_PLUS"), // Set the device version for simulation functionality (ULTRASCALE,
                                  // ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
    .UPDATE_MODE("ASYNC")           // Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                  // SYNC)
)
phy_rx_ctl_idelay
(
    .CASC_OUT(),
    .CNTVALUEOUT(),
    .DATAOUT(phy_rx_ctl_delay),
    .CASC_IN(1'b0),
    .CASC_RETURN(1'b0),
    .CE(1'b0),
    .CLK(1'b0),
    .CNTVALUEIN(9'd0),
    .DATAIN(1'b0),
    .EN_VTC(1'b1),
    .IDATAIN(phy_rx_ctl),
    .INC(1'b0),
    .LOAD(1'b0),
    .RST(1'b0)
);

rgmii_core
core_inst (
    /*
     * Clock: 125MHz
     * Synchronous reset
     */
    .clk(clk_int),
    .clk90(clk90_int),
    .rst(rst_int),
    /*
     * Ethernet: 1000BASE-T RGMII
     */
    .phy_rx_clk(phy_rx_clk),
    .phy_rxd(phy_rxd_delay),
    .phy_rx_ctl(phy_rx_ctl_delay),
    .phy_tx_clk(phy_tx_clk),
    .phy_txd(phy_txd),
    .phy_tx_ctl(phy_tx_ctl),
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
    .tx_fifo_overflow(tx_fifo_overflow),
    .tx_fifo_bad_frame(tx_fifo_bad_frame),
    .tx_fifo_good_frame(tx_fifo_good_frame),
    .rx_error_bad_frame(rx_error_bad_frame),
    .rx_error_bad_fcs(rx_error_bad_fcs),
    .rx_fifo_overflow(rx_fifo_overflow),
    .rx_fifo_bad_frame(rx_fifo_bad_frame),
    .rx_fifo_good_frame(rx_fifo_good_frame),
    .speed(speed)
);

endmodule
