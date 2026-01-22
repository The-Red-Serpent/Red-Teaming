## Delegation
Kerberos delegation is a feature in the **Kerberos authentication protocol** that allows a service to act **on behalf of a user** to access resources on another service. In simple terms, it lets **Service A** (like a web server) use a user's credentials to authenticate to **Service B** (like a database), as if the user had connected directly to Service B. **Delegation** means **giving someone else permission to act on your behalf**.

Kerberos delegation is defined using **specific attributes on service accounts or computer accounts** in Active Directory. These attributes control whether a service is allowed to **impersonate users** when accessing other services.


## Unconstrained Delegation
Unconstrained delegation is a Kerberos delegation type in Active Directory where a **service or computer account is trusted to impersonate any user** that authenticates to it, allowing access to **any other service in the domain** on the user’s behalf.

Unconstrained delegation is defined by setting the `TRUSTED_FOR_DELEGATION` flag in the `userAccountControl` attribute of a service or computer account. When unconstrained delegation is defined on an AD object, that account can impersonate any user that authenticates to it and access all services in the domain on their behalf.



![image](https://adsecurity.org/wp-content/uploads/2015/08/Visio-KerberosUnconstrainedDelegation-visio.png)

When this flag is set on a service account, and a user makes a TGS request to access this
service, the domain controller will add a copy of the user's TGT to the Service Ticket .
This way, the service account can extract this TGT, and thus make TGS requests to the
Domain Controller using a copy of the user's TGT . The service will therefore have valid
TGS ticket or Service Ticket (ST) as the user and will be able to access any services as
the user 

![image](https://eladshamir.com/images/SPN-jacking/image1.png)


- Enumeration
```
findDelegation.py -dc-ip <DCIP> domain.local/USERNAME
```


### Unconstrained Delegation - Computers
If a user requests a service ticket on a server with unconstrained delegation enabled, the
user's Ticket Granting Ticket (TGT) is embedded into the service ticket that is then presented
to the server.

The server can cache this ticket in memory and then pretend to be that user for subsequent
resource requests in the domain. If unconstrained delegation is not enabled, only the user's
Ticket Granting Service (TGS) ticket will be stored in memory.

If we are able to compromise a server that has unconstrained delegation enabled, and a
Domain Administrator subsequently logs in, we will be able to extract their TGT and use it to
move laterally and compromise other machines, including Domain Controllers.

### Unconstrained Delegation - Users
Unconstrained delegation can also be enabled on **user accounts** in Active Directory, not just on computer or service accounts. This is controlled by the **TRUSTED_FOR_DELEGATION** flag, which is stored in the `userAccountControl` attribute. When this flag is set, the account is trusted to receive and use forwarded Kerberos credentials, including full Ticket Granting Tickets (TGTs). This can Lead to Full Domain Compromised

Exploiting unconstrained delegation on a user account requires more than just identifying it. The attacker must first compromise the delegated user account and also possess sufficient privileges (such as **GenericWrite** or **WriteSPN**) to modify the account’s Service Principal Name (SPN) list. Without the ability to add or change SPNs, the delegation abuse cannot be triggered.

The core idea of the attack is to trick a victim into authenticating to a **fake service** controlled by the attacker. This is done by registering a rogue DNS record in Active Directory that points to the attacker’s machine and represents a fake computer. The attacker then adds a corresponding **CIFS SPN** (for example, `CIFS/fakehost.domain.local`) to the compromised user account that has unconstrained delegation enabled.

When a victim, especially a privileged user such as a Domain Administrator, attempts to access this fake host over SMB, Kerberos authentication is initiated. Because the target account is configured for unconstrained delegation, the Domain Controller embeds a **copy of the victim’s TGT** inside the issued TGS. This service ticket is sent to the attacker’s machine, where the attacker can extract the forwarded TGT.
