List of Potential data we can gather

### **1. Domain Information**

| Data Point             | Description                                                                      |
| ---------------------- | -------------------------------------------------------------------------------- |
| Domain Name            | Fully qualified domain name (FQDN) of the domain.                                |
| Domain Controllers     | List of all domain controllers and their IP addresses.                           |
| Domain SID             | Security Identifier (SID) unique to the domain.                                  |
| Forest and Root Domain | Information about the forest and root domain, including functional level.        |
| Trust Relationships    | Information about domain trust relationships (e.g., one-way, two-way, external). |
| Schema Version         | Version of the Active Directory schema in use.                                   |

### **2. User Account Information**

| Data Point                   | Description                                                   |
| ---------------------------- | ------------------------------------------------------------- |
| User Account Names           | List of all user accounts in the domain.                      |
| User Account Details         | Includes:                                                     |
|                              | - Username                                                    |
|                              | - Display name                                                |
|                              | - Email addresses                                             |
|                              | - Description                                                 |
|                              | - Password last set date                                      |
|                              | - Account creation date                                       |
|                              | - Last login timestamp                                        |
|                              | - Account expiration date                                     |
|                              | - Account lock or disable status                              |
| Group Memberships            | Which groups the user is a member of.                         |
| Password Policies            | Password expiration, length, complexity requirements.         |
| Account Flags                | Flags like "Account Disabled," "Password Never Expires," etc. |
| Home Directory/Profile Paths | User-specific home directory and profile paths.               |

### **3. Group Information**

|Data Point|Description|
|---|---|
|Group Names|List of all groups in the domain (local, global, universal).|
|Group Types|Whether the group is a Security or Distribution group.|
|Group Memberships|Which users or groups are members of each group.|
|Group Scopes|The scope of the group (Local, Global, Universal).|
|Group Nesting|Information about nested groups (groups within groups).|
|Group Privileges|Permissions assigned to each group.|

### **4. Organizational Units (OUs)**

|Data Point|Description|
|---|---|
|List of OUs|Structure and list of Organizational Units (OUs) in the domain.|
|OU Attributes|Includes:|
||- Name|
||- Description|
||- Location (Distinguished name in AD)|
|OU Membership|Which objects (users, computers, groups) belong to each OU.|

### **5. Computer Account Information**

|Data Point|Description|
|---|---|
|Computer Names|List of all computer accounts in the domain.|
|Computer Details|Includes:|
||- Name|
||- OS version|
||- IP address|
||- Last login timestamp|
||- Domain-joined status|
||- Expiration of computer account|

### **6. Service Account Information**

| Data Point                 | Description                                                              |
| -------------------------- | ------------------------------------------------------------------------ |
| Service Accounts           | List of service accounts used by applications and services.              |
| Service Account Privileges | Check if service accounts have elevated privileges (e.g., Domain Admin). |
| Service Account Passwords  | Ensuring service account passwords are strong and secure.                |

### **7. File Shares and Permissions**

| Data Point            | Description                                    |
| --------------------- | ---------------------------------------------- |
| Shared Folders        | List of all shared folders in the domain.      |
| Permissions on Shares | Access Control Lists (ACLs) for file shares.   |
| Share Visibility      | Which users/groups can access specific shares. |
| Folder ACLs           | Permissions on folders within file systems.    |

### **8. Active Directory Rights and Privileges**

|Data Point|Description|
|---|---|
|Admin Groups|Information about administrative groups (Domain Admins, etc.).|
|Group Policy Objects (GPOs)|List of all Group Policy Objects applied to the domain, OUs, or groups.|
|GPO Permissions|Which groups have read/write permissions to modify GPOs.|
|Effective Permissions|Users/groups and their effective rights on AD objects.|
|Delegation of Control|Information about delegated administrative tasks in OUs.|

### **9. Group Policy Information (GPOs)**

|Data Point|Description|
|---|---|
|GPO Settings|Group Policy Objects applied across the domain.|
|GPO Inheritance|Information on inherited GPOs in OUs or groups.|
|GPO Permissions|Permissions related to who can edit or apply specific GPOs.|
|Password Policies|Password length, complexity, and expiration policies.|
|Security Policies|Policies on auditing, logon/logoff restrictions, and user rights.|

### **10. Trust Relationships and Forest Information**

|Data Point|Description|
|---|---|
|Domain Trust Details|Information on trust relationships between domains (one-way, two-way).|
|External and Forest Trusts|Trust information with external domains and different forests.|
|SID Filtering|Whether SID filtering is enabled for cross-domain trusts.|
|Cross-Forest Communication|Information on how forests communicate and potential vulnerabilities.|

### **11. DNS Information**

|Data Point|Description|
|---|---|
|DNS Zones|DNS records and zones associated with the domain.|
|DNS Records|List of resource records (A, CNAME, SRV, PTR, etc.) in DNS.|
|DNS Replication|DNS replication status and issues.|

