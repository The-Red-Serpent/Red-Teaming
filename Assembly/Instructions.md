## Instructions

## 1. MOV
`MOV` copies data from the source operand to the destination operand. The original source value is not changed.

### Syntax

```asm
MOV destination, source
```

### Example

```asm
mov rax, rbx
```

This copies the value in `RBX` into `RAX`.


## 2. INC

`INC` increases the value of its operand by 1.

### Syntax

```asm
INC destination
```

### Example

```asm
inc rax
```

If `RAX` contains `10`, it becomes `11`.


## 3. DEC

`DEC` decreases the value of its operand by 1.

### Syntax

```asm
DEC destination
```

### Example

```asm
dec rax
```

If `RAX` contains `10`, it becomes `9`.


## 4. ADD

`ADD` adds the source operand to the destination operand and stores the result in the destination.

### Syntax

```asm
ADD destination, source
```

### Example

```asm
add rax, rbx
```

If `RAX = 10` and `RBX = 5`, then `RAX = 15`.

## 5. SUB

`SUB` subtracts the source operand from the destination operand and stores the result in the destination.

### Syntax

```asm
SUB destination, source
```

### Example

```asm
sub rax, rbx
```

If `RAX = 10` and `RBX = 3`, then `RAX = 7`.


## 6. MUL

`MUL` performs an unsigned multiplication. One operand is explicitly provided, while the other operand is implicitly taken from the accumulator register. In x64, multiplying two 64-bit values produces a 128-bit result in `RDX:RAX`.

### Syntax

```asm
MUL source
```

### Example

```asm
mov rax, 10
mov rbx, 5
mul rbx
```

This multiplies `RAX × RBX`, producing `50` in the `RDX:RAX` result.


## 7. IMUL

`IMUL` performs signed integer multiplication. Unlike `MUL`, `IMUL` also has forms that allow you to specify the destination explicitly.

### Syntax

```asm
IMUL destination, source
```

### Example

```asm
imul rax, rbx
```

If `RAX = 10` and `RBX = 5`, then `RAX = 50`.


## 8. DIV

`DIV` performs unsigned integer division. The CPU divides the implicit dividend by the specified divisor, placing the quotient and remainder in specific registers.

For 64-bit division, the dividend is `RDX:RAX`, the quotient goes into `RAX`, and the remainder goes into `RDX`.

### Syntax

```asm
DIV divisor
```

### Example

```asm
mov rax, 20
xor rdx, rdx
mov rbx, 6
div rbx
```

This calculates `20 ÷ 6`.

```text
RAX = 3    ; quotient
RDX = 2    ; remainder
```

## 9. IDIV
`IDIV` performs signed integer division. Like `DIV`, it produces a quotient and remainder, but it interprets the operands as signed values.

### Syntax

```asm
IDIV divisor
```

### Example

```asm
mov rax, -20
cqo
mov rbx, 6
idiv rbx
```

This calculates `-20 ÷ 6`.

The quotient is stored in `RAX` and the remainder in `RDX`.

## 10. XOR

`XOR` performs a bitwise exclusive OR operation between two operands. A bit is `1` when the corresponding bits are different and `0` when they are the same.

### Syntax

```asm
XOR destination, source
```

### Example

```asm
xor eax, eax
```

This sets `EAX` to `0`, because any value XORed with itself produces zero.


## 11. INT

`INT` generates a software interrupt, transferring execution to an interrupt handler. On older 32-bit Linux systems, `int 0x80` was commonly used to request a system call from the kernel.

### Syntax

```asm
INT interrupt_number
```

### Example

```asm
int 0x80
```
