##  Service Principle Name
A Service Principal Name (SPN) is a unique identifier stored in Active Directory that associates a network service with the specific Active Directory account (user, computer, or managed service account) that runs that service. Kerberos uses the SPN to locate the correct account, generate a service ticket encrypted with that account's secret key, and authenticate the client to the service. The permissions assigned to the account that owns the SPN determine what resources and actions that service can access.

## Format
```
service-class / host : port
        |          |      |
        |          |      └── Optional port number
        |          |
        |          └── The hostname of the computer running the service
        |
        └── The type of service
```


## Process
When a user wants to access a service using Kerberos:

The user requests a service ticket from the KDC (Key Distribution Center) on the Domain Controller.

The user tells the KDC:

"I need access to the service identified by this SPN."

Example:
```
HTTP/webserver.company.com
```
Active Directory looks up the SPN and finds the account that owns it.

The SPN owner can be:

- A computer account (for example, WEB01$)
- A user/service account (for example, svc_webapp)

The KDC creates a service ticket and encrypts part of it using the password hash of the SPN owner's account.

If the SPN belongs to a computer account:

```
HTTP/webserver.company.com → WEB01$
```

The ticket is encrypted using the machine account's secret.

If the SPN belongs to a service account:
```
HTTP/app.company.com → svc_app
```

The ticket is encrypted using the service account's secret.

The service receives the ticket and decrypts it using its own account credentials.
## Service Account
A service account is a special, non-human user account created for an application, virtual machine, or automated script so it can securely run processes, access data, and talk to other software or APIs without a person needing to log in

## Issue with SPN
SPNs can be associated with both **computer accounts** and **service accounts**, and using a computer account is not wrong. However, the reason organizations often create dedicated service accounts is to follow the **principle of least privilege** and improve security separation. If a service runs under a computer account like `WEB01$`, the Kerberos ticket is encrypted using the machine account's secret, and the service operates with the identity and permissions assigned to that computer account. Since a server can run multiple services (IIS, backup agents, monitoring tools, scheduled tasks, etc.), any permissions granted to `WEB01$` could potentially be used by other services running under the same identity. To avoid this, administrators create a dedicated service account like `svc_webapp`, associate the SPN with that account, and grant it only the permissions required by that specific application, such as access to a database or a particular file share. This provides better control, easier auditing, and reduces the risk of one compromised service gaining unnecessary access to other resources.
