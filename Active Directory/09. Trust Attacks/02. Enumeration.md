###  Forest and Trust Enumeration

```
 --- [1] BASIC DOMAIN TRUST ENUMERATION (Windows built-ins) ---

# List trusted domains known to the local machine
nltest /trusted_domains

# Query domain trusts for a specific domain
netdom query /domain:inlanefreight.local trust


 --- [2] ENUMERATION WITH POWERSHELL (AD Module) ---

# Get all trust objects visible to the current domain
Get-ADTrust -Filter *

# Retrieve details about the current forest (forest-wide info)
Get-Forest

# List all domains in the current forest
Get-ForestDomain

# List all global catalog servers in the current forest
Get-ForestGlobalCatalog

# Enumerate forest-level trusts
Get-ForestTrust


--- [3] ENUMERATION WITH POWERVIEW (Offensive/Red Team PowerShell) ---

# Enumerate domain trusts for the current domain
Get-DomainTrust

# Enumerate trusts for a specific domain
Get-DomainTrust -Domain <Domain_name>

# Show mapped trust relationships and details between domains
Get-DomainTrustMapping

# List users in a specific child domain
Get-DomainUser -Domain LOGISTICS.INLANEFREIGHT.LOCAL | select SamAccountName

# Enumerate users who are members of groups outside their primary domain
Get-DomainForeignUser -Domain <domain_name>

# Enumerate groups that contain users from other domains
Get-DomainForeignGroupMember

# Map and enumerate all trusts recursively across the forest
Invoke-MapDomainTrust

# Find users that are members of groups in other domains
Find-ForeignUser -Domain <domain>

# Find groups that contain members from other domains
Find-ForeignGroup -Domain <domain>


--- [4] ENUMERATION WITH NETEXEC / IMPACKET STYLE TOOLS ---

# Enumerate domain trusts using LDAP with credentials
nxc ldap <ip> -u <user> -p <pass> -M enum_trusts
```
## Tools:
- [DomainTrustMapper](https://github.com/sixdub/DomainTrustExplorer)
- [TrustVisualizer](https://github.com/HarmJ0y/TrustVisualizer)

# Trust Attacks
https://itm8.com/articles/sid-filter-as-security-boundary-between-domains-part-1
