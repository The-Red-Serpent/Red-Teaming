## Arithmetic Instructions

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

## Logical Instructions

## 1. AND

`AND` performs a bitwise AND operation between two operands. Each resulting bit is `1` only when both corresponding bits are `1`; otherwise, it is `0`.

### Syntax

```asm
AND destination, source
```

### Example

```asm
mov al, 0b1010
and al, 0b0011
```

Result:

```text
1010
0011
----
0010
```

So `AL = 0010`.

A common use of `AND` is **masking bits**, such as checking whether a number is odd:

```asm
and al, 1
```

If the result is `1`, the number was odd; if it is `0`, it was even.


## 2. OR

`OR` performs a bitwise OR operation between two operands. Each resulting bit is `1` when either or both corresponding bits are `1`; it is `0` only when both bits are `0`.

### Syntax

```asm
OR destination, source
```

### Example

```asm
mov al, 0b0101
or  al, 0b0011
```

Result:

```text
0101
0011
----
0111
```

So `AL = 0111`.

A common use of `OR` is **setting specific bits to 1**.



## 3. XOR

`XOR` performs a bitwise exclusive OR operation. Each resulting bit is `1` when the corresponding bits are different and `0` when they are the same.

### Syntax

```asm
XOR destination, source
```

### Example

```asm
mov al, 0b0101
xor al, 0b0011
```

Result:

```text
0101
0011
----
0110
```

So `AL = 0110`.

A very common use is clearing a register:

```asm
xor eax, eax
```

Because any value XORed with itself produces zero, this sets `EAX` to `0`.

## 4. TEST

`TEST` performs a bitwise AND between two operands **only for the purpose of setting the CPU flags**. Unlike `AND`, it does not store the result, so the operands remain unchanged.

### Syntax

```asm
TEST operand1, operand2
```

### Example

```asm
test al, 1
```

This checks the lowest bit of `AL`.

If the lowest bit is `0`, the Zero Flag (`ZF`) is set:

```asm
jz even_number
```

This is commonly used to check whether a number is even or odd without modifying the original value.


## 5. NOT
`NOT` performs a bitwise NOT operation. It reverses every bit in the operand: `1` becomes `0`, and `0` becomes `1`.

### Syntax

```asm
NOT destination
```

### Example

```asm
mov al, 0b01010011
not al
```

Result:

```text
01010011
↓ NOT
10101100
```

So `AL = 10101100`.


