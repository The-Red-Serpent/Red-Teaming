## Access Modes :
**Access Mode** here refers to the **privilege level at which the CPU executes code**. Windows has **two main modes**:
1. **User Mode**
2. **Kernel Mode**

## User Mode

**User mode** is a restricted execution environment where most applications run. Code executing in user mode cannot directly access hardware, kernel memory, or critical system structures. This isolation ensures system stability and security—if a user‑mode process crashes, it does not crash the operating system.

Each user‑mode application runs in its own **private virtual address space**, preventing it from directly accessing the memory of other processes.

### User‑Mode Components

#### Applications
User-facing programs such as web browsers, office applications, and games. From a red team perspective, these processes are common post‑exploitation targets because they operate in user context and often handle sensitive data.

#### Subsystems
Subsystems act as intermediaries between user‑mode applications and kernel‑mode services.

- **Win32 Subsystem (`csrss.exe`)**  
  Supports console windows, process and thread creation, and parts of GUI handling. It is critical to system stability and always running.

- **NT Subsystem (`ntdll.dll`)**  
  Provides the lowest-level user‑mode interface to the Windows kernel. Contains system call stubs (`Nt*` / `Zw*`) that transition execution from user mode to kernel mode. Nearly all Windows API calls pass through `ntdll.dll`.

- **Other Subsystems**  
  Historically included POSIX and OS/2 subsystems for compatibility. These are largely deprecated today.

### Dynamic Link Libraries (DLLs)

Windows implements much of its functionality using **Dynamic Link Libraries (DLLs)**. DLLs contain shared code and data that multiple processes can load at runtime.

Instead of statically linking common functionality into every executable, Windows loads DLLs dynamically. The **code sections of DLLs are shared in physical memory** across processes, while data sections remain private to each process.


## Kernel Mode

**Kernel mode** is the privileged execution environment where the Windows operating system has unrestricted access to hardware, memory, and system resources. Code running in kernel mode can fully control the system.

User‑mode applications must interact with kernel mode through **system calls**, enforcing a strict security boundary.

### Windows Executive

The **Windows Executive** provides high‑level operating system services and manages most system functionality.

Key components include:

- **Object Manager**  
  Manages system resources as objects (files, processes, threads, mutexes, registry keys). Access is controlled using handles and security descriptors.
- **Virtual Memory Manager (VMM)**  
  Manages virtual address spaces, paging, memory protection, and pagefile interaction, enforcing process isolation.
- **Process Manager**  
  Handles creation, management, and termination of processes and threads.
- **Security Reference Monitor (SRM)**  
  Enforces access control and security policies by validating permissions for object access.
- **I/O Manager**  
  Provides a unified interface for input/output operations and coordinates communication with device drivers.
- **Cache Manager**  
  Improves performance by caching frequently accessed data in memory.





![image](https://www.scaler.com/topics/images/user-mode-and-kernel-mode-2.webp)

### System Calls
User‑mode applications cannot directly access kernel‑mode memory or hardware resources. To request privileged operations, they must use **system calls** (also known as *syscalls* or *service calls*). System calls are the controlled interface that allows user‑mode code to transition safely into kernel mode.
```
[Application Layer]        ← Your program (C/C++, .NET, etc.)
       │
       ▼
[High-level Libraries]      ← Optional wrappers (MFC, Qt, .NET Framework)
       │
       ▼
[Win32 API]                 ← user32.dll, gdi32.dll, kernel32.dll
       │
       ▼
[NTDLL.dll]                 ← The lowest **user-mode** library
       │
       ▼
[Kernel-mode]               ← ntoskrnl.exe and Windows kernel
       │
       ▼
[Hardware / Drivers]        ← CPU, memory, disk, GPU, etc.
```
