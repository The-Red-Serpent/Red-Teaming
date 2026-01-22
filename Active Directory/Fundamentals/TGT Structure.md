```
                +=================================================+
                |            Ticket Granting Ticket (TGT)         |
                +=================================================+
                |                                                 |
                |  +------------------------------------------+   |
                |  |      Ticket (Inner / EncTicketPart)      |   |
                |  |        Encrypted with KRBTGT key          |  |
                |  +------------------------------------------+   |
                |  |  Client Name (User / Computer)            |  |
                |  |  Client Realm (Domain)                    |  |
                |  |  Session Key (Kc,tgs)                     |  |
                |  |  PAC (Privileges & Group Memberships)     |  |
                |  |  Ticket Flags                             |  |
                |  |  Start Time                               |  |
                |  |  End Time                                 |  |
                |  |  Renew‑Till                               |  |
                |  |                                           |  |
                |  |  (Readable ONLY by the KDC / DC)          |  |
                |  +------------------------------------------+   |
                |                                                 |
                |  +------------------------------------------+   |
                |  |     Encrypted Part (Outer / AS‑REP)       |  |
                |  |     Encrypted with Client Secret          |  |
                |  +------------------------------------------+   |
                |  |  Session Key (Kc,tgs)                     |  |
                |  |  Timestamp / Nonce                        |  |
                |  |  Ticket Flags                             |  |
                |  |                                           |  |
                |  |  (Readable by Client)                     |  |
                |  +-------------------------------------------+  |
                |                                                 |
                +================================================+

```


### Ticket (Encrypted with KRBTGT Key)

The ticket is the core part of the TGT and is encrypted using the KRBTGT account secret. Only the Domain Controller (KDC) can decrypt this portion. It contains the client’s identity, privileges, session key, and validity information. Because the entire domain trusts tickets signed by KRBTGT, compromising this key enables Golden Ticket attacks.

### Client Name

This field identifies the authenticated principal, which can be a user or computer account. It represents who the ticket is issued for. In forged tickets, attackers modify this value to impersonate privileged users such as Domain Admins.

### Client Realm

The realm specifies the Active Directory domain to which the client belongs. It ensures the ticket is valid only within the correct domain and ties the TGT to that domain’s Kerberos infrastructure.

### Session Key (Client ↔ TGS)

The session key is a symmetric key shared between the client and the Ticket Granting Service (TGS). It is used to securely request service tickets and protect further Kerberos communications.

### Privilege Attribute Certificate (PAC)

The PAC contains authorization data, including the user’s SID, group memberships, and privileges. Domain Controllers rely on the PAC to determine access rights. Manipulating the PAC allows attackers to grant themselves elevated privileges.

### Ticket Flags

Ticket flags define how the TGT can be used. Common flags indicate whether the ticket is forwardable, renewable, proxiable, or requires pre-authentication. These flags control delegation behavior and ticket lifecycle.

### Start Time

The start time indicates when the ticket becomes valid. The ticket cannot be used before this time, ensuring proper enforcement of authentication timing.

### End Time

The end time defines when the ticket expires. After expiration, the TGT is no longer valid. Attackers often extend this value in forged tickets to maintain long-term access.

### Renew‑Till

This field specifies the maximum time until which the ticket can be renewed. It allows the ticket’s lifetime to be extended without reauthentication, contributing to persistence when abused.

### Encrypted Part (Client‑Readable Section)

This portion of the TGT is encrypted with the client’s secret key (derived from the user or computer password). It allows the client to decrypt and retrieve the session key needed to communicate securely with the TGS.

### Timestamp / Nonce

The timestamp and nonce prevent replay attacks by proving the freshness of the authentication request. They ensure the ticket is not reused or replayed by an attacker.
