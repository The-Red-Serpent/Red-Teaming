### Virtual Memory
Virtual memory is a memory management technique that provides each process with its own private, contiguous virtual address space), decoupling application memory needs from limited physical RAM. It maps virtual addresses to physical RAM or page files (disk) using paging, allowing programs to exceed physical memory limits and ensuring security through process isolation

Memory Manager: The Windows Memory Manager handles the translation of virtual addresses to physical addresses, making it appear as though the process has a large, contiguous, and private memory space.

![image](https://upload.wikimedia.org/wikipedia/commons/6/6e/Virtual_memory.svg)

### Memory Allocation Functions

- VirtualAlloc
- VirtualAllocEx
- HeapCreate
- HeapAlloc
- MapViewOfFile
- CreateFileMapping

### Memory Writing Functions

- WriteProcessMemory
- memcpy
- RtlCopyMemory

### Memory Protection / Permission Functions
- VirtualProtect
- VirtualProtectEx

### Execution‑Related (commonly associated)
- CreateRemoteThread
- QueueUserAPC


### Paging
Paging is a memory management technique in which the operating system divides the virtual memory of a process into fixed-size blocks called pages and the physical memory into blocks of the same size called frames, mapping pages to frames as needed. This allows processes to run even if they are larger than physical memory, supports virtual memory, prevents memory fragmentation, and enables efficient multitasking.

- Example: You have 4 GB RAM but want to run a 6 GB game. Windows will keep some pages on disk (paging file) and swap them in/out as needed.

#### Page Table:
A page table is a data structure maintained by the operating system that maps the virtual pages of a process to physical memory frames. It is used to translate virtual addresses into physical addresses and to keep track of the status and location of each page in memory.

#### Demand Paging
A memory management strategy where the OS does not load a program's pages into RAM when it first starts. Instead it loads pages only when the program actually tries to access them  on demand. Until a page is accessed it stays on disk or simply doesn't exist in physical memory at all.
