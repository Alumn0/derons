#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 offer 3100
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 bid 3100
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 transfer 3100
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 royalty 1111
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 arbitrary 8888
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
