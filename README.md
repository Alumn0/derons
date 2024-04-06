# Dero Name Service (DeroNS or DNS)
<img src="https://github.com/Alumn0/derons/assets/145239468/529d2090-2149-4216-94ec-916810b71953" width="700">
<br>
<br>

## Components
DeroNS comprises:
1. **One Smart Contract**: Handles domain registration on the DERO blockchain.
2. **CLI / App** (in development): Tools for domain management.
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
<img src="https://github.com/Alumn0/derons/assets/145239468/692aad1c-c6b1-4d50-8be9-5f3b605467cf" width="700">
<br>
<br>
<br>

## Domain Registration and Management
<img src="https://github.com/Alumn0/derons/assets/145239468/97bcc36d-e62f-41ba-8271-9005bb0abd16" width="700">
<br>
<br>
<br>

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
