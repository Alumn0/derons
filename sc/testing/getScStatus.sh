#!/bin/bash

BASEDIR="$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")"
CLIDIR="$BASEDIR/cli"
TESTDIR="$BASEDIR/testing"

source $CLIDIR/scid.dat

output=$(curl -s -X POST http://127.0.0.1:20000/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "1","method": "DERO.GetSC","params": {"scid": "'$SCID'","code": false,"variables": true}}' | jq 'del(.result.stringkeys.C)')

if [ -z "$1" ]; then
    echo "$output"
else
    echo "$output" > "$1"
fi
