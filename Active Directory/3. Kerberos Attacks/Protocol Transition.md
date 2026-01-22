### Protocol Transition
**Protocol Transition** is a Kerberos feature that allows a service to obtain a Kerberos identity for a user who authenticated using a **non-Kerberos authentication protocol**, without requiring the user’s password or TGT. It is implemented using **S4U2Self** and enables the service to later delegate access to other Kerberos services on the user’s behalf.

Protocol Transition is enabled **ONLY** when **both** of the following exist on an AD object (user/computer/gMSA): 
`userAccountControl` == `TRUSTED_TO_AUTH_FOR_DELEGATION`
