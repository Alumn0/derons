# DeroNS CLI
A command line wrapper to interact with DeroNS Smart Contract.

> [!IMPORTANT]
> - **The DERO testnet's block time is 60 seconds. That means on-chain data updates only evey minute.**
> - For domain name resolution to work, the domain name must be a valid domain name label (https://www.rfc-editor.org/rfc/rfc1035) and **must not** contain capitalized letters.
> - The smart contract is designed to refund incorrect or excess amounts where possible.
> - The commands and scripts use the public testnet node `ns1.testnet.dero.zone`.
> - Testnet domain rules:
>     - Reserve for 120 seconds (2 minutes)
>     - Claim for 86400 seconds (24 hours)
>     - Extend / renew for 3600 seconds (1 hour)
>     - No fees imposed by the contract.
>     - domain label length (excl. `.dero`): min 1 / max 63 characters
>     - ns1.testnet.dero.zone synchronizes every 5 minutes with on-chain data
>     - TTL for dns resource records:
>         - default: 900 seconds (15 minutes)
>         - minimum: 300 seconds (5 minutes)
>         - maximum: 21600 seconds (6 hours)


## Getting Started with DeroNS CLI on Docker
### Prerequisites:
- **Docker:** Ensure Docker is installed on your system. If you haven't installed Docker yet, follow the [official Docker installation guide](https://docs.docker.com/engine/install/).
- **Dero CLI wallet for Linux 64-bit:** Download it from the [official Dero download page](https://dero.io/download.html#linux) and extract the files into a directory.
- **Terminal window**: Open a terminal and change directory to the extracted `Dero CLI wallet for Linux 64-bit` files.
### Execute the following commands in the terminal window.
#### Step 1: Display DeroNS Smart Contract status
Retrieves the data automatically from the public testnet node `ns1.testnet.dero.zone:40402`. To colorize and filter the output, install jq (command-line JSON processor) and add ` | jq` to the end of this command:
```shell
docker run --rm alumn0/derons-cli
```

![DeroNS-sc-status-colored](https://github.com/Alumn0/derons/assets/145239468/d668264b-8175-4220-b4ed-d8a64757fb8f)

#### Step 2: Create local Docker network
Create local `derons` network to allow the DeroNS CLI container to communicate with the Dero CLI wallet container.
```shell
docker network create derons
```
#### Step 3: Start Dero CLI in Testnet Mode
Create a container and start the Dero CLI wallet inside.
```shell
docker run -it --rm --name "dero-cli-testnet" --network derons -v $(pwd):/opt/dero -w /opt/dero debian:12-slim /bin/sh -c './dero-wallet-cli-linux-amd64 --testnet --daemon-address=ns1.testnet.dero.zone:40402 --rpc-server --rpc-bind=0.0.0.0:40403'
```
#### Step 4: Create a testnet account
You can use your existing testnet account and don't need to create a new one. Just restore from seed or copy your wallet files into the `Dero CLI wallet for Linux 64-bit` directory and adjust file permissions accordingly.

![testnet-account-registration](https://github.com/Alumn0/derons/assets/145239468/fa2a1299-4617-49d3-8176-c252dda6617e)

#### Step 5: Reserve a domain
Reserve domain `test12345678.dero` before claiming it. Change `test12345678` to the domain name you want to reserve  without `.dero`.
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Reserve 0 2 1 test12345678
```

Reserving a domain affects these DeroNS Smart Contract stores:
```
t,1,r,counter = Total number of domain reservations (Uint64)
t,1,r,<DOMAIN-SHA256> = Raw address that reserved a domain (String)
t,1,r,<DOMAIN-SHA256>,e = Reservation expires (unix timestamp, Uint64)
```

#### Step 6: Verify the operation
You can verify whether the operation succeeded by displaying the DeroNS Smart Contract status (Step 1) again and compare the outputs. If you don't see any changes, you might need to wait for about a minute and then check again to see the changes reflected on-chain.
```shell
docker run --rm alumn0/derons-cli
```

#### Step 7: Claim a domain
Claim domain test12345678.dero after reserving it previously.
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Claim 0 2 1 test12345678
```

Affected DeroNS Smart Contract stores:
```
t,1,l,<DOMAIN-HEX> = Domain owner's raw address (String)
t,1,l,<DOMAIN-HEX>,r = Registration timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,e = Expiration timestamp (unix timestamp, Uint64)
t,1,r,<DOMAIN-SHA256> = Raw address that reserved a domain (String)
t,1,r,<DOMAIN-SHA256>,e = Reservation expires (unix timestamp, Uint64)
```

#### Step 8: Renew / Extend domain registration period
Renew / Extend domain test12345678.dero by 1 year (8760 hours).
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Extend 0 2 1 test12345678 8760
```

Affected DeroNS Smart Contract stores:
```
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,e = Expiration timestamp (unix timestamp, Uint64)
```


#### Step 9: Update domain zone data
Save this simple zone data example to a file and name it `dns-zone-data.json`. Place that file in the `Dero CLI wallet for Linux 64-bit` directory (Step 'Prerequisites').:

```json
{
    "dns": {
        "@": {
            "a": "195.246.230.239"
        }
    }
}
```
For a more comprehensive example have a look at: [zone-homebase.dero-example.json](https://github.com/Alumn0/derons/blob/main/sc/cli/zone-homebase.dero-example.json)<br>
More information on BIND9 resource records: https://bind9.readthedocs.io/en/latest/chapter3.html#resource-records<br>
DeroNS domains supports `A`, `AAAA`, `TXT`, `CNAME`, `MX`, and `SRV` resource records, with the capability to extend this list as needed.

**Update domain zone data for test12345678.dero:**
```shell
docker run --rm --network derons -v $(pwd)/dns-zone-data.json:/app/cli/dns-zone-data.json alumn0/derons-cli ./invoke_testnet.sh Update 0 2 1 test12345678 dns-zone-data.json
```

Affected DeroNS Smart Contract stores:
```
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,z = Encoded stored zone data (String)
t,1,l,<DOMAIN-HEX>,z,e = Zone data encoding, defaults to `msgpack/zlib` (String)
```

#### Step 8: Query domain resource records
Query domain test12345678.dero's "a"-resource record. Be sure to wait 5 minutes for the name server to update its data from the blockchain. Adjust `a` to the resource record type you want to query (`a`, `aaaa`, `cname`, `txt`, `srv`, `mx`) and remove `+short` for a more detailed output.
```shell
docker run --rm alumn0/derons-cli dig @ns1.testnet.dero.zone test12345678.dero a +short
```
For more information on `dig`, please have a look the the [official BIND 9 man page for dig](https://downloads.isc.org/isc/bind9/cur/9.19/doc/arm/html/manpages.html#dig-dns-lookup-utility).

> [!IMPORTANT]
> The command above should output at least one ip address. If it outputs nothing instead, then that could be an indication that your dns traffic is being filtered.
> You will need to use an ISP or VPN that allows for unfiltered dns traffic.

## Build the docker image
#### Step 1: Clone the git respository
```shell
git clone https://github.com/Alumn0/derons.git
```

#### Build docker image
Change into the sub directory `sc` and run the following `docker build` command:
```shell
docker build --pull --rm -t alumn0/derons-cli:latest .
```

## Command reference
#### A command explained:
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Reserve 0 2 1 test12345678
```
|Parameter|Description|
|---|---|
|docker run|Create container from docker image|
|--rm|Remove container after termination|
|--network derons|Attach to `derons` network|
|alumn0/derons-cli|Docker image to use|
|./invoke_testnet.sh|Execute CLI wrapper|
|Reserve|Invoke this smart contract method|
|0|Send this amount of DERI (100000 DERI = 1 DERO)|
|2|Use this ring size for the transaction|
|1|The top level domain (1=`.dero`)|
|test12345678|The domain name label (excl. `.dero`)|


#### Query public DeroNS Resolver for domain resource records
```shell
docker run --rm alumn0/derons-cli dig @ns1.testnet.dero.zone homebase.dero a
```
> [!IMPORTANT]
> The command above should output at least one ip address. If it outputs nothing instead, then that could be an indication that your dns traffic is being filtered.
> You will need to use an ISP or VPN that allows for unfiltered dns traffic.

#### Create local Docker `derons` network
```shell
docker network create derons
```

#### Start Dero CLI in testnet mode
```shell
docker run -it --rm --name "dero-cli-testnet" --network derons -v $(pwd):/opt/dero -w /opt/dero debian:12-slim /bin/sh -c './dero-wallet-cli-linux-amd64 --testnet --daemon-address=ns1.testnet.dero.zone:40402 --rpc-server --rpc-bind=0.0.0.0:40403'
```

#### Display smart contract status
```shell
docker run --rm --network derons alumn0/derons-cli
```

#### Display status of specific domain (1 liner version, change domain name label `test12345678`)
Requires `jq`, a command-line JSON processor.
```shell
export DOMAIN=test12345678 \
&& export HEX_DOMAIN=$(docker run --rm alpine /bin/sh -c 'echo -n "'${DOMAIN}'" | xxd -p -c 256') \
&& docker run --rm --network derons alumn0/derons-cli | jq --arg prefix "t,1,l,${HEX_DOMAIN}" '.result.stringkeys | to_entries | map(select(.key | startswith($prefix))) | from_entries' && unset HEX_DOMAIN && unset DOMAIN
```

#### Determine hex encoded domain name label (change `test12345678`)
```shell
docker run --rm alpine /bin/sh -c 'echo -n "test12345678" | xxd -p -c 256'
```

#### Display status of specific domain (change hex encoded domain name `746573743132333435363738`)
```shell
docker run --rm --network derons alumn0/derons-cli | jq '.result.stringkeys | to_entries | map(select(.key | startswith("t,1,l,746573743132333435363738"))) | from_entries'
```

#### Display status of specific domain (alternative with regular expression, change hex encoded domain name `746573743132333435363738`)
```shell
docker run --rm --network derons alumn0/derons-cli | jq '.result.stringkeys | to_entries | map(select(.key | test("^t,1,l,746573743132333435363738"))) | from_entries'
```

#### Reserve domain test12345678.dero before claiming
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Reserve 0 2 1 test12345678
```
Affects stores:
```
t,1,r,counter = Total number of domain reservations (Uint64)
t,1,r,<DOMAIN-SHA256> = Raw address that reserved a domain (String)
t,1,r,<DOMAIN-SHA256>,e = Reservation expires (unix timestamp, Uint64)
```

#### Claim previously reserved domain test12345678.dero
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Claim 0 2 1 test12345678
```
Affects stores:
```
t,1,l,<DOMAIN-HEX> = Domain owner's raw address (String)
t,1,l,<DOMAIN-HEX>,r = Registration timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,e = Expiration timestamp (unix timestamp, Uint64)
t,1,r,<DOMAIN-SHA256> = Raw address that reserved a domain (String)
t,1,r,<DOMAIN-SHA256>,e = Reservation expires (unix timestamp, Uint64)
```

#### Update zone data for test12345678.dero
Save your domain zone data to a file `dns-zone-data.json` in the your current working directory before executing the following command. See example `dns-zone-data.json` file below.
```shell
docker run --rm --network derons -v $(pwd)/dns-zone-data.json:/app/cli/dns-zone-data.json alumn0/derons-cli ./invoke_testnet.sh Update 0 2 1 test12345678 dns-zone-data.json
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,e = Expiration timestamp (unix timestamp, Uint64)
```

#### Example dns-zone-data.json file
Simple example:
```json
{
    "dns": {
        "@": {
            "a": "195.246.230.239"
        }
    }
}
```
More comprehensive example: https://github.com/Alumn0/derons/blob/main/sc/cli/zone-homebase.dero-example.json<br>
For more information on BIND9 resource records: https://bind9.readthedocs.io/en/latest/chapter3.html#resource-records<br>
DeroNS domains support `A`, `AAAA`, `TXT`, `CNAME`, `MX`, and `SRV` resource records, with the capability to extend this list as needed.

#### Renew / Extend domain test12345678.dero
On testnet domains renew by 3600 seconds (1 hour), extend domain by 24 hours x 365 days = 8760 hours
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Extend 0 2 1 test12345678 8760
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,e = Expiration timestamp (unix timestamp, Uint64)
```

#### Transfer domain test12345678.dero for 1 DERO (=100000 DERI) to account deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Transfer 0 2 1 test12345678 deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9 100000
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,c = Raw address permitted to claim the domain transfer (String)
t,1,l,<DOMAIN-HEX>,c,v = Quantity of Deri required to successfully claim the domain transfer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Cancel domain transfer for test12345678.dero (empty address cancels the transfer)
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Transfer 0 2 1 test12345678 "" 0
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,c = Raw address permitted to claim the domain transfer (String)
t,1,l,<DOMAIN-HEX>,c,v = Quantity of Deri required to successfully claim the domain transfer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Claim domain transfer for test12345678.dero for 1 DERO (=100000 DERI) from account deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh ClaimTransfer 100000 2 1 test12345678
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,c = Raw address permitted to claim the domain transfer (String)
t,1,l,<DOMAIN-HEX>,c,v = Quantity of Deri required to successfully claim the domain transfer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,o = Quantity of Deri required to successfully claim the domain offer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Offer domain test12345678.dero for 2 DERO (=200000 DERI)
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Offer 0 2 1 test12345678 200000
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,o = Quantity of Deri required to successfully claim the domain offer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Remove domain offer for test12345678.dero (placing same offer a second time, deletes it)
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Offer 0 2 1 test12345678 200000
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,o = Quantity of Deri required to successfully claim the domain offer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Claim domain offer for test12345678.dero for 2 DERO (=200000 DERI)
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh ClaimOffer 200000 2 1 test12345678
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,c = Raw address permitted to claim the domain transfer (String)
t,1,l,<DOMAIN-HEX>,c,v = Quantity of Deri required to successfully claim the domain transfer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,o = Quantity of Deri required to successfully claim the domain offer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Bid 1 DERO (=100000 DERI) on test12345678.dero
Needs to be highest bid or gets rejected
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Bid 100000 2 1 test12345678
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,b = Raw address of current highest bidder (String)
t,1,l,<DOMAIN-HEX>,b,v = Current highest bid (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,b,e = Minimum commitment window. Current bid can be changed only after timestamp has passed. (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Remove Bid on test12345678.dero (sending 0 DERI removes the current bid)
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh Bid 0 2 1 test12345678
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,b = Raw address of current highest bidder (String)
t,1,l,<DOMAIN-HEX>,b,v = Current highest bid (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,b,e = Minimum commitment window. Current bid can be changed only after timestamp has passed. (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```

#### Claim bid on test12345678.dero if bid >=1 DERO (=100000 DERI)
```shell
docker run --rm --network derons alumn0/derons-cli ./invoke_testnet.sh ClaimBid 0 2 1 test12345678 100000
```
Affects stores:
```
t,1,l,<DOMAIN-HEX>,b = Raw address of current highest bidder (String)
t,1,l,<DOMAIN-HEX>,b,v = Current highest bid (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,b,e = Minimum commitment window. Current bid can be changed only after timestamp has passed. (unix timestamp, Uint64)
t,1,l,<DOMAIN-HEX>,c = Raw address permitted to claim the domain transfer (String)
t,1,l,<DOMAIN-HEX>,c,v = Quantity of Deri required to successfully claim the domain transfer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,o = Quantity of Deri required to successfully claim the domain offer (100000 = 1 Dero, Uint64)
t,1,l,<DOMAIN-HEX>,u = Update timestamp (unix timestamp, Uint64)
```
