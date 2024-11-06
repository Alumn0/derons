Function Initialize() Uint64
1 IF e("c,created") == 1 THEN GOTO 7
2 STORE("c,created", bt())
3 STORE("c,created,height", BLOCK_HEIGHT())
4 STORE("c,captain", SIGNER())
5 STORE("c,t,fee,royalty,max", 3000)
6 STORE("c,t,avail", 2)
7 RETURN 0
End Function

Function Reserve(tld Uint64, h String) Uint64
1 DIM k as String
2 IF isVT(tld) != 1 || STRLEN(h) != 64 || isSignerKnown() != 1 THEN GOTO 16
3 IF e(getTldCKey(tld) + ",sunrise") != 1 THEN GOTO 5
4 IF LOAD(getTldCKey(tld) + ",sunrise") > bt() && isCommander(tld) != 1 THEN GOTO 16
5 IF DEROVALUE() < getFee(tld, "reserve") THEN GOTO 16
6 LET k = "t," + tld + ",r," + h
7 IF e(k) != 1 THEN GOTO 10
8 IF LOAD(k + ",e") < bt() THEN GOTO 10
9 GOTO 16
10 STORE(k, SIGNER())
11 STORE(k + ",e", bt() + getD("reserve", tld))
12 iC("t," + tld + ",r,counter", 1)
13 re(DEROVALUE()-getFee(tld, "reserve"), tld)
14 aB(getFee(tld, "reserve"), tld)
15 GOTO 17
16 re(DEROVALUE(), tld)
17 RETURN 0
End Function

Function Claim(tld Uint64, l String) Uint64
1 DIM rk, k as String
2 LET rk = "t," + tld + ",r," + HEX(SHA256(l))
3 IF e(rk) != 1 THEN GOTO 32
4 IF isVT(tld) != 1 || isVL(l, tld) != 1 THEN GOTO 30
5 IF DEROVALUE() < getFee(tld, ITOA(STRLEN(l))) THEN GOTO 32
6 LET k = getKey(l, tld)
7 IF e(k) != 1 THEN GOTO 12
8 IF isCommander(tld) != 1 THEN GOTO 10
9 IF LOAD(k + ",e") < bt() THEN GOTO 13
10 IF LOAD(k + ",e") + getD("orphan", tld) < bt() THEN GOTO 12
11 GOTO 30
12 IF LOAD(rk) != SIGNER() THEN GOTO 32
13 STORE(k, SIGNER())
14 STORE(k + ",r", bt())
15 STORE(k + ",u", bt())
16 STORE(k + ",e", bt() + getD("register", tld))
17 iC("t," + tld + ",l,counter", 1)
18 d(rk)
19 d(rk + ",e")
20 IF e(k + ",o") != 1 THEN GOTO 22
21 d(k + ",o")
22 IF e(k + ",c") != 1 THEN GOTO 25
23 d(k + ",c")
24 d(k + ",c,v")
25 IF e(k + ",l") != 1 THEN GOTO 27
26 d(k + ",l")
27 re(DEROVALUE()-getFee(tld, ITOA(STRLEN(l))), tld)
28 aB(getFee(tld, ITOA(STRLEN(l))), tld)
29 GOTO 33
30 d(rk)
31 d(rk + ",e")
32 re(DEROVALUE(), tld)
33 RETURN 0
End Function

Function Extend(tld Uint64, l String, q Uint64) Uint64
1 IF isVT(tld) != 1 || isVL(l, tld) != 1 || q < 1 THEN GOTO 9
2 IF DEROVALUE() < getFee(tld, ITOA(STRLEN(l))) * q THEN GOTO 9
3 IF e(getKey(l, tld)) != 1 THEN GOTO 9
4 STORE(getKey(l, tld) + ",u", bt())
5 STORE(getKey(l, tld) + ",e", LOAD(getKey(l, tld) + ",e") + (getD("extend", tld) * q))
6 re(DEROVALUE() - (getFee(tld, ITOA(STRLEN(l))) * q), tld)
7 aB(getFee(tld, ITOA(STRLEN(l))) * q, tld)
8 GOTO 10
9 re(DEROVALUE(), tld)
10 RETURN 0
End Function

