## Kerberoasting

Kerberoasting is an authenticated Kerberos attack in which an attacker with valid domain credentials requests service tickets (TGS) for accounts with Service Principal Names (SPNs). These service tickets are encrypted with a key derived from the service account’s password. If the password is weak, the attacker can crack the ticket offline and recover the service account’s credentials.

When a service is registered in Active Directory, a **Service Principal Name (SPN)** is created and associated with an **AD account**. An SPN uniquely identifies a service instance using elements such as the **service type, hostname, and port**, and it maps that service to the account under which it runs. SPN is an attribute stored on an Active Directory account object

Active Directory does **not store the service account’s password hash inside the SPN**. Instead, the SPN is an attribute of the account object, and the **account’s password hash** is used by Kerberos to encrypt service tickets.

Any user Authenticated to AD can query User accounts with a SPN set. This allows a user to access to enumerate all the service accounts . But most services are executed by machine accounts which have 120 chars long password. But if we find an user account with an SPN set the password is highly predictable.

- Syntax of SPN
```
serviceClass/host:port/serviceName
```
### Enumeration
```
GetUserSPNs.py inlanefreight.local/pixis

netexec ldap $TARGETS -u $USER -p $PASSWORD --kerberoasting kerberoastables.txt --kdcHost $KeyDistributionCenter
```

### Exploitation
```
GetUserSPNs.py inlanefreight.local/pixis -dc-ip 10.10.10.5 -request -outputfile kerberoast_hashes.txt
```

We can also perform an Kerberoasting attack without any valid domain account/password. This can be possible when we know of an account without Kerberos pre-authentication enabled. We can use this account to use an AS-REQ request (usually used to request a TGT) to request a TGS ticket for a Kerberoastable user.
