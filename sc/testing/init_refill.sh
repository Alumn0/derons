#!/bin/bash

./invoke_wallet1.sh SetRefill 0 2 interval 60
sleep 1
./invoke_wallet1.sh SetRefill 0 2 amount 1
sleep 1
./invoke_wallet1.sh SetTldAvailMax 0 2 3