Function Update(tld Uint64, l String, z String, e String) Uint64
1 IF isVT(tld) != 1 || isVL(l, tld) != 1 THEN GOTO 11
2 IF DEROVALUE() < getFee(tld, "update") THEN GOTO 11
3 IF e(getKey(l, tld)) != 1 THEN GOTO 11
4 IF LOAD(getKey(l, tld)) != SIGNER() || isLocked(tld, l) != 0 THEN GOTO 11
5 STORE(getKey(l, tld) + ",z", HEXDECODE(z))
6 STORE(getKey(l, tld) + ",z,e", e)
7 STORE(getKey(l, tld) + ",u", bt())
8 re(DEROVALUE()-getFee(tld, "update"), tld)
9 aB(getFee(tld, "update"), tld)
10 GOTO 12
11 re(DEROVALUE(), tld)
12 RETURN 0
End Function

Function Transfer(tld Uint64, l String, d String, v Uint64) Uint64
1 IF isVT(tld) != 1 || isVL(l, tld) != 1 THEN GOTO 13
2 IF e(getKey(l, tld)) != 1 THEN GOTO 13
3 IF LOAD(getKey(l, tld)) != SIGNER() THEN GOTO 13
4 IF IS_ADDRESS_VALID(ADDRESS_RAW(d)) != 1 THEN GOTO 8
5 STORE(getKey(l, tld) + ",c", ADDRESS_RAW(d))
6 STORE(getKey(l, tld) + ",c,v", v)
7 GOTO 11
8 IF e(getKey(l, tld) + ",c") != 1 THEN GOTO 13
9 d(getKey(l, tld) + ",c")
10 d(getKey(l, tld) + ",c,v")
11 STORE(getKey(l, tld) + ",u", bt())
12 RETURN 0
13 RETURN 1
End Function

Function SetLock(tld Uint64, l String, v Uint64) Uint64
1 IF isVT(tld) != 1 || isVL(l, tld) != 1 THEN GOTO 9
2 IF e(getKey(l, tld)) != 1 THEN GOTO 9
3 IF LOAD(getKey(l, tld)) != SIGNER() THEN GOTO 9
4 IF e(getKey(l, tld) + ",l") != 1 THEN GOTO 6
5 IF LOAD(getKey(l, tld) + ",l") > v THEN GOTO 9
6 STORE(getKey(l, tld) + ",l", v)
7 STORE(getKey(l, tld) + ",u", bt())
8 RETURN 0
9 RETURN 1
End Function

Function ClaimTransfer(tld Uint64, l String) Uint64
1 DIM k as String
2 DIM royalties as Uint64
3 IF isVT(tld) != 1 || isVL(l, tld) != 1 THEN GOTO 19
4 LET k = getKey(l, tld)
5 IF e(k + ",c") != 1 || isLocked(tld, l) != 0 THEN GOTO 19
6 IF LOAD(k + ",c") != SIGNER() || LOAD(k + ",c,v") > DEROVALUE() THEN GOTO 19
7 IF DEROVALUE() < 1 THEN GOTO 12
8 LET royalties = LOAD(k + ",c,v") * getFee(tld, "transfer") / 10000
9 SEND_DERO_TO_ADDRESS(LOAD(k), LOAD(k + ",c,v") - royalties)
10 aB(royalties, tld)
11 re(DEROVALUE() - LOAD(k + ",c,v"), tld)
12 STORE(k, SIGNER())
13 STORE(k + ",u", bt())
14 d(k + ",c")
15 d(k + ",c,v")
16 IF e(k + ",o") != 1 THEN GOTO 20
17 d(k + ",o")
18 GOTO 20
19 re(DEROVALUE(), tld)
20 RETURN 0
End Function

