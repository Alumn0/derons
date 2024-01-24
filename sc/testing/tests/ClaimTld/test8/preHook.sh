#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet2.sh ReserveTld 0 2 dero
sleep 1
$BASEDIR/invoke_wallet2.sh ClaimTld 0 2 dero
sleep 1
$BASEDIR/invoke_wallet2.sh ReserveTld 0 2 toolong890123456789012345678901234567890123456789012345678901234
sleep 1
$BASEDIR/invoke_wallet2.sh ReserveTld 0 2 welcome-home
sleep 1
$BASEDIR/invoke_wallet1.sh ReserveTld 0 2 dero2
sleep 1
$BASEDIR/invoke_wallet1.sh ClaimTld 0 2 dero2

