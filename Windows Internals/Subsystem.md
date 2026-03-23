### Subsystem
Windows Subsystem is a layer that sits between user mode applications and the Windows kernel, providing a specific set of pre-written API functions that applications can call instead of talking to the kernel directly. The kernel only understands one low level language (the Native API), so the subsystem acts as a translator  receiving high level API calls from applications, translating them into native kernel calls, and passing them down through ntdll.dll to the kernel.

The Windows subsystem has two parts:
 
### Subsystem DLL

The actual libraries your application links against. These are the DLLs that implement the Windows API (kernel32.dll, user32.dll, advapi32.dll) that contain the API functions your application calls

```
            ╔══════════════════╦═══════════════════════════╦══════════════════════════════════════════════╗
            ║       DLL        ║        CATEGORY           ║           KEY FUNCTIONS                      ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  CreateProcess, OpenProcess                  ║
            ║  kernel32.dll    ║  Processes, Threads,      ║  CreateThread, OpenThread                    ║
            ║                  ║  Memory, Files            ║  VirtualAlloc, VirtualProtect                ║
            ║                  ║                           ║  CreateFile, ReadFile, WriteFile             ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  NtCreateProcess, NtOpenProcess              ║
            ║  ntdll.dll       ║  Native API — lowest      ║  NtAllocateVirtualMemory                     ║
            ║                  ║  user mode layer,         ║  NtWriteVirtualMemory                        ║
            ║                  ║  bridge to kernel         ║  NtCreateThreadEx                            ║
            ║                  ║                           ║  LdrLoadDll (loads DLLs)                     ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  CreateWindow, DestroyWindow                 ║
            ║  user32.dll      ║  Windows, GUI,            ║  SendMessage, PostMessage                    ║
            ║                  ║  Input, Messages          ║  GetMessage, MessageBox                      ║
            ║                  ║                           ║  SetWindowsHookEx                            ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  RegOpenKey, RegCreateKey                    ║
            ║  advapi32.dll    ║  Security, Registry,      ║  RegSetValue, RegQueryValue                  ║
            ║                  ║  Services, Tokens         ║  OpenProcessToken, DuplicateToken            ║
            ║                  ║                           ║  AdjustTokenPrivileges                       ║
            ║                  ║                           ║  CreateService, OpenService                  ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  DrawText, BitBlt                            ║
            ║  gdi32.dll       ║  Graphics, Drawing,       ║  CreateFont, SelectObject                    ║
            ║                  ║  Bitmaps                  ║  CreateBitmap, StretchBlt                    ║
            ║                  ║                           ║  GetDeviceCaps                               ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  WSAStartup, WSACleanup                      ║
            ║  ws2_32.dll      ║  Networking,              ║  socket, connect, bind                       ║
            ║                  ║  Sockets                  ║  send, recv                                  ║
            ║                  ║                           ║  getaddrinfo                                 ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  CoInitialize, CoCreateInstance              ║
            ║  ole32.dll       ║  COM Objects,             ║  CoGetClassObject                            ║
            ║                  ║  OLE                      ║  IUnknown interface                          ║
            ║                  ║                           ║  CoUninitialize                              ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  LoadLibrary, FreeLibrary                    ║
            ║  kernelbase.dll  ║  Core subset of           ║  GetProcAddress                              ║
            ║                  ║  kernel32 — many          ║  VirtualAlloc, VirtualFree                   ║
            ║                  ║  kernel32 calls           ║  CreateFile                                  ║
            ║                  ║  forward here             ║  (kernel32 forwards many                     ║
            ║                  ║                           ║   calls here internally)                     ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  CryptEncrypt, CryptDecrypt                  ║
            ║  crypt32.dll     ║  Cryptography,            ║  CertOpenStore                               ║
            ║                  ║  Certificates             ║  CryptSignMessage                            ║
            ║                  ║                           ║  CryptVerifySignature                        ║
            ╠══════════════════╬═══════════════════════════╬══════════════════════════════════════════════╣
            ║                  ║                           ║  NetUserGetInfo, NetUserAdd                  ║
            ║  netapi32.dll    ║  Network management,      ║  NetLocalGroupAdd                            ║
            ║                  ║  User/Group management    ║  NetShareAdd, NetShareDel                    ║
            ║                  ║                           ║  NetSessionEnum                              ║
            ╚══════════════════╩═══════════════════════════╩══════════════════════════════════════════════╝
```

### CSRSS.exe  

Client Server Runtime Subsystem a system process running in user mode that manages console windows, process/thread creation notifications, and some GUI operations. It is one of the most critical processes on the system  killing it causes an immediate BSOD.A critical system process that keeps the subsystem running.


### Windows Native API

Windows Native API is the lowest level set of functions available in user mode, implemented inside ntdll.dll. It sits directly above the kernel and is the last stop before a syscall crosses the Ring 3 / Ring 0 boundary. Every single API call from every subsystem DLL  whether it comes from kernel32.dll, advapi32.dll, user32.dll, or anywhere else eventually gets translated into a Native API call before reaching the kernel.

### Syscall

A Syscall (System Call) is a special CPU instruction that is the only legal way for user mode code (Ring 3) to ask the kernel (Ring 0) to perform a privileged operation on its behalf. Since user mode code is blocked by the CPU from directly accessing hardware, other processes memory, or any other privileged resource, it must use a syscall to cross the Ring 3 / Ring 0 boundary. When a syscall fires, the CPU saves the current user mode state, switches to Ring 0, runs the requested kernel function, then switches back to Ring 3 and returns the result  all transparently, without the calling program needing to know anything about what happened inside the kernel.
Every syscall is identified by a unique number called the SSN (System Service Number) which is loaded into the eax register before the syscall fires. The kernel reads this number and looks it up in the SSDT (System Service Descriptor Table) to find which kernel function to execute.

