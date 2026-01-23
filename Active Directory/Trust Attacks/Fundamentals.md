## Domain

A **domain** in Active Directory is like a **private space or container** that holds objects such as **users, computers, and groups**. Each domain:
- Has its own set of **configurations**, **security policies**, and **administrative control**.
- **Domain** includes domain controllers, which are servers responsible for running Active Directory Domain Services. These domain controllers authenticate and authorize users, manage groups and policies, and store and synchronize the Active Directory database.


## Tree
A **tree** is a collection of one or more **domains** that shares same contiguous DNS namespace ,A hierarchical structure ,Automatic trust relationships** (transitive trusts)

```
# Tree Example
company.com
 ├── sales.company.com
 └── hr.company.com
```

## Forest
A forest is a collection of one or more domains that shares the common schema and global catalog and they Trust each other

```
Active Directory Forest
│
├── Schema (rules for objects/attributes)
├── Global Catalog (search index for the forest)
├── Configuration Partition (forest-wide config)
│
├── Domain Tree 1
│   ├── domain1.com
│   │   ├── OU: Users
│   │   ├── OU: Computers
│   │   ├── OU: Groups
│   │   └── OU: Departments
│   │        ├── HR
│   │        ├── IT
│   │        └── Finance
│   └── child.domain1.com
│       ├── OU: Users
│       └── OU: Computers
│
└── Domain Tree 2
    └── domain2.net
        ├── OU: Servers
        ├── OU: Users
        └── OU: Groups
```


## Root Domain
Also called as forest root domain is the **first domain created** in an Active Directory forest and is at the **top of the hierarchy**. It is the foundation for the forest.
- Stores **forest-wide configuration** (like schema & configuration partitions)
- Holds **Enterprise Admins** and **Schema Admins** groups
- Root of **trust relationships**
- First domain controller in the forest has the **Forest FSMO roles**:
    - Schema Master
    - Domain Naming Master


 ## Trust Account
When two domains establish a trust, each domain creates a hidden trust account in its own Active Directory to represent the other domain’s KDC.
The trust account acts as a Kerberos principal, not a user or computer.
Key properties:
- sAMAccountType = SAM_TRUST_ACCOUNT
- sAMAccountName = <OtherDomain>$
- Holds the  Trust Account Password.
Used only for Kerberos authentication

```
ldapsearch (samAccountType=805306370) --attributes samAccountName
```

## Trust Key or Kereberos Keys
A trust key is a cryptographic key derived from the trust account password in the active Directory that is used to sign the inter realm ticket granting ticket or inter Domain Kerberos ticket
Important Detail
- In the Trusted Domain the shared secret or the trust Key is stored as the password of the trust account which is used by the Trusted Domain KDC to encrypt the inter realm TGTS
- In the Trusting Domain The same shared secret or the trust key is stored in the Trusted Domain Object (TDO) which is used by  the trusting domain’s KDC to Validate and re-sign cross-domain  kereberos tickets


## Inter-Realm ticket granting ticket
It is a special type of Kerberos ticket granting ticket that is used to authenticate a user form one domain to another domain in a trusted active Directory environment.

## Trusted Domain Object
A Trusted Domain Object (TDO) is an Active Directory object that represents a trust relationship with another domain or forest and contains the trust’s configuration, direction, and authentication information.

### A TDO stores metadata about a trust, including:
- Which domain is trusted
- How authentication flows
- Whether the trust is transitive
- Whether SID filtering is enabled
- A shared secret (trust password) used by Domain Controllers
- This allows Domain Controllers (KDCs) in different domains to verify each other during authentication.

```
ldapsearch (objectClass=trustedDomain)
```

## Transitivity
Transitivity is the property of a relationship whereby the relationship extends through an intermediary, such that if A is related to B and B is related to C, then A is also related to C.

## Trust Attacks


