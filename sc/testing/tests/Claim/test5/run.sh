#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"


$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh Claim 2000 2 1 toolong890123456789012345678901234567890123456789012345678901234
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
