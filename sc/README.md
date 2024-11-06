# Domain Name Automat

> [!IMPORTANT]
> Work in progress. Please check back frequently for updates.

This smart contract for the `Dero Stargate` network is intended to provide a `trustless`, `permissionless` and `efficient` public store.
The automat functions as an autonomous machine where all parts consider sane limits and incentives to serve domain owners best.

There are four roles implemented:
1. Captain
2. Commander
3. P-Admin
4. Lt. Commander

The **Captain** is managing the availability of top level domains and can impose royalties on Commanders.

A **Commander** is managing the settings for a single top level domain, can define the pricing for domain labels and can impose royalties on traded domain labels.

The **P-Admin**, which is the Commander by default, manages a public key/value store space for a specific top level domain, which can be utilized to provide additional services or information, such as trusted public DNS resolvers.

The **Lt. Commander** is the actual domain owner who manages its contents and has the authority to trade it.<br>
<br>

> [!IMPORTANT]
> Note that there are no administrative permissions to overrule anyones decision.
> The Captain and Commanders can not impair already provided public resources (top level domains, domains).
> The Captain and Commanders can set unreasonable prices or label length settings, but any change applies only to future actions.
> If you registered your domain and pay the fee for the next 200 years, then no Captain or Commander can change anything about that for the next 200 years.
>
> ***No one can break the machine.***


## How to claim a domain label

When the sunrise phase of the top level domain has passed, anyone can claim domain labels on a first come first serve basis.
To prevent transaction pool attack vectors, one first needs to reserve the sha256 hash of the domain label before claiming it.

```
Reserve(1, "5747a72836c99bb6a5287dbb6aadf589778a1e8c676e5808d1f2415bfb030c9c")
Claim(1, "welcome-home")
```

The Reserve and Claim functions can impose a fixed fee in DERI (0.00001 DERO = 1 DERI) . The fee is set by the Commander.
If one sends not enough DERI to invoke the function, the smart contract will just return the DERI to the sender.
If one sends too much DERI, the smart contract will refund the change.

During the sunrise phase, only the Commander of that top level domain can reserve and claim domain labels.
If a domain label expired it enters an orphaned period during which it can be reserved and claimed only by the Commander.

## How to renew a domain label

```
Extend(1, "welcome-home", 1)
```

Anyone can extend the registration time for any domain label by any amount. When invoking the function Extend, a multiplier for the extension period has to be provided.a



## How to trade a domain label

The smart contract offers the following function pairs to provide a platform for trustless and permissionless trading of domain labels without intermediary.
If the domain label is locked, then the Claim* functions are blocked, an owner change is impossible.

```
Transfer(1, "welcome-home", "deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9", 100000)
ClaimTransfer(1, "welcome-home")
```

The Transfer function allows to transfer a domain for a specific quantity of DERI (can be 0) to a specific destination account.<br>
The ClaimTransfer function has to be invoked by the destination account after the sending account initiated the transfer. The destination account has to send the required amount of DERI in the same transaction to successfully claim the transfer.<br>

```
Offer(1, "welcome-home", 100000)
ClaimOffer(1, "welcome-home")
```

The Offer function allows a domain label owner to offer the label for a set quantity of DERI for anyone to claim.<br>
The ClaimOffer function allows anyone that sends enough DERI to claim the offer.


```
Bid(1, "welcome-home")
ClaimBid(1, "welcome-home", 100000)
```

The Bid function allows anyone to make an offer for a domain label. Only the highest bid is available. If one makes a bid, the new bid must be higher than the current one. A bid has a minimum time before the bidder can cancel it. The bidder must include the actual amount of DERI in the transaction to place the bid. The former bidder will receive back the DERI from the previous bid.<br>
The ClaimBid function has to be invoked by the domain label owner to accept the bid and receive the DERI.


## How to lock a domain label

```
SetLock(1, "welcome-home", 1704088800)
SetLock(1, "welcome-home", 18446744073709551615)
```

The SetLock function allows the domain label owner to resign from all authority over the domain label until a timestamp has passed. Nobody will be able to update the data stored with the domain label. Owner transfers (bid, offer, transfer) are impossible. The only way to release the lock of a domain label is to let it expire and then claim it again.<br>
Locking a domain label is useful in situation where it is necessary to delegate all authority over the stored data to a different smart contract.


## How to update a domain label

```
Update(1, "welcome-home", <DATA>, "msgpack/zlib")
```

