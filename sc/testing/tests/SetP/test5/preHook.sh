#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet1.sh ReserveTld 2500 2 dero2
sleep 1
$BASEDIR/invoke_wallet1.sh ClaimTld 2500 2 dero2