Function Offer(tld Uint64, l String, q Uint64) Uint64
1 DIM k as String
2 IF isVT(tld) != 1 || isVL(l, tld) != 1 THEN GOTO 13
3 LET k = getKey(l, tld)
4 IF e(k) != 1 THEN GOTO 13
5 IF LOAD(k) != SIGNER() THEN GOTO 13
6 IF e(k + ",o") != 1 THEN GOTO 10
7 IF LOAD(k + ",o") != q THEN GOTO 10
8 d(k + ",o")
9 GOTO 11
10 STORE(k + ",o", q)
11 STORE(k + ",u", bt())
12 RETURN 0
13 RETURN 1
End Function

Function ClaimOffer(tld Uint64, l String) Uint64
1 DIM k as String
2 DIM royalties as Uint64
3 IF isVT(tld) != 1 || isVL(l, tld) != 1 || isSignerKnown() != 1 THEN GOTO 19
4 LET k = getKey(l, tld)
5 IF e(k + ",o") != 1 || isLocked(tld, l) != 0 THEN GOTO 19
6 IF DEROVALUE() < LOAD(k + ",o") THEN GOTO 19
7 LET royalties = LOAD(k + ",o") * getFee(tld, "offer") / 10000
8 SEND_DERO_TO_ADDRESS(LOAD(k), LOAD(k + ",o") - royalties)
9 aB(royalties, tld)
10 re(DEROVALUE()-LOAD(k + ",o"), tld)
11 STORE(k, SIGNER())
12 STORE(k + ",u", bt())
13 d(k + ",o")
14 IF e(k + ",c") != 1 THEN GOTO 20
16 d(k + ",c")
17 d(k + ",c,v")
18 GOTO 20
19 re(DEROVALUE(), tld)
20 RETURN 0
End Function

Function Bid(tld Uint64, l String) Uint64
1 DIM k as String
2 IF isVT(tld) != 1 || isVL(l, tld) != 1 || isSignerKnown() != 1 THEN GOTO 21
3 LET k = getKey(l, tld)
4 IF e(k) != 1 THEN GOTO 21
5 IF e(k + ",b") != 1 THEN GOTO 8
6 IF DEROVALUE() <= LOAD(k + ",b,v") THEN GOTO 13
7 SEND_DERO_TO_ADDRESS(LOAD(k + ",b"), LOAD(k + ",b,v"))
8 IF DEROVALUE() < 1 THEN GOTO 22
9 STORE(k + ",b", SIGNER())
10 STORE(k + ",b,v", DEROVALUE())
11 STORE(k + ",b,e", bt() + getD("bid", tld))
12 GOTO 22
13 IF LOAD(k + ",b") != SIGNER() THEN GOTO 21
14 IF LOAD(k + ",b,e") > bt() THEN GOTO 21
15 SEND_DERO_TO_ADDRESS(LOAD(k + ",b"), LOAD(k + ",b,v"))
16 IF DEROVALUE() > 0 THEN GOTO 10
17 d(k + ",b")
18 d(k + ",b,v")
19 d(k + ",b,e")
20 GOTO 22
21 re(DEROVALUE(), tld)
22 RETURN 0
End Function

Function ClaimBid(tld Uint64, l String, v Uint64) Uint64
1 DIM k as String
2 DIM royalties as Uint64
3 IF isVT(tld) != 1 || isVL(l, tld) != 1 || isSignerKnown() != 1 THEN GOTO 23
4 LET k = getKey(l, tld)
5 IF e(k) != 1 THEN GOTO 23
6 IF LOAD(k) != SIGNER() THEN GOTO 23
7 IF e(k + ",b") != 1 || isLocked(tld, l) != 0 THEN GOTO 23
8 IF LOAD(k + ",b,v") < v THEN GOTO 23
9 LET royalties = LOAD(k + ",b,v") * getFee(tld, "bid") / 10000
10 SEND_DERO_TO_ADDRESS(LOAD(k), LOAD(k + ",b,v") - royalties)
11 aB(royalties, tld)
12 STORE(k, LOAD(k + ",b"))
13 STORE(k + ",u", bt())
14 d(k + ",b")
15 d(k + ",b,v")
16 d(k + ",b,e")
17 IF e(k + ",c") != 1 THEN GOTO 20
18 d(k + ",c")
19 d(k + ",c,v")
20 IF e(k + ",o") != 1 THEN GOTO 22
21 d(k + ",o")
22 RETURN 0
23 RETURN 1
End Function

