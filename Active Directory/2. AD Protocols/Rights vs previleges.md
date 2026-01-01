### 1. **Rights vs. Privileges**

|**Concept**|**Description**|
|---|---|
|**Rights**|Access permissions to objects (e.g., files, directories).|
|**Privileges**|Permissions to perform system-level actions (e.g., shut down the system, reset passwords).|

---

### 2. **Built-in AD Groups**

|**Group Name**|**Description**|
|---|---|
|**Account Operators**|Members can create and modify most types of accounts, including users, local groups, and global groups, and log in locally to domain controllers. Cannot manage high-privileged accounts like Administrators.|
|**Administrators**|Full and unrestricted access to a computer or entire domain if on a Domain Controller.|
|**Backup Operators**|Can back up and restore all files, regardless of file permissions. Can log on and shut down the computer, and can access DCs locally. Can make shadow copies of the SAM/NTDS database.|
|**DnsAdmins**|Members have access to network DNS information. Only created if the DNS server role is installed on a domain controller.|
|**Domain Admins**|Full access to administer the domain and are members of the local administrator group on all domain-joined machines.|
|**Domain Computers**|Includes any computers created in the domain, except domain controllers.|
|**Domain Controllers**|Contains all domain controllers within a domain. New DCs are automatically added.|
|**Domain Guests**|Contains the domain's built-in Guest account. Used for guest accounts who log on to a domain-joined computer.|
|**Domain Users**|Contains all user accounts in a domain. New user accounts are automatically added to this group.|
|**Enterprise Admins**|Provides complete configuration access within the domain. Only exists in the root domain of an AD forest. Grants forest-wide changes like adding child domains or creating trusts.|
|**Event Log Readers**|Members can read event logs on local computers. Only created when a host is promoted to a domain controller.|
|**Group Policy Creator Owners**|Members can create, edit, or delete Group Policy Objects in the domain.|
|**Hyper-V Administrators**|Full access to all features in Hyper-V. Considered Domain Admins if virtual DCs are in the domain.|
|**IIS_IUSRS**|A built-in group used by Internet Information Services (IIS) from version 7.0 onward.|
|**Pre–Windows 2000 Compatible Access**|Exists for backward compatibility with older systems like Windows NT 4.0. Can expose AD information without a valid username or password.|
|**Print Operators**|Can manage printers on domain controllers, including creating, sharing, and deleting printers. Can log on locally and escalate privileges via malicious printer drivers.|
|**Protected Users**|Members have additional protections against credential theft and tactics like Kerberos abuse.|
|**Read-only Domain Controllers**|Contains all read-only domain controllers in the domain.|
|**Remote Desktop Users**|Grants permission to connect to a host via Remote Desktop (RDP). Cannot be renamed, deleted, or moved.|
|**Remote Management Users**|Grants users remote access to computers via Windows Remote Management (WinRM).|
|**Schema Admins**|Members can modify the Active Directory schema. Only exists in the root domain of an AD forest.|
|**Server Operators**|Exists only on domain controllers. Members can modify services, access SMB shares, and backup files on DCs.|




### 3. **User Rights Assignment**

| **Privilege**                     | **Description**                                                                                                   |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **SeRemoteInteractiveLogonRight** | Allows RDP access to a host, potentially useful for gathering sensitive data.                                     |
| **SeBackupPrivilege**             | Allows creation of system backups, useful for capturing sensitive files like passwords and NTDS.dit.              |
| **SeDebugPrivilege**              | Allows debugging of processes and reading memory, used for tools like Mimikatz to capture credentials from LSASS. |
| **SeImpersonatePrivilege**        | Allows impersonation of a privileged account’s token for privilege escalation.                                    |
| **SeTakeOwnershipPrivilege**      | Allows taking ownership of objects (files, shares), bypassing permission restrictions.                            |

---

### 4. **Viewing Privileges**

|**Command**|**Description**|
|---|---|
|**whoami /priv**|Command to view the current user’s privileges. Non-privileged users have limited rights.|

|**User Type**|**Privileges**|
|---|---|
|**Standard Domain User**|Only a few basic rights (e.g., SeChangeNotifyPrivilege).|
|**Domain Admin Rights (Non-Elevated)**|Shows minimal rights; no elevated rights (e.g., SeShutdownPrivilege, SeChangeNotifyPrivilege).|
|**Domain Admin Rights (Elevated)**|Full listing of rights when running as an elevated user (e.g., SeDebugPrivilege, SeBackupPrivilege, SeShutdownPrivilege).|
|**Backup Operator Rights**|Includes SeShutdownPrivilege, SeChangeNotifyPrivilege. Potentially disruptive if used maliciously.|

---

### 5. **Privilege Escalation**

|**Privilege**|**Description**|
|---|---|
|**SeBackupPrivilege**|Can be used to obtain sensitive data from system backups (e.g., SAM, SYSTEM hives, NTDS.dit).|
|**SeDebugPrivilege**|Can be used to capture credentials from LSASS memory using tools like Mimikatz.|
|**SeImpersonatePrivilege**|Allows privilege escalation by impersonating another user's token (e.g., NT AUTHORITY\SYSTEM).|

---

### 6. **Administrative Best Practices**

|**Best Practice**|**Description**|
|---|---|
|**Limit Group Membership**|Use built-in groups sparingly. Only add trusted accounts to high-privileged groups like Domain Admins, Enterprise Admins.|
|**Use Separate Accounts**|Admin accounts should be separate from day-to-day user accounts to reduce risk of exploitation.|
|**Strict Monitoring**|Closely monitor and audit privileged accounts. Ensure access to privileged groups is highly controlled.|

---



