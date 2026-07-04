### Resource Based Constrained Delegation
**Resource-Based Constrained Delegation (RBCD)** is an Active Directory Kerberos feature where a **target resource (typically a computer account) explicitly controls which accounts are allowed to impersonate users to access its services**. 

In RBCD, the delegation trust is stored on the **resource itself** in the `msDS-AllowedToActOnBehalfOfOtherIdentity` attribute, allowing a trusted account to obtain service tickets for any user via **S4U2Self and S4U2Proxy**, without requiring the user’s credentials or prior authentication.

### In RBCD, impersonation is **resource-controlled**

- The **target resource** defines who can impersonate users **to it**.
- The **attribute** that controls this is:
    `msDS-AllowedToActOnBehalfOfOtherIdentity`
- **Any account listed here** can impersonate **any user** to the target, because Kerberos delegation via S4U2Self + S4U2Proxy does **not restrict which users** — it’s “any user” by design.
### Attack Requirements

- Obtain access to an account with Write permissions to modify a computer object’s `msDS-AllowedToActOnBehalfOfOtherIdentity` attribute, granting permissions to the compromised account.
- Control an object with a Service Principal Name (SPN). This could involve using an existing computer where we hold administrator privileges or creating a fake computer object if necessary.

### RBCD Abuse
Resource‑Based Constrained Delegation (RBCD) abuse occurs when an attacker gains the ability to modify a target computer’s delegation settings in Active Directory. By adding an attacker‑controlled computer account to the target’s `msDS-AllowedToActOnBehalfOfOtherIdentity` attribute, the attacker configures the target system to trust that account for delegation.

Once this trust is in place, Kerberos allows the attacker to impersonate any user using S4U extensions and obtain valid service tickets to the target system without needing the user’s credentials or authentication. These legitimate Kerberos tickets are accepted by the target, enabling access as the impersonated user and often leading to full system compromise.

![image](https://eladshamir.com/images/TrustedToAuthForDelegationWho/Diagrams/FirstAttack.png)
