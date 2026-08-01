## Domain
An Active Directory Domain is a logical and administrative boundary within an Active Directory environment that contains and manages a collection of users, computers, groups, and other network resources. It uses a centralized database for authentication, authorization, and security management, allowing administrators to control access to resources through a common set of policies.
<br></br>
<p align="center">
  <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGaG_aKV23dNIQPlJqwjNZhpvu9n8j_lfPA_WVFGlSe6iNBd2XU3rfxvie&s=10" alt="Architecture Diagram" width="600">
</p>
<br> </br>

## Realm 
A realm is a Kerberos authentication boundary that defines where user and service credentials are stored and validated. Each Active Directory domain functions as a Kerberos realm, and realms are primarily used when Active Directory interoperates with non-Windows Kerberos systems.

```
Active Directory domain: example.com
Corresponding Kerberos realm: EXAMPLE.COM
```
<br> </br>

## Distinguished Name
A Distinguished Name (DN) is the unique full path that identifies an object (like a user, group, or computer) in Active Directory. It specifies the exact location of the object within the AD hierarchy, including its OU, domain, and any parent containers.
```
CN=John Doe,OU=HR,DC=example,DC=com
```
<br></br>

## Fully Qualified Domain Name
A Fully Qualified Domain Name (FQDN) is the complete, exact domain name of a computer, server, or network resource in the DNS hierarchy. It specifies its exact location in the domain name system, including the host name and all domain levels up to the top-level domain (TLD).

```
hostname.subdomain.domain.tld
```

Example: 
`server01.hr.example.com`
- `server01` → host/computer name
- `hr` → subdomain or OU-level grouping
- `example` → second-level domain
- `com` → top-level domain
<br></br>
## Tree
An Active Directory Tree is a hierarchical collection of one or more Active Directory domains that share a contiguous DNS namespace and are connected through automatic two-way transitive trust relationship.

