## Registers
A register is a small, high-speed storage location located inside the CPU, used to hold data, memory addresses, or instructions that are currently being processed or immediately needed by the CPU.


## Types of Registers

## General Purpose Register
A general-purpose register is a CPU register used for temporary storage of data, addresses, or intermediate results during program execution.
```
                                | 64-bit | 32-bit | 16-bit | 8-bit |
                                | ------ | ------ | ------ | ----- |
                                | RAX    | EAX    | AX     | AL    |
                                | RBX    | EBX    | BX     | BL    |
                                | RCX    | ECX    | CX     | CL    |
                                | RDX    | EDX    | DX     | DL    |
```

## Accumulator
An accumulator is a special-purpose register in the CPU used to store the results of arithmetic or logic operations.
```
                        | 64-bit  | 32-bit  | 16-bit | 8-bit (lower) | 8-bit (higher) |
                        | ------- | ------- | ------ | ------------- | -------------- |
                        |  RAX    |  EAX    |   AX   |     AL        |     AH         |
```

## Instruction Register (IR)
The instruction register is a CPU register that holds the currently executing instruction fetched from memory.

## Program Counter (PC)
The program counter (PC), called RIP in x64 or EIP in x86, is a CPU register that holds the address of the next instruction to execute.
```
| CPU Architecture | Register Name | Purpose / Use                                                          | Notes                                                                             |
| ---------------- | ------------- | ---------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| x86              | EIP           | Holds the **address of the next instruction** to execute               | 32-bit system; automatically increments unless a jump/branch occurs               |
| x64              | RIP           | Holds the **address of the next instruction** to execute               | 64-bit system; used in Windows x64 calling convention; controls instruction fetch |
| All CPUs         | PC            | Works with Instruction Register (IR) to fetch and execute instructions | Updated every CPU cycle; not directly writable in normal programs                 |
```

## Stack Pointer
RSP (x64) / ESP (x86) is a CPU register that points to the top of the stack.Stack grows downwards in memory (toward smaller addresses).RSP always points to the most recent value pushed onto the stack.

## Base Pointer
RBP (x64) / EBP (x86) is a CPU register that points to the start (base) of the current function’s stack frame.

```
| Register  | Role          | Moves?                        | Use                                          |
| --------- | ------------- | ----------------------------- | -------------------------------------------- |
| RSP / ESP | Stack Pointer | Moves as stack grows/shrinks  | Top of stack for PUSH/POP/allocations        |
| RBP / EBP | Base Pointer  | Usually fixed within function | Stable reference for local vars & parameters |
```