Function ReserveTld(h String) Uint64
1 IF getTldAvail() < 1 || STRLEN(h) != 64 || isSignerKnown() != 1 THEN GOTO 12
2 IF DEROVALUE() < getTldFee("reserve") THEN GOTO 12
3 IF e("t,r," + h) != 1 THEN GOTO 6
4 IF LOAD("t,r," + h + ",e") < bt() THEN GOTO 6
5 GOTO 12
6 STORE("t,r," + h, SIGNER())
7 STORE("t,r," + h + ",e", bt() + getTldD())
8 iC("t,r,counter", 1)
9 aB(getTldFee("reserve"), 0)
10 re(DEROVALUE()-getTldFee("reserve"), 0)
11 GOTO 13
12 re(DEROVALUE(), 0)
13 RETURN 0
End Function

Function ClaimTld(l String) Uint64
1 DIM rk, nk as String
2 LET rk = "t,r," + HEX(SHA256(l))
3 IF e(rk) != 1 THEN GOTO 25
4 IF getTldAvail() < 1 || STRLEN(l) < 1 || STRLEN(l) > 63 THEN GOTO 23
5 IF DEROVALUE() < getTldFee("register") THEN GOTO 25
6 IF e("t,list," + HEX(l)) != 0 THEN GOTO 23
7 LET nk = "t," + (getTldCount() + 1)
8 IF LOAD(rk) != SIGNER() THEN GOTO 25
9 STORE(nk, l)
10 STORE(nk + ",c,commander", SIGNER())
11 STORE(nk + ",c,registered", bt())
12 STORE(nk + ",c,updated", bt())
13 STORE(nk + ",c,sunrise", 18446744073709551615)
14 STORE(nk + ",p", SIGNER())
15 iC("t,count", 1)
16 STORE("c,t,avail", getTldAvail()-1)
17 STORE("t,list," + HEX(l), nk)
18 aB(getTldFee("register"), 0)
19 re(DEROVALUE()-getTldFee("register"), 0)
20 d(rk)
21 d(rk + ",e")
22 GOTO 26
23 d(rk)
24 d(rk + ",e")
25 re(DEROVALUE(), 0)
26 RETURN 0
End Function

Function TransferTld(tld Uint64, d String) Uint64
1 IF isVT(tld) != 1 THEN GOTO 10
2 IF isCommander(tld) != 1 THEN GOTO 10
3 IF IS_ADDRESS_VALID(ADDRESS_RAW(d)) != 1 THEN GOTO 6
4 STORE(getCmdKey(tld) + ",c", ADDRESS_RAW(d))
5 GOTO 8
6 IF e(getCmdKey(tld) + ",c") != 1 THEN GOTO 10
7 d(getCmdKey(tld) + ",c")
8 STORE(getTldCKey(tld) + ",updated", bt())
9 RETURN 0
10 RETURN 1
End Function

Function ClaimTransferTld(tld Uint64) Uint64
1 IF isVT(tld) != 1 THEN GOTO 8
2 IF e(getCmdKey(tld) + ",c") != 1 THEN GOTO 8
3 IF LOAD(getCmdKey(tld) + ",c") != SIGNER() THEN GOTO 8
4 STORE(getCmdKey(tld), SIGNER())
5 d(getCmdKey(tld) + ",c")
6 STORE(getTldCKey(tld) + ",updated", bt())
7 RETURN 0
8 RETURN 1
End Function

