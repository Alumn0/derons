# Dero Name Service (DeroNS or DNS)

DeroNS utilizes the Dero blockchain to provide a trustless, permissionless and efficient domain name service to anyone.
It integrates the Dero blockchain with Bind DNS to serve (not limited to) a, aaaa, txt, cname, mx and srv resource records.
It is compatible with the existing DNS system, all network devices and it doesn't require any plugin or software to be installed to resolve domains.
All you need to do is to add a resolving DNS server to your local (DHCP) network configuration.
If you do that, all connecting devices will be able to seamlessly resolve the domains managed by the smart contract.

## What is working:
1. Registering and managing any amount of top level domains (`.dero`, `.nonsensus`, `.freedom`, ...)
2. Registering and managing any amount of domains underneath top level domains (`homebase.dero`, `secretnamebase.nonsensus`, `permissionless.freedom`, ...)
3. Trading domains on chain in contract
4. Serving the Domain data through [Bind DNS](https://www.isc.org/bind/)
5. Support for the most common DNS resource record types (not limited to): `a`, `aaaa`, `txt`, `cname`, `mx` and `srv`
6. Everything is containerized with `Docker` for easy distribution to spin up your own DNS.

## What is missing:
1. Feedback
2. Public DNS resolver
3. public beta test (simulator or testnet)
4. Web frontend to register / manage domains for end customers
5. Community support to drive adoption
6. Cleaning up
7. Documentation and publishing of all components as open source

## What happens next:
1. Please review the smart contract and design decisions I made
2. Please give feedback
3. Public beta test
4. Web Frontend
5. Public launch
<br>

> [!IMPORTANT]
> Currently, only the smart contract is publicly available for study and feedback.<br>
> This documentation is work in progress. Please check back frequently for updates.<br>
<br>

## Sponsoring
Along my adventure of cooking DeroNS, I have come accross other ideas and solutions worth exploring in the Dero space.
For example, out of necessity to be able to test complex smart contracts like DeroNS, I have developed a testing toolkit to automate smart contract testing on the side.
In my research, I have also documented numerous small improvements to the Dero Virtual Machine, that would allow for significantly improved smart contracts.

To pursue these and more projects, I am seeking support in the form of sponsorship.
If you like my work, think my efforts are of value and you want me to work more in the Dero space, then please consider sponsoring me.

***You can sponsor my work by sending Dero directly to my wallet: `Alumno`<br>
Or you reach out to me to discuss your alternative.***
