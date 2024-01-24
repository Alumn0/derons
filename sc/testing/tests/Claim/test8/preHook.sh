#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet2.sh SetDuration 0 2 1 register 10
sleep 1
$BASEDIR/invoke_wallet2.sh SetDuration 0 2 1 orphan 10
sleep 1
$BASEDIR/invoke_wallet1.sh Reserve 500 2 1 welcome-back
sleep 1
$BASEDIR/invoke_wallet1.sh Claim 2000 2 1 welcome-back
sleep 1
$BASEDIR/invoke_wallet1.sh Offer 0 2 1 welcome-back 10000
sleep 1
$BASEDIR/invoke_wallet1.sh SetLock 0 2 1 welcome-back $(($(date +%s) + 10))
sleep 1
$BASEDIR/invoke_wallet1.sh Transfer 0 2 1 welcome-back deto1qyre7td6x9r88y4cavdgpv6k7lvx6j39lfsx420hpvh3ydpcrtxrxqg8v8e3z 1000
sleep 11
$BASEDIR/invoke_wallet3.sh Reserve 500 2 1 welcome-back