#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet2.sh SetSunrise 0 2 1 $(($(date +%s) + 600))
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
