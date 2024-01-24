#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"


$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet2.sh SetTldFee 0 2 reserve 300
sleep 1
$BASEDIR/invoke_wallet2.sh SetTldFee 0 2 register 3000
sleep 1
$BASEDIR/invoke_wallet2.sh SetTldFee 0 2 royalty 300
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