The domain label owner is authorized to update the data stored on the blockchain. <DATA> can be any hexencoded string of approx. 6600 bytes. The Commander can set a fixed fee for performing updates. "msgpack/zlib" is a data encoding that DeroNS supports to maximize the quantity of data that can be stored in the available space. The encoding is an arbitrary string to inform reading apps of how to handle the data.
<br>
<br>


## Public functions:
```
Function Initialize() Uint64

Initializes the contract. Is invoked only once on contract installation.

Parameters:
none


Function Reserve(tld Uint64, h String) Uint64

Reserves the hash of a domain label.
May require a fee to be paid.

Parameters:
tld - top level domain id
h - sha256 hash of a domain label

Example:
Reserve(1, "5747a72836c99bb6a5287dbb6aadf589778a1e8c676e5808d1f2415bfb030c9c")


Function Claim(tld Uint64, l String) Uint64

Claims a previously reserved domain label.
May require a fee to be paid.

Parameters
tld - top level domain id
l - domain label.

Example:
Claim(1, "welcome-home")

Function Extend(tld Uint64, l String, q Uint64) Uint64

Extends the reserved duration of a domain label.
May require a fee to be paid.

Parameters:
tld - top level domain id
l - domain label
q - quantity. Multiplier for the registration period. If the registration period is 31557600 seconds (1 year), then a quantity of 2 will extend the registration period to 63115200 seconds (2 years).

Example:
Extend(1, "welcome-home", 1)


Function Update(tld Uint64, l String, z String, e String) Uint64

Updates the data stored for a domain label.
May require a fee to be paid.

Parameters:
tld - top level domain id
l - domain label
z - zone data (hexencoded)
e - encoding. A descriptor for the encoding used for the zone data. This tells reading processes what to expect and how to handle the zone data.

Example:
Update(1, "welcome-home", <DATA>, "msgpack/zlib")

<DATA> = 78da6b5c9c9257dcb2d0a165516ec5a4e685995c0b4bb6e72666e6e895a7e624e7e7a6ea660009bd94d4a27cbdc525253967f9049a16668a2c2cd90152648445d5c2c449ab0d2d8df40ccd2cf40cf58c90d8c64b128160d26a23030343ab94240b2b2b4324b6d1e2928a920d65b6c50569860a890ab9150a758939394b40d6342f4c4432c6046c0c924e93c5c54565935a1766322c2c675c587096f921013fc828b4823c0a578cd32f501f2f05cb372d4c5c8b7085a18101d81d6b917c6360b0b8bcbcbc09c5b5a6e8ae350600f39f878d

Expands to:
{
        "dns": {
            "@": {
                "mx": [
                    {
                        "i": 10,
                        "t": "mail.welcome-home.dero.",
                        "ttl": 3600
                    },
                    {
                        "i": 20,
                        "t": "mail2.welcome-home.dero."
                    }
                ],
                "a": [
                    "192.168.1.2",
                    "192.168.1.3"
                ],
                "aaaa": [
                    "2001:db8::1",
                    "2001:db8::2"
                ],
                "txt": "v=spf1 a mx ~all"
            },
            "mail": {
                "a": "192.168.1.4",
                "aaaa": "2001:db8::4",
                "srv": [
                    {
                        "i": 0,
                        "w": 1,
                        "p": 993,
                        "t": "mail.welcome-home.dero.",
                        "ttl": 7200
                    },
                    {
                        "i": 10,
                        "w": 1,
                        "p": 993,
                        "t": "mail2.welcome-home.dero.",
                        "ttl": 3600
                    }
                ]
            },
            "mail2": {
                "a": "192.168.1.100",
                "aaaa": "2001:db8::100"
            },
            "www": {
                "a": "192.168.1.5",
                "aaaa": "2001:db8::3"
            }
        }
    }


Function Transfer(tld Uint64, l String, d String, v Uint64) Uint64

Transfers a domain label to another account.
May charge royalties to the current owner.

Parameters:
tld - top level domain id
l - domain label
d - destination account
v - value. The amount of DERI to be paid to the current owner of the domain label.

Examples:
Transfer(1, "welcome-home", "deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9", 0)
Transfer(1, "welcome-home", "deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9", 100000)


Function SetLock(tld Uint64, l String, v Uint64) Uint64

Locks a domain label until a certain timestamp.
If a domain label is locked, it can only be extended.
If a domain label expires, the lock gets removed on the next registration.

Parameters:
tld - top level domain id
l - domain label
v - value. The timestamp until which the domain label is locked.

Example:
SetLock(1, "welcome-home", 1704088800)
SetLock(1, "welcome-home", 18446744073709551615)


Function ClaimTransfer(tld Uint64, l String) Uint64

Claims the initiated transfer of a domain label.
May require a fee to be paid.

Parameters:
tld - top level domain id
l - domain label

Example:
ClaimTransfer(1, "welcome-home")


Function Offer(tld Uint64, l String, q Uint64) Uint64

Offers a domain label for sale for a specific price.

Parameters:
tld - top level domain id
l - domain label
q - quantity. The amount of DERI for which the domain label is offered.

Example:
Offer(1, "welcome-home", 100000)


Function ClaimOffer(tld Uint64, l String) Uint64

Claims the offer of a domain label.
May require a fee to be paid.

Parameters:
tld - top level domain id
l - domain label

Example:
ClaimOffer(1, "welcome-home")


Function Bid(tld Uint64, l String) Uint64

Bids an amount of DERI on a domain label.
Requires to send DERI with the transaction.

Parameters:
tld - top level domain id
l - domain label

Example:
Bid(1, "welcome-home")


Function ClaimBid(tld Uint64, l String, v Uint64) Uint64

Claims the bid on a domain label.
May subtract royalties from the bid.

Parameters:
tld - top level domain id
l - domain label
v - value. The minimum amount of DERI to claim. If the bid is lower than is value, the claim is not performed.

Example:
ClaimBid(1, "welcome-home", 100000)


Function ReserveTld(h String) Uint64

Reserves the hash of a top level domain label.
May require a fee to be paid.
May fail due to insufficient unregistered top level domains availability.

Parameters:
h - sha256 hash of a top level domain label

Example:
ReserveTld("6b2662e3a1f6a133d438cd99ca9cf536e77bc0345c25f6c56911cf8098ee7ae2")

Function ClaimTld(l String) Uint64

Claims a previously reserved top level domain label.
May require a fee to be paid.

Parameters:
l - top level domain label

Example:
ClaimTld("dero")


Function TransferTld(tld Uint64, d String) Uint64

Transfers a top level domain label to another account.

Parameters:
tld - top level domain id
d - destination account

Example:
TransferTld(1, "deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9")

Function ClaimTransferTld(tld Uint64) Uint64

Claims the initiated transfer of a top level domain label.

Parameters:
tld - top level domain id

Example:
ClaimTransferTld(1)


Function TransferSc(d String) Uint64

Transfers the contract to another account.

Parameters:
d - destination account

Example:
TransferSc("deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9")


Function ClaimTransferSc() Uint64

Claims the initiated transfer of the contract.

Example:
ClaimTransferSc()


Function SetCsp(scid String, data String) Uint64

Sets a successor contract with arbitrary data.

Parameters:
scid - successor contract id
data - arbitrary data (hexencoded)

Example:
SetCsp("8d3ba65b9203e83356e076e375e7bc20e7ab1ef5ce3228fe464f28f029d5699d", "7768617465766572")


Function TransferP(tld Uint64, d String) Uint64

Transfers the P(ublic) space of a top level domain label to another account.

Parameters:
tld - top level domain id
d - destination account

Example:
TransferP(1, "deto1qyx7qyvrtrhvaszeej487k2g689fav7h38ay37fja9qf40ycgl0m2qg8ap2y9")


Function ClaimTransferP(tld Uint64) Uint64

Claims the initiated transfer of the P(ublic) space of a top level domain label.

Parameters:
tld - top level domain id

Example:
ClaimTransferP(1)

Function SetP(tld Uint64, k String, v String, t Uint64) Uint64

Sets a key/value pair in the P(ublic) space of a top level domain label.
Stays unlocked when domain label is locked.

Parameters:
tld - top level domain id
k - key
v - value (hexencoded if t is not 1)
t - type. If 1 then v is converted to Uint64

Example:
SetP(1, "testkey-1", "7768617465766572", 0)
SetP(1, "testkey-2", "18446744073709551615", 1)


Function SetLabelLength(tld Uint64, min Uint64, max Uint64) Uint64

Sets the minimum and maximum length of a domain label at a top level domain.
Has to be from 1 to 63. (inclusive)

Parameters:
tld - top level domain id
min - minimum length
max - maximum length

Example:
SetLabelLength(1, 1, 63)


Function SetDuration(tld Uint64, k String, v Uint64) Uint64

Sets the duration for the operations:
register - the duration for which a domain label is registered
extend - the duration for which a domain label is extended
orphan - the duration for which a domain label is orphaned
reserve - the duration for which a domain label hash is reserved
bid - the duration for which a bid on a domain label can not be lowered or deleted

Parameters:
tld - top level domain id
k - key. One of: register, extend, orphan, reserve, bid
v - value. The duration in seconds.

Examples:
SetDuration(1, "register", 31557600)
SetDuration(1, "extend", 31557600)
SetDuration(1, "orphan", 15778800)
SetDuration(1, "reserve", 600)
SetDuration(1, "bid", 600)


Function SetSunrise(tld Uint64, v Uint64) Uint64

Sets the timestamp for the end of the sunrise period for a top level domain.
The default value is max Uint64 (18446744073709551615).
A  call to this function can only lower the current value.

Parameters:
tld - top level domain id
v - value. The timestamp for the end of the sunrise period.

Example:
SetSunrise(1, 1704088800)


Function SetFeeS(tld Uint64, k String, v Uint64) Uint64

Sets a fee with one of these string keys for a top level domain:
reserve - reserving a domain label hash
update - updating a domain label's data store
default - fallback fee in case no other fee is set
offer - royalty fee when a domain label changes ownership through an offer
bid - royalty fee when a domain label changes ownership through a bid
transfer - royalty fee when a domain label changes ownership through a transfer
royalty - royalty fee imposed by the captain of the smart contract on the commander of a top level domain

Parameters:
tld - top level domain id
k - key. One of: reserve, update, default, offer, bid, transfer, royalty
v - value. The fee in DERI for reserve, update and default. The fee in 1/100th of a percent for offer, bid, transfer and royalty.

Examples:
SetFeeS(1, "reserve", 200)
SetFeeS(1, "update", 200)
SetFeeS(1, "default", 200)
SetFeeS(1, "offer", 1000) // 10%
SetFeeS(1, "bid", 2000)  // 20%
SetFeeS(1, "transfer", 1000) // 10%
SetFeeS(1, "royalty", 1000) // 10%


Function SetFeeU(tld Uint64, k Uint64, v Uint64) Uint64

Sets a fee for claiming a domain label with a specific length.

Parameters:
tld - top level domain id
k - key. The length of the domain label.
v - value. The fee in DERI.

Example:
SetFeeU(1, 5, 100000)


Function SetTldFee(k String, v Uint64) Uint64

Sets a fee with one of these string keys for all top level domains:
reserve - reserving a domain label hash
register - claiming a domain label
royalty - royalty fee imposed by the captain of the smart contract on all commanders of a top level domains

Parameters:
k - key. One of: reserve, register, royalty
v - value. The fee in DERI for reserve and register. The fee in 1/100th of a percent for royalty.

Examples:
SetTldFee("reserve", 200)
SetTldFee("register", 200)
SetTldFee("royalty", 1000) // 10%


Function SetTldAvailMax(v Uint64) Uint64

Sets the maximum amount of unregistered top level domains that can be available simultaneously.
Lowering this limit does not lower the amount of unregistered top level domains that are already available.

Parameters:
v - value. The limit of unregistered top level domains.

Example:
SetTldAvailMax(5)


Function SetRefill(k String, v Uint64) Uint64

Sets the one of these string keys for the refill of unregistered top level domains:
interval - the interval in seconds after which the amount of available unregistered top level domains can be increased.
amount - the amount of unregistered top level domains that can be added to the available unregistered top level domains.

Parameters:
k - key. One of: interval, amount
v - value. The interval in seconds or the amount of unregistered top level domains that can be added with each refill.

Examples:
SetRefill("interval", 31557600)
SetRefill("amount", 1)


Function SetTldDurationReserve(v Uint64) Uint64

Sets the duration for which a top level domain label hash is reserved.

Parameters:
v - value. The duration in seconds.

Example:
SetTldDurationReserve(600)


Function Refill() Uint64

Refills the amount of available unregistered top level domains if the interval has passed since the last refill by the amount set for a refill.

Parameters:
none


Function Withdraw(tld Uint64, q Uint64) Uint64

Withdraws DERI from the contract.

Parameters:
tld - top level domain id
q - quantity. The amount of DERI to withdraw. (0 for all)

Example:
Withdraw(1, 100000)
```
