#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source $BASEDIR/scid.dat

FUNCTION="$1"
DEROVALUE="$2"
shift
shift

if [ -f /.dockerenv ]; then
    $BASEDIR/controller.sh $FUNCTION host.docker.internal:40403 $DEROVALUE $SCID "$@"
else
    $BASEDIR/controller.sh $FUNCTION 127.0.0.1:40403 $DEROVALUE $SCID "$@"
fi