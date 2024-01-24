#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh ClaimTransferTld 0 2 0
sleep 1
$BASEDIR/invoke_wallet2.sh ClaimTransferTld 0 2 0
sleep 1
$BASEDIR/invoke_wallet3.sh ClaimTransferTld 0 2 0
sleep 1
$BASEDIR/invoke_wallet1.sh ClaimTransferTld 0 2 42
sleep 1
$BASEDIR/invoke_wallet2.sh ClaimTransferTld 0 2 42
sleep 1
$BASEDIR/invoke_wallet3.sh ClaimTransferTld 0 2 42
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
