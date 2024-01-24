#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/init_wallet2.sh
sleep 1
$BASEDIR/invoke_wallet2.sh SetSunrise 0 2 1 0
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 royalty 1000
sleep 1
$BASEDIR/invoke_wallet3.sh Reserve 2000 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet3.sh Claim 2000 2 1 welcome-home