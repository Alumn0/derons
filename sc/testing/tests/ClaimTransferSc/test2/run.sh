#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh ClaimTransferSc 0 2
sleep 1
$BASEDIR/invoke_wallet2.sh ClaimTransferSc 0 2
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
