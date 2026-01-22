## AS REP Roasting

**AS-REP Roasting** is a **Kerberos attack** that allows an attacker to **crack a user’s password offline** when **Kerberos pre-authentication is disabled** for that account. It's an attribute on an user account which tells us preauth is enabled or not

## Pre-Authentication
Pre-authentication is a **security feature** within the Kerberos authentication flow, but it's **separate** from the core or default workflow of Kerberos authentication. Pre-authentication is an **optional step** that enhances security, and it typically needs to be **explicitly enabled** in the Kerberos configuration.

### How the Attack Works

1. **Account Enumeration**
    - The attacker identifies a user account with the **“Do not require Kerberos preauthentication”** flag enabled.
    - Only the **username** is required.

2. **AS-REQ Without Pre-Authentication**
    - The attacker sends an **AS-REQ** to the KDC containing only the username.
    - No encrypted timestamp or password proof is included.

3. **AS-REP Returned by the KDC**
    - Since pre-authentication is disabled, the KDC responds with an **AS-REP**.
    - The AS-REP contains two parts:
        - **Ticket Granting Ticket (TGT)** encrypted with the **TGS’s long-term key**
        - **Client/TGS session key encrypted with a key derived from the user’s password**

4. **Offline Password Cracking**
    - The attacker extracts the encrypted session key from the AS-REP.
    - This encrypted data can be cracked offline using tools such as **Hashcat** or **John the Ripper**.
    - No interaction with the domain is required after capture.


### Enumeration

```
# Powerview
Get-DomainUser -PreauthNotRequired | select UserPrincipalName

# Netexec
netexec ldap $TARGETS -u $USER -p $PASSWORD --asreproast ASREProastables.txt --kdcHost $KeyDistributionCenter

# Linux 
impacket-GetNPUsers -dc-ip ip-of-dc -request -outputfile hashes.asreproast domain-name/username_used_for_Auth
```

## Red Team Usage

Red Teams may utilize **AS-REP Roasting** as part of multiple attack chains due to the fact that it **does not require prior authentication** and allows **offline password cracking**.

### 1. Initial Access / Credential Harvesting

- Enumerate domain accounts with the **DONT_REQUIRE_PREAUTH** flag enabled
- Request AS-REP responses for those users without authenticating
- Extract password-encrypted session keys
- Perform offline cracking to recover cleartext passwords

This is especially effective against:
- Legacy service accounts
- Accounts created for old applications
- Rarely monitored user or device accounts
### 2. Persistence

Setting the **“Do not require Kerberos preauthentication”** flag on an account enables a stealthy persistence mechanism.
- Even if the password is later changed, attackers can:
    - Request a new AS-REP at any time
    - Attempt to crack the updated password offline
- No interactive logon attempts are required
- Minimal security logging compared to password resets

This is particularly useful for:
- Printer accounts
- Service accounts
- Legacy infrastructure accounts
- Devices outside normal monitoring scope

Because these accounts are often ignored by defenders, the persistence may remain undetected for long periods.

### 3. Privilege Escalation (Indirect)

In some scenarios, attackers may:
- Have permission to **modify account attributes**
- Lack permission to reset or change the password.

Instead of resetting the password (which is noisy and easily detected), the attacker can:
1. Enable the **DONT_REQUIRE_PREAUTH** flag
2. Request AS-REP responses for the account
3. Crack the password offline
4. Authenticate normally using recovered credentials

This avoids:
- Password reset alerts
- Account lockouts
- User disruption

