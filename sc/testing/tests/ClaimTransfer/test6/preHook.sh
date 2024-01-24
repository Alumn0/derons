#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

source $BASEDIR/wallet_address1.dat
source $BASEDIR/wallet_address2.dat
source $BASEDIR/wallet_address3.dat

$BASEDIR/invoke_wallet3.sh Transfer 0 2 1 welcome-home $WALLETADDRESS1 1000
sleep 1
$BASEDIR/invoke_wallet3.sh SetLock 0 2 1 welcome-home $(($(date +%s) + 10))


