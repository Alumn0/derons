#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"


$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetScSuccessor 0 4 1234 7465737476616c75650a
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
