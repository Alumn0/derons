#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet3.sh Update 1000 2 1 welcome-home 7468616e6b73666f72616c6c74686566697368 plain/none
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