### **12. Active Directory Health and Replication**

|Data Point|Description|
|---|---|
|Replication Topology|Structure of AD replication across domain controllers.|
|Replication Status|Status of AD replication (successful or failed).|
|KCC (Knowledge Consistency Checker)|Algorithm used for domain controller replication.|
|Event Logs|Logs related to AD health, errors in replication, or security issues.|

### **13. Active Directory Security Settings**

|Data Point|Description|
|---|---|
|Security Logs|Logs related to security events, such as successful/failed logins.|
|Audit Policies|Audit settings for AD events (successful login, object access, etc.).|
|LDAP Configuration|Configuration settings for LDAP binding.|

### **14. Password and Authentication Information**

|Data Point|Description|
|---|---|
|Kerberos Tickets|Information on Kerberos authentication tickets in AD.|
|NTLM Hashes|NTLM password hashes (if accessible and vulnerable).|
|LDAP Binding|Details on how users/computers bind to LDAP.|

### **15. Additional Active Directory Data Points**

|Data Point|Description|
|---|---|
|Schema Objects|Custom attributes or schema extensions in AD.|
|Active Directory Sites|Site and subnet configurations for AD replication.|
|Time Synchronization|Time synchronization between domain controllers.|

### Active Directory Enumeration From a Blackbox Perspective

 The **first step** in a black-box scenario is an **Nmap scan** to identify services that indicate an **Active Directory (AD) environment**.

### Step 1: Run Nmap Scan for AD Services

Use this command to check for **key AD-related ports**:

```bash
nmap -p 88,135,139,389,445,464,593,636,3268,3269,3389 -sV -Pn <target>
```

💡 **Breakdown of Important Ports**:

| **Port** | **Service**              | **Indication**                                   |
| -------- | ------------------------ | ------------------------------------------------ |
| **88**   | Kerberos                 | Strong AD Indicator (Authentication Service)     |
| **135**  | MSRPC                    | Windows RPC (Common in AD)                       |
| **139**  | NetBIOS                  | Legacy Windows File Sharing                      |
| **389**  | LDAP                     | Directory Services Querying (AD Uses LDAP)       |
| **445**  | SMB                      | Windows File Sharing (Often a Domain Controller) |
| **464**  | Kerberos Password Change | AD User Management                               |
| **593**  | RPC over HTTP            | Windows RPC (Sometimes Used in AD)               |
| **636**  | LDAPS                    | Secure LDAP                                      |
| **3268** | Global Catalog (LDAP)    | Multi-Domain AD Environment                      |
| **3269** | Global Catalog (LDAPS)   | Secure Multi-Domain AD                           |
| **3389** | RDP                      | Often Found on Domain Controllers                |


### **Step 2: Analyze the Scan Results**

✅ If you see **Kerberos (88)**, **LDAP (389/636)**, or **SMB (445)** → **Highly likely an AD environment**.  
✅ If you see **RDP (3389)** and Windows services, but no LDAP/Kerberos → Could be a domain-joined machine.  
❌ If you see only general web services (HTTP/HTTPS) → Likely **not** an AD network.

After we Determine that we have an Ad environment or a domain joined machine . we need to enumerate every service further to exploit and gain access.

|**Service**|**Tools**|
|---|---|
|**SMB (Server Message Block)**|Nmap, CrackMapExec (CME), enum4linux, smbclient|
|**LDAP (Lightweight Directory Access Protocol)**|Nmap, ldapsearch, CrackMapExec (CME), ldapdomaindump|
|**Kerberos**|Nmap, Kerbrute, GetNPUsers.py (Impacket), Rubeus|
|**RPC (Remote Procedure Call)**|rpcclient, CrackMapExec (CME), Nmap|
|**DNS**|Nslookup, Dig, Fierce|
|**GPO (Group Policy Object)**|SharpGPOAbuse, CrackMapExec (CME), BloodHound|
|**AD Graph Analysis (Attack Paths)**|BloodHound (SharpHound), PingCastle|


#### Manual Enumeration Tools:

| **Service**                                      | **Manual Enumeration Tools**                                    |
| ------------------------------------------------ | --------------------------------------------------------------- |
| **SMB (Server Message Block)**                   | `smbclient`, `net view`, `dir \\<target>\share` (Windows)       |
| **LDAP (Lightweight Directory Access Protocol)** | `ldapsearch`, `ldp.exe` (Windows)                               |
| **Kerberos**                                     | `klist`, `setspn -L <user>` (Windows)                           |
| **RPC (Remote Procedure Call)**                  | `rpcclient`, `wbinfo -u`, `wbinfo -g`                           |
| **DNS**                                          | `nslookup`, `dig`, `host`                                       |
| **GPO (Group Policy Object)**                    | `gpresult /R`, `rsop.msc`, `secedit` (Windows)                  |
| **AD Graph Analysis (Attack Paths)**             | `whoami /groups`, `net group "Domain Admins" /domain` (Windows) |


