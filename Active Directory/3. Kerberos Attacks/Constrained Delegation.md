### Constrained Delegation
Constrained delegation is a Kerberos delegation type in Active Directory where a service account or computer account is trusted to impersonate a user **only to a specific list of services**. 

The allowed services are defined in the account’s **`msDS-AllowedToDelegateTo`** attribute, and the delegation is controlled by the Domain Controller.

### Auth Flow
Unlike **unconstrained delegation**, the **user’s TGT is not automatically sent** to the service. The service must **request a TGS** from the Domain Controller (KDC) to access a target resource on behalf of the user.
#### **Step 1: Special TGS Request**
- The service account (e.g., `WEBSRV`) makes a **special TGS request** to the KDC.
- **Two fields are modified** compared to a normal TGS request:
    1. **`additional tickets`** – contains the user’s TGS/service ticket for the service.
    2. **`cname-in-addl-tkt` flag** – tells the KDC to use the **user’s identity** in the additional ticket, not the service account’s identity.
#### **Step 2: Domain Controller Verification**
- KDC checks:
    1. Is the service allowed to delegate to the requested target? (**`msDS-AllowedToDelegateTo`**)
    2. Is the user’s ticket **forwardable**? (Forwardable by default; can be disabled via UAC flag “Do not allow delegation”)
#### **Step 3: Ticket Issuance**

- If the checks pass, the KDC issues a **service ticket** to the service containing:
    - A copy of the user’s TGS/service ticket in **`additional tickets`**
    - **Delegation flag (`cname-in-addl-tkt`)** so the service can impersonate the user

#### **Step 4: Access Target Resource**
- The service can now access the **target service** (e.g., `SQL/DBSRV`) **as the user**
- Restriction: the service can only delegate to services **listed in its allowed delegation attribute**

![image](https://eladshamir.com/images/SPN-jacking/image2.png)


### Abuse Any Service
A Kerberos service ticket contains an **unencrypted SPN** and an **encrypted part** holding the user identity and session key, encrypted with the **target service account’s key**. Because the SPN is not encrypted, an attacker can modify it without breaking the ticket.

In constrained delegation, the ticket can normally only be used by the **service account it was issued for**, since only that account can decrypt it. However, if the same account exposes **multiple services** (as is common with machine accounts), all those services share the **same Kerberos key**.

As a result, even if delegation is allowed only to one service (e.g., SQL), an attacker can change the SPN to another service hosted by the same account (e.g., CIFS) and access it successfully. This allows abuse of **any service exposed by that account**, not just the delegated one.

- Enumerating SPN's  of an Account
```
Get-DomainComputer DB01 | Select -ExpandProperty servicePrincipalName
```

### Impersonate any User
When a service account is configured for **constrained delegation**, it is allowed to delegate authentication only to specific services listed in its delegation settings. 

If this constrained delegation also has **protocol transition** enabled (via the `TRUSTED_TO_AUTH_FOR_DELEGATION` flag), the service can use the **S4U2Self** Kerberos extension to obtain a **forwardable service ticket to itself on behalf of any user**, without requiring that user to authenticate with Kerberos or provide credentials. 

This means that if an attacker compromises such an account, they can arbitrarily impersonate any domain user and then use **S4U2Proxy** to authenticate to the services in the allowed delegation list. 

Because the Kerberos tickets can be requested without waiting for a real user logon, the attacker can immediately abuse the delegated services while appearing as the impersonated user.
