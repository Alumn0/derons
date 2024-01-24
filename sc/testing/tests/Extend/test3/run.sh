#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"


$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet2.sh Extend 2500 2 1 welcome-home 1
sleep 1
$BASEDIR/invoke_wallet3.sh Extend 2500 2 1 welcome-home 1
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
