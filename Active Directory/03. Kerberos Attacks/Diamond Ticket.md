## Diamond ticket Attack
Like a golden ticket, a diamond ticket is a TGT which can be used to access any service as any user. A golden ticket is forged completely offline, encrypted with the krbtgt hash of that domain, and then passed into a logon session for use. Because domain controllers don’t track TGTs it (or they) have legitimately issued, they will happily accept TGTs that are encrypted with its own krbtgt hash.

There are two common techniques to detect the use of golden tickets:

- Look for TGS-REQs that have no corresponding AS-REQ.
- Look for TGTs that have silly values, such as Mimikatz’s default 10-year lifetime.

  In Diamond Attack, the attacker leverages the KRBTGT AES hash to decrypt a valid TGT (Ticket Granting Ticket). Then, they modify the PAC (Privilege Attribute Certificate) inside the TGT before re-encrypting the modified TGT with the KRBTGT AES hash again to make it appear legitimate.

  ## WorkFlow
- Obtain the AES hash of the KRBTGT account: The attacker first compromises the KRBTGT account (often by dumping hashes from the domain controller or gaining access to sensitive domain controller information).
- Decrypt the TGT using the KRBTGT AES hash: The attacker then uses the AES hash of the KRBTGT account to decrypt a valid TGT. The TGT, when decrypted, contains the PAC which includes user privileges, group memberships, and other critical information.
- Modify the PAC: After decrypting the TGT, the attacker can modify the PAC to reflect unauthorized attributes or privileges. This could include adding themselves to privileged groups like Domain Admins or changing their group memberships to escalate privileges.
- Re-encrypt the modified TGT using the KRBTGT AES hash: Once the attacker has modified the PAC as desired, they re-encrypt the TGT using the KRBTGT AES hash to create a new valid TGT. This re-encryption makes the modified TGT appear legitimate to the Kerberos infrastructure.
- Use the modified TGT: The attacker can now present the modified TGT to access resources as if they were a privileged user, bypassing normal access control mechanisms.
- TGS (Service Ticket): The TGS tickets are issued based on the TGT. They do not directly store the PAC; instead, they rely on the TGT’s PAC to validate the user’s identity and permissions.

```
ticketer.py -request -domain 'lab.local' -user 'domain_user' -password 'password' -nthash 'krbtgt/service NT hash' -aesKey 'krbtgt/service AES key' -domain-sid 'S-1-5-21-...' -user-id '1337' -groups '512,513,518,519,520' 'baduser'

Rubeus.exe diamond /domain:DOMAIN /user:USER /password:PASSWORD /dc:DOMAIN_CONTROLLER /enctype:AES256 /krbkey:HASH /ticketuser:USERNAME /ticketuserid:USER_ID /groups:GROUP_IDS

```

**`ticketer.py` fields**

* **`-request`** – Requests a legitimate ticket from the KDC before creating/modifying the final ticket.
* **`-domain`** – Active Directory domain (Kerberos realm).
* **`-user`** – Account used to authenticate to the KDC.
* **`-password`** – Password of the authentication account.
* **`-nthash`** – RC4 (NT) key of the `krbtgt` account (Golden) or service account (Silver).
* **`-aesKey`** – AES128/AES256 key of the `krbtgt` account or service account.
* **`-domain-sid`** – Base SID of the Active Directory domain.
* **`-user-id`** – Relative Identifier (RID) of the user.
* **`-groups`** – Comma-separated list of group RIDs we want to impersonate to include in the PAC.
* **`baduser`** – Username that the ticket will represent.

**`Rubeus diamond` fields**

* **`/domain`** – Active Directory domain (Kerberos realm).
* **`/user`** – Account used to obtain the legitimate TGT.
* **`/password`** – Password of that account.
* **`/dc`** – Domain Controller (KDC) to contact.
* **`/enctype`** – Kerberos encryption type (AES256, AES128, or RC4).
* **`/krbkey`** – Long-term `krbtgt` key (AES or RC4) used to decrypt and re-protect the TGT.
* **`/ticketuser`** – Username that the modified ticket will represent.
* **`/ticketuserid`** – RID of the user to include in the PAC.
* **`/groups`** – Group RIDs we want to impersonate  to include in the PAC for authorization.




## Reference
- https://www.thehacker.recipes/ad/movement/kerberos/forged-tickets/diamond
