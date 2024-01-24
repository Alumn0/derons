#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/getScStatus.sh $TESTDIR/before.json

$BASEDIR/invoke_wallet2.sh TransferTld 0 2 1 deto1qybrokenx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg
sleep 1
$BASEDIR/getScStatus.sh $TESTDIR/after.json
