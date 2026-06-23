## Object
In Windows, an object is a kernel-managed data structure that represents a system resource.This resource could be a file, process, thread, event, mutex, registry key, or device.
Objects provide a uniform interface so that the Windows kernel can manage resources consistently.

| Key Point                         | Explanation                                                                                                                                          |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Managed by Object Manager         | All Windows kernel objects live in a namespace managed by the Object Manager.                                                                        |
| Has attributes                    | - Type – e.g., file, process, thread<br>- Access rights – who can read/write/execute<br>- Reference count – how many handles point to it             |
| Kernel memory resident            | Objects live in kernel memory and are not directly accessible by user programs.                                                                      |
| Used for resource abstraction     | Programs interact with objects via handles, keeping the kernel safe and consistent.                                                                  |


## Handle
A handle is a user-mode reference or pointer to a kernel object.Handles are opaque identifiers—the program doesn’t see the actual object memory, just a number that represents it.

| Key Point                       | Explanation                                                                                                 |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| Opaque                          | You cannot see the actual object data; you only use the handle to perform operations.                       |
| Reference to kernel object      | When you call `CreateFile()` (or similar APIs), Windows returns a **handle** pointing to the kernel object. |
| Access-controlled               | Each handle has specific permissions (read, write, execute) defined when it’s created.                      |
| Managed by the handle table     | Each process has a handle table that maps handle numbers to kernel objects.                                 |


## Register
A register is a small, high-speed storage location located inside the CPU, used to hold data, memory addresses, or instructions that are currently being processed or immediately needed by the CPU.

#### Step-by-step: how addition uses registers

Take this simple code:

```c
int a = 5;
int b = 3;
int c = a + b;
```

### Step 1: Load values from memory (RAM → registers)

```
RAX ← 5   (value of a)
RBX ← 3   (value of b)
```

### Step 2: Perform the addition (inside CPU)

```
RAX = RAX + RBX
```
Now:

```
RAX = 8
```

### Step 3: Store result back to memory

```
c ← RAX
```

```
                                RAM                        CPU
                           +------------+         +------------------+
                           | a = 5      | ----->  | RAX = 5          |
                           | b = 3      | ----->  | RBX = 3          |
                           | c = ?      |         |                  |
                           +------------+         | RAX = RAX + RBX  |
                                                  | RAX = 8          |
                                                  +--------|---------+
                                                           |
                                                           v
                                                     c = 8 (back to RAM)
```

### Types of Registers

### General Purpose Register
A general-purpose register is a CPU register used for temporary storage of data, addresses, or intermediate results during program execution.
```
                                | 64-bit | 32-bit | 16-bit | 8-bit |
                                | ------ | ------ | ------ | ----- |
                                | RAX    | EAX    | AX     | AL    |
                                | RBX    | EBX    | BX     | BL    |
                                | RCX    | ECX    | CX     | CL    |
                                | RDX    | EDX    | DX     | DL    |
```

### Accumulator
An accumulator is a special-purpose register in the CPU used to store the results of arithmetic or logic operations.
```
                        | 64-bit  | 32-bit  | 16-bit | 8-bit (lower) | 8-bit (higher) |
                        | ------- | ------- | ------ | ------------- | -------------- |
                        |  RAX    |  EAX    |   AX   |     AL        |     AH         |
```

### Instruction Register (IR)
The instruction register is a CPU register that holds the currently executing instruction fetched from memory.

### Program Counter (PC)
The program counter (PC), called RIP in x64 or EIP in x86, is a CPU register that holds the address of the next instruction to execute.
```
| CPU Architecture | Register Name | Purpose / Use                                                          | Notes                                                                             |
| ---------------- | ------------- | ---------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| x86              | EIP           | Holds the **address of the next instruction** to execute               | 32-bit system; automatically increments unless a jump/branch occurs               |
| x64              | RIP           | Holds the **address of the next instruction** to execute               | 64-bit system; used in Windows x64 calling convention; controls instruction fetch |
| All CPUs         | PC            | Works with Instruction Register (IR) to fetch and execute instructions | Updated every CPU cycle; not directly writable in normal programs                 |
```

### Stack Pointer
RSP (x64) / ESP (x86) is a CPU register that points to the top of the stack.Stack grows downwards in memory (toward smaller addresses).RSP always points to the most recent value pushed onto the stack.

### Base Pointer
RBP (x64) / EBP (x86) is a CPU register that points to the start (base) of the current function’s stack frame.

```
| Register  | Role          | Moves?                        | Use                                          |
| --------- | ------------- | ----------------------------- | -------------------------------------------- |
| RSP / ESP | Stack Pointer | Moves as stack grows/shrinks  | Top of stack for PUSH/POP/allocations        |
| RBP / EBP | Base Pointer  | Usually fixed within function | Stable reference for local vars & parameters |
```

## Stack
The stack is a special region of computer memory that the CPU uses to store temporary data in a structured, last-in-first-out (LIFO) order. It is fundamental for function calls, returning from functions, storing local variables, and keeping track of execution context.
![image](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*3M10Yuk0xd6kXSm2k1W77A.png)

## Stack Frame
A stack frame is like a “workspace folder” for a function.Every time a function is called, the CPU creates a stack frame on the stack to keep everything that function needs to run—its local variables, return address, and a link to the previous function’s workspace.When the function finishes, the CPU throws away that folder and goes back to the previous one.

