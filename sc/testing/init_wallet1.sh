#!/bin/bash

./invoke_wallet1.sh ReserveTld 0 2 dero
sleep 1
./invoke_wallet1.sh ClaimTld 0 2 dero
sleep 1
./invoke_wallet1.sh SetLabelLength 0 2 1 8 20
sleep 1
./invoke_wallet1.sh SetDuration 0 2 1 register 86400
sleep 1
./invoke_wallet1.sh SetDuration 0 2 1 extend 3600
sleep 1
./invoke_wallet1.sh SetDuration 0 2 1 reserve 120
sleep 1
./invoke_wallet1.sh SetFeeS 0 2 1 default 5000
sleep 1
./invoke_wallet1.sh SetFeeS 0 2 1 reserve 5000
sleep 1
./invoke_wallet1.sh SetFeeS 0 2 1 update 5000
sleep 1
./invoke_wallet1.sh SetFeeS 0 2 1 offer 2000
sleep 1
./invoke_wallet1.sh SetFeeS 0 2 1 bid 2000
sleep 1
./invoke_wallet1.sh SetFeeS 0 2 1 transfer 2000

sleep 1
source init_refill.sh
