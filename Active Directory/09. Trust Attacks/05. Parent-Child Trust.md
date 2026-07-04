When a **child domain** is added to an existing **Active Directory tree**, a **two-way, transitive trust** is automatically created between the **parent and child domains**. This relationship is known as a **parent–child trust**, and because it is **transitive**, the trust extends throughout the entire forest.

If an attacker gains **Domain Admin privileges in a child domain**, they can potentially **escalate privileges to Enterprise Admin**, resulting in **full forest compromise**. This Attack is also known as SID History Injection Attack

This escalation is possible because **intra-forest trusts do not enforce SID filtering**. An attacker can **forge a Golden Ticket** and include **Enterprise Admin SIDs in the SIDHistory attribute**. Since the parent domain trusts the child domain and does not filter SIDs, the parent domain accepts these elevated SIDs, granting **Enterprise Admin-level access** across the forest.

This works because:
- Parent–child and tree-root trusts inside a forest are **two-way and transitive**
- **SID filtering is NOT applied** within a forest

```
Rubeus.exe golden /rc4:<KRBTGT_RC4_HASH> /domain:<CHILD_DOMAIN> /sid:<CHILD_DOMAIN_SID> /sids:<SIDs you want in the ticket's SID history.> /user:<user your want to impersonate> /ptt
```



