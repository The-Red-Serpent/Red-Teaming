### Kernel
The kernel is a specialised program that acts as a mandatory middleman between all software and the hardware of the computer. It runs in the highest CPU privilege level (Ring 0) giving it unrestricted access to memory and hardware. No user mode program can interact with hardware directly,they must request it through the kernel via system calls. The kernel carries out those requests on behalf of programs, enforcing security and stability by ensuring no program can corrupt another or directly abuse hardware.

![image](https://media.geeksforgeeks.org/wp-content/uploads/20250124124411692602/kernel.webp)

### CPU Privilege Rings
Modern CPUs (x86/x64) have a hardware-enforced privilege system built directly into the processor itself. It's called the ring model.
```
        Ring 0  ←  Kernel (unrestricted, all instructions allowed)
        Ring 1  ←  (unused by Windows)
        Ring 2  ←  (unused by Windows)
        Ring 3  ←  User mode applications (restricted)
```
Windows only uses two of them in practice  Ring 0 and Ring 3.

#### Ring 0 (Kernel Mode)

The CPU allows execution of any instruction, including privileged ones like directly reading/writing hardware ports, modifying page tables, and controlling interrupts
The kernel, device drivers, and the Windows Executive all run here.A bug here crashes the entire system hence Blue Screen of Death. There's no safety net above it

#### Ring 3 (User Mode)

Where every normal program runs  your browser, notepad, malware, everything
The CPU actively blocks privileged instructions. If a Ring 3 program tries to execute one, the CPU throws a fault immediately the program doesn't get a choice
Memory is also restricted a Ring 3 program can only see its own virtual address space, not kernel memory or other processes' memory

How a program crosses from Ring 3 to Ring 0
When your program needs something privileged (open a file, allocate memory, create a process), it executes a special instruction called a syscall. This is the only legal crossing point:
```
User mode program (Ring 3)
        ↓  calls CreateFile()
    kernel32.dll → ntdll.dll
        ↓  executes syscall instruction
CPU switches to Ring 0
        ↓
    Kernel handles the request
        ↓
CPU switches back to Ring 3
        ↓
Result returned to your program
```

### Kernel Object 
A kernel Object is a structured data structure allocated in kernel memory (Ring 0) that represents a system resource such as a process, thread or file. Your program never accesses this memory directly , it is owned and managed entirely by the kernel's Object Manager. Every kernel object has two parts: a header (containing the object's name, type, reference count, and DACL for permission checks) and a body (the actual resource data, e.g. EPROCESS for a process, FILE_OBJECT for a file). The object stays alive in memory as long as its reference count is above zero, which increments every time a handle to it is opened and decrements every time a handle is closed.

### Kernel Handle
A kernel handle is an opaque integer value returned by the kernel when you open or create a kernel object. It is not the memory address of the object itself, it is an index into your process's private handle table, which in turn stores the actual pointer to the kernel object along with an access mask. This extra layer of indirection exists so the kernel can intercept and permission-check every single operation you attempt through that handle. Handles are process-local, meaning the same integer value in two different processes points to completely different objects. Every handle must be closed with CloseHandle() when done, which decrements the reference count on the underlying object.
