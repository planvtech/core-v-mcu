// Copyright 2023 PlanV.
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
// Description: AXI Stream Handler Module For Interfacing core-v-mcu UDMA master signals with slave
//
///////////////////////////////////////////////////////////////////////////////
// 
// Authors    : Mustafa Karadayi(PlanV    -   mustafa.karadayi@planv.tech)
//
///////////////////////////////////////////////////////////////////////////////
module udma_slave_axis_handler#(
    parameter DATA_WIDTH = 8,
    parameter TRANS_SIZE     = 16
    )
    (
    //GENERAL
    input wire      clk_i,
    input wire      rstn_i,

    //TX PATH UDMA SIDE
    input  wire [DATA_WIDTH - 1 : 0]    data_tx_i,
    input  wire                         data_tx_valid_i,
    output wire                         data_tx_ready_o,
    
    //RX PATH UDMA SIDE
    output wire [DATA_WIDTH - 1 : 0]    data_rx_o,
    output wire                         data_rx_valid_o,
    input  wire                         data_rx_ready_i

    //TX PATH SLAVE SIDE - AXIS
    output wire [DATA_WIDTH - 1 : 0]    tx_axis_tdata,
    output wire                         tx_axis_tvalid,
    input wire                          tx_axis_tready,
    output wire                         tx_axis_tlast,
    output wire                         tx_axis_tuser,
    
    //RX PATH SLAVE SIDE - AXIS
    input wire  [DATA_WIDTH - 1 : 0]    rx_axis_tdata,
    input wire                          rx_axis_tvalid,
    output wire                         rx_axis_tready,
    input wire                          rx_axis_tlast,
    input wire                          rx_axis_tuser,

    //TRANSFER_LENGTH_INFO
    input   wire [10:0]                   tx_transfer_size,
    output  wire [10:0]                   rx_transfer_size
)

endmodule //end udma_ethernet_axis_handler