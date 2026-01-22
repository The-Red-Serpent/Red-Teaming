**PowerView** is a **PowerShell-based** post-exploitation tool used to **enumerate and analyze Active Directory (AD) environments**. It allows attackers or red teamers to query domain users, groups, computers, trusts, ACLs, sessions, and privilege relationships.

**SharpView** is a **C# reimplementation of PowerView** that provides similar AD enumeration functionality but is compiled as a **.NET binary**, making it more suitable for situations where PowerShell is restricted or heavily monitored.

### Domain Functions
```

# Domain Policy Enumeration
Get-DomainPolicy

# -----------------------------------------------------------
# Domain & Forest Enumeration
# -----------------------------------------------------------
Get-Domain
# Returns domain information (name, DCs, child domains, FSMO roles)

Get-DomainController
# Enumerates domain controllers

Get-Forest
# Returns forest information

Get-ForestDomain
# Lists all domains in the forest

Get-ForestGlobalCatalog
# Enumerates global catalog servers

Get-DomainSID
# Returns the SID of the current or specified domain

# -----------------------------------------------------------
# DNS Enumeration
# -----------------------------------------------------------
Get-DomainDNSZone
# Enumerates Active Directory DNS zones

Get-DomainDNSRecord -ZoneName <zone>
# Enumerates DNS records for a given zone

# -----------------------------------------------------------
# User Enumeration & Management
# -----------------------------------------------------------
Get-DomainUser
# Returns all domain users

Get-DomainUser -KerberosPreauthNotRequired
# return all users where pre auth is not required (asep roasting)

Get-DomainUser <username>
# Returns a specific user object

New-DomainUser
# Creates a new domain user (requires permissions)

Set-DomainUserPassword
# Sets or resets a user password (requires permissions)

Get-DomainUserEvent
# Enumerates logon events (4624) and explicit credential usage

# -----------------------------------------------------------
# Computer & Object Enumeration
# -----------------------------------------------------------
Get-DomainComputer
# Returns all domain computers

Get-DomainObject
# Returns all or specified AD objects

Set-DomainObject
# Modifies attributes of an AD object (requires permissions)

# -----------------------------------------------------------
# ACL & Permission Enumeration
# -----------------------------------------------------------
Get-DomainObjectAcl
# Retrieves ACLs for a specific AD object

Add-DomainObjectAcl
# Adds ACLs to an AD object (requires permissions)

Find-InterestingDomainAcl
# Finds non-standard or potentially exploitable ACLs

Find-DomainObjectPropertyOutlier
# Identifies AD objects with unusual or risky attributes

# -----------------------------------------------------------
# Organizational Units, Sites, and Subnets
# -----------------------------------------------------------
Get-DomainOU
# Enumerates Organizational Units (OUs)

Get-DomainSite
# Enumerates AD sites

Get-DomainSubnet
# Enumerates AD subnets

# -----------------------------------------------------------
# Group Enumeration & Management
# -----------------------------------------------------------
Get-DomainGroup
# Enumerates all domain groups

Get-DomainGroupMember -Identity <group>
# Lists members of a domain group

New-DomainGroup
# Creates a new domain group (requires permissions)

Add-DomainGroupMember
# Adds a user or group to a domain group (requires permissions)

Get-DomainManagedSecurityGroup
# Finds security groups with a manager assigned

# -----------------------------------------------------------
# File Servers & Shares
# -----------------------------------------------------------
Get-DomainFileServer
# Identifies likely file servers in the domain

Get-DomainDFSShare
# Enumerates Distributed File System (DFS) shares
```

### GPO Functions
```
Get-DomainGPO
# Returns all GPOs or a specific GPO object in Active Directory

Get-DomainGPOLocalGroup
# Returns GPOs that modify local group memberships

Get-DomainGPOUserLocalGroupMapping
# Maps which computers a user/group is added to a local group via GPOs

Get-DomainGPOComputerLocalGroupMapping
# Determines local group members on a computer through GPO correlation

Get-DomainPolicy
# Returns the Default Domain Policy or Domain Controller Policy
```

### Computer Enumeration Functions
```
Get-NetLocalGroup
# Enumerates local groups on the local or remote machine

Get-NetLocalGroupMember
# Enumerates members of a local group on the local or remote machine

Get-NetShare
# Lists open file shares on the local or remote machine

Get-NetLoggedon
# Returns users currently logged on to the local or remote machine

Get-NetSession
# Returns active session information on the local or remote machine

Get-RegLoggedOn
# Identifies logged-on users via remote registry enumeration

Get-NetRDPSession
# Returns RDP and terminal session information

Test-AdminAccess
# Tests whether the current user has local admin access on a machine

Get-NetComputerSiteName
# Returns the Active Directory site of a computer

Get-WMIRegProxy
# Enumerates proxy and WPAD settings for the current user

Get-WMIRegLastLoggedOn
# Returns the last logged-on user of a machine

Get-WMIRegCachedRDPConnection
# Returns cached outbound RDP connection information

Get-WMIRegMountedDrive
# Returns saved network-mounted drive information

Get-WMIProcess
# Lists running processes and their owners

Find-InterestingFile
# Searches for files matching specific criteria on a given path
```

### Threaded Meta Functions
```
Find-DomainUserLocation
# Finds domain machines where specified users are logged in

Find-DomainProcess
# Finds domain machines where specified processes are running

Find-DomainUserEvent
# Finds logon events for specified users in the domain

Find-DomainShare
# Finds reachable file shares on domain machines

Find-InterestingDomainShareFile
# Searches for interesting files on readable domain shares

Find-LocalAdminAccess
# Finds machines where the current user has local administrator access

Find-DomainLocalGroupMember
# Enumerates members of a specified local group across domain machines

```

### Trust Functions
```
Get-DomainTrust
# Returns all domain trusts for the current or specified domain

Get-ForestTrust
# Returns all forest trusts for the current or specified forest

Get-DomainForeignUser
# Enumerates users who are members of groups outside their domain

Get-DomainForeignGroupMember
# Enumerates foreign users in domain groups

Get-DomainTrustMapping
# Enumerates all trusts and recursively maps related domains
```

### MISC Functions
```
Export-PowerViewCSV
# Appends PowerView output to a CSV file in a thread-safe manner

Resolve-IPAddress
# Resolves a hostname to an IP address

ConvertTo-SID
# Converts a user or group name to a SID

Convert-ADName
# Converts Active Directory object names between formats

ConvertFrom-UACValue
# Converts UserAccountControl integer values to readable flags

Add-RemoteConnection
# Creates a remote connection using supplied credentials

Remove-RemoteConnection
# Removes a remote connection created earlier

Invoke-UserImpersonation
# Impersonates a user token (runas /netonly behavior)

Invoke-RevertToSelf
# Reverts back to the original security token

Get-DomainSPNTicket
# Requests a Kerberos service ticket for a given SPN

Invoke-Kerberoast
# Requests Kerberos service tickets and extracts crackable hashes

Get-PathAcl
# Retrieves ACLs for local or remote files and directories

```
