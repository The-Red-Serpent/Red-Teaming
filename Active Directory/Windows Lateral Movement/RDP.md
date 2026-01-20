## Remote Desktop Protocol (RDP)

**RDP (Remote Desktop Protocol)** is a proprietary protocol developed by Microsoft that allows a user to access the **graphical user interface (GUI)** of a remote computer over a network. Authentication is typically performed using a **username and password**, but in some cases **NT hashes or certificates** may be used.


## Windows

Microsoft provides a native binary called **`mstsc.exe`**, which is used to connect to remote machines via RDP.

```
mstsc.exe
```

---

## Restricted Admin Mode

Before **Windows Server 2012**, when a user logged into a system using RDP with an interactive session (username and password), a copy of the credentials was stored in the **Local Security Authority Subsystem Service (LSASS)** on the destination host. This posed a serious security risk if the system was compromised.

To mitigate this, Microsoft introduced **Restricted Admin Mode**. When enabled, the RDP server uses **network logon instead of interactive logon**, meaning credentials are **not stored** on the remote system.

In Restricted Admin Mode:

* Authentication is performed using an **NT hash or Kerberos ticket**
* Passwords are not cached on the target system
* NT hashes may still be cached and can be abused

Although this reduces credential exposure, attackers can still collect NT hashes and perform **Pass-the-Hash** or **Pass-the-Ticket** attacks. This mode is **disabled by default** in Windows.

Attackers with administrative access can enable this mode to:

* Avoid password storage
* Potentially bypass MFA
* Move laterally using hashes or Kerberos tickets

### Enable Restricted Admin Mode

```
mstsc.exe /RestrictedAdmin
```

### Enumerate Restricted Admin Mode

```
reg query HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v DisableRestrictedAdmin
```

---

## SharpRDP

**SharpRDP** is a **.NET-based post-exploitation tool** that allows attackers or red teamers to execute commands on a remote Windows machine **over RDP without opening a graphical desktop session**.

### Key Characteristics

* Executes **one command at a time**
* Command length limited to **259 characters**
* **No command output**
* Often used to **drop and execute a reverse shell**

### Usage Example

```
.\SharpRDP.exe computername=<TARGET_HOST> command="<COMMAND>" username=<DOMAIN\USER> password=<PASSWORD>
```

SharpRDP abuses the Windows **Run** feature to execute commands. These commands are recorded in the **RunMRU registry key**, which stores command history from the **Run dialog (`Win + R`)**.

---

## Clearing RunMRU Artifacts

To remove SharpRDP execution traces, the **RunMRU registry entries** must be cleared. This can be done using **CleanRunMRU**:

🔗 [https://github.com/0xthirteen/CleanRunMRU](https://github.com/0xthirteen/CleanRunMRU)

```
.\CleanRunMRU.exe clearall
```

---

## Linux

To connect to an RDP server from Linux, the **`xfreerdp`** tool is commonly used.

### Example Command

```
xfreerdp /u:user /p:'pass' /d:Domain /v:10.129.229.244 \
/dynamic-resolution /drive:.,linux /bpp:8 /compression \
-themes -wallpaper /clipboard /audio-mode:0 \
/auto-reconnect -glyph-cache
```
* Add a **defensive/detection section**
* Fix **another README section** for you
