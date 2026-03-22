### Thread
A thread is the smallest unit of execution within a Windows process. It represents a single flow of control or sequence of instructions that the CPU executes independently, while sharing the process’s resources such as virtual memory, handles, and loaded modules. 

```
                              +----------------------------------------------------------+
                              |                          THREAD                          |
                              |----------------------------------------------------------|
                              |  Belongs to a Process (EPROCESS)                         |
                              |                                                          |
                              |====================== USER MODE =========================|
                              |  +----------------------------------------------------+  |
                              |  | Thread Environment Block (TEB)                     |  |
                              |  |----------------------------------------------------|  |
                              |  |  Thread ID                                         |  |
                              |  |  Pointer to PEB                                    |  |
                              |  |  Thread Local Storage (TLS)                        |  |
                              |  |  SEH Chain                                         |  |
                              |  |  Stack Base / Stack Limit                          |  |
                              |  |  LastErrorValue                                    |  |
                              |  +----------------------------------------------------+  |
                              |                                                          |
                              |  +----------------------------------------------------+  |
                              |  | User Stack                                         |  |
                              |  |  - Function frames                                 |  |
                              |  |  - Local variables                                 |  |
                              |  |  - Return addresses                                |  |
                              |  +----------------------------------------------------+  |
                              |                                                          |
                              |  CPU Execution Context                                   |
                              |  - General-purpose registers                             |
                              |  - Instruction Pointer (RIP/EIP)                         |
                              |  - Stack Pointer (RSP/ESP)                               |
                              |                                                          |
                              |====================== KERNEL MODE ====================== |
                              |  +----------------------------------------------------+  |
                              |  | ETHREAD                                            |  |
                              |  |----------------------------------------------------|  |
                              |  |  Thread ID                                         |  |
                              |  |  Owning Process (EPROCESS)                         |  |
                              |  |  Scheduling State                                  |  |
                              |  |  Priority / Quantum                                |  |
                              |  |  APC State                                         |  |
                              |  |  Wait Objects                                      |  |
                              |  |                                                    |  |
                              |  |  Kernel Stack                                      |  |
                              |  +----------------------------------------------------+  |
                              +----------------------------------------------------------+
```

### Components
1. **Stack**: A memory region used to store local variables, function call information, and return addresses for the thread’s execution.
2. **CPU Registers**: Hardware registers that hold temporary data necessary for the thread’s execution, including general-purpose registers and the instruction pointer.
3. **Instruction Pointer (IP)**: A register that stores the memory address of the next instruction to be executed by the thread.
4. **Thread-Local Storage (TLS)**: Memory allocated for data that is private to the thread, ensuring that each thread has its own independent set of variables.
5. **Scheduling Information**: Data that contains the thread’s priority, execution time (quantum), and state, used by the scheduler to determine when and how the thread is executed.
6. **Thread State**: Indicates the current status of the thread, which can be one of the following: running, ready, waiting, or terminated.

### Thread Environment Block
Thread Environment Block (TEB) is a structure used by the Windows operating system to store information about a single thread within a process. Each thread in a process has its own TEB, and this structure contains data that the thread needs to perform its tasks

### Asynchronous Procedure Call)
An APC (Asynchronous Procedure Call) is a mechanism in Windows that allows a function to be executed asynchronously in the context of a specific thread. Instead of calling a function directly, you can queue it to a thread, and that thread will execute it later when it enters an alertable state. Each thread has its own APC queue where these functions wait until they can run. APCs are useful for scheduling work to a specific thread, accessing thread-specific resources safely, or handling asynchronous operations.

There are three types of APCs:

1. User-mode APC: Runs in user mode and is queued by applications to a specific thread. The thread must enter an alertable wait for the APC to execute. It is commonly used for asynchronous I/O completion and thread-specific callbacks.

2. Kernel-mode APC: Runs in kernel mode and is used by the operating system and drivers. It can execute even when a thread is performing kernel-mode operations, such as notifying threads of I/O completion or executing driver routines.

3. Special kernel-mode APC: A subset of kernel APCs that run in special kernel states. They are used internally by the system for operations like thread termination or resource cleanup and are not accessible to normal user-mode applications.

### Hooking
It is a powerful technique used to intercept function calls, messages, or events between software components, allowing a program to monitor, modify, or block behavior. 
By rerouting execution to a custom function (a "hook procedure"), developers can analyze application behavior, debug, or, in security contexts, hook API calls to hide processes or bypass security checks

#### **IAT Hooking**
Modify the **Import Address Table (IAT)** in the PE (Portable Executable) file. This involves replacing the function pointers in the IAT with the address of the custom hook function. This redirects the calls of specific API functions to your own functions.
#### 2. **Detours-style Hooking (Inline Hooking)**
How it's done**: Modify the first few bytes of a target function to insert a **JMP instruction** that redirects execution to a custom hook function. The custom function can call the original function if needed (or modify its behavior) before or after executing.
#### 3. **SetWindowsHookEx**
Use the **SetWindowsHookEx** API to install a hook procedure that intercepts specific window messages (like keyboard or mouse events). You can modify, cancel, or forward the messages to other hooks depending on the type of hook (e.g., `WH_KEYBOARD`, `WH_MOUSE`).

### Thread Creation
Threads can be created using:
- CreateThread (Win32)
- CreateRemoteThread (Win32)
- NtCreateThreadEx (Native API)

### Reference :
- https://scorpiosoftware.net/2024/07/24/what-can-you-do-with-apcs/
- https://tbhaxor.com/windows-process-injection-using-asynchronous-threads-queueuserapc/
