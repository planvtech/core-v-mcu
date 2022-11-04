/*
 * This is a generated file
 * 
 * Copyright 2021 QuickLogic
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

`define BUILD_DATE 32'h20221101
`define BUILD_TIME 32'h00084851

//  PER_ID definitions
`define PER_ID_UART      0
`define PER_ID_QSPIM     2
`define PER_ID_I2CM      4
`define PER_ID_I2SC      6
`define PER_ID_CSI2      6
`define PER_ID_HYPER     6
`define PER_ID_SDIO      6
`define PER_ID_CAM       7
`define PER_ID_JTAG      8
`define PER_ID_MRAM      8
`define PER_ID_FILTER    8
`define PER_ID_FPGA      9
`define PER_ID_EXT_PER   9

//  UDMA TX channels
`define CH_ID_TX_UART    0
`define CH_ID_TX_UART0   0
`define CH_ID_TX_UART1   1
`define CH_ID_TX_QSPIM   2
`define CH_ID_TX_QSPIM0  2
`define CH_ID_TX_QSPIM1  3
`define CH_ID_CMD_QSPIM  4
`define CH_ID_CMD_QSPIM0 4
`define CH_ID_CMD_QSPIM1 5
`define CH_ID_TX_I2CM    6
`define CH_ID_TX_I2CM0   6
`define CH_ID_TX_I2CM1   7
`define CH_ID_TX_I2SC    8
`define CH_ID_TX_CSI2    8
`define CH_ID_TX_HYPER   8
`define CH_ID_TX_HYPER   8
`define CH_ID_TX_HYPER0  8
`define CH_ID_TX_JTAG    9
`define CH_ID_TX_MRAM    9
`define CH_ID_TX_FPGA    9
`define CH_ID_TX_EXT_PER 9

//  UDMA RX channels
`define CH_ID_RX_UART    0
`define CH_ID_RX_UART0   0
`define CH_ID_RX_UART1   1
`define CH_ID_RX_QSPIM   2
`define CH_ID_RX_QSPIM0  2
`define CH_ID_RX_QSPIM1  3
`define CH_ID_RX_I2CM    4
`define CH_ID_RX_I2CM0   4
`define CH_ID_RX_I2CM1   5
`define CH_ID_RX_I2SC    6
`define CH_ID_RX_CSI2    6
`define CH_ID_RX_HYPER   6
`define CH_ID_RX_HYPER   6
`define CH_ID_RX_HYPER0  6
`define CH_ID_CAM        7
`define CH_ID_CAM0       7
`define CH_ID_RX_JTAG    8
`define CH_ID_RX_MRAM    8
`define CH_ID_RX_FPGA    8
`define CH_ID_RX_EXT_PER 8

//  Number of channels
`define N_TX_CHANNELS  9
`define N_RX_CHANNELS  8

//  Define indices for sysio in IO bus

//added by mkdigitals begin
`define PERIO_UART_NPORTS	2

`define PERIO_UART0_TX		0
`define PERIO_UART0_RX		1

`define PERIO_UART1_TX		2
`define PERIO_UART1_RX		3


`define PERIO_QSPIM_NPORTS	2

`define PERIO_QSPIM0_CLK	4
`define PERIO_QSPIM0_CSN0	5
`define PERIO_QSPIM0_CSN1	6
`define PERIO_QSPIM0_CSN2	7
`define PERIO_QSPIM0_CSN3	8
`define PERIO_QSPIM0_DATA0	9
`define PERIO_QSPIM0_DATA1	10
`define PERIO_QSPIM0_DATA2	11
`define PERIO_QSPIM0_DATA3	12

`define PERIO_QSPIM1_CLK	13
`define PERIO_QSPIM1_CSN0	14
`define PERIO_QSPIM1_CSN1	15
`define PERIO_QSPIM1_CSN2	16
`define PERIO_QSPIM1_CSN3	17
`define PERIO_QSPIM1_DATA0	18
`define PERIO_QSPIM1_DATA1	19
`define PERIO_QSPIM1_DATA2	20
`define PERIO_QSPIM1_DATA3	21


`define PERIO_I2CM_NPORTS	2

`define PERIO_I2CM0_SCL		22
`define PERIO_I2CM0_SDA		23

`define PERIO_I2CM1_SCL		24
`define PERIO_I2CM1_SDA		25


`define PERIO_SDIO_NPORTS	1
`define PERIO_SDIO0_CLK		26
`define	PERIO_SDIO0_CMD		27
`define PERIO_SDIO0_DATA0	28
`define PERIO_SDIO0_DATA1	29
`define PERIO_SDIO0_DATA2	30
`define PERIO_SDIO0_DATA3	31

`define PERIO_I2SC_NPORTS	1
`define PERIO_I2SC0_SCK		32
`define PERIO_I2SC0_WS		33
`define PERIO_I2SC0_SD0		34
`define PERIO_I2SC0_SD1		35

`define PERIO_CAM_NPORTS	1
`define PERIO_CAM0_VSYNC	36
`define PERIO_CAM0_HSYNC	37
`define PERIO_CAM0_CLK		38
`define PERIO_CAM0_DATA0	39
`define PERIO_CAM0_DATA1	40
`define PERIO_CAM0_DATA2	41
`define PERIO_CAM0_DATA3	42
`define PERIO_CAM0_DATA4	43
`define PERIO_CAM0_DATA5	44
`define PERIO_CAM0_DATA6	45
`define PERIO_CAM0_DATA7	46

//added by mkdigitals end