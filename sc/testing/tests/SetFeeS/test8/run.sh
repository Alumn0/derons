#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 default 3000
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 reserve 300
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 update 130
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 offer 1300
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 bid 300
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 transfer 530
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
