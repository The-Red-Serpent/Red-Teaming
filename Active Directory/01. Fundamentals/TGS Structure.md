```
+================================================================+
|                        SERVICE TICKET (TGS)                    |
+================================================================+
|                                                                |
|  +----------------------------------------------------------+  |
|  |                  Ticket (Encrypted)                      |  |
|  |      Encrypted with SERVICE ACCOUNT SECRET (key)         |  |
|  |                                                          |  |
|  |  Client Name           → user@REALM                      |  |
|  |  Client Realm         → DOMAIN.LOCAL                     |  |
|  |  Service Name (SPN)   → CIFS/host.domain.local           |  |
|  |  Service Realm        → DOMAIN.LOCAL                     |  |
|  |                                                          |  |
|  |  Validity Times                                          |  |
|  |   ├─ Start Time       → When ticket becomes valid        |  |
|  |   ├─ End Time         → Ticket expiration                |  |
|  |   └─ Renew Till       → Renewal deadline                 |  |
|  |                                                          |  |
|  |  Session Key          → Shared client ↔ service key      |  |
|  |                                                          |  |
|  |  Ticket Flags                                            |  |
|  |   ├─ forwardable                                         |  |
|  |   ├─ renewable                                           |  |
|  |   ├─ pre_authent                                         |  |
|  |   └─ name_canonicalize                                   |  |
|  |                                                          |  |
|  |  +--------------------------------------------------+    |  |
|  |  |        PAC (Privilege Attribute Certificate)     |    |  |
|  |  |                                                  |    |  |
|  |  |  User SID                                       |     |  |
|  |  |  User RID                                       |     |  |
|  |  |  Group SIDs                                     |     |  |
|  |  |  Extra SIDs                                     |     |  |
|  |  |  Logon Info                                     |     |  |
|  |  |  Privileges                                     |     |  |
|  |  |  PAC Checksums                                  |     |  |
|  |  +--------------------------------------------------+    |  |
|  +----------------------------------------------------------+  |
|                                                                |
|  +----------------------------------------------------------+  |
|  |                 Authenticator                            |  |
|  |   Encrypted with SESSION KEY (from ticket)               |  |
|  |                                                          |  |
|  |  Client Name                                             |  |
|  |  Timestamp                                               |  |
|  |  Sub-session Key (optional)                              |  |
|  +----------------------------------------------------------+  |
|                                                                |
+================================================================+

```

## **Kerberos Service Ticket (TGS)**

A **Kerberos Service Ticket (TGS)** is a credential issued by the Domain Controller that allows a user or system to authenticate to a **specific service** in an Active Directory environment. The ticket is presented directly to the target service and proves the identity and authorization of the client without requiring further interaction with the Domain Controller.

---

## **Ticket Encryption**

The service ticket is **encrypted using the password‑derived secret of the service or machine account** that owns the Service Principal Name (SPN). This ensures that **only the intended service** can decrypt and read the ticket. Successful decryption is treated as proof that the ticket is valid and untampered, which is why the service trusts the ticket contents.

---

## **Client Identity Information**

The ticket contains the **client name** and **client realm**, which identify the user requesting access and the domain to which the user belongs. These fields establish the identity context of the request and ensure that authentication occurs within the correct Kerberos realm.

---

## **Service Identification (SPN)**

The **Service Principal Name (SPN)** specifies the exact service instance the ticket is valid for, such as CIFS, HTTP, or MSSQL on a particular host. This binds the ticket to one service and prevents it from being reused to access other services.

---

## **Validity and Lifetime**

Service tickets include **time‑based restrictions**, such as start time, expiration time, and renewal time. These timestamps define when the ticket can be used and limit the impact of ticket theft by enforcing automatic expiration.

---

## **Session Key**

A **session key** is embedded in the service ticket and shared between the client and the service. This key is used to encrypt the authenticator and protect the integrity of the authentication exchange, ensuring secure communication between both parties.

---

## **Ticket Flags**

Ticket flags control how the service ticket can be used. Common flags include forwardable, renewable, and pre‑authenticated. These flags govern delegation behavior, ticket renewal, and authentication requirements.

---

## **Privilege Attribute Certificate (PAC)**

The **Privilege Attribute Certificate (PAC)** contains the authorization data for the client. It includes the user’s SID, group memberships, extra SIDs, and assigned privileges. Services rely on the PAC to determine what level of access the client should receive. Because the PAC is embedded inside the encrypted ticket, the service assumes its contents are trustworthy.

---
## Authenticator

The authenticator is sent alongside the service ticket and is encrypted using the session key. It contains a timestamp and client identity information, which prevents replay attacks by ensuring the ticket is being actively used by the legitimate client.
