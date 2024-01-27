#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh Reserve 2500 2 75 welcome-home
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json