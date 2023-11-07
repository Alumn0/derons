# DeroNS CLI
### A command line wrapper to interact with smart contracts

This bash wrapper requires these tools / commands to invoke all smart contract functions correctly:
[json2msgpack]|(https://github.com/ludocode/msgpack-tools)
pigz<br>
xxd<br>
sha256sum<br>
head<br>

The wrapper expects a testnet wallet rpc accessible at 127.0.0.1:40403 with no authentication.<br>
The script `getScStatus_testnet.sh` expects a daemon rpc accessible to 127.0.0.1:40402 with no authentication.

## Invoking smart contract functions

### Example: Reserve a domain (label hash)
./invoke.sh Reserve 0 2 1 homebase

### Example: Claim a domain (label)
./invoke.sh Claim 0 2 1 homebase

### Explanation
`./invoke.sh` executes the wrapper (needs to be in the current working directory)<br>
`Reserve` and `Claim` are the names of the smart contract functions to invoke.<br>
`0 2 1` defines how many DERI (0) to send in the transaction, the ring size (2) and the top level domain to perform the action on (1 = .dero).<br>
`homebase` is the domain label (homebase.dero) to first reserve and then claim.

> [!IMPORTANT]
> Only lowercase labels are resolveable through dns resolution.<br>
> The smart contract does not impose limitations on the use of capital and small letters. But only all lowercase domain labels are served through dns resolution.
> Domain labels with capital letters are fully functional except for dns resolution.



### Example: Update dns zone data
./invoke Update 0 2 1 homebase zone-homebase.dero-example.json

### Explanation
`Update` invoke the Update function of the smart contract<br>
`1 homebase` for the domain label homebase at the top level domain id 1 (.dero = homebase.dero)
`zone-homebase.dero-example.json` convert the content (json string) of this file to zlib compressed msgpack data for the update
