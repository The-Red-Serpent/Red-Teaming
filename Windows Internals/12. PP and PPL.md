### Protected Process
Protected process is a  special process type introduced in Windows Vista that runs with significantly stronger protections than a normal process. The kernel enforces these protections directly  even processes running as Administrator or SYSTEM cannot open a full access handle to a protected process. The protection is not a permission setting, it is a kernel-enforced flag stored in the EPROCESS structure that the Object Manager checks every time someone tries to open a handle to that process.

How protection works
The kernel stores the protection info in the EPROCESS structure inside a field called _PS_PROTECTION:
```
EPROCESS
  └── Protection (_PS_PROTECTION)
       ├── Type     ← PP or PPL
       ├── Signer   ← who signed it, determines trust level
       ├── Audit    ← whether auditing is enabled
       └── Level    ← overall protection level packed into one byte
```
When you try to open a handle to a protected process the kernel checks this field. If the process is protected and your process has a lower or incompatible signer level, the kernel denies the handle with ACCESS_DENIED regardless of your privileges.

Processes with SeDebugPrivilege (like those run by administrators) can normally access and control any other process like reading memory, injecting code, and managing threads enabling tools like Task Manager to work. However, this poses a problem for protecting sensitive digital content. To address this, Microsoft introduced protected processes in Windows Vista and Server 2008, which restrict access so that even administrators cannot fully control them.

### Signer
A Signer  is a trust level assigned to a protected process that identifies who vouches for that process and determines where it sits in the protection hierarchy. Every Protected Process Light (PPL) carries a signer designation baked into its _PS_PROTECTION field in EPROCESS, derived from the digital certificate the executable was signed with. The signer is not just a label, it is the mechanism that controls which processes can interact with which other processes. Higher signer levels can open handles to lower signer levels but the reverse is never permitted.
```
                                    Level 7  WinSystem
                                               └── Most critical OS processes
                                                   System process, Memory Compression
                                    
                                      Level 6  WinTCB  (Windows Trusted Computing Base)
                                               └── Highest level for user mode processes
                                                   Processes the kernel trusts completely
                                    
                                      Level 5  Windows
                                               └── Key system processes
                                                   smss.exe, csrss.exe, services.exe, wininit.exe
                                    
                                      Level 4  AntiMalware
                                               └── AV/EDR products
                                                   Windows Defender (MsMpEng.exe)
                                    
                                      Level 3  Authenticode
                                               └── Regular signed third party applications
                                    
                                      Level 2  Lsa
                                               └── lsass.exe specifically
                                    
                                      Level 1  CodeGen
                                               └── .NET JIT compiler helpers
                                    
                                      Level 0  None
                                               └── Normal processes — where you land as an attacker
```

#### How signer level is determined

The signer level a process gets is not chosen by the process itself — it is determined by the digital certificate used to sign the executable and specifically by the EKU (Enhanced Key Usage) fields inside that certificate. Windows Code Integrity reads the certificate at load time and maps specific EKU identifiers to specific signer values. A certificate from the Microsoft Windows Issuer with the Windows System Component Verification EKU gets WinTCB. A certificate with the anti-malware EKU gets AntiMalware. You cannot fake this  the certificates are issued and controlled by Microsoft.


### Protected Process Light (PPL)

Protected Process Light is a Windows kernel security feature that allows certain processes to run with restricted access, preventing untrusted or lower-privileged processes from reading their memory, injecting code, or manipulating handles. It is designed to protect critical system and security processes while allowing limited trusted interactions.


### PPL Signer Levels
**PPL Signer Levels** in Windows are enumerated trust levels assigned to **Protected Process Light (PPL) processes**, indicating the **source or authority of the code that created the process**. These levels are used by the Windows kernel to enforce access restrictions: only processes with an equal or higher trust level can perform sensitive operations (such as handle opening, memory access, or termination) on a PPL process.

### Implementation : 
- Each PPL process has **two key fields** in its `EPROCESS` structure:
    1. **PsProtectedType** → Type of protection (Protected, Protected Light)
    2. **PsProtectedSigner** → Signer level (WinSystem, Lsa, Antimalware, etc.)
- When a process tries to **open a handle, duplicate a handle, read/write memory, or inject code**:
    - The **kernel checks the requestor’s signer level**.
    - If the requestor is **not trusted at that level**, the action is **denied**, even if it’s running as SYSTEM.
- There are also **light vs full protection types**:
    
    - Light (ProtectedLight) → moderate protection.
    - Full (Protected) → very strict, even more restrictions.
