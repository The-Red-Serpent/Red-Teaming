## Loops
Loops are implemented using labels, comparison instructions, and jump instructions to control the execution flow. Unlike high-level languages with explicit for or while structures, assembly relies on manually altering the CPU's instruction pointer based on conditional checks.

```asm
    MOV ECX, 10          ; Initialize counter to 10
loop_start:
    ; ... [Your loop body code goes here] ...

    DEC ECX              ; Decrement counter by 1
    JNZ loop_start       ; Jump back to loop_start if ECX is not 0
```

## Functions
In x64 assembly, a procedure is basically a **function**: a reusable block of code that you can call whenever you need it. You usually create a procedure with a **label**, use `CALL` to execute it, and `RET` to return to the instruction after the `CALL`.

### Basic syntax

```asm
procedure_name:
    ; instructions
    ret
```

### Example

```asm
section .text

_start:
    mov rax, 5
    mov rbx, 10

    call add_numbers

    ; RAX now contains 15

add_numbers:
    add rax, rbx
    ret
```

The flow is:

```text
_start
  ↓
mov rax, 5
  ↓
mov rbx, 10
  ↓
call add_numbers
  ↓
add_numbers:
  add rax, rbx
  ↓
ret
  ↓
back to instruction after CALL
```

`CALL` does two important things:

1. Jumps to the procedure.
2. Saves the address of the next instruction so `RET` knows where to return.

`RET` then returns to that saved address.

## Reference
- https://exercism.org/tracks/x86-64-assembly/concepts/loops
