#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet1.sh SetTldAvailMax 0 2 10
sleep 1
$BASEDIR/invoke_wallet1.sh SetRefill 0 2 amount 25