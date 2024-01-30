# Dero Name Service (DeroNS or DNS)

DeroNS extends ICANN's DNS system by adding new Top Level Domains (TLDs) like `.dero` and domains such as `homebase.dero`. These are registered through the DeroNS Smart Contract and integrate with existing networks using the DeroNS Resolver. Domain registration and management are facilitated by the DeroNS CLI and user-friendly DeroNS App.

## Components
DeroNS comprises:
1. **One Smart Contract**: Handles domain registration on the DERO blockchain.
2. **CLI / App**: Tools for domain management.
3. **Resolver**: Connects DeroNS domains with standard DNS queries.
   - Supports DNS records: `a`, `aaaa`, `txt`, `cname`, `mx`, `srv`

### Public Beta Test
- DeroNS Resolver: `ns1.testnet.dero.zone` (IP: `195.246.230.239`)
- Add as DNS resolver in local network or router configuration to resolve `.dero` domains
- Access domains via browser: Precede with `http://` (e.g., `http://homebase.dero`)
- Query domain settings: `dig @ns1.testnet.dero.zone homebase.dero mx`
- Registration period: 1 day (86400 seconds), renewal extends by 1 hour (3600 seconds).
- Zone data updates every 5 minutes
- Testnet smart contract URL: [DeroNS Testnet Smart Contract](https://testnetexplorer.dero.io/tx/acdc0e94fa87904a3eebad656c809d29046fdbfa69a6fd3a82b23b93b07412be)
- Reminder: Remove the DeroNS Resolver from configurations after testing

## How DeroNS integrates
![DeroNS-Integrates](https://github.com/Alumn0/derons/assets/145239468/d3a46934-76f2-4e5f-99d6-734d373f6eec)

## Domain Registration and Management
![DeroNS-Domains](https://github.com/Alumn0/derons/assets/145239468/53faa464-c1eb-45c7-a0ba-086da6c2b998)

## DeroNS Smart Contract features
![DeroNS-Features](https://github.com/Alumn0/derons/assets/145239468/07fd476d-0df9-415b-92c3-b13f5e321cb9)

---

> [!IMPORTANT]
> This documentation is a work in progress. Please check back frequently for updates.

---

## Sponsorship Request

As I navigate the journey of developing DeroNS, I've encountered numerous potential innovations within the Dero ecosystem. Notably, I've created a toolkit for automated smart contract testing, born from the need to efficiently test intricate contracts like DeroNS. Additionally, my research has led to the identification of several enhancements for the Dero Virtual Machine, paving the way for more advanced smart contracts.

To further these initiatives and explore new projects, I am seeking sponsorships. Your support will enable me to dedicate more time and resources to developing valuable solutions in the Dero space.

**Interested in supporting my work?** You can sponsor me by sending Dero to my wallet: `Alumno`. Alternatively, feel free to contact me to discuss other forms of sponsorship.

---

*Your contribution is vital to the continuous innovation and development in the Dero ecosystem.*
