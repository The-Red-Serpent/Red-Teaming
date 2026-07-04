## SMB

For successful **SMB-based lateral movement**, the attacker requires an account that is a member of the **local Administrators group** on the target system. SMB lateral movement heavily relies on **named pipes**, which enable remote command execution and service interaction within a Windows network.


## Windows

### PSExec

**PSExec** is a tool from the **Microsoft Sysinternals Suite** that enables remote command execution over the **SMB protocol**. It works by creating a temporary service on the target system and communicating with it via a **named pipe** to execute commands and retrieve output.

```
PsExec.exe \\SRV02 -i -u DOMAIN\user -p password cmd
```


### SharpNoPSExec

**SharpNoPSExec** is a lateral movement tool that leverages **existing services** on a target system instead of creating new ones or writing files to disk, reducing detection risk.

The tool:

* Enumerates all services on the target system
* Identifies services that are:

  * Disabled or manual
  * Currently stopped
  * Running as **Local System**
* Randomly selects one service
* Temporarily modifies its binary path to execute an attacker-controlled payload

SharpNoPSExec does **not** provide a direct reverse shell. However, it can execute payloads already present on the target system to obtain a reverse shell.

```
SharpNoPSExec.exe --target=172.20.0.52 ^
--payload="c:\windows\system32\cmd.exe /c powershell -e <BASE64>"
```


### NimExec

**NimExec** functions similarly to SharpNoPSExec and enables lateral movement using existing services on the target system.

```
NimExec.exe -u user -p password -d domain -t target -c "cmd.exe /c <payload>"
```


## Linux

### psexec.py

`psexec.py` is part of the **Impacket toolkit** and replicates the functionality of PSExec on Linux systems.

#### How It Works

* Uploads an executable with a **random filename** to the `ADMIN$` share
* Creates and registers a **Windows service** via **RPC** using the Service Control Manager
* Communicates with the service through a **named pipe**
* Executes commands and retrieves output remotely

Administrator-level credentials are required.

```
psexec.py domain/user:password@TARGET
```

### smbexec.py

`smbexec.py` leverages native **Windows SMB functionality** to execute commands remotely **without uploading files**, making it a quieter execution technique.

Key characteristics:

* Operates over **TCP port 445**
* Creates a temporary Windows service using **MSRPC**
* Uses the **svcctl SMB named pipe**
* Executes commands without writing payloads to disk

```
smbexec.py <domain>/<username>:<password>@<target_ip>
```


### services.py

The `services.py` script allows interaction with **Windows services via MSRPC**. It can be used to:

* List services
* Query service status
* Start and stop services
* Create and delete services
* Modify service configurations

During **red team engagements**, access to Windows services greatly simplifies lateral movement and post-exploitation. **Administrator privileges are required**.

```
services.py <domain>/<username>:<password>@<target_ip>
```

### atexec.py

The `atexec.py` script abuses the **Windows Task Scheduler service** via the **`atsvc` SMB named pipe** to execute commands remotely.

Unlike interactive execution methods, `atexec.py`:

* Creates a scheduled task
* Executes it immediately (or at a specified time)
* Retrieves command output from a file on the `ADMIN$` share
* Deletes the task after execution

```
atexec.py <domain>/<username>:<password>@<target_ip> "<command>"
```


* Review the **entire repo for formatting consistency**
