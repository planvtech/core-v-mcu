# UDMA_ETHERNET

Memory address: UDMA_CH_ADDR_ETHERNET(`UDMA_CH_ADDR_ETHERNET)

Basic ETHERNET MAC driven by UDMA system

### RX_SADDR offset = 0x00

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| SADDR      |  11:0 |    RW |            | Address of receive buffer on write; current address on read |

### RX_SIZE offset = 0x04

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| SIZE       |  15:0 |    RW |            | Size of receive buffer on write; bytes left on read |

### RX_CFG offset = 0x08

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| CLR        |   6:6 |    WO |            | Clear the receive channel |
| PENDING    |   5:5 |    RO |            | Receive transaction is pending |
| EN         |   4:4 |    RW |            | Enable the receive channel |
| CONTINUOUS |   0:0 |    RW |            | 0x0: stop after last transfer for channel |
|            |       |       |            | 0x1: after last transfer for channel, |
|            |       |       |            | reload buffer size and start address and restart channel |

### TX_SADDR offset = 0x0C

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| SADDR      |  11:0 |    RW |            | Address of transmit buffer on write; current address on read |

### TX_SIZE offset = 0x10

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| SIZE       |  15:0 |    RW |            | Size of receive buffer on write; bytes left on read |

### TX_CFG offset = 0x14

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| CLR        |   6:6 |    WO |            | Clear the transmit channel |
| PENDING    |   5:5 |    RO |            | Transmit transaction is pending |
| EN         |   4:4 |    RW |            | Enable the transmit channel |
| CONTINUOUS |   0:0 |    RW |            | 0x0: stop after last transfer for channel |
|            |       |       |            | 0x1: after last transfer for channel, |
|            |       |       |            | reload buffer size and start address and restart channel |

### STATUS offset = 0x18

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| busy       | 10:10 |    RO |            |                 |
| speed      |   9:8 |    RO |            |                 |
| TX_FIFO_OVERFLOW |   7:7 |    RO |            |                 |
| TX_FIFO_BAD_FRAME |   6:6 |    RO |            |                 |
| TX_FIFO_GOOD_FRAME |   5:5 |    RO |            |                 |
| RX_ERROR_BAD_FRAME |   4:4 |    RO |            |                 |
| RX_ERROR_BAD_FCS |   3:3 |    RO |            |                 |
| RX_FIFO_OVERFLOW |   2:2 |    RO |            |                 |
| RX_FIFO_BAD_FRAME |   1:1 |    RO |            |                 |
| RX_FIFO_GOOD_FRAME |   0:0 |    RO |            |                 |

### ETH_SETUP offset = 0x1C

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| RX_ENABLE  |   9:9 |    RW |            |                 |
| TX_ENABLE  |   8:8 |    RW |            |                 |

### ERROR offset = 0x20

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| TX_ERROR_FIFO_OVERFLOW |   5:5 |    RC |            | 0x1 indicates tx fifo overflow error; read clears the bit |
| TX_ERROR_FIFO_BAD_FRAME |   4:4 |    RC |            | 0x1 indicates tx fifo bad frame error; read clears the bit |
| RX_ERROR_BAD_FRAME |   3:3 |    RC |            | 0x1 indicates rx bad frame error; read clears the bit |
| RX_ERROR_BAD_FCS |   2:2 |    RC |            | 0x1 indicates rx bad frame check sequence error; read clears the bit |
| RX_ERROR_FIFO_OVERFLOW |   1:1 |    RC |            | 0x1 indicates rx fifo overflow error; read clears the bit |
| RX_ERROR_FIFO_BAD_FRAME |   0:0 |    RC |            | 0x1 indicates rx fifo bad frame error; read clears the bit |

### IRQ_EN offset = 0x24

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| ERR_IRQ_EN |   1:1 |    RW |            | Enable the error interrupt |
| RX_IRQ_EN  |   0:0 |    RW |            | Enable the receiver interrupt |

### RX_FCS offset = 0x28

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| rx_fcs     |  31:0 |    RO |            | frame check sequence of the last received packet |

### TX_FCS offset = 0x2C

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| tx_fcs     |  31:0 |    RO |            | frame check sequence of the last transmitted packet |

### Notes:

| Access type | Description |
| ----------- | ----------- |
| RW          | Read & Write |
| RO          | Read Only    |
| RC          | Read & Clear after read |
| WO          | Write Only |
| WC          | Write Clears (value ignored; always writes a 0) |
| WS          | Write Sets (value ignored; always writes a 1) |
| RW1S        | Read & on Write bits with 1 get set, bits with 0 left unchanged |
| RW1C        | Read & on Write bits with 1 get cleared, bits with 0 left unchanged |
| RW0C        | Read & on Write bits with 0 get cleared, bits with 1 left unchanged |