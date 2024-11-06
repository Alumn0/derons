#!/bin/bash

BASEDIR="$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")"
CLIDIR="$BASEDIR/cli"
TESTDIR="$BASEDIR/testing"

curl -s --request POST --data-binary @$BASEDIR/DeroNS.bas http://127.0.0.1:20201/install_sc | grep -oE "[0-9a-f]{64}" | sed 's/^/SCID=/' > $CLIDIR/scid.dat
$TESTDIR/getWalletAddresses.sh