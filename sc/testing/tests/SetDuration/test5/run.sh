#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetDuration 0 2 1 arbitrary 12345678
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
