#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json
sleep 11
$BASEDIR/invoke_wallet2.sh Refill 0 4
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
