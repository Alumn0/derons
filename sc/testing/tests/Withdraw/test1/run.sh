#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh Withdraw 0 4 0 500
sleep 1
$BASEDIR/invoke_wallet2.sh Withdraw 0 4 0 5000
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
