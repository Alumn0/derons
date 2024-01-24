#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet2.sh SetP 0 2 1 announce "" 0
sleep 1
$BASEDIR/invoke_wallet2.sh SetP 0 2 1 announce2 "" 0
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