Function TransferSc(d String) Uint64
1 IF isCaptain() != 1 THEN GOTO 9
2 IF IS_ADDRESS_VALID(ADDRESS_RAW(d)) != 1 THEN GOTO 5
3 STORE("c,captain,c", ADDRESS_RAW(d))
4 GOTO 7
5 IF e("c,captain,c") != 1 THEN GOTO 9
6 d("c,captain,c")
7 STORE("c,updated", bt())
8 RETURN 0
9 RETURN 1
End Function

Function ClaimTransferSc() Uint64
1 IF e("c,captain,c") != 1 THEN GOTO 7
2 IF LOAD("c,captain,c") != SIGNER() THEN GOTO 7
3 STORE("c,captain", SIGNER())
4 d("c,captain,c")
5 STORE("c,updated", bt())
6 RETURN 0
7 RETURN 1
End Function

Function SetCsp(scid String, data String) Uint64
1 IF isCaptain() != 1 THEN GOTO 10
2 STORE("cspScid", scid)
3 IF data == "" THEN GOTO 6
4 STORE("cspData", HEXDECODE(data))
5 GOTO 7
6 STORE("cspData", "")
7 STORE("cspUpdate", bt())
8 STORE("c,updated", bt())
9 RETURN 0
10 RETURN 1
End Function

Function TransferP(tld Uint64, d String) Uint64
1 IF isVT(tld) != 1 THEN GOTO 10
2 IF isPAdmin(tld) != 1 THEN GOTO 10
3 IF IS_ADDRESS_VALID(ADDRESS_RAW(d)) != 1 THEN GOTO 6
4 STORE("t," + tld + ",pc", ADDRESS_RAW(d))
5 GOTO 8
6 IF e("t," + tld + ",pc") != 1 THEN GOTO 10
7 d("t," + tld + ",pc")
8 STORE(getTldCKey(tld) + ",updated", bt())
9 RETURN 0
10 RETURN 1
End Function

Function ClaimTransferP(tld Uint64) Uint64
1 IF isVT(tld) != 1 THEN GOTO 8
2 IF e("t," + tld + ",pc") != 1 THEN GOTO 8
3 IF LOAD("t," + tld + ",pc") != SIGNER() THEN GOTO 8
4 STORE("t," + tld + ",p", SIGNER())
5 d("t," + tld + ",pc")
6 STORE(getTldCKey(tld) + ",updated", bt())
7 RETURN 0
8 RETURN 1
End Function

Function SetP(tld Uint64, k String, v String, t Uint64) Uint64
1 IF isVT(tld) != 1 THEN GOTO 12
2 IF isPAdmin(tld) != 1 THEN GOTO 12
3 IF t == 1 THEN GOTO 9
4 IF v == "" THEN GOTO 7
5 STORE("t," + tld + ",p," + k, HEXDECODE(v))
6 GOTO 10
7 d("t," + tld + ",p," + k)
8 GOTO 10
9 STORE("t," + tld + ",p," + k, ATOI(v))
10 STORE(getTldCKey(tld) + ",updated", bt())
11 RETURN 0
12 RETURN 1
End Function

Function SetLabelLength(tld Uint64, min Uint64, max Uint64) Uint64
1 IF isVT(tld) != 1 || min < 1 || max > 63 || min > max THEN GOTO 7
2 IF isCommander(tld) != 1 THEN GOTO 7
3 STORE(getTldCKey(tld) + ",l,length,min", min)
4 STORE(getTldCKey(tld) + ",l,length,max", max)
5 STORE(getTldCKey(tld) + ",updated", bt())
6 RETURN 0
7 RETURN 1
End Function

Function SetDuration(tld Uint64, k String, v Uint64) Uint64
1 IF isVT(tld) != 1 THEN GOTO 7
2 IF k != "register" && k != "extend" && k != "orphan" && k != "reserve" && k != "bid" THEN GOTO 7
3 IF isCommander(tld) != 1 THEN GOTO 7
4 STORE(getTldCKey(tld) + ",duration," + k, v)
5 STORE(getTldCKey(tld) + ",updated", bt())
6 RETURN 0
7 RETURN 1
End Function

