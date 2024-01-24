#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetDuration 0 2 1 register 63115200
sleep 1
$BASEDIR/invoke_wallet1.sh SetDuration 0 2 1 extend 31557600
sleep 1
$BASEDIR/invoke_wallet1.sh SetDuration 0 2 1 orphan 15778800
sleep 1
$BASEDIR/invoke_wallet1.sh SetDuration 0 2 1 reserve 1200
sleep 1
$BASEDIR/invoke_wallet1.sh SetDuration 0 2 1 bid 600
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
