#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/invoke_wallet1.sh SetRefill 0 2 interval 10
sleep 1
$BASEDIR/invoke_wallet1.sh SetRefill 0 2 amount 1
sleep 1
$BASEDIR/invoke_wallet1.sh SetTldAvailMax 0 2 5
