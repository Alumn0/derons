#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh Update 1000 2 1 welcome-home default
sleep 1
$BASEDIR/invoke_wallet2.sh Update 1000 2 1 welcome-home default
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
