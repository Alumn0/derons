#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/installsc_wallet2.sh
sleep 1
$BASEDIR/invoke_wallet1.sh ReserveTld 0 2 dero
sleep 1
$BASEDIR/invoke_wallet1.sh ClaimTld 0 2 dero
