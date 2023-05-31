//-----------------------------------------------------
// This is a generated file
//-----------------------------------------------------
// Copyright 2018 ETH Zurich and University of bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "pulp_soc_defines.svh"
`include "pulp_peripheral_defines.svh"

module pad_control(
    // PAD CONTROL REGISTER
    input  logic [`N_IO-1:0][`NBIT_PADMUX-1:0]    pad_mux_i,

    // IOS
    output logic [`N_IO-1:0]        io_out_o,
    input  logic [`N_IO-1:0]        io_in_i,
    output logic [`N_IO-1:0]        io_oe_o,

    // PERIOS
    input  logic [`N_PERIO-1:0]     perio_out_i,
    output logic [`N_PERIO-1:0]     perio_in_o,
    input  logic [`N_PERIO-1:0]     perio_oe_i,

    // APBIOs
    input  logic [`N_APBIO-1:0]      apbio_out_i,
    output logic [`N_APBIO-1:0]      apbio_in_o,
    input  logic [`N_APBIO-1:0]      apbio_oe_i,

    // FPGAIOS
    input  logic [`N_FPGAIO-1:0]    fpgaio_out_i,
    output logic [`N_FPGAIO-1:0]    fpgaio_in_o,
    input  logic [`N_FPGAIO-1:0]    fpgaio_oe_i
    );

    ///////////////////////////////////////////////////
    // Assign signals to the perio bus
    ///////////////////////////////////////////////////
    assign perio_in_o[0] =  1'b1;
    assign perio_in_o[1] =  1'b1;
    assign perio_in_o[2] =  1'b1;
    assign perio_in_o[3] =  1'b1;
    assign perio_in_o[4] =  1'b1;
    assign perio_in_o[5] =  1'b1;
    assign perio_in_o[6] =  1'b1;
    assign perio_in_o[7] =  1'b1;
    assign perio_in_o[8] =  1'b1;
    assign perio_in_o[9] =  1'b1;
    assign perio_in_o[10] =  1'b1;
    assign perio_in_o[11] =  1'b1;
    assign perio_in_o[12] =  1'b1;
    assign perio_in_o[13] =  1'b1;
    assign perio_in_o[14] =  1'b1;
    assign perio_in_o[15] =  1'b1;
    assign perio_in_o[16] =  1'b1;
    assign perio_in_o[17] =  1'b1;
    assign perio_in_o[18] =  1'b1;
    assign perio_in_o[19] =  1'b1;
    assign perio_in_o[20] =  1'b1;
    assign perio_in_o[21] =  1'b1;
    assign perio_in_o[22] =  1'b1;
    assign perio_in_o[23] =  1'b1;
    assign perio_in_o[24] =  1'b1;
    assign perio_in_o[25] =  1'b1;
    assign perio_in_o[26] =  1'b1;
    assign perio_in_o[27] =  1'b1;
    assign perio_in_o[28] =  1'b1;
    assign perio_in_o[29] =  1'b1;
    assign perio_in_o[30] =  1'b1;
    assign perio_in_o[31] =  1'b1;
    assign perio_in_o[32] =  1'b1;
    assign perio_in_o[33] =  1'b1;
    assign perio_in_o[34] =  1'b1;
    assign perio_in_o[35] =  1'b1;
    assign perio_in_o[36] =  1'b1;
    assign perio_in_o[37] =  1'b1;
    assign perio_in_o[38] =  1'b1;
    assign perio_in_o[39] =  1'b1;
    assign perio_in_o[40] =  1'b1;
    assign perio_in_o[41] =  1'b1;
    assign perio_in_o[42] =  1'b1;
    assign perio_in_o[43] =  1'b1;
    assign perio_in_o[44] =  1'b1;
    assign perio_in_o[45] =  1'b1;
    assign perio_in_o[46] =  1'b1;
    assign perio_in_o[47] =  1'b1;
    assign perio_in_o[48] =  1'b1;

    ///////////////////////////////////////////////////
    // Assign signals to the apbio bus
    ///////////////////////////////////////////////////
    assign apbio_in_o[0] =  1'b0;
    assign apbio_in_o[1] =  1'b0;
    assign apbio_in_o[2] =  1'b0;
    assign apbio_in_o[3] =  1'b0;
    assign apbio_in_o[4] =  1'b0;
    assign apbio_in_o[5] =  1'b0;
    assign apbio_in_o[6] =  1'b0;
    assign apbio_in_o[7] =  1'b0;
    assign apbio_in_o[8] =  1'b0;
    assign apbio_in_o[9] =  1'b0;
    assign apbio_in_o[10] =  1'b0;
    assign apbio_in_o[11] =  1'b0;
    assign apbio_in_o[12] =  1'b0;
    assign apbio_in_o[13] =  1'b0;
    assign apbio_in_o[14] =  1'b0;
    assign apbio_in_o[15] =  1'b0;
    assign apbio_in_o[16] =  1'b0;
    assign apbio_in_o[17] =  1'b0;
    assign apbio_in_o[18] =  1'b0;
    assign apbio_in_o[19] =  1'b0;
    assign apbio_in_o[20] =  1'b0;
    assign apbio_in_o[21] =  1'b0;
    assign apbio_in_o[22] =  1'b0;
    assign apbio_in_o[23] =  1'b0;
    assign apbio_in_o[24] =  1'b0;
    assign apbio_in_o[25] =  1'b0;
    assign apbio_in_o[26] =  1'b0;
    assign apbio_in_o[27] =  1'b0;
    assign apbio_in_o[28] =  1'b0;
    assign apbio_in_o[29] =  1'b0;
    assign apbio_in_o[30] =  1'b0;
    assign apbio_in_o[31] =  1'b0;
    assign apbio_in_o[32] =  1'b0;
    assign apbio_in_o[33] =  1'b0;
    assign apbio_in_o[34] =  1'b0;
    assign apbio_in_o[35] =  1'b0;
    assign apbio_in_o[36] =  1'b0;
    assign apbio_in_o[37] =  1'b0;
    assign apbio_in_o[38] =  1'b0;
    assign apbio_in_o[39] =  1'b0;
    assign apbio_in_o[40] =  1'b0;
    assign apbio_in_o[41] =  1'b0;
    assign apbio_in_o[42] =  1'b0;
    assign apbio_in_o[43] =  1'b0;
    assign apbio_in_o[44] =  1'b0;
    assign apbio_in_o[45] =  1'b0;
    assign apbio_in_o[46] =  1'b0;
    assign apbio_in_o[47] =  1'b0;
    assign apbio_in_o[48] =  1'b0;
    assign apbio_in_o[49] =  1'b0;
    assign apbio_in_o[50] =  1'b0;

    ///////////////////////////////////////////////////
    // Assign signals to the fpgaio bus
    ///////////////////////////////////////////////////
    assign fpgaio_in_o[0] =  1'b0;
    assign fpgaio_in_o[1] =  1'b0;
    assign fpgaio_in_o[2] =  1'b0;
    assign fpgaio_in_o[3] =  1'b0;
    assign fpgaio_in_o[4] =  1'b0;
    assign fpgaio_in_o[5] =  1'b0;
    assign fpgaio_in_o[6] =  1'b0;
    assign fpgaio_in_o[7] =  1'b0;
    assign fpgaio_in_o[8] =  1'b0;
    assign fpgaio_in_o[9] =  1'b0;
    assign fpgaio_in_o[10] =  1'b0;
    assign fpgaio_in_o[11] =  1'b0;
    assign fpgaio_in_o[12] =  1'b0;
    assign fpgaio_in_o[13] =  1'b0;
    assign fpgaio_in_o[14] =  1'b0;
    assign fpgaio_in_o[15] =  1'b0;
    assign fpgaio_in_o[16] =  1'b0;
    assign fpgaio_in_o[17] =  1'b0;
    assign fpgaio_in_o[18] =  1'b0;
    assign fpgaio_in_o[19] =  1'b0;
    assign fpgaio_in_o[20] =  1'b0;
    assign fpgaio_in_o[21] =  1'b0;
    assign fpgaio_in_o[22] =  1'b0;
    assign fpgaio_in_o[23] =  1'b0;
    assign fpgaio_in_o[24] =  1'b0;
    assign fpgaio_in_o[25] =  1'b0;
    assign fpgaio_in_o[26] =  1'b0;
    assign fpgaio_in_o[27] =  1'b0;
    assign fpgaio_in_o[28] =  1'b0;
    assign fpgaio_in_o[29] =  1'b0;
    assign fpgaio_in_o[30] =  1'b0;
    assign fpgaio_in_o[31] =  1'b0;
    assign fpgaio_in_o[32] =  1'b0;
    assign fpgaio_in_o[33] =  1'b0;
    assign fpgaio_in_o[34] =  1'b0;
    assign fpgaio_in_o[35] =  1'b0;
    assign fpgaio_in_o[36] =  1'b0;
    assign fpgaio_in_o[37] =  1'b0;
    assign fpgaio_in_o[38] =  1'b0;
    assign fpgaio_in_o[39] =  1'b0;
    assign fpgaio_in_o[40] =  1'b0;
    assign fpgaio_in_o[41] =  1'b0;
    assign fpgaio_in_o[42] =  1'b0;

    ///////////////////////////////////////////////////
    // Assign signals to the io_out bus
    ///////////////////////////////////////////////////
    assign io_out_o[0] =  1'b0;
    assign io_out_o[1] =  1'b0;
    assign io_out_o[2] =  1'b0;
    assign io_out_o[3] =  1'b0;
    assign io_out_o[4] =  1'b0;
    assign io_out_o[5] =  1'b0;
    assign io_out_o[6] =  1'b0;
    assign io_out_o[7] =  1'b0;
    assign io_out_o[8] =  1'b0;
    assign io_out_o[9] =  1'b0;
    assign io_out_o[10] =  1'b0;
    assign io_out_o[11] =  1'b0;
    assign io_out_o[12] =  1'b0;
    assign io_out_o[13] =  1'b0;
    assign io_out_o[14] =  1'b0;
    assign io_out_o[15] =  1'b0;
    assign io_out_o[16] =  1'b0;
    assign io_out_o[17] =  1'b0;
    assign io_out_o[18] =  1'b0;
    assign io_out_o[19] =  1'b0;
    assign io_out_o[20] =  1'b0;
    assign io_out_o[21] =  1'b0;
    assign io_out_o[22] =  1'b0;
    assign io_out_o[23] =  1'b0;
    assign io_out_o[24] =  1'b0;
    assign io_out_o[25] =  1'b0;
    assign io_out_o[26] =  1'b0;
    assign io_out_o[27] =  1'b0;
    assign io_out_o[28] =  1'b0;
    assign io_out_o[29] =  1'b0;
    assign io_out_o[30] =  1'b0;
    assign io_out_o[31] =  1'b0;
    assign io_out_o[32] =  1'b0;
    assign io_out_o[33] =  1'b0;
    assign io_out_o[34] =  1'b0;
    assign io_out_o[35] =  1'b0;
    assign io_out_o[36] =  1'b0;
    assign io_out_o[37] =  1'b0;
    assign io_out_o[38] =  1'b0;
    assign io_out_o[39] =  1'b0;
    assign io_out_o[40] =  1'b0;
    assign io_out_o[41] =  1'b0;
    assign io_out_o[42] =  1'b0;
    assign io_out_o[43] =  1'b0;
    assign io_out_o[44] =  1'b0;
    assign io_out_o[45] =  1'b0;
    assign io_out_o[46] =  1'b0;
    assign io_out_o[47] =  1'b0;

    ///////////////////////////////////////////////////
    // Assign signals to the io_oe bus
    ///////////////////////////////////////////////////
    assign io_oe_o[0] =  1'b0;
    assign io_oe_o[1] =  1'b0;
    assign io_oe_o[2] =  1'b0;
    assign io_oe_o[3] =  1'b0;
    assign io_oe_o[4] =  1'b0;
    assign io_oe_o[5] =  1'b0;
    assign io_oe_o[6] =  1'b0;
    assign io_oe_o[7] =  1'b0;
    assign io_oe_o[8] =  1'b0;
    assign io_oe_o[9] =  1'b0;
    assign io_oe_o[10] =  1'b0;
    assign io_oe_o[11] =  1'b0;
    assign io_oe_o[12] =  1'b0;
    assign io_oe_o[13] =  1'b0;
    assign io_oe_o[14] =  1'b0;
    assign io_oe_o[15] =  1'b0;
    assign io_oe_o[16] =  1'b0;
    assign io_oe_o[17] =  1'b0;
    assign io_oe_o[18] =  1'b0;
    assign io_oe_o[19] =  1'b0;
    assign io_oe_o[20] =  1'b0;
    assign io_oe_o[21] =  1'b0;
    assign io_oe_o[22] =  1'b0;
    assign io_oe_o[23] =  1'b0;
    assign io_oe_o[24] =  1'b0;
    assign io_oe_o[25] =  1'b0;
    assign io_oe_o[26] =  1'b0;
    assign io_oe_o[27] =  1'b0;
    assign io_oe_o[28] =  1'b0;
    assign io_oe_o[29] =  1'b0;
    assign io_oe_o[30] =  1'b0;
    assign io_oe_o[31] =  1'b0;
    assign io_oe_o[32] =  1'b0;
    assign io_oe_o[33] =  1'b0;
    assign io_oe_o[34] =  1'b0;
    assign io_oe_o[35] =  1'b0;
    assign io_oe_o[36] =  1'b0;
    assign io_oe_o[37] =  1'b0;
    assign io_oe_o[38] =  1'b0;
    assign io_oe_o[39] =  1'b0;
    assign io_oe_o[40] =  1'b0;
    assign io_oe_o[41] =  1'b0;
    assign io_oe_o[42] =  1'b0;
    assign io_oe_o[43] =  1'b0;
    assign io_oe_o[44] =  1'b0;
    assign io_oe_o[45] =  1'b0;
    assign io_oe_o[46] =  1'b0;
    assign io_oe_o[47] =  1'b0;
endmodule
