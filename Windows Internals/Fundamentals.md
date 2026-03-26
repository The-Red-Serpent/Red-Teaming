## Object
In Windows, an object is a kernel-managed data structure that represents a system resource.This resource could be a file, process, thread, event, mutex, registry key, or device.
Objects provide a uniform interface so that the Windows kernel can manage resources consistently.

| Key Point                         | Explanation                                                                                                                                          |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Managed by Object Manager**     | All Windows kernel objects live in a **namespace managed by the Object Manager**.                                                                    |
| **Has attributes**                | - **Type** – e.g., file, process, thread<br>- **Access rights** – who can read/write/execute<br>- **Reference count** – how many handles point to it |
| **Kernel memory resident**        | Objects live in **kernel memory** and are **not directly accessible** by user programs.                                                              |
| **Used for resource abstraction** | Programs interact with objects **via handles**, keeping the kernel safe and consistent.                                                              |


## Handle
A handle is a user-mode reference or pointer to a kernel object.Handles are opaque identifiers—the program doesn’t see the actual object memory, just a number that represents it.

| Key Point                       | Explanation                                                                                                 |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| **Opaque**                      | You cannot see the actual object data; you only use the handle to perform operations.                       |
| **Reference to kernel object**  | When you call `CreateFile()` (or similar APIs), Windows returns a **handle** pointing to the kernel object. |
| **Access-controlled**           | Each handle has specific **permissions** (read, write, execute) defined when it’s created.                  |
| **Managed by the handle table** | Each process has a **handle table** that maps handle numbers to kernel objects.                             |


## Register
A register is a small, high-speed storage location located inside the CPU, used to hold data, memory addresses, or instructions that are currently being processed or immediately needed by the CPU.

#### Step-by-step: how addition uses registers

Take this simple code:

```c
int a = 5;
int b = 3;
int c = a + b;
```

#### Step 1: Load values from memory (RAM → registers)

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

#### Step 3: Store result back to memory

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

#### General Purpose Register
A general-purpose register is a CPU register used for temporary storage of data, addresses, or intermediate results during program execution.
```
| 64-bit | 32-bit | 16-bit | 8-bit |
| ------ | ------ | ------ | ----- |
| RAX    | EAX    | AX     | AL    |
| RBX    | EBX    | BX     | BL    |
| RCX    | ECX    | CX     | CL    |
| RDX    | EDX    | DX     | DL    |
```

#### Accumulator
An accumulator is a special-purpose register in the CPU used to store the results of arithmetic or logic operations.
```
| 64-bit  | 32-bit  | 16-bit | 8-bit (lower) | 8-bit (higher) |
| ------- | ------- | ------ | ------------- | -------------- |
| **RAX** | **EAX** | **AX** | **AL**        | **AH**         |
```

#### Instruction Register (IR)
The instruction register is a CPU register that holds the currently executing instruction fetched from memory.

#### Program Counter (PC)
The program counter (PC), called RIP in x64 or EIP in x86, is a CPU register that holds the address of the next instruction to execute.
```
| CPU Architecture | Register Name | Purpose / Use                                                          | Notes                                                                             |
| ---------------- | ------------- | ---------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| x86              | EIP           | Holds the **address of the next instruction** to execute               | 32-bit system; automatically increments unless a jump/branch occurs               |
| x64              | RIP           | Holds the **address of the next instruction** to execute               | 64-bit system; used in Windows x64 calling convention; controls instruction fetch |
| All CPUs         | PC            | Works with Instruction Register (IR) to fetch and execute instructions | Updated every CPU cycle; not directly writable in normal programs                 |
```

#### Stack Pointer
RSP (x64) / ESP (x86) is a CPU register that points to the top of the stack.Stack grows downwards in memory (toward smaller addresses).RSP always points to the most recent value pushed onto the stack.

#### Base Pointer
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

