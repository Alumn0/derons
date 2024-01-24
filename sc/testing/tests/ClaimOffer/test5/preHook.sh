#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet2.sh Offer 0 2 1 welcome-home 10000
sleep 1
$BASEDIR/invoke_wallet2.sh SetLock 0 2 1 welcome-home $(($(date +%s) + 10))