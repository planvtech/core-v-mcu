# Pin Assignment

| IO | sysio | sel=0 | sel=1 | sel=2 | sel=3 |
| --- | --- | --- | --- | --- | --- |
| IO_0 | jtag_tck |  |  |  |  |
| IO_1 | jtag_tdi |  |  |  |  |
| IO_2 | jtag_tdo |  |  |  |  |
| IO_3 | jtag_tms |  |  |  |  |
| IO_4 | jtag_trst |  |  |  |  |
| IO_5 | ref_clk |  |  |  |  |
| IO_6 | rstn |  |  |  |  |
| IO_7 | eth_refclk |  |  |  |  |
| IO_8 | eth_rstn |  |  |  |  |
| IO_9 | eth_crs_dv |  |  |  |  |
| IO_10 | eth_rx_er |  |  |  |  |
| IO_11 | eth_rxd0 |  |  |  |  |
| IO_12 | eth_rxd1 |  |  |  |  |
| IO_13 | eth_tx_en |  |  |  |  |
| IO_14 | eth_txd0 |  |  |  |  |
| IO_15 | eth_txd1 |  |  |  |  |
| IO_16 |  | smi0_mdc |  |  |  |
| IO_17 |  | smi0_mdio |  |  |  |
| IO_18 | ld_ref_clk_lock |  |  |  |  |
| IO_19 | ld_ref_clk_blink |  |  |  |  |
| IO_20 | ld_eth_clk_lock |  |  |  |  |
| IO_21 | ld_eth_clk_blink |  |  |  |  |
| IO_22 |  | uart0_rx |  | apbio_0 | fpgaio_0 |
| IO_23 |  | uart0_tx |  | apbio_1 | fpgaio_1 |
| IO_24 |  | uart1_tx |  | apbio_2 | fpgaio_2 |
| IO_25 |  | uart1_rx |  | apbio_3 | fpgaio_3 |
| IO_26 |  | apbio_32 | apbio_47 | apbio_4 | fpgaio_4 |
| IO_27 |  | apbio_0 |  | apbio_5 | fpgaio_5 |
| Jxadc[1] |  | qspim0_csn0 | apbio_34 | apbio_6 | fpgaio_6 |
| Jxadc[2] |  | qspim0_data0 | apbio_35 | apbio_7 | fpgaio_7 |
| Jxadc[3] |  | qspim0_data1 | apbio_37 | apbio_8 | fpgaio_8 |
| Jxadc[4] |  | qspim0_clk | apbio_38 | apbio_9 | fpgaio_9 |
| Jxadc[7] |  | apbio_1 | apbio_40 | apbio_10 | fpgaio_10 |
| Jxadc[8] |  | apbio_2 | apbio_41 | apbio_11 | fpgaio_11 |
| Jxadc[9] |  | qspim0_data2 | apbio_42 | apbio_12 | fpgaio_12 |
| Jxadc[10] |  | qspim0_data3 | apbio_43 | apbio_13 | fpgaio_13 |
| IO_36 |  | cam0_vsync | apbio_36 | apbio_14 | fpgaio_14 |
| IO_37 |  | cam0_hsync | apbio_39 | apbio_15 | fpgaio_15 |
| IO_38 |  | i2cm0_scl |  | apbio_16 | fpgaio_16 |
| IO_39 |  | i2cm0_sda |  | apbio_17 | fpgaio_17 |
| IO_40 |  | cam0_clk | apbio_33 | apbio_18 | fpgaio_18 |
| IO_41 |  | apbio_32 | qspim0_csn1 | apbio_19 | fpgaio_19 |
| IO_42 |  | apbio_48 | qspim0_csn2 | apbio_20 | fpgaio_20 |
| IO_43 |  | apbio_49 | qspim0_csn3 | apbio_21 | fpgaio_21 |
| IO_44 |  | cam0_data0 | qspim1_csn0 | apbio_22 | fpgaio_22 |
| IO_45 |  | cam0_data1 | qspim1_data0 | apbio_23 | fpgaio_23 |
| IO_46 |  | cam0_data2 | qspim1_data1 | apbio_24 | fpgaio_24 |
| IO_47 |  | cam0_data3 | qspim1_clk | apbio_25 | fpgaio_25 |
| IO_48 |  | cam0_data4 | qspim1_csn1 | apbio_26 | fpgaio_26 |
| IO_49 |  | cam0_data5 | qspim1_csn2 | apbio_27 | fpgaio_27 |
| IO_50 |  | cam0_data6 | qspim1_data2 | apbio_28 | fpgaio_28 |
| IO_51 |  | cam0_data7 | qspim1_data3 | apbio_29 | fpgaio_29 |
| IO_52 |  | sdio0_data3 |  | apbio_30 | fpgaio_30 |
| IO_53 |  | sdio0_cmd |  | apbio_31 | fpgaio_31 |
| IO_54 |  | sdio0_data0 |  | apbio_32 | fpgaio_32 |
| IO_55 |  | sdio0_clk |  | apbio_43 | fpgaio_33 |
| IO_56 |  | sdio0_data1 |  | apbio_44 | fpgaio_34 |
| IO_57 |  | sdio0_data2 |  | apbio_45 | fpgaio_35 |
| IO_58 |  | apbio_50 | apbio_0 | apbio_46 | fpgaio_36 |
| IO_59 | stm |  |  |  |  |
| IO_60 | bootsel |  |  |  | fpgaio_37 |
| IO_61 |  | i2cm1_scl |  |  | fpgaio_38 |
| IO_62 |  | i2cm1_sda |  |  | fpgaio_39 |
