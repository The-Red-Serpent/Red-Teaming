
A **one‑way outbound trust** in Active Directory means that **your domain trusts another domain**, but **users from the other domain cannot access your domain’s resources**. In this setup, **access flows out of your domain**.

In simpler terms, if **Domain A has an outbound trust to Domain B**, then **Domain A trusts Domain B**, allowing **Domain A users to access resources in Domain B** (if permissions are granted), but **Domain B users cannot access resources in Domain A**. This type of trust is often used when one domain needs to access services or resources hosted in another domain, while keeping its own resources isolated.

An adversary may also find themselves on the 'wrong' side of a one-way trust, i.e. the trusting side.  In this scenario, they are against the direction of access and can not access resources in the trusted domain by design.  Also we cant even Enumerate the foreign Domain as well in this setup

In these cases, we can dump the trust key from the trusted domain object and use it to request a TGT. After that, you should be able to enumerate the trusted domain

https://adminions.ca/books/domain-trust-attacks/page/one-way-outbound-trust-abuse
