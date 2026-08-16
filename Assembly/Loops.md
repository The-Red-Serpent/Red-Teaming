## Loops
Loops are implemented using labels, comparison instructions, and jump instructions to control the execution flow. Unlike high-level languages with explicit for or while structures, assembly relies on manually altering the CPU's instruction pointer based on conditional checks.

```asm
    MOV ECX, 10          ; Initialize counter to 10
loop_start:
    ; ... [Your loop body code goes here] ...

    DEC ECX              ; Decrement counter by 1
    JNZ loop_start       ; Jump back to loop_start if ECX is not 0
```

## Reference
- https://exercism.org/tracks/x86-64-assembly/concepts/loops