```
# Tree Example
company.com
 ├── sales.company.com
 └── hr.company.com
```
<br></br>
![image](https://cdn.infrasos.com/wp-content/uploads/2023/10/Untitled-2-4.png)
<br></br>

##  Forest
A Forest is the highest-level logical structure in Active Directory that consists of one or more Active Directory trees. All trees within a forest share a common schema, configuration, and global catalog, and are connected through automatic two-way transitive trust relationships, enabling centralized management, authentication, and resource sharing across the entire environment.
<br></br>

<p align="center">
  <img src="https://ad4noobs.justin-p.me/terminology_installing_a_active_directory/domain_tree_forest/domain_tree_forest_05.png" alt="Architecture Diagram" width="600">
</p>
<br></br>

##  Organizational Units (OUs)
An Organizational Unit (OU) is a container in an Active Directory domain that organizes users, computers, and groups. It allows delegation of administrative control and serves as a scope for applying Group Policy settings. OUs can be nested to create a structured hierarchy.
<br></br>

<p align="center">
  <img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1691363420865/8a7b429b-d600-4ea7-ad33-ee3b9e9c13f2.jpeg" alt="Architecture Diagram" width="600">
</p>
<br></br>

## Container
A container in Active Directory is an object that can hold (contain) other Active Directory objects. Those child objects can include users, computers, groups, other containers, or Organizational Units (OUs). The easiest way to understand containers is to think of Active Directory as a hierarchical tree.

```
DC=contoso,DC=com
│
├── CN=Users
│    ├── Alice
│    ├── Bob
│    └── HR Group
│
├── OU=IT
│    ├── John
│    ├── PC-01
│    └── OU=Servers
│
└── CN=Computers
     ├── PC-02
     └── PC-03

```
<br></br>

## Domain Controller (DC)

A Domain Controller is a server that runs Active Directory Domain Services (AD DS). It is responsible for authenticating users and computers, authorizing access to resources, storing Active Directory data, and replicating directory information within a domain. A DC acts as the central authority for identity and access management in an Active Directory environment.
<br></br>


## Global catalog Server
A Global Catalog (GC) Server is a domain controller in an Active Directory forest that stores a full, writable copy of all objects in its own domain and a partial, read-only copy of objects from every other domain in the forest. It enables users and applications to quickly locate Active Directory objects and supports forest-wide authentication and directory searches.

Key Functions of a Global Catalog Server:
- Stores a complete copy of all objects in its own domain.
- Stores a partial replica (selected attributes) of objects from all other domains in the forest.
- Enables forest-wide searches for users, groups, computers, and other AD objects.
- Assists with user logon by providing Universal Group Membership information.
- Helps applications such as Microsoft Exchange locate recipients across the forest.
<br></br>

<p align="center">
  <img src="https://networkencyclopedia.com/wp-content/uploads/2019/08/global-catalog-active-directory-infrastructure.jpg" alt="Architecture Diagram" width="600">
</p>
<br></br>


## Group Policy Object

A Group Policy Object (GPO) is a set of rules that administrators apply to user and computer accounts in an Active Directory environment. These rules control system behavior, security settings, and user experience, ensuring consistency across all devices. In other words, the GPO prevents users from going rogue, delivering centralized governance across devices and users at scale.

A GPO can be linked to:
```
Site
Domain
Organizational Unit (OU)
```

Users and computers inherit the GPOs linked to the container they belong to.

There are two primary Group Policy Object types:

**Local Group Policy**  applies only to a single machine and is managed independently.
**Domain-Based GPO** is managed through Active Directory and applies settings to groups of users or devices across the network.

GPOs are structured into two scopes:

**User Configuration**: Controls the user environment – desktop settings, application access, folder redirection, and more.
**Computer Configuration**: Applies system-wide settings like firewall rules, password policies, and software controls.

Every Group Policy Object is made up of:

**Group Policy Template (GPT)**: Stored in the SYSVOL folder of domain controllers; contains policy files, scripts, and templates.
**Group Policy Container (GPC)**: Stored in Active Directory; holds metadata such as version, status, and permissions.

### Structure of a GPT folder

A typical GPO folder looks like this:
```
{GUID}
│
├── GPT.INI
├── Machine
│   ├── Registry.pol
│   ├── Scripts
│   └── Preferences
│
└── User
    ├── Registry.pol
    ├── Scripts
    └── Preferences
```
Important files include:

- GPT.INI – version information for the GPO
- Machine – computer configuration settings
- User – user configuration settings
- Registry.pol – registry-based policy settings
- Scripts – startup, shutdown, logon, and logoff scripts
- Preferences – Group Policy Preferences data.
<br> </br>


## Security Identifier (SID)
A Security Identifier (SID) is a unique value used in Windows operating systems to identify user accounts, groups, and other security principals. SIDs are essential in Windows security because they are used to control access to resources—permissions are assigned to SIDs, not to the human-readable names of accounts.

```
S-1-5-21-DomainIdentifier-RID
```

- **S** → Indicates it is a Security Identifier (SID)
- **1** → Revision level
- **5** → Identifier authority (NT Authority)
- **21-DomainIdentifier** → Unique identifier for the domain or computer
- **RID** → Relative Identifier, identifying the specific user, group, or computer within that domain
<br> </br>

## Relative Identifier

A RID is the last part of a Security Identifier (SID) in Windows, used to uniquely identify a user, group, or computer within a domain.Each object in a domain shares the same domain SID prefix, and the RID differentiates them.

| RID   | Who it belongs to     |
| ----- | --------------------- |
| 500   | Administrator account |
| 501   | Guest account         |
| 512   | Domain Admins group   |
| 1000+ | Normal user accounts  |
<br></br>


## Global Unique Identifier (GUID)

<p align="justify">Global Unique Identifier is a unique 128-bit value assigned when a domain user or group is created. This GUID value is unique across the enterprise, similar to a MAC address. Every single object created by Active Directory is assigned a GUID, not only user and group objects. The GUID is stored in the `ObjectGUID` attribute</p>
<br></br>


## Foreign Security Principal

<p align="justify">When domains establish trust relationships (such as forest or external trusts), security principals (users, groups, or computers) from one domain can be referenced in another. A Foreign Security Principal (FSP) is an Active Directory object that represents a security principal from a trusted external domain or forest within the local domain.</p>

An FSP acts as a placeholder that allows external principals to be:
- Added to domain local security groups
- Assigned permissions on resources through ACLs
- Included in Group Policy filtering
<br></br>


## AdminCount

The `adminCount` attribute is like a “VIP badge” on certain accounts. If a user has `adminCount = 1`, it means they are or were a privileged account, such as a Domain Admin, and their permissions are protected to prevent tampering. AD uses a background process called AdminSDHolder to enforce this protection, making sure these high-value accounts maintain their special access rights.

<br></br>


## MachineAccountQuota
Machine Account Quota (MAQ), or `ms-DS-MachineAccountQuota`, is an Active Directory (AD) setting that determines the maximum number of computer accounts an individual non-administrative user is allowed to create in the domain.
<br></br>

## Tombstone

Tombstone is a container object in AD that holds deleted AD objects. When an object is deleted and the Recycle Bin is not enabled, the object enters the **Tombstone state** as a part of Active Directory’s internal process for marking deleted objects. When an object is deleted from AD, the object remains for a set period of time known as the `Tombstone Lifetime,` and the `isDeleted` attribute is set to `TRUE`. Once an object exceeds the `Tombstone Lifetime`, it will be entirely removed.

- A **deleted object placeholder** in AD.
- Objects remain in **tombstoned** state for a **defined lifetime** before full deletion.
- Attribute `isDeleted = TRUE`.
<br></br>


## Active Directory Recycle Bin

 <p align="justify">It is a feature that allows for the recovery of deleted AD objects, such as users, groups, and organizational units, without requiring a system restore. When an object is deleted, it enters a "soft delete" state where its data is preserved, and it can be restored with all its attributes, including group memberships and passwords</p>
 
- Allows recovery of deleted AD objects with **attributes and group memberships preserved**.
- Must be **enabled manually**.
- Default retention: **180 days**.
<br></br>


## Services

AD is a Directory Service(A directory service is like a digital phone book or catalog for a network, where information about users, computers, devices, and other resources is stored and organized.)

#### Key features provided by AD:

| **Service Provided**                         | **Description**                                                             | **Component Involved**    |
| -------------------------------------------- | --------------------------------------------------------------------------- | ------------------------- |
| **User and Computer Authentication**         | Verifies login credentials of users and computers.                          | AD DS                     |
| **Assigning Permissions and Access Control** | Controls who can access which resources (files, printers, etc.).            | **AD DS**                 |
| **Organizing and Storing Resource Info**     | Stores and organizes user accounts, computers, groups, and other resources. | **AD DS**                 |
| **Applying Group Policies**                  | Enforces settings like password requirements, software installation, etc.   | **Group Policy in AD DS** |
| **Centralized Management**                   | Allows centralized control of users, devices, and network resources.        | **AD DS**                 |
| **Time Synchronization**                     | Ensures all computers in the network have synchronized time.                | **AD DS**                 |

<br></br>


## SYSVOL
The SYSVOL folder is a shared directory on each domain controller in an Active Directory environment. It contains critical data such as Group Policy Objects (GPOs), Logon scripts, and other AD-related files that need to be replicated between domain controllers within the same domain. SYSVOL ensures that domain controllers maintain a consistent copy of data for the proper functioning of the network.
<br></br>


## NTDS.DIT 
It is a critical database file in Active Directory, stored on every Domain Controller in the `C:\Windows\NTDS\` directory. It contains all the essential information about the Active Directory environment, including:
- User and group objects (like user accounts and groups)
- Group membership
- Password hashes for all users in the domain (this is particularly important to attackers)




