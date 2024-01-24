#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh SetP 0 2 1 announce 536f206c6f6e672c20616e64207468616e6b7320666f72666620616c6c20746865206669736821 0
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
