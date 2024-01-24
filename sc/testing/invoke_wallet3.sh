#!/bin/bash

BASEDIR="$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")"
CLIDIR="$BASEDIR/cli"
TESTDIR="$BASEDIR/testing"

source $CLIDIR/scid.dat

FUNCTION="$1"
DEROVALUE="$2"
shift
shift

$CLIDIR/controller.sh $FUNCTION 127.0.0.1:30002 $DEROVALUE $SCID "$@"