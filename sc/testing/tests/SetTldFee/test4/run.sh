#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"


$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetTldFee 0 2 reserve 555
sleep 1
$BASEDIR/invoke_wallet1.sh SetTldFee 0 2 register 5555
sleep 1
$BASEDIR/invoke_wallet1.sh SetTldFee 0 2 royalty 2555
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
