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
$BASEDIR/invoke_wallet1.sh Reserve 500 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet1.sh Claim 2500 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet2.sh Bid 4321 2 1 welcome-home
sleep 1
$BASEDIR/invoke_wallet1.sh Transfer 0 2 1 welcome-home deto1qyre7td6x9r88y4cavdgpv6k7lvx6j39lfsx420hpvh3ydpcrtxrxqg8v8e3z 0
sleep 1
$BASEDIR/invoke_wallet1.sh Offer 0 2 1 welcome-home 77777