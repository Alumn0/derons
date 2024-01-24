#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

sleep 10
$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh ClaimBid 0 2 1 welcome-home 0
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
