
A **one‑way inbound trust** in Active Directory means that **your domain trusts another domain**, allowing **users from the other (trusted) domain to access resources in your domain**, but **not the other way around**. In other words, access flows **into** your domain. For example, if **Domain A has an inbound trust with Domain B**, then **users from Domain B can access resources in Domain A** if permissions are granted, but users from Domain A cannot access resources in Domain B.

Here is a **cleaned‑up, corrected, and clear version** of your notes, with the **logic fixed and wording tightened**, but **no extra attack detail added**.

If we gain access to a **trusted domain**, we can access **resources in the trusting domain** _by design_ of Active Directory, **as long as permissions exist**. However, because this trust is **between different forests**, **SID filtering is enabled**. This means **SIDHistory‑based attacks (e.g., Enterprise Admin SID injection)** **do NOT work**, since the trusting domain **drops all non‑native SIDs**.

This is done by finding **foreign users or groups that are members of groups in the trusting domain**.

- You can enumerate FSPs in the trusting domain using LDAP:

```bash
ldapsearch "(objectClass=foreignSecurityPrincipal)" \
  --attributes cn,memberOf \
  --hostname <TARGET_DOMAIN_CONTROLLER> \
  --dn <BASE_DN>
```

This reveals:
- The **SID** of the foreign user or group (`cn`)
- The **local groups** they belong to (`memberOf`)
Any non‑default SID found here is **high‑value**, as it represents **real cross‑domain access**.

If an attacker compromises **any user or group represented by a Foreign Security Principal**, they inherit **whatever permissions that identity has in the trusting domain**.

With sufficient privileges and access to the **trust key**, an attacker can **forge an inter‑realm TGT**, which can then be used to request **service tickets** in the trusting domain (e.g., via Kerberos tooling).

https://adminions.ca/books/domain-trust-attacks/page/one-way-inbound-trust-abuse