Function SetSunrise(tld Uint64, v Uint64) Uint64
1 IF isVT(tld) != 1 THEN GOTO 8
2 IF isCommander(tld) != 1 THEN GOTO 8
3 IF e(getTldCKey(tld) + ",sunrise") != 1 THEN GOTO 5
4 IF LOAD(getTldCKey(tld) + ",sunrise") < v THEN GOTO 8
5 STORE(getTldCKey(tld) + ",sunrise", v)
6 STORE(getTldCKey(tld) + ",updated", bt())
7 RETURN 0
8 RETURN 1
End Function

Function SetFeeS(tld Uint64, k String, v Uint64) Uint64
1 IF isVT(tld) != 1 THEN GOTO 13
2 IF k != "reserve" && k != "update" && k != "default" && k != "offer" && k != "bid" && k != "transfer" && k != "royalty" THEN GOTO 13
3 IF isCaptain() == 1 && k == "royalty" THEN GOTO 5
4 IF isCommander(tld) != 1 || k == "royalty" THEN GOTO 13
5 IF (k == "offer" || k == "bid" || k == "transfer" || k == "royalty") && v > LOAD("c,t,fee,royalty,max") THEN GOTO 13
6 IF e(getTldCKey(tld) + ",fee," + k) != 1 THEN GOTO 10
7 IF LOAD(getTldCKey(tld) + ",fee," + k) != v THEN GOTO 10
8 d(getTldCKey(tld) + ",fee," + k)
9 GOTO 11
10 STORE(getTldCKey(tld) + ",fee," + k, v)
11 STORE(getTldCKey(tld) + ",updated", bt())
12 RETURN 0
13 RETURN 1
End Function

Function SetFeeU(tld Uint64, k Uint64, v Uint64) Uint64
1 IF isVT(tld) != 1 THEN GOTO 11
2 IF k < getMinL(tld) || k > getMaxL(tld) THEN GOTO 11
3 IF isCommander(tld) != 1 THEN GOTO 11
4 IF e(getTldCKey(tld) + ",fee," + k) != 1 THEN GOTO 8
5 IF LOAD(getTldCKey(tld) + ",fee," + k) != v THEN GOTO 8
6 d(getTldCKey(tld) + ",fee," + k)
7 GOTO 9
8 STORE(getTldCKey(tld) + ",fee," + k, v)
9 STORE(getTldCKey(tld) + ",updated", bt())
10 RETURN 0
11 RETURN 1
End Function

Function SetTldFee(k String, v Uint64) Uint64
1 IF k != "reserve" && k != "register" && k != "royalty" THEN GOTO 8
2 IF isCaptain() != 1 THEN GOTO 8
3 IF k != "royalty" THEN GOTO 5
4 IF v > LOAD("c,t,fee,royalty,max") THEN GOTO 8
5 STORE("c,t,fee," + k, v)
6 STORE("c,updated", bt())
7 RETURN 0
8 RETURN 1
End Function

Function SetTldAvailMax(v Uint64) Uint64
1 IF isCaptain() != 1 THEN GOTO 5
2 STORE("c,t,avail,max", v)
3 STORE("c,updated", bt())
4 RETURN 0
5 RETURN 1
End Function

Function SetRefill(k String, v Uint64) Uint64
1 IF k != "interval" && k != "amount" THEN GOTO 6
2 IF isCaptain() != 1 THEN GOTO 6
3 STORE("c,t,refill," + k, v)
4 STORE("c,updated", bt())
5 RETURN 0
6 RETURN 1
End Function

Function SetTldDurationReserve(v Uint64) Uint64
1 IF isCaptain() != 1 THEN GOTO 5
2 STORE("c,t,duration,reserve", v)
3 STORE("c,updated", bt())
4 RETURN 0
5 RETURN 1
End Function

