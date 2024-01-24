#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet1.sh SetLock 0 2 1 welcome-home $(($(date +%s) + 10))
sleep 1
$BASEDIR/invoke_wallet1.sh Offer 0 2 1 welcome-home 7777
sleep 1
$BASEDIR/invoke_wallet3.sh Bid 4321 2 1 welcome-home