#!/bin/bash

BASEDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source $BASEDIR/scid.dat

output=$(curl -s -X POST http://ns1.testnet.dero.zone:40402/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "1","method": "DERO.GetSC","params": {"scid": "'$SCID'","code": false,"variables": true}}' | jq 'del(.result.stringkeys.C)')

if [ -z "$1" ]; then
    echo "$output"
else
    echo "$output" > "$1"
fi