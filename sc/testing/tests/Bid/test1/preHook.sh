#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/init_wallet2.sh
sleep 1
$BASEDIR/invoke_wallet2.sh SetSunrise 0 2 1 0
sleep 1
$BASEDIR/invoke_wallet1.sh Reserve 500 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet1.sh Claim 2500 2 1 welcome-home