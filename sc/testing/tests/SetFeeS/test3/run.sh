#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 default 5000
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 reserve 500
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 update 250
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 offer 1500
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 bid 2000
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 transfer 1000
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
