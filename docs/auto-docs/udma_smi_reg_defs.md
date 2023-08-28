# UDMA_SMI

Memory address: UDMA_CH_ADDR_SMI(`UDMA_CH_ADDR_SMI)

Basic SMI driven by UDMA system

### PHY_RW offset = 0x00

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| rw         |   0:0 |    WO |            |  0: read 1 : write; Phy read/write control; |

### PHY_EN offset = 0x04

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| en         |   0:0 |    WO |            | enable transaction; |

### PHY_ND offset = 0x08

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| nd         |   0:0 |    RO |            | New data indicator; |

### PHY_BUSY offset = 0x0C

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| busy       |   0:0 |    RO |            | Busy indicator; |

### PHY_ADDR offset = 0x10

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| addr       |   4:0 |    WO |            | Device address of PHY; |

### REG_ADDR offset = 0x14

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| addr       |   4:0 |    WO |            | Register address of PHY; |

### TX_DATA offset = 0x18

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| data       |  15:0 |    WO |            | PHY register write data; |

### RX_DATA offset = 0x20

| Field      |  Bits |  Type |    Default | Description     |
| --------------------- |   --- |   --- |        --- | ------------------------- |
| data       |  15:0 |    RO |            | PHY register read data; |

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