### Active Directory - Enumeration Using Legacy Windows Tools:
1. net.exe- Installed by default on all windows systems.

### Enumerating Active Directory using PowerShell and .NET Classes:
- NET is a development platform that provides ready-made functionalities, tools, and libraries to help developers build applications faster and more efficiently, without having to create everything from scratch. Provides readymade functions and classes to work with
#### LDAP Path Format for AD Enumeration:

LDAP (Lightweight Directory Access Protocol) is used to query Active Directory (AD). The required **LDAP ADsPath** format is:

```
LDAP://HostName[:PortNumber][/DistinguishedName]
```

**Breakdown:**

1. **HostName** → Domain Controller (e.g., `dc01.example.com`).
2. **PortNumber** → Default **389** (LDAP) or **636** (LDAPS).
3. **DistinguishedName (DN)** → Full object path in AD (e.g., `CN=John Doe,OU=Users,DC=example,DC=com`).

**Example LDAP Query Path:**

```plaintext
LDAP://dc01.example.com:389/CN=John Doe,OU=Users,DC=example,DC=com
```

- This ldap path is combined with ldapsearch tool to enumerate


	The **`System.DirectoryServices.ActiveDirectory`** namespace in **.NET** provides classes for interacting with Active Directory (AD). we can check more in msdn . we can use these classes with python to write a Ad enum tool

#### AD Enumeration with Power View:
<p align="justify">PowerView is a **PowerShell script** used for **Active Directory (AD) enumeration and recon**. It is part of the **PowerSploit** framework and is widely used for **red teaming, penetration testing, and post-exploitation**.</p>
- This will display all commands inside the **Power View** module.
```
Get-Command -Module PowerView
```
- Get help with specific Command
```
Get-Help Get-DomainUser -Detailed
```

```
Get-Help Get-DomainUser -Examples
```



#### Manual Enumeration: To be done on a compromised machine.
- Enumerating Operating Systems- used to enumerate the computer objects in the domain.
		
```
Get-NetComputer
```

- Permissions and Logged on Users-command scans the network in an attempt to determine if our current user has administrative permissions on any computers in the domain
```
Find-LocalAdminAccess
```

- Returns a list of active user sessions- needs admin previleges to get a response` HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\DefaultSecurity`) now **prevent regular domain users from accessing session data** remotely.
```
Get-NetSession
```

- Used to retrieve the **Access Control List (ACL)** of a file, folder, or registry key.
```
Get-Acl -Path <object_path>
```

- Power view tool is not working for newer windows but its a good toolkit

## PsLoggedOn:

**PsLoggedOn** is a command-line tool that:
- Used to **enumerate logged-in users** on remote systems.
- This is an alternative to power view. 

Requirements: Requires the **Remote Registry service** to be enabled to scan registry keys.
- How to check if enabled or not
```
Get-Service -Name RemoteRegistry | Select-Object Name, StartType, Status
```
#### What it can do:
- **Identify Local User Logins**
- **Identify Remote User Logins**
- **Check Specific User Sessions**
- **Check Logged-On Users on a Remote System**
- **Works on Windows Workstations & Servers**
- **Queries Registry Keys (`HKEY_USERS`)**
- **Uses `NetSessionEnum` API**
- **Remote Registry Service Dependency**
- **Cannot Detect Disconnected RDP Sessions**


### Enumeration Through Service Principal Names

- SPN  is a unique identifier of a service in AD
---

### **1. `setspn.exe` (Built-in Windows Tool)**

- **Command:**
    
    ```powershell
    setspn -Q */*
    ```
    
    - Enumerates all registered SPNs in the domain (requires appropriate privileges).
- **Example for a specific user:**
    
    ```powershell
    setspn -L <username>
    ```
    
- **Example for a specific computer:**
    
    ```powershell
    setspn -L <computername>
    ```
    

---

### **2. PowerShell (Using Active Directory Module)**

- **Command:**
    
    ```powershell
    Get-ADUser -Filter * -Properties ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }
    ```
    
    - Retrieves all users with an SPN set.
- **For a specific user:**
    
    ```powershell
    Get-ADUser <username> -Properties ServicePrincipalName
    ```
    
- **For computers:**
    
    ```powershell
    Get-ADComputer -Filter * -Properties ServicePrincipalName | Where-Object { $_.ServicePrincipalName -ne $null }
    ```
    

---

### **3. PowerView (PowerShell Recon & Exploitation)**

- **Command:**
    
    ```powershell
    Get-NetUser -SPN
    ```
    
    - Enumerates all users with an SPN.
