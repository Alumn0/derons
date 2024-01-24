#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/init_wallet2.sh
sleep 1
$BASEDIR/invoke_wallet2.sh SetFeeU 0 2 1 19 1000
sleep 1
$BASEDIR/invoke_wallet2.sh SetSunrise 0 2 1 0
sleep 1
$BASEDIR/invoke_wallet1.sh SetTldFee 0 2 royalty 2500
sleep 1
$BASEDIR/invoke_wallet1.sh Reserve 500 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet1.sh Reserve 500 2 1 toolong890123456789012345678901234567890123456789012345678901234
sleep 1
$BASEDIR/invoke_wallet2.sh Reserve 500 2 1 thanksforallthefish
sleep 1
$BASEDIR/invoke_wallet2.sh Reserve 500 2 1 