![image](https://miro.medium.com/v2/resize:fit:720/format:webp/1*Fiz_h9O9DTHmC4RtCPWPhA.png)


## Heap
The heap is a region of computer memory used for dynamic memory allocation, where data can be created and destroyed at runtime.Unlike the stack, memory in the heap does not automatically disappear when a function ends; it persists until the program explicitly frees it (or a garbage collector reclaims it).It is used to store objects, dynamically sized data structures, buffers, and any data that must outlive a single function call.
![image](https://craftofcoding.wordpress.com/wp-content/uploads/2015/12/stackmemory4.jpg?w=593)

## Drivers
A device driver is a software component that enables the operating system to communicate with and control hardware devices (or virtual/logical devices). It acts as an abstraction layer, exposing a standardized interface to the OS and applications while internally handling the device-specific implementation details. Without drivers, the OS would need built-in knowledge of every possible hardware variant  which is impractical given the diversity of vendors and device behavior. Instead, Windows defines a common driver model, and manufacturers implement drivers conforming to that model for their specific hardware.

A driver is the piece of code written for a specific operating system which gives that operating system the ability to use the features that a particular piece of hardware has. You could think of a driver quite like a translator

### How It Works
### 1. Detection and Loading

When a device is connected (or at boot), the Plug and Play (PnP) Manager identifies it via hardware IDs and locates a matching driver — either bundled with Windows, installed by the vendor, or fetched via Windows Update. The driver is then loaded as a service by the Service Control Manager (SCM).

### 2. Execution Context

Drivers run in one of two modes:

Kernel mode — full access to hardware and system memory; used for performance-critical or low-level devices (storage, network, GPU). Runs at Ring 0, so a fault here can crash the system.
User mode (UMDF) — runs with restricted privileges in a sandboxed process; safer, used for less critical devices (some USB peripherals, printers).

### 3. The I/O Request Path

When an application needs to interact with a device, it doesn't talk to hardware directly. The request flows through layers:
Application → Win32 API → I/O Manager → Driver Stack → Hardware

The I/O Manager packages the request into an I/O Request Packet (IRP).
The IRP travels down a driver stack, which may include multiple layered drivers:

Filter drivers (optional) — intercept and modify behavior (e.g., antivirus minifilters monitoring file I/O)
Function drivers — implement the core device functionality
Bus drivers — manage the underlying bus (PCI, USB) the device sits on


The lowest driver in the stack issues commands to the physical hardware.

### 4. Response and Completion
The hardware returns data/status, which propagates back up the stack to the I/O Manager, and finally to the requesting application.

### 5. Integrity Controls
Since kernel drivers run with the highest privilege level, Windows enforces driver signing (and WHQL certification for broader distribution) to ensure only trusted, verified code loads into kernel space — a control point often targeted in attacks (e.g., loading legitimately signed but vulnerable drivers to gain kernel-level execution).

```
                                                +---------------------------------------------------+
                                                |                     USER                          |
                                                +---------------------------------------------------+
                                                                         |
                                                                         v
                                                +---------------------------------------------------+
                                                |                Applications                       |
                                                |  Chrome | Discord | Word | Games | Notepad        |
                                                +---------------------------------------------------+
                                                                         |
                                                                         | Windows API Calls
                                                                         v
                                                +---------------------------------------------------+
                                                |                  USER MODE                        |
                                                |                                                   |
                                                |  user32.dll | kernel32.dll | ntdll.dll            |
                                                +---------------------------------------------------+
                                                                         |
                                                                         | System Calls
                                                                         v
                                                =====================================================
                                                                 USER ↔ KERNEL BOUNDARY
                                                =====================================================
                                                                         |
                                                                         v
                                                +---------------------------------------------------+
                                                |                 Windows Kernel                    |
                                                |                 (ntoskrnl.exe)                    |
                                                |                                                   |
                                                |  Process Mgmt | Memory Mgmt | Scheduler | I/O     |
                                                +---------------------------------------------------+
                                                                         |
                                                            +------------+------------+
                                                            |                         |
                                                            v                         v
                                                +-------------------+     +-----------------------+
                                                |   I/O Manager     |     | Security Reference    |
                                                |                   |     | Monitor (SRM)         |
                                                +-------------------+     +-----------------------+
                                                            |
                                                            | IRPs (I/O Request Packets)
                                                            v
                                                +---------------------------------------------------+
                                                |                    Drivers                        |
                                                |                                                   |
                                                |  Keyboard Driver                                  |
                                                |  Mouse Driver                                     |
                                                |  Network Driver                                   |
                                                |  Storage Driver                                   |
                                                |  Graphics Driver                                  |
                                                |  USB Driver                                       |
                                                +---------------------------------------------------+
                                                                         |
                                                                         | Device Commands
                                                                         v
                                                +---------------------------------------------------+
                                                |                    Hardware                       |
                                                |                                                   |
                                                | Keyboard | Mouse | SSD | GPU | NIC | Printer      |
                                                +---------------------------------------------------+

```





Reference : https://learn.microsoft.com/en-us/windows-hardware/drivers/gettingstarted/what-is-a-driver-


