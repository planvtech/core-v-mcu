/*
 * eth.c
 *
 *  Created on: Apr 21, 2021
 *      Author: gregmartin
 *      Edited by: mkdigitals - planv
 */

#include "core-v-mcu-config.h"
#include "udma_ctrl_reg_defs.h"
#include "udma_ethernet_reg_defs.h"
uint8_t* eth_read_buffer;
uint16_t udma_eth_open (uint8_t eth_id) {
	UdmaEthernet_t*				peth;
	volatile UdmaCtrl_t*		pudma_ctrl = (UdmaCtrl_t*)UDMA_CH_ADDR_CTRL;

	/* Enable reset and enable eth clock */
	pudma_ctrl->reg_rst |= (UDMA_CTRL_ETH0_CLKEN << eth_id);
	pudma_ctrl->reg_rst &= ~(UDMA_CTRL_ETH0_CLKEN << eth_id);
	pudma_ctrl->reg_cg |= (UDMA_CTRL_ETH0_CLKEN << eth_id);


	/* configure */
	peth = (UdmaEthernet_t*)(UDMA_CH_ADDR_ETH + eth_id * UDMA_CH_SIZE);
	peth->eth_setup_b.tx_enable = 1;
	peth->rx_saddr = (uint32_t)eth_read_buffer;
	peth->eth_setup_b.rx_enable = 1;

	return 0;
}

uint16_t udma_eth_writeraw(uint8_t eth_id, uint16_t write_len, uint8_t* write_buffer)
{
	UdmaEthernet_t*				peth = (UdmaEthernet_t*)(UDMA_CH_ADDR_ETH + eth_id * UDMA_CH_SIZE);
	int i = 0;
	while (peth->tx_size != 0) {
		i++;
	}

	peth->tx_saddr = (uint32_t)write_buffer;
	peth->tx_size = write_len;
	peth->tx_cfg_b.en = 1; //enable the transfer
	while (peth->tx_size != 0) {
		i++;
	}

	return i;
}

uint8_t udma_eth_readraw(uint8_t eth_id, uint16_t read_len, uint8_t* read_buffer)
{
	uint8_t lSts = 0;
	// UdmaEthernet_t *peth = (UdmaEthernet_t*)(UDMA_CH_ADDR_UART + eth_id * UDMA_CH_SIZE);

	// if( puart->valid_b.rx_data_valid == 1 )
	// {
	// 	*read_buffer = puart->data_b.rx_data;
	// 	lSts = 1;
	// }
	 return lSts;
}
