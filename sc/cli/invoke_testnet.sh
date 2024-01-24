#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source $BASEDIR/scid.dat

FUNCTION="$1"
DEROVALUE="$2"
shift
shift

$BASEDIR/controller.sh $FUNCTION 127.0.0.1:40403 $DEROVALUE $SCID "$@"