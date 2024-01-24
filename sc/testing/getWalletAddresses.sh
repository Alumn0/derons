#!/bin/bash

BASEDIR="$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")"
CLIDIR="$BASEDIR/cli"
TESTDIR="$BASEDIR/testing"

echo "WALLETADDRESS1=$(curl -s -X POST http://127.0.0.1:30000/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "0","method": "GetAddress"}' | jq -r '.result.address')" > $TESTDIR/wallet_address1.dat
echo "WALLETADDRESS2=$(curl -s -X POST http://127.0.0.1:30001/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "0","method": "GetAddress"}' | jq -r '.result.address')" > $TESTDIR/wallet_address2.dat
echo "WALLETADDRESS3=$(curl -s -X POST http://127.0.0.1:30002/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "0","method": "GetAddress"}' | jq -r '.result.address')" > $TESTDIR/wallet_address3.dat