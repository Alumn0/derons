#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/installsc_wallet1.sh
sleep 1
$BASEDIR/init_wallet2.sh
sleep 1
$BASEDIR/invoke_wallet1.sh SetFeeS 0 2 1 royalty 1000
sleep 1
$BASEDIR/invoke_wallet1.sh Reserve 20000 4 1 welcome-home
