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




## Reference
- https://www.thehacker.recipes/ad/movement/kerberos/forged-tickets/diamond
