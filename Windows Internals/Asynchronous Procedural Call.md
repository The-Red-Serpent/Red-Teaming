
## Asynchronous Procedural Call
An asynchronous procedure call (APC) is a mechanism in the Windows operating system that enables a specified function to execute asynchronously within the context of a particular thread, without blocking the thread's ongoing operations.When an APC is queued to a thread, the system generates a software interrupt, allowing the APC function to run the next time the thread is scheduled for execution. Each thread maintains its own dedicated APC queue, which facilitates non-blocking asynchronous processing for tasks such as input/output (I/O) completion notifications and timer callbacks.

APC queues are defined inside KTHREAD which is the first member of ETHREAD named Tcb.Specifically inside a field called ApcState which is of type KAPC_STATE:
```
ETHREAD
  └── Tcb  (this IS the KTHREAD)
       └── ApcState  (type: KAPC_STATE)
            ├── UserApcListHead    ← user mode APC queue
            ├── KernelApcListHead  ← kernel mode APC queue
            ├── KernelApcInProgress
            ├── KernelApcPending
            └── UserApcPending     ← flag: APC waiting to fire
```

When a user mode APC is queued to a thread (more on that later), the APC just sits there in the queue, doing nothing. To actually run the APCs currently attached to a thread, that thread must go into an alertable wait (also called alertable state). When in that state, any and all APCs in the thread’s queue execute in sequence. APCs do NOT execute immediately.They execute only when the target thread becomes alertable.

## Implementation
User Mode — QueueUserAPC
The Win32 API function for queuing a user mode APC:

```
cDWORD QueueUserAPC(
    PAPCFUNC pfnAPC,   // function to execute
    HANDLE hThread,    // thread to queue it to
    ULONG_PTR dwData   // parameter passed to function
);
```

```
// The function you want to execute in another thread:
  VOID CALLBACK MyApcFunction(ULONG_PTR parameter) {
      MessageBox(NULL, "APC fired!", "APC", MB_OK);
  }

  // Queue it to a thread:
  QueueUserAPC(
      MyApcFunction,   // function to run
      hThread,         // target thread handle
      0                // parameter
  );

  // Now MyApcFunction will execute inside hThread
  // the next time hThread enters an alertable wait
```

---

### What happens internally when you call QueueUserAPC
```
  You call QueueUserAPC(MyFunction, hThread, param)
          ↓
  Goes to ntdll.dll
          ↓
  Calls NtQueueApcThread() — native API
          ↓
  syscall → crosses into Ring 0
          ↓
  Kernel allocates a KAPC structure
  ┌─────────────────────────────────┐
  │  KAPC                           │
  │  Thread         → hThread       │
  │  NormalRoutine  → MyFunction    │
  │  NormalContext  → param         │
  └─────────────────────────────────┘
          ↓
  Kernel inserts KAPC into thread's
  KTHREAD.ApcState.UserApcListHead
  (adds to end of linked list)
          ↓
  Kernel sets UserApcPending = TRUE
  on the target thread's KTHREAD
          ↓
  Returns to user mode
```

---

### How the APC actually fires
```
  Target thread is running normally
          ↓
  Target thread calls alertable wait:
  SleepEx(1000, TRUE)
          ↓
  Thread crosses into kernel via syscall
          ↓
  Kernel checks KTHREAD.ApcState.UserApcPending
  flag = TRUE → APCs are pending
          ↓
  Kernel calls KiDeliverApc()
          ↓
  Walks UserApcListHead linked list
  removes each KAPC one by one
          ↓
  Builds a special stack frame in user mode
  that will call your APC function
          ↓
  Thread returns to user mode
          ↓
  Instead of resuming SleepEx
  thread executes your APC function first
          ↓
  MyFunction(param) runs inside target thread
          ↓
  APC function returns
          ↓
  If more APCs pending → deliver next one
  If no more APCs → SleepEx resumes normally
```

### How to queue a function in a specific thread
```
                            YOUR PROCESS                    TARGET PROCESS
                            ┌────────────────┐              ┌──────────────────────┐
                            │                │              │  Thread (hThread)    │
                            │ 1. OpenProcess─┼─────────────→│                      │
                            │                │              │  KTHREAD             │
                            │ 2. VirtualAlloc┼─────────────→│  ApcState            │
                            │    Ex creates  │              │  UserApcListHead     │
                            │    memory here │              │  [empty]             │
                            │                │              │                      │
                            │ 3. WriteProcMem┼─────────────→│  pRemoteMemory       │
                            │    copies      │              │  [your shellcode]    │
                            │    shellcode   │              │                      │
                            │                │              │                      │
                            │ 4. QueueUserAPC┼─────────────→│  UserApcListHead     │
                            │    queues APC  │              │  [KAPC→pRemoteMemory]│
                            │    to hThread  │              │  UserApcPending=TRUE │
                            └────────────────┘              │                      │
                                                            │  Thread enters       │
                                                            │  alertable wait      │
                                                            │         ↓            │
                                                            │  shellcode executes  │
                                                            │  at pRemoteMemory    │
                                                            └──────────────────────┘
```

## Types of APC Code Injection:

### 1- Normal APC Injection:
This method involves targeting a handle to a thread within a running process and queuing code into that thread’s APC queue using functions like QueueUserAPC. After queuing the code, the goal is to make the thread enter an alertable state (e.g., by invoking SleepEx or WaitForSingleObjectEx), which will then trigger the queued code for execution.

### 2- Early Bird APC Injection:
In this technique, a new process is created in a suspended state. Code is injected while the process is still suspended. A pointer to the injected code is then added to the APC queue of a thread in this suspended process. When the process resumes execution, it enters an alertable state, and the queued APC is executed. This allows the code to run early in the process lifecycle, at about the same time as ntdll.dll initializes low-level and environment setup for the process.Because this technique injects code before many AVs have a chance to analyze the process, it can evade detection by running code at a point AVs may not yet monitor.

