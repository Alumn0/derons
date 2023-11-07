#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BUILDCMD=${BASEDIR}/buildcmd.sh
FUNCTION=${BASEDIR}/functions/${1}.sh
shift 

if [[ -f "$FUNCTION" ]]; then
    source "$FUNCTION"
    source "$BUILDCMD"
else
    echo -n "Error: Unknown script '${FUNCTION}'\n"
    exit 1
fi

echo ${COMMAND[@]}
echo $(eval ${COMMAND[@]})
