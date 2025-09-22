#!/bin/bash

RX=
TX=

init() {
	screen -S $1 -p 0 -X stuff $'data_rate ieee802154_250Kbit\r'
	#screen -S $1 -p 0 -X stuff $'data_rate ble_lr125Kbit\r'
	screen -S $1 -p 0 -X stuff $'transmit_pattern pattern_11110000\r'
	screen -S $1 -p 0 -X stuff $'start_channel 40\r'
	screen -S $1 -p 0 -X stuff $'parameters_print\r'
	screen -S $1 -p 0 -X stuff $'\r'
}

if [ "$1" = "init" ]; then
	init $RX
	init $TX
	exit 0
fi

date -u +"%Y-%m-%dT%H:%M:%S.%3NZ"; screen -S $RX -p 0 -X stuff $'start_rx 10\r' &
#sleep 0.1
date -u +"%Y-%m-%dT%H:%M:%S.%3NZ"; screen -S $TX -p 0 -X stuff $'start_tx_modulated_carrier 10\r' &
