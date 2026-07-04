### Golden Ticket
A **Golden Ticket attack** is a Kerberos ticket‑forging attack in Active Directory where an attacker uses the **NTLM hash of the KRBTGT account** to create a **fake but valid Ticket Granting Ticket (TGT)**.

After gaining **Domain Admin–level privileges**, the attacker can extract the KRBTGT secret, decrypt and modify the **PAC** inside a TGT (for example, adding privileged group memberships), and re‑encrypt it using the KRBTGT key. 

Because the forged ticket is correctly signed, it is trusted by **domain controllers and all domain services**, allowing the attacker to impersonate any user and maintain persistent, domain‑wide access.

Requirements :
 - Domain Name
 - Domain SID
 - Username to Impersonate
 - KRBTGT's hash

- Enumerating Domain SID
```
lookupsid.py domain.local/username@dc01.domain.local
```

- Creating TGT
```
ticketer.py -nthash <krbtgt_NTLM_hash> -domain-sid <DOMAIN_SID> -domain <domain_fqdn> <username>
```
