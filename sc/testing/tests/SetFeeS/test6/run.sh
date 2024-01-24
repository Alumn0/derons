#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet2.sh SetFeeS 0 2 1 royalty 1111
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
