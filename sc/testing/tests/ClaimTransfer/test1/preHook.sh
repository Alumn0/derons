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
$BASEDIR/invoke_wallet1.sh SetTldFee 0 2 royalty 2500
sleep 1
$BASEDIR/invoke_wallet2.sh SetSunrise 0 2 1 0
sleep 1
$BASEDIR/invoke_wallet1.sh Reserve 2000 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet1.sh Claim 2000 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet1.sh Transfer 0 2 1 welcome-home $WALLETADDRESS3 0
sleep 1
$BASEDIR/invoke_wallet1.sh Offer 0 2 1 welcome-home 25000
sleep 1
$BASEDIR/invoke_wallet2.sh Bid 5000 2 1 welcome-home