- **For Kerberoastable accounts:**
    
    ```powershell
    Get-DomainUser -SPN | Select-Object name, samaccountname, serviceprincipalname
    ```
    
- **For computers:**
    
    ```powershell
    Get-NetComputer | ForEach-Object { Get-NetComputer -FullData $_.name } | Select-Object name, serviceprincipalname
    ```
    

---

### **4. Impacket (`GetUserSPNs.py`)**

- **Command:**
    
    ```bash
    python3 GetUserSPNs.py 'DOMAIN/USER:PASSWORD' -dc-ip <Domain Controller IP>
    ```
    
    - Retrieves SPNs that are **Kerberoastable**.
- **For NTLM Hash instead of Password:**
    
    ```bash
    python3 GetUserSPNs.py 'DOMAIN/USER@DOMAIN' -hashes :<NTLM_HASH> -dc-ip <Domain Controller IP>
    ```
    

---

### **5. BloodHound (GUI-Based Enumeration)**

- **BloodHound Query:**
    
    ```
    MATCH (u:User) WHERE u.hasspn = TRUE RETURN u
    ```
    
    - Graphically displays SPN-enabled accounts.

---

### **6. LDAP Queries (Using `ldapsearch`)**

- **Command:**
    
    ```bash
    ldapsearch -x -h <DC-IP> -D "DOMAIN\USER" -w "PASSWORD" -b "DC=DOMAIN,DC=COM" "(servicePrincipalName=*)"
    ```
    
    - Retrieves SPN records via LDAP.


#### Enumerating Object Permissions

| **Object Type**                 | **Description**                                                             |
| ------------------------------- | --------------------------------------------------------------------------- |
| **Users**                       | Find who has permissions over user accounts.                                |
| **Computers**                   | Check who can modify or control a computer object.                          |
| **Groups**                      | See which users or groups have permissions over other groups.               |
| **Organizational Units (OUs)**  | Identify who has permissions to create, delete, or modify objects in an OU. |
| **Service Accounts**            | Determine which accounts have special privileges.                           |
| **GPOs (Group Policy Objects)** | Find out who can edit, apply, or delete policies.                           |
| **Domain Root**                 | Check who has high-level permissions over the entire domain.                |
| **Shares and Files**            | Verify access control on network shares.                                    |

```
Get-ObjectAcl -Identity <object or user>
```

```
Convert-SidToName - converts sid into human readable.
```

### **Key Permissions to Look For**

|**Permission**|**Description**|**Attack Potential**|
|---|---|---|
|**GenericAll**|Full control over an object.|**Privilege Escalation** – Modify group memberships, reset passwords.|
|**GenericWrite**|Modify attributes of an object.|**Modify sensitive properties** (e.g., logon script for user takeover).|
|**WriteOwner**|Change ownership of an object.|**Take full control over an object**.|
|**WriteDACL**|Modify object permissions.|**Grant attacker privileges**.|
|**AllExtendedRights**|Change/reset passwords, modify sensitive settings.|**Gain access to accounts** without knowing passwords.|
|**ForceChangePassword**|Reset password for an object.|**Take over accounts without needing old passwords**.|
|**Self (Self-Membership)**|Add yourself to a group.|**Escalate privileges via group membership**.|
#### **1. Security Identifier (SID)**

- *A **Security Identifier (SID)** is a unique value that **identifies** a **user, group, or computer** in Active Directory (AD).

 #### **2. What Does the SecurityIdentifier Tell Us?**

- **Who has a specific permission on an object.**
- **Which user, group, or computer a permission applies to.**
- **Identifies AD objects in security settings and access control lists (ACLs).**

#### **2. ActiveDirectoryRights**

- **ActiveDirectoryRights** defines the **permissions** a user, group, or computer has over an **Active Directory (AD) object** (like a user, group, or organizational unit).

## Enumerating Domain Shares:
- Function to find the shares in the domain
```
Find-DomainShare
```

| **Service**                                      | **Manual Enumeration Tools**                                                  |
| ------------------------------------------------ | ----------------------------------------------------------------------------- |
| **SMB (Server Message Block)**                   | `smbclient`, `net view`, `dir \\<target>\share` (Windows), smbmap, enum4linux |
| **LDAP (Lightweight Directory Access Protocol)** | `ldapsearch`, `ldp.exe` (Windows),windapsearch                                |
| **Kerberos**                                     | `klist`, `setspn -L <user>` (Windows)                                         |
| **RPC (Remote Procedure Call)**                  | `rpcclient`, `wbinfo -u`, `wbinfo -g`                                         |
| **DNS**                                          | `nslookup`, `dig`, `host`,                                                    |
| **GPO (Group Policy Object)**                    | `gpresult /R`, `rsop.msc`, `secedit` (Windows)                                |
| **AD Graph Analysis (Attack Paths)**             | `whoami /groups`, `net group "Domain Admins" /domain` (Windows)               |