```
                            YOUR PROGRAM (Ring 3 — User Mode)
                              ═══════════════════════════════════════════════════════════════
                            
                              ┌─────────────────────────────────────────────────────────┐
                              │                  YOUR CODE                              │
                              │                                                         │
                              │   HANDLE h = CreateFile("passwords.txt", ...)           │
                              └─────────────────────────────┬───────────────────────────┘
                                                            │
                                                            ▼
                              ┌─────────────────────────────────────────────────────────┐
                              │                  kernel32.dll                           │
                              │                                                         │
                              │   CreateFile()                                          │
                              │   validates arguments, prepares the call                │
                              └─────────────────────────────┬───────────────────────────┘
                                                            │
                                                            ▼
                              ┌─────────────────────────────────────────────────────────┐
                              │                   ntdll.dll                             │
                              │                                                         │
                              │   NtCreateFile()                                        │
                              │                                                         │
                              │   ┌─────────────────────────────────────────────┐       │
                              │   │            KERNEL GATE                      │       │
                              │   │                                             │       │
                              │   │   mov r10, rcx    ← save argument           │       │
                              │   │   mov eax, 0x55   ← load SSN                │       │
                              │   │   syscall         ← FIRE                    │       │
                              │   │   ret             ← return result           │       │
                              │   └──────────────────────┬──────────────────────┘       │
                              └──────────────────────────┼──────────────────────────────┘
                                                         │
                                                         │  CPU saves Ring 3 state
                                                         │  (registers, stack, instruction pointer)
                                                         │  CPU flips to Ring 0
                                                         │
                              ═══════════════════════════╪═══════════════════════════════════════
                                              RING 3 / RING 0 BOUNDARY
                              ═══════════════════════════╪═══════════════════════════════════════
                                                         │
                                                         ▼
                              KERNEL (Ring 0 — Kernel Mode)
                              ═══════════════════════════════════════════════════════════════
                            
                              ┌─────────────────────────────────────────────────────────┐
                              │               SYSCALL HANDLER                           │
                              │                                                         │
                              │   reads eax = 0x55                                      │
                              │   looks up SSDT[0x55]                                   │
                              │            │                                            │
                              │            ▼                                            │
                              │   ┌──────────────────────────────────────────┐          │
                              │   │    SSDT (System Service Descriptor Table) │         │
                              │   │                                          │          │
                              │   │   SSDT[0x26]  →  NtOpenProcess           │          │
                              │   │   SSDT[0x18]  →  NtAllocateVirtualMemory │          │
                              │   │   SSDT[0x55]  →  NtCreateFile  ◄─────────┼──found   │
                              │   │   SSDT[0x3A]  →  NtWriteVirtualMemory    │          │
                              │   └──────────────────────┬───────────────────┘          │
                              └──────────────────────────┼──────────────────────────────┘
                                                         │
                                                         ▼
                              ┌─────────────────────────────────────────────────────────┐
                              │               NtCreateFile runs in Ring 0               │
                              │                                                         │
                              │   runs security checks                                  │
                              │   checks your token against file DACL                   │
                              │   creates FILE_OBJECT in kernel memory                  │
                              │   adds entry to your handle table                       │
                              │   puts result in eax register                           │
                              └──────────────────────────┬──────────────────────────────┘
                                                         │
                                                         │  CPU restores Ring 3 state
                                                         │  CPU flips back to Ring 3
                                                         │
                              ═══════════════════════════╪═══════════════════════════════════════
                                              RING 0 / RING 3 BOUNDARY
                              ═══════════════════════════╪═══════════════════════════════════════
                                                         │
                                                         ▼
                              YOUR PROGRAM (Ring 3 — back in User Mode)
                              ═══════════════════════════════════════════════════════════════
                            
                              ┌─────────────────────────────────────────────────────────┐
                              │                  YOUR CODE                              │
                              │                                                         │
                              │   h = 0x00B4   ← handle to passwords.txt returned       │
                              │                   program continues normally            │
                              └─────────────────────────────────────────────────────────┘
                            
                            
                              EDR HOOK SCENARIO (how EDR intercepts):
                              ════════════════════════════════════════
                            
                              Normal (clean):                    Hooked (EDR present):
                              ───────────────                    ─────────────────────
                              mov r10, rcx                       jmp 0x[EDR.dll]   ← EDR intercepts here
                              mov eax, 0x55                      mov eax, 0x55       before syscall fires
                              syscall          ← fires clean     syscall
                              ret                                ret
                            
                            
                              Direct Syscall (bypass EDR):
                              ═════════════════════════════
                            
                              Your code                          Your code
                                   ↓                                  ↓
                              ntdll (hooked by EDR)             mov eax, 0x55   ← you do this yourself
                                   ↓                            syscall         ← go straight to kernel
                              syscall                                ↓
                                   ↓                           Kernel (Ring 0)
                              Kernel (Ring 0)
                              EDR sees the call                 EDR sees nothing

  ```

### Kernel Gate

Kernel Gate
The kernel gate is a small piece of code that sits inside every Native API function in ntdll.dll and is responsible for actually triggering the syscall. Think of it as the physical doorway between user mode and kernel mode  everything builds up to it, and it is the exact moment the crossing happens.
When you call a function like NtOpenProcess, the kernel gate is the last thing that runs before control leaves your program and enters the kernel. It does two simple things  loads the correct SSN into the eax register so the kernel knows which operation to perform, then fires the syscall instruction to cross the boundary.

```
NtOpenProcess inside ntdll.dll:

  mov r10, rcx       ← save the argument
  mov eax, 0x26      ← load the SSN (which operation to perform)
  syscall            ← THIS IS THE KERNEL GATE
  ret                ← return result back to caller
```
