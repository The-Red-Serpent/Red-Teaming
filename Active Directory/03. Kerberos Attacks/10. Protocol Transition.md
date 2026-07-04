### Protocol Transition
**Protocol Transition** is a Kerberos feature that allows a service to obtain a Kerberos identity for a user who authenticated using a **non-Kerberos authentication protocol**, without requiring the user’s password or TGT. It is implemented using **S4U2Self** and enables the service to later delegate access to other Kerberos services on the user’s behalf.

In Active Directory, Protocol Transition is enabled when the account has:
* `TRUSTED_TO_AUTH_FOR_DELEGATION`
When enabled, the service is trusted to tell the KDC: “Create a Kerberos identity for this user.” Even if that user never performed Kerberos authentication.


### Authentication Flow — Protocol Transition ENABLED

```
[1] User → WEB01
    Authentication = NTLM
    Result:
      - WEB01 knows username
      - No Kerberos ticket exists

------------------------------------------------------------

[2] WEB01 → KDC     (TGS-REQ : S4U2Self)
    Contains:
      - WEB01 TGT
      - PA-FOR-USER (User)
      - Service Name = WEB01

------------------------------------------------------------

[3] KDC checks:
      - Is WEB01 trusted for protocol transition?
      - Is User allowed to be delegated?

    If YES →

    KDC → WEB01     (TGS-REP)

    Issues:
      Ticket:
        Client = User
        Service = WEB01
        Flags = FORWARDABLE
        Encrypted with WEB01$ key

------------------------------------------------------------

[4] WEB01 → KDC     (TGS-REQ : S4U2Proxy)
    Contains:
      - Evidence ticket (User → WEB01)
      - Target SPN = MSSQLSvc/SQL01
      - Constrained delegation data

------------------------------------------------------------

[5] KDC checks:
      - Is MSSQLSvc/SQL01 in msDS-AllowedToDelegateTo?
      - Is evidence ticket forwardable?

    If YES →

    KDC → WEB01     (TGS-REP)

    Issues:
      Ticket:
        Client = User
        Service = MSSQLSvc/SQL01
        Encrypted with SQL01$ key

------------------------------------------------------------

[6] WEB01 → SQL01   (AP-REQ)
    Sends:
      - Service ticket (User → SQL01)
      - Authenticator

------------------------------------------------------------

[7] SQL01 decrypts ticket
      Client = User
      Access granted

```

### Authentication Flow — Protocol Transition DISABLED
```
[1] User → WEB01
    Authentication = NTLM
    No Kerberos ticket exists

------------------------------------------------------------

[2] WEB01 → KDC     (TGS-REQ : S4U2Self)
    Requests:
      User → WEB01

------------------------------------------------------------

[3] KDC checks:
      - WEB01 is NOT trusted for protocol transition

    KDC → WEB01     (TGS-REP)

    Issues:
      Ticket:
        Client = User
        Service = WEB01
        Flags = NOT forwardable
        Encrypted with WEB01$ key

------------------------------------------------------------

[4] WEB01 → KDC     (TGS-REQ : S4U2Proxy)
    Attempts delegation to MSSQLSvc/SQL01
    Includes:
      - Evidence ticket (User → WEB01)

------------------------------------------------------------

[5] KDC checks:
      - Is evidence ticket forwardable?

      NO

    KDC returns:
      KDC_ERR_BADOPTION

------------------------------------------------------------

Delegation fails.
```
