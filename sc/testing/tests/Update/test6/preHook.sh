#!/bin/bash
TESTDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BASEDIR="$(dirname "$(dirname "$(dirname "$TESTDIR")")")"

$BASEDIR/invoke_wallet3.sh SetLock 0 2 1 welcome-home $(($(date +%s) + 10))