![Trust image](https://ad4noobs.justin-p.me/terminology_installing_a_active_directory/domain_tree_forest/domain_tree_forest_05.png)



## What is Trust
A trust is a link between two domains that allows users from one domain (the trusted) to access resources in another (the trusting), essentially extending authentication and authorization across domain boundaries for simplified management and resource sharing
```
+-----------------------+        TRUST        +-----------------------+
|  Domain B             |<-------------------|  Domain A              |
|  (TRUSTED)            |                    |  (TRUSTING)            | 
|                       |                    |                        |
|  Users                |                    |  Resources             |
|  Attacker foothold    |------------------> |  Targets               |
+-----------------------+                    +------------------------+

```

## Types of Trust

## Transitive Trust

Transitive trust is defined as a trust that automatically extends to any other domains that either of the partners trust, enabling [authentication requests]to pass through multiple domains without the need for explicit trust relationships between each pair. If Domain A trusts Domain B and Domain B trusts Domain C, then Domain A trusts Domain C through the transitive property of trust relationships

## Non-transitive Trust
Non-Transitive trust, if domain A trusts domain B, and domain B has a non-transitive trust with domain C. In this case, even though domain A has an indirect link to domain C through domain B, domain A does not trust domain C because the trust is non-transitive.

## One-Way Trust
A one-way trust occurs when only one domain trusts another. For example, Domain A can access Domain B’s resources, but Domain B cannot access Domain A’s resources in return.

## Two-way trusts
Two-Way trusts when one domain trusts another domain, the other way is also trust. So, both domains can access the resources of the other.

![image](https://miro.medium.com/1*3jZAOt9bRwW5Se7NSc0VuA.png)

## Parent-Child Trust
Parent-child trust is implicitly established. It is a two-way transitive trust. Parent-child trust is automatically generated when a child domain is added to a parent domain. When a new child domain is added, the trust path flows upward through the domain hierarchy.

![image](https://zindagitech.com/storage/2021/09/Picture4-Deepak-4.png)

## Tree-Root Trust
It link the root domain of one tree to root domain of another tree within the same forest. This trust is created automatically when a new tree created in the forest. Tree-root trust is also a two-way transitive trust

![image](https://zindagitech.com/storage/2021/09/Picture4-Deepak-4.png)

## External Trust
An External trust is a one-way non-transitive trust. The trust links forms between a domain in one forest and a domain in another separate forest.

![image](https://zindagitech.com/storage/2021/09/Picture7-Deepak-4.png)

## Forest Trust
Forest trust are transitive trust, and they can either one-way or two-way trust. It is explicitly transitive (between two forest) created trust between two forest root domains. Forest trust are manually created, one-way transitive or two-way transitive trust that allows you to provide access to the resource between multiple forest. It required DNS resolution to be established between forests.

![image](https://zindagitech.com/storage/2021/09/Picture5-Deepak-4.png)

## Shortcut (cross link) trust
Shortcut trust are manually created one-way, transitive trusts. They can only exist within a forest. This trust connection emerges between 2 child domains belonging to diff tress within same forest.

![image](https://zindagitech.com/storage/2021/09/Picture6-Deepak-4.png)

## Realm Trust
A realm trust is a trust relationship that allows an Active Directory domain to authenticate users from a non-Active Directory Kerberos realm, or vice versa, using the Kerberos protocol.
```
+-----------------------+        REALM TRUST        +-----------------------+
|  AD Domain            | <----------------------> |  Kerberos Realm       |
|  corp.local           |                          |  UNIX.REALM           |
|                       |                          |  (MIT / Heimdal)      |
+-----------------------+                          +-----------------------+
```



## **Cross-Domain Kerberos Authentication Process**
When a user in Domain A wants to access a resource in an Domain B. There are 2 steps involved
- Authentication
- Authorization

1. **Initial Authentication (AS-REQ / AS-REP)**
    
    - The user in **Domain A** begins authentication by sending an **Authentication Service Request (AS-REQ)** to the **Domain A Key Distribution Center (KDC)**.
    - The **KDC** validates the user’s credentials and responds with an **Authentication Service Response (AS-REP)** that contains a **Ticket Granting Ticket (TGT)**.
    - This **TGT** is **encrypted using the KRBTGT account key** of **Domain A**, ensuring that only Domain A’s KDC can read or issue tickets based on it.


2. **Requesting Access to a Resource in Domain B**
    - When the user attempts to access a resource hosted in **Domain B**, their workstation sends a **Ticket Granting Service Request (TGS-REQ)** to **Domain A’s KDC** for that resource.
    - However, because the resource resides in **Domain B**, **Domain A’s KDC** cannot issue a service ticket directly. Instead, it issues a **referral ticket**, also known as an **Inter-realm Ticket Granting Ticket (TGT)**, pointing the user to **Domain B**.

2. **Referral (Inter-realm) TGT Creation**
    
    - The **referral TGT** acts as a bridge between the two domains.
    - Unlike a normal TGT (which is encrypted using the KRBTGT key of the user’s home domain), the **inter-realm TGT** is **encrypted using the shared secret key** that exists between **Domain A and Domain B**.
    - This shared secret is automatically established through the **Active Directory trust relationship** between the two domains.

3. **Validation by Domain B**
    - The user’s workstation presents the **referral TGT** to **Domain B’s KDC**.
    - **Domain B’s KDC** uses the **shared trust key** to **decrypt and validate** the referral ticket.
    - If the ticket is valid, the KDC in **Domain B** issues a **service ticket** for the requested resource, allowing the user from **Domain A** to access the service securely.

## Authorization

The **service ticket** issued by Domain B’s KDC to Alice includes:
- Alice’s **User Principal Name (UPN)** (e.g., `alice@domainA.com`)
- Alice’s **SIDs** (user SID + group SIDs)
- Potentially her **SIDHistory**
- **PAC (Privilege Attribute Certificate)** — a data structure containing all this security information

> The **PAC** is digitally signed by **Domain A’s KDC** (the user’s home domain) and re-signed by **Domain B’s KDC** for trust integrity.

When Alice connects to the file share in Domain B:
- The **Domain B file server** (a Kerberos service) decrypts the service ticket using its own key.
- It then extracts the **PAC** to read Alice’s security identifiers (SIDs) and group memberships

The **Domain B server** now performs **authorization** locally:
1. It checks the **Access Control List (ACL)** on the requested resource (e.g., folder permissions).
2. It compares the SIDs in Alice’s PAC against the SIDs listed in the ACL.
3. If there’s a match (e.g., Alice’s SID or one of her group SIDs appears in the ACL), access is **granted**.
4. If not, access is **denied**.

![Kerberos Trust Flow Diagram](https://miro.medium.com/v2/resize:fit:1100/format:webp/0*gUBEFVsfluURDEgJ.png)

## PAC
PAC (Privileged Attribute Certificate) is a cryptographically signed data structure inside Kerberos tickets that securely carries a user's security context (like their SID and group memberships) from the Domain Controller (DC) to services, allowing those services to verify the user's permissions (authorization) without needing to query the DC repeatedly, speeding up authentication

## SID Filtering
The **Security Identifier (SID) Filtering mechanism** is a **security feature in Microsoft Active Directory (AD)** designed to protect domains that are connected through **trust relationships**. It prevents unauthorized elevation of privileges by ensuring that only valid, legitimate SIDs are honored when users from one domain access resources in another domain. 
When SID Filtering is **enabled**:
- The trusting domain examines the list of SIDs in the user’s token.
- It only honors SIDs that **originate from the trusted domain’s own namespace**.
- Any **foreign, spoofed, or invalid SIDs** are **filtered out** before access is granted.

## SID History
SID History is an attribute in AD that supports migration scenarios. Every user account has an associated Security IDentifier (SID) which is used to track the security principal and the access the account has when connecting to resources. SID History enables access for another account to effectively be cloned to another. This is extremely useful to ensure users retain access when moved (migrated) from one domain to another. Since the user’s SID changes when the new account is created, the old SID needs to map to the new one. When a user in Domain A is migrated to Domain B, a new user account is created in DomainB and DomainA user’s SID is added to DomainB’s user account’s SID History attribute. This ensures that DomainB user can still access resources in DomainA.

The interesting part of this is that SID History works for SIDs in the same domain as it does across domains in the same forest, which means that a regular user account in DomainA can contain DomainA SIDs and if the DomainA SIDs are for privileged accounts or groups, a regular user account can be granted Domain Admin rights without being a member of Domain Admins.

## Enterprise Admins
An Enterprise Admin is a highly privileged built‑in group in Active Directory that has full administrative control over the entire forest, not just a single domain. Members of this group can manage all domains in the forest, create or remove domains, modify forest‑wide configuration and trusts, and add themselves or others to any privileged group. The group exists in the forest root domain, and its permissions automatically apply across every child domain and tree in the forest. In practice, Enterprise Admins are the highest‑level administrators in Active Directory, meaning compromise of this role equals complete forest compromise.


### Trust Attacks

- [https://itm8.com/articles/sid-filter-as-security-boundary-between-domains-part-1](https://itm8.com/articles/sid-filter-as-security-boundary-between-domains-part-1)
