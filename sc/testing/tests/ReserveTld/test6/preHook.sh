#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/invoke_wallet2.sh ReserveTld 0 2 dero
sleep 1
$BASEDIR/invoke_wallet2.sh ClaimTld 0 2 dero
sleep 1
$BASEDIR/invoke_wallet2.sh ReserveTld 0 2 dero2
sleep 1
$BASEDIR/invoke_wallet2.sh ClaimTld 0 2 dero2