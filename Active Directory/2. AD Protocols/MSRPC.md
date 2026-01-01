MSRPC stands for Microsoft remote procedural call

#### What is RPC:
<p align="justify">A **Remote Procedure Call (RPC)** is a **protocol** that allows one program to request a service or execute a function on another program running on a different machine / system. Essentially, it's a way for **software programs** to communicate with each other over a **network**. This allows a client program to execute code on a remote server (which may be running on a different machine) as if it were a local procedure call.</p>
- The machine that invokes this request  is called RPC client and has a seperate sofware "Rpcclient " is installed

- The machine that receives this request and performs an action  is called RPC server  and has a seperate sofware "Rpc server " is installed

![[Pasted image 20250210161705.png]]


### MSRPC:
MSRPC is a protocol developed by Microsoft . MSRPC is specific to **Microsoft technologies** and is used heavily in Windows environments for **inter-process communication** (IPC) between systems and processes.

##### 4 interfaces of MSPC

|**Interface Name**|**Description**|**Key Functions**|**Use in Active Directory**|**Security Considerations**|
|---|---|---|---|---|
|**lsarpc**|RPC interface for managing Local Security Authority (LSA) on Windows. It manages security policies, authentication, and audit policies.|- Authentication services- Policy management (domain security policies)- Audit policy management|Used to manage domain security policies, user authentication, and auditing in a domain environment.|Attackers can use it for **enumeration** of domain security policies and potentially escalate privileges. Ensure proper access control for LSA queries.|
|**netlogon**|A Windows service that handles user authentication and establishes secure communication with domain controllers in an Active Directory environment.|- User authentication- Secure communication with domain controllers- Kerberos/NTLM support|Critical for domain-joined computers to authenticate to domain controllers. Supports **Single Sign-On (SSO)**.|Misuse could lead to **unauthorized authentication** attempts or service disruption. Proper network security is crucial to protect against external or unauthorized access.|
|**samr**|Protocol for managing the **Security Account Manager (SAM)**, which stores user accounts, groups, and security principles.|- User account management- Group management- Security principles management (access permissions, groups, etc.)|Used by administrators to manage users, groups, and other security principles in an AD domain. Can be exploited for **enumeration** of user accounts and group memberships.|Attackers can use it for **reconnaissance** to map user accounts, groups, and privilege escalation paths. Restrict remote SAM queries to **administrators** only for better security.|
|**drsuapi**|Microsoft API used for **Directory Replication Service (DRS)** to synchronize Active Directory data across domain controllers.|- Directory replication- Synchronization of AD data across multiple DCs- Backup and recovery of AD data|Handles **replication** of Active Directory data to ensure consistency across multiple domain controllers. Critical for maintaining **domain database integrity**.|Attackers can replicate the AD database (**NTDS.dit**) and steal **password hashes**, enabling **Pass-the-Hash** or offline cracking attacks. Restrict access to replication services.|

https://www.hackingarticles.in/active-directory-enumeration-rpcclient/