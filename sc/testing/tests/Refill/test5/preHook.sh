#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet1.sh SetTldAvailMax 0 2 20
sleep 1
$BASEDIR/invoke_wallet1.sh SetRefill 0 2 amount 1
sleep 1
$BASEDIR/invoke_wallet1.sh SetRefill 0 2 interval 120
sleep 11
$BASEDIR/invoke_wallet1.sh Refill 0 2