Function Refill() Uint64
1 IF e("c,t,refill") != 1 THEN GOTO 3
2 IF LOAD("c,t,refill") > bt() THEN GOTO 11
3 IF LOAD("c,t,refill,amount") < 1 || LOAD("c,t,avail,max") < 1 || getTldAvail() >= LOAD("c,t,avail,max") THEN GOTO 11
4 IF getTldAvail() + LOAD("c,t,refill,amount") > LOAD("c,t,avail,max") THEN GOTO 7
5 iC("c,t,avail", LOAD("c,t,refill,amount"))
6 GOTO 8
7 STORE("c,t,avail", LOAD("c,t,avail,max"))
8 STORE("c,t,refill", bt() + LOAD("c,t,refill,interval"))
9 STORE("c,updated", bt())
10 RETURN 0
11 RETURN 1
End Function

Function Withdraw(tld Uint64, q Uint64) Uint64
1 IF tld == 0 && isCaptain() == 1 && getB(0) >= q THEN GOTO 4
2 IF isVT(tld) != 1 THEN GOTO 11
3 IF isCommander(tld) != 1 || getB(tld) < q THEN GOTO 11
4 IF q == 0 THEN GOTO 8
5 SEND_DERO_TO_ADDRESS(SIGNER(), q)
6 sB(q, tld)
7 GOTO 10
8 SEND_DERO_TO_ADDRESS(SIGNER(), getB(tld))
9 sB(getB(tld), tld)
10 RETURN 0
11 RETURN 1
End Function

Function re(v Uint64, tld Uint64)
1 IF v < 1 || isSignerKnown() != 1 THEN GOTO 4
2 SEND_DERO_TO_ADDRESS(SIGNER(), v)
3 GOTO 5
4 aB(v, tld)
5 RETURN
End Function

Function iC(k String, v Uint64)
1 IF e(k) != 1 THEN GOTO 7
2 IF 18446744073709551615 - v < LOAD(k) THEN GOTO 5
3 STORE(k, LOAD(k) + v)
4 GOTO 8
5 STORE(k, v - (18446744073709551615 - LOAD(k)))
6 GOTO 8
7 STORE(k, v)
8 RETURN
End Function

Function aB(v Uint64, tld Uint64)
1 DIM royalties as Uint64
2 IF v < 1 THEN GOTO 9
3 IF isVT(tld) != 1 THEN GOTO 8
4 LET royalties = v * getTldRoyaltyFee(tld) / 10000
5 STORE(getTldCKey(tld) + ",balance", getB(tld) + v - royalties)
6 STORE("c,captain,balance", getB(0) + royalties)
7 GOTO 9
8 STORE("c,captain,balance", getB(0) + v)
9 RETURN
End Function

Function sB(v Uint64, tld Uint64)
1 IF v < 1 THEN GOTO 6
2 IF tld == 0 THEN GOTO 5
3 STORE(getTldCKey(tld) + ",balance", getB(tld) - v)
4 GOTO 6
5 STORE("c,captain,balance", getB(0) - v)
6 RETURN
End Function

Function getKey(l String, tld Uint64) String
1 RETURN "t," + tld + ",l," + HEX(l)
End Function

Function getTldCKey(tld Uint64) String
1 RETURN "t," + tld + ",c"
End Function

Function getCmdKey(tld Uint64) String
1 RETURN getTldCKey(tld) + ",commander"
End Function

Function getTldFee(k String) Uint64
1 IF e("c,t,fee," + k) != 1 THEN GOTO 3
2 RETURN LOAD("c,t,fee," + k)
3 RETURN 0
End Function

Function getTldRoyaltyFee(tld Uint64) Uint64
1 IF e(getTldCKey(tld) + ",fee,royalty") != 1 THEN GOTO 3
2 RETURN LOAD(getTldCKey(tld) + ",fee,royalty")
3 IF e("c,t,fee,royalty") != 1 THEN GOTO 5
4 RETURN LOAD("c,t,fee,royalty")
5 RETURN 0
End Function

Function getB(tld Uint64) Uint64
1 IF tld == 0 THEN GOTO 4
2 IF e(getTldCKey(tld) + ",balance") != 1 THEN GOTO 6
3 RETURN LOAD(getTldCKey(tld) + ",balance")
4 IF e("c,captain,balance") != 1 THEN GOTO 6
5 RETURN LOAD("c,captain,balance")
6 RETURN 0
End Function

Function getFee(tld Uint64, s String) Uint64
1 IF e(getTldCKey(tld) + ",fee," + s) != 1 THEN GOTO 3
2 RETURN LOAD(getTldCKey(tld) + ",fee," + s)
3 IF s == "offer" || s == "bid" || e(getTldCKey(tld) + ",fee,default") != 1 THEN GOTO 5
4 RETURN LOAD(getTldCKey(tld) + ",fee,default")
5 RETURN 0
End Function

Function getD(k String, tld Uint64) Uint64
1 IF e(getTldCKey(tld) + ",duration," + k) != 1 THEN GOTO 3
2 RETURN LOAD(getTldCKey(tld) + ",duration," + k)
3 RETURN 0
End Function

Function getTldD() Uint64
1 IF e("c,t,duration,reserve") != 1 THEN GOTO 3
2 RETURN LOAD("c,t,duration,reserve")
3 RETURN 60
End Function

Function getMaxL(tld Uint64) Uint64
1 IF e(getTldCKey(tld) + ",l,length,max") != 1 THEN GOTO 3
2 RETURN LOAD(getTldCKey(tld) + ",l,length,max")
3 RETURN 0
End Function

Function getMinL(tld Uint64) Uint64
1 IF e(getTldCKey(tld) + ",l,length,min") != 1 THEN GOTO 3
2 RETURN LOAD(getTldCKey(tld) + ",l,length,min")
3 RETURN 0
End Function

Function getTldAvail() Uint64
1 IF e("c,t,avail") != 1 THEN GOTO 3
2 RETURN LOAD("c,t,avail")
3 RETURN 0
End Function

Function getTldCount() Uint64
1 IF e("t,count") != 1 THEN GOTO 3
2 RETURN LOAD("t,count")
3 RETURN 0
End Function

Function isVL(l String, tld Uint64) Uint64
1 IF STRLEN(l) > getMaxL(tld) || STRLEN(l) < getMinL(tld) || STRLEN(l) < 1 THEN GOTO 3
2 RETURN 1
3 RETURN 0
End Function

Function isVT(tld Uint64) Uint64
1 IF tld < 1 || tld > getTldCount() THEN GOTO 3
2 RETURN 1
3 RETURN 0
End Function

Function isLocked(tld Uint64, l String) Uint64
1 IF e(getKey(l, tld) + ",l") != 1 THEN GOTO 3
2 IF LOAD(getKey(l, tld) + ",l") > bt() THEN GOTO 4
3 RETURN 0
4 RETURN 1
End Function

Function isSignerKnown() Uint64
1 IF ADDRESS_STRING(SIGNER()) == "" THEN GOTO 3
2 RETURN 1
3 RETURN 0
End Function

Function isCaptain() Uint64
1 IF LOAD("c,captain") == SIGNER() THEN GOTO 3
2 RETURN 0
3 RETURN 1
End Function

Function isCommander(tld Uint64) Uint64
1 IF LOAD(getCmdKey(tld)) == SIGNER() THEN GOTO 3
2 RETURN 0
3 RETURN 1
End Function

Function isPAdmin(tld Uint64) Uint64
1 IF LOAD("t," + tld + ",p") == SIGNER() THEN GOTO 3
2 RETURN 0
3 RETURN 1
End Function

Function bt() Uint64
1 RETURN BLOCK_TIMESTAMP()
End Function

Function d(s String) Uint64
1 RETURN DELETE(s)
End Function

Function e(k String) Uint64
1 RETURN EXISTS(k)
End Function
