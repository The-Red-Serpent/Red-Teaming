## What is Trust
A trust is a security Relationship between 2 domains that allows user in one domain to access resources in another domain.(trusted_domain_user<----->trusting_domain_resource )
### Types of Trust

## One-Way Trust
A one-way trust occurs when only one domain trusts another. For example, Domain A can access Domain B’s resources, but Domain B cannot access Domain A’s resources in return.
## Two-way trusts
Two-Way trusts when one domain trusts another domain, the other way is also trust. So, both domains can access the resources of the other.
## Transitive Trust

Transitive trust is defined as a trust that automatically extends to any other domains that either of the partners trust, enabling [authentication requests]to pass through multiple domains without the need for explicit trust relationships between each pair. If Domain A trusts Domain B and Domain B trusts Domain C, then Domain A trusts Domain C through the transitive property of trust relationships
## Non-transitive Trust
Non-Transitive trust, if domain A trusts domain B, and domain B has a non-transitive trust with domain C. In this case, even though domain A has an indirect link to domain C through domain B, domain A does not trust domain C because the trust is non-transitive.

## Parent-Child Trust
Parent-child trust is implicitly established. It is a two-way transitive trust. Parent-child trust is automatically generated when a child domain is added to a parent domain. When a new child domain is added, the trust path flows upward through the domain hierarchy.

## Tree-Root Trust
It link the root domain of one tree to root domain of another tree within the same forest. This trust is created automatically when a new tree created in the forest. Tree-root trust is also a two-way transitive trust
## External Trust
An External trust is a one-way non-transitive trust. The trust links forms between a domain in one forest and a domain in another separate forest.

## Forest Trust
Forest trust are transitive trust, and they can either one-way or two-way trust. It is explicitly transitive (between two forest) created trust between two forest root domains. Forest trust are manually created, one-way transitive or two-way transitive trust that allows you to provide access to the resource between multiple forest. It required DNS resolution to be established between forests.
## Shortcut (cross link) trust

Shortcut trust are manually created one-way, transitive trusts. They can only exist within a forest. This trust connection emerges between 2 child domains belonging to diff tress within same forest.

## Some Important Terms
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
When 2 Domains Establish a trust , each Domain creates a trust account in it own domain to represent the other domain. The trust account is essentially a placeholder or identity in AD for the other Domain

- It Stores some metadata like
    - The type of trust
    - The Direction of trust
    - A trust Password

## Trust Key
A trust key is a cryptographic key derived from the trust account password in the active Directory that is used to sign the inter realm ticket granting ticket or inter Domain Kerberos ticket

## What is Inter-Realm ticket granting ticket
It is a special type of Kerberos ticket granting ticket that is used to authenticate a user form one domain to another domain in a trusted active Directory environment.

## PAC
PAC (Privileged Attribute Certificate) is a cryptographically signed data structure inside Kerberos tickets that securely carries a user's security context (like their SID and group memberships) from the Domain Controller (DC) to services, allowing those services to verify the user's permissions (authorization) without needing to query the DC repeatedly, speeding up authentication

### SID Filtering
The **Security Identifier (SID) Filtering mechanism** is a **security feature in Microsoft Active Directory (AD)** designed to protect domains that are connected through **trust relationships**. It prevents unauthorized elevation of privileges by ensuring that only valid, legitimate SIDs are honored when users from one domain access resources in another domain. When SID Filtering is **enabled**:
- The trusting domain examines the list of SIDs in the user’s token.
- It only honors SIDs that **originate from the trusted domain’s own namespace**.
- Any **foreign, spoofed, or invalid SIDs** are **filtered out** before access is granted.

## SID History
**SID History** is an **attribute in Active Directory** that stores **previous SIDs (Security Identifiers)** that were associated with a user, group, or computer account before it was migrated or renamed. This mechanism allows users and groups to **retain access to resources** that were secured under their **old SID** even after being moved to a new domain.

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

###### Trust Attacks

- [https://itm8.com/articles/sid-filter-as-security-boundary-between-domains-part-1](https://itm8.com/articles/sid-filter-as-security-boundary-between-domains-part-1)
