#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json
sleep 10
$BASEDIR/invoke_wallet1.sh ClaimTransfer 2000 2 1 welcome-home
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json