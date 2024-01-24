#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"


$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet3.sh SetLock 0 2 1 welcome-home $(($(date +%s) + 172800))
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json