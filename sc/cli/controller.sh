#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BUILDCMD=${BASEDIR}/buildcmd.sh
FUNCTION=${BASEDIR}/functions/${1}.sh
shift 

if [[ -f "$FUNCTION" ]]; then
    source "$FUNCTION"
    source "$BUILDCMD"
else
    echo -e "Error: Unknown script '${FUNCTION}'\n"
    exit 1
fi

echo -e "\nCommand:"
echo ${COMMAND[@]}
echo -e "\nOutput:"
echo $(eval ${COMMAND[@]})
echo -e "\n"
