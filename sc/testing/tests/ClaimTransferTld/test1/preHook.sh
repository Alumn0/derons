#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

source $BASEDIR/wallet_address1.dat
source $BASEDIR/wallet_address2.dat
source $BASEDIR/wallet_address3.dat

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/init_wallet2.sh
sleep 1
$BASEDIR/invoke_wallet2.sh TransferTld 0 2 1 $WALLETADDRESS3
