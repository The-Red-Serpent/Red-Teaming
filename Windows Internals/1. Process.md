## Process
A process in Windows is a container the operating system creates to run a program, giving it its own memory space, security identity, and system resources, inside which one or more threads actually execute the code.

### A process consists of :
#### private virtual address space : 
A private virtual address space is the range of virtual memory addresses assigned by the operating system to a process, isolated from other processes, in which virtual addresses are mapped to physical memory by the OS and CPU, providing memory protection, security, and a consistent environment for execution.  
#### Executable Image : 
An executable image is a program file (usually `.exe`) loaded into a process’s virtual address space, containing the program’s code, static/global data, headers, and import information, which provides the environment for the process’s threads to begin execution.
#### Private Handle Table : 
A private handle table is a per-process data structure maintained by the Windows kernel that keeps track of all handles a process owns to system objects, such as files, events, mutexes, registry keys, and other kernel objects.
```
+---------+------------------+----------------+
| Handle  | Resource Pointer | Access Rights  |
+---------+------------------+----------------+
| 0x0001  | Object A         | Read/Write     |
| 0x0002  | Object B         | Read           |
| 0x0003  | Object C         | Execute        |
| 0x0004  | Object D         | Read/Write     |
+---------+------------------+----------------+
```
#### Security Context :
The security context of a process is the set of information that defines the process’s identity, privileges, and access rights within Windows. It determines what the process can do and which resources it can access
#### Process Execution Block:
A **Process Execution Block (EPROCESS)** is a **kernel-mode data structure that represents and manages a process**. It contains all information the operating system needs to control and track the process, including its **process ID, threads, memory management information, security token, handle table, state, and session association**.

The EPROCESS structure serves as the **kernel’s authoritative record of a process** and is used for scheduling, resource management, and security enforcement.
```
                                  +--------------------------------------------------+
                                  |                    PROCESS                       |
                                  |--------------------------------------------------|
                                  |  Access Token (Security Context)                 |
                                  |  Priority Class                                  |
                                  |                                                  |
                                  |  +--------------------------------------------+  |
                                  |  |      Private Virtual Address Space         |  |
                                  |  |--------------------------------------------|  |
                                  |  |  Executable Image (.exe)                   |  |
                                  |  |  Loaded DLLs                               |  |
                                  |  |  Heap(s)                                   |  |
                                  |  |  Stack(s) (one per thread)                 |  |
                                  |  |  Memory-mapped files                       |  |
                                  |  +--------------------------------------------+  |
                                  |                                                  |
                                  |  Working Set (Resident Physical Memory)          |
                                  |                                                  |
                                  |  +--------------------------------------------+  |
                                  |  |      Private Handle Table                  |  |
                                  |  |--------------------------------------------|  |
                                  |  |  File Handles                              |  |
                                  |  |  Registry Keys                             |  |
                                  |  |  Events / Mutexes / Sections               |  |
                                  |  +--------------------------------------------+  |
                                  |                                                  |
                                  |  Threads                                         |
                                  |  +--------------------+  +--------------------+  |
                                  |  |      Thread 1      |  |      Thread 2      |  |
                                  |  |--------------------|  |--------------------|  |
                                  |  |  TEB               |  |  TEB               |  |
                                  |  |  Stack             |  |  Stack             |  |
                                  |  |  Registers / IP    |  |  Registers / IP    |  |
                                  |  +--------------------+  +--------------------+  |
                                  |                                                  |
                                  |  Kernel Representation: EPROCESS                 |
                                  +--------------------------------------------------+
```

### Workflow
![image](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*iwtUvROcoetOHmT7LMdakQ.png)

Creating a process : 
- CreateProcess
- CreateProcessAsUser
- CreateProcessWithTokenW

Terminating a Process :
- ExitProcess
- TerminateProcess
