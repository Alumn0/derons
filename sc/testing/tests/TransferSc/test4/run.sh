#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet1.sh TransferSc 0 2 deto1qyinvalidx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2q
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
