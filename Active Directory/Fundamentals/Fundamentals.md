## Structure
### Forest
A **forest** is the **topmost logical container** in Active Directory and can contain **one or more domains**.
- All domains in a forest share:
    - A **common schema**
    - A **configuration**
    - A **global catalog**

### Domain
A **domain** in Active Directory is like a **private space or container** that holds objects such as **users, computers, and groups**. Each domain:
- Has its own set of **configurations**, **security policies**, and **administrative control**.
- Has its own set of **administrators** who manage the objects within it.
## Tree
A **tree** is a collection of one or more **domains** that shares same contiguous DNS namespace ,A hierarchical structure ,Automatic trust relationships** (transitive trusts)

```
# Tree Example
company.com
 ├── sales.company.com
 └── hr.company.com

```
## Organizational Units (OUs)

An **Organizational Unit (OU)** is a container in an Active Directory domain that organizes users, computers, and groups. It allows delegation of administrative control and serves as a scope for applying Group Policy settings. OUs can be nested to create a structured hierarchy.

![image](https://cdn.hashnode.com/res/hashnode/image/upload/v1691363420865/8a7b429b-d600-4ea7-ad33-ee3b9e9c13f2.jpeg)


## Domain Controller (DC)

A **Domain Controller (DC)** is a server that runs **Active Directory Domain Services (AD DS)**. It is responsible for **authenticating users and computers**, **authorizing access to resources**, **storing Active Directory data**, and **replicating directory information** within a domain.

A DC acts as the **central authority** for identity and access management in an Active Directory environment.
#### Types of Domain Controllers

##### 1. Writable Domain Controller
A **Writable Domain Controller (DC)** holds a **read/write copy of the Active Directory database**. It can **create, modify, and delete AD objects** and replicates these changes to other domain controllers in the domain. Writable DCs are the **most common type of DC** used in Active Directory environments.
##### 2. Read-Only Domain Controller (RODC)
A **Read-Only Domain Controller (RODC)**, on the other hand, holds a **read-only copy of Active Directory**. It is typically deployed in **remote or less secure locations**. RODCs **cannot make directory changes** and help **limit the exposure of credentials** in environments where security may be a concern.
##### 3. Global Catalog (GC) Server
A **Global Catalog (GC) Server** is a domain controller with the **Global Catalog role enabled**. It stores a **partial copy of all objects in the forest**, allowing users and applications to perform **forest-wide searches and authenticate across multiple domains**.
##### 4. FSMO Role Holders
**FSMO** are **specialized roles** in Active Directory that handle tasks **which cannot be safely performed on multiple domain controllers at the same time**. While most AD operations use **multi-master replication**, some operations require a **single authoritative source** to avoid conflicts.

There are **five FSMO roles**:
1. **Schema Master** – Controls changes to the **AD schema** (structure of objects and attributes) for the entire forest.
2. **Domain Naming Master** – Manages the addition or removal of **domains in the forest**.
3. **RID Master** – Allocates **Relative Identifiers (RIDs)** to domain controllers for creating unique SIDs for new objects.
4. **PDC Emulator** – Acts as the **primary domain controller** for legacy systems and handles **password changes, account lockouts, and time synchronization**.
5. **Infrastructure Master** – Maintains references to objects in other domains and ensures **cross-domain group memberships** are updated correctly.
### Realm 
A realm is a Kerberos authentication boundary that defines where user and service credentials are stored and validated. Each Active Directory domain functions as a Kerberos realm, and realms are primarily used when Active Directory interoperates with non-Windows Kerberos systems.

```
Active Directory domain: example.com
Corresponding Kerberos realm: EXAMPLE.COM
```


### Global Catalog
Global Catalog Server is a  DC in an Active Directory (AD) network stores full information only related to the domain it is in. To locate objects outside its domain is beyond its scope. Hence, there is a need for a server called a global catalog server. The global catalog contains a partial representation of all objects in the entire forest. Hence, a global catalog server has the potential to search objects from any domain within the forest it is in.

### SYSVOL

The SYSVOL folder is a shared directory on each domain controller in an Active Directory environment. It contains critical data such as Group Policy Objects (GPOs), Logon scripts, and other AD-related files that need to be replicated between domain controllers within the same domain. SYSVOL ensures that domain controllers maintain a consistent copy of data for the proper functioning of the network.
### NTDS.DIT 

It is a critical database file in Active Directory, stored on every **Domain Controller** (DC) in the `C:\Windows\NTDS\` directory. It contains all the essential information about the Active Directory environment, including:
- **User and group objects** (like user accounts and groups)
- **Group membership**
- **Password hashes** for all users in the domain (this is particularly important to attackers)


## Terminology

###  Object
An **object** is a distinct entity in AD, such as a **user**, **computer**, or **group**. Each object has **attributes** (properties)
![image](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*80HXxowWgJgAAbrZsDiTmw.png)

#### 1. **User Account**
Represents a **human user** in Active Directory  used for logging into systems and accessing resources.
####  **Identification:**

- `objectClass`: `user`
- `sAMAccountType`: `0x30000000`
- `sAMAccountName`: **does not end with `$`**
- `userAccountControl`: typically `512` (UF_NORMAL_ACCOUNT)
#### 2. **Computer Account**
Represents a **domain-joined computer**  used for machine authentication and policy application.
####  **Identification:**
- `objectClass`: `computer`
- `sAMAccountType`: `0x30000001`
- `sAMAccountName`: **ends with `$`** (e.g., `WIN10-PC$`)
- `userAccountControl`: `4096` (UF_WORKSTATION_TRUST_ACCOUNT)
####  3. **Service Account**
A **user account** intended to run services or applications not meant for human interaction.
####  **Identification:**
- `objectClass`: `user`
- **sAMAccountName** often includes `svc`, `service`, or `app`
- May have `ServicePrincipalName` set (SPN)
- `userAccountControl`: often includes `DONT_EXPIRE_PASSWORD`
- Interactive login typically **disabled**

###  Security Principal
An entity (user, group, computer, service) that can be **authenticated** and **authorized** in AD.
### Security Identifier (SID)
A **Security Identifier (SID)** is a unique value used in Windows operating systems to identify **user accounts, groups, and other security principals**. SIDs are essential in Windows security because they are used to control access to resources—permissions are assigned to SIDs, not to the human-readable names of accounts.

Format 
```
S-1-5-21-DomainIdentifier-RID
```
- **S** → Indicates it is a Security Identifier (SID)
- **1** → Revision level
- **5** → Identifier authority (NT Authority)
- **21-DomainIdentifier** → Unique identifier for the domain or computer
- **RID** → Relative Identifier, identifying the specific user, group, or computer within that domain

### Relative Identifier
A **RID** is the last part of a **Security Identifier (SID)** in Windows, used to uniquely identify a user, group, or computer **within a domain**.Each object in a domain shares the same domain SID prefix, and the **RID** differentiates them.

| RID   | Who it belongs to     |
| ----- | --------------------- |
| 500   | Administrator account |
| 501   | Guest account         |
| 512   | Domain Admins group   |
| 1000+ | Normal user accounts  |

### Global Unique Identifier (GUID)
<p align="justify">Global Unique Identifier is a unique 128-bit value assigned when a domain user or group is created. This GUID value is unique across the enterprise, similar to a MAC address. Every single object created by Active Directory is assigned a GUID, not only user and group objects. The GUID is stored in the `ObjectGUID` attribute</p>

###  sAMAccountName
The **logon username** used within a domain for authentication.

### Foreign Security Principal
<p align="justify">When domains establish trust relationships (such as forest or external trusts), security principals (users, groups, or computers) from one domain can be referenced in another. A Foreign Security Principal (FSP) is an Active Directory object that represents a security principal from a trusted external domain or forest within the local domain.</p>

An FSP acts as a placeholder that allows external principals to be:
- Added to domain local security groups
- Assigned permissions on resources through ACLs
- Included in Group Policy filtering

### Service Principal Name (SPN)

A **Service Principal Name (SPN)** is a unique identifier for a specific service on a network, such as SQL Server, a web server, or LDAP. It is **linked to the Active Directory account** (called the service account) that runs the service. SPNs allow **Kerberos authentication** to locate the correct service account so that clients can securely connect to the service. Essentially, an SPN acts like a network “nameplate” for the service: it represents the service itself, tells Kerberos which account to issue tickets for, and ensures that clients can verify the service’s identity. Without an SPN, Kerberos cannot authenticate the service properly, which can cause authentication failures.

### Distinguished Name
A **Distinguished Name (DN)** is the **unique full path that identifies an object** (like a user, group, or computer) in Active Directory. It specifies the **exact location of the object** within the AD hierarchy, including its **OU, domain, and any parent containers**.
```
CN=John Doe,OU=HR,DC=example,DC=com
```

### Fully Qualified Domain Name
A **Fully Qualified Domain Name (FQDN)** is the **complete, exact domain name of a computer, server, or network resource** in the DNS hierarchy. It specifies **its exact location in the domain name system**, including the host name and all domain levels up to the top-level domain (TLD).
```
hostname.subdomain.domain.tld
```
Example: 
`server01.hr.example.com`
- `server01` → host/computer name
- `hr` → subdomain or OU-level grouping
- `example` → second-level domain
- `com` → top-level domain

### AdminCount
The `adminCount` attribute is like a “VIP badge” on certain accounts. If a user has `adminCount = 1`, it means they are or were a privileged account, such as a Domain Admin, and their permissions are protected to prevent tampering. AD uses a background process called AdminSDHolder to enforce this protection, making sure these high-value accounts maintain their special access rights.


## Security and Access Control

### Access Control List
Access Control List in Active Directory is a list of permissions attached to an object (like a user, group, folder, or file) that defines who can access it and what actions they can perform (read, write, modify, etc.), acting as a digital security roster to control access and enforce security policies within the network
ACLs tell the system: _“These are the users, computers, and service accounts that can access this resource, and here’s what they can do.”_
### Access Control Entry
An Access Control Entry (ACE) in Active Directory is a rule within an Access Control List (ACL) that defines specific permissions (allow or deny) for a user or group (a trustee) on a securable object, like a file, folder, or Active Directory object. Each ACE contains a Security Identifier (SID) for the trustee, the specific access rights (e.g., Read, Write, Delete), and flags for inheritance, controlling exactly who can do what to that resource
### Group Policy Object (GPO)
A **Group Policy Object (GPO)** is a collection of settings in Active Directory that allows administrators to **control and manage the configuration of users and computers** across a domain. GPOs are **linked to containers** such as **sites, domains, or organizational units (OUs)**, and all users and computers within those containers automatically receive the policies. These policies can include security settings, software installation, desktop configurations, login scripts, and more. While GPOs primarily apply based on **OU or domain membership**, administrators can optionally use **security group filtering** to target specific users or computers within the container.

### MachineAccountQuota
Machine Account Quota (MAQ), or `ms-DS-MachineAccountQuota`, is an Active Directory (AD) setting that determines the maximum number of computer accounts an individual non-administrative user is allowed to create in the domain


## Lifecycle and Recovery
### Tombstone
Tombstone is a container object in AD that holds deleted AD objects. When an object is deleted and the Recycle Bin is not enabled, the object enters the **Tombstone state** as a part of Active Directory’s internal process for marking deleted objects. When an object is deleted from AD, the object remains for a set period of time known as the `Tombstone Lifetime,` and the `isDeleted` attribute is set to `TRUE`. Once an object exceeds the `Tombstone Lifetime`, it will be entirely removed.

- A **deleted object placeholder** in AD.
- Objects remain in **tombstoned** state for a **defined lifetime** before full deletion.
- Attribute `isDeleted = TRUE`.
### Active Directory Recycle Bin
 <p align="justify">It is a feature that allows for the recovery of deleted AD objects, such as users, groups, and organizational units, without requiring a system restore. When an object is deleted, it enters a "soft delete" state where its data is preserved, and it can be restored with all its attributes, including group memberships and passwords</p>
 
- Allows recovery of deleted AD objects with **attributes and group memberships preserved**.
- Must be **enabled manually**.
- Default retention: **180 days**.





## Services

AD is a Directory Service(A **directory service** is like a **digital phone book** or **catalog** for a network, where information about users, computers, devices, and other resources is stored and organized.)
#### Key features provided by AD:

| **Service Provided**                         | **Description**                                                             | **Component Involved**    |
| -------------------------------------------- | --------------------------------------------------------------------------- | ------------------------- |
| **User and Computer Authentication**         | Verifies login credentials of users and computers.                          | **AD DS**                 |
| **Assigning Permissions and Access Control** | Controls who can access which resources (files, printers, etc.).            | **AD DS**                 |
| **Organizing and Storing Resource Info**     | Stores and organizes user accounts, computers, groups, and other resources. | **AD DS**                 |
| **Applying Group Policies**                  | Enforces settings like password requirements, software installation, etc.   | **Group Policy in AD DS** |
| **Centralized Management**                   | Allows centralized control of users, devices, and network resources.        | **AD DS**                 |
| **Time Synchronization**                     | Ensures all computers in the network have synchronized time.                | **AD DS**                 |

#### Types of AD Services:
#### 1. **Active Directory Domain Services (AD DS)**

- **Description**: This is the core service of Active Directory. It handles most of the essential functionality, including user authentication, managing user accounts, devices, permissions, and security policies in a **domain**.
    
- **Key Features**:
    
    - **Domain Controllers**: Servers that store and manage AD DS data.
    - **Authentication and Authorization**: Ensures users and computers are authenticated and assigned proper access permissions.
    - **Directory Services**: Organizes and stores information about users, groups, computers, and network resources in a hierarchical structure.
    - **Group Policies**: Allows admins to define security and configuration settings across the network.
    - **Replication**: Ensures data consistency across multiple domain controllers.
- **Use Case**: AD DS is used for **domain-based networks**, where the goal is to manage a network's users, devices, and resources centrally. It's the most widely used AD service in corporate environments.
#### 2. **Active Directory Federation Services (AD FS)**

- **Description**: AD FS enables **Single Sign-On (SSO)** and cross-domain authentication by creating a trust relationship between different domains or even organizations.
    
- **Key Features**:
    
    - **Single Sign-On (SSO)**: Users authenticate once and gain access to resources across different domains or services without re-entering credentials.
    - **Federation Trusts**: AD FS allows different organizations or domains to trust each other’s identities (useful for partnerships, collaborations, or cloud services).
    - **Secure Access**: Users can access applications in external or partner domains without managing separate usernames and passwords.
    - **Claims-Based Authentication**: Uses claims (pieces of information about a user, like roles or groups) to manage access.
- **Use Case**: Used when organizations need to provide secure access to resources across different domains or between internal and external systems. AD FS is commonly used with cloud services like **Office 365**, allowing users to authenticate once to access both on-premises and cloud resources.
#### 3. **Active Directory Certificate Services (AD CS)**

- **Description**: AD CS is used to manage **digital certificates** for secure communication and **Public Key Infrastructure (PKI)**. It allows organizations to issue, renew, and manage certificates for secure authentication and encryption.
- **Key Features**:
    
    - **Certificate Authority (CA)**: The server that issues and manages digital certificates.
    - **Certificate Templates**: Predefined settings for the types of certificates to be issued (e.g., SSL certificates, email encryption).
    - **Public Key Infrastructure (PKI)**: A framework that uses cryptographic keys and certificates to enable secure communication and identity verification.
    - **Enrollment**: Users and devices can request and obtain certificates for secure communication.
    - **Revocation**: Manages the revocation of certificates if they are compromised or expired.
- **Use Case**: Used in environments requiring secure communication, encryption, and identity validation. AD CS is essential for setting up secure VPNs, email encryption, **SSL/TLS** certificates for websites, and more.
#### 4. **Active Directory Lightweight Directory Services (AD LDS)**

- **Description**: AD LDS is a lighter, more flexible version of AD DS, providing directory services without the need for a domain. It is ideal for applications that need directory services but don’t require full AD domain functionality.
- **Key Features**:
    - **Lightweight Directory**: A simplified directory service for applications that don't require full AD features.
    - **No Domain Requirements**: It doesn't require users or computers to be part of an AD domain.
    - **Flexible Directory**: Can be customized to store application-specific data (e.g., user info for a web application).
    - **Replicates Data**: Like AD DS, AD LDS can replicate its data across multiple servers.
- **Use Case**: Commonly used for **custom applications** or **non-domain-based** applications that need to store and access directory information, but don't need to manage a full AD domain.
#### 5. **Active Directory Rights Management Services (AD RMS)**

- **Description**: AD RMS helps protect sensitive information by applying **rights management** to documents, emails, and other resources, ensuring that only authorized users can access or modify content.
- **Key Features**:
    - **Encryption**: Encrypts data to prevent unauthorized access.
    - **Usage Rights**: Defines what users can do with content (e.g., view, edit, print, forward).
    - **Policy Templates**: Admins can define custom rights policies for documents, ensuring sensitive content is protected.
    - **Content Protection**: Even if content is shared externally, it remains protected.
- **Use Case**: Used to protect **sensitive information** in documents or emails, such as legal contracts, financial reports, or intellectual property, ensuring that only authorized individuals can access or edit the content.
#### 6. **Active Directory Web Services (ADWS)**

- **Description**: ADWS provides a web service interface for applications and clients to interact with Active Directory data, often used to connect non-Windows systems or applications over HTTP/HTTPS.
- **Key Features**:
    - **Remote Access to AD**: Provides a web-based interface for applications to access AD directory data.
    - **Cross-Platform Support**: Allows non-Windows applications (like web apps) to interact with AD.
    - **SOAP Protocol**: ADWS uses SOAP (Simple Object Access Protocol) to allow remote communication with Active Directory over HTTP.
- **Use Case**: Useful when you need to **access AD** data from **web-based applications** or systems that are not running Windows. It helps in scenarios where non-Windows platforms need to authenticate users or query directory information from AD.

