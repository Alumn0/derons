#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

source $BASEDIR/wallet_address1.dat
source $BASEDIR/wallet_address2.dat
source $BASEDIR/wallet_address3.dat

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet3.sh Transfer 0 2 1 welcome-home $WALLETADDRESS1 0
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
