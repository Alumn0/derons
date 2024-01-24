#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet2.sh SetDuration 0 2 1 bid 10
sleep 1
$BASEDIR/invoke_wallet1.sh Bid 2500 2 1 welcome-home