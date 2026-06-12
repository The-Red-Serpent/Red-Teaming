
# Primitive Data Types

## `char`

Stores a single character.

```c
char grade = 'A';
```

**Size:** 1 Byte

**Range:**

| Type          | Range       |
| ------------- | ----------- |
| signed char   | -128 to 127 |
| unsigned char | 0 to 255    |

**Use Cases**

* Characters
* ASCII values
* Small byte-sized values

---

## `int`

Stores whole numbers.

```c
int age = 25;
```

**Size:** Usually 4 Bytes

**Range**

```text
-2,147,483,648 to 2,147,483,647
```

**Use Cases**

* Counters
* Process IDs
* Integer calculations

---

## `float`

Stores decimal numbers.

```c
float pi = 3.14;
```

**Size:** 4 Bytes

**Precision:** ~7 decimal digits

**Use Cases**

* Measurements
* Sensor values
* Scientific calculations

---

## `double`

Stores decimal numbers with higher precision.

```c
double pi = 3.14159265359;
```

**Size:** 8 Bytes

**Precision:** ~15 decimal digits

**Use Cases**

* Financial calculations
* Scientific applications

---

# Integer Variants

## `short`

Smaller integer type.

```c
short x = 100;
```

**Size:** 2 Bytes

**Range**

```text
-32,768 to 32,767
```

---

## `long`

Larger integer type.

```c
long population = 10000000;
```

**Size**

| Platform  | Size    |
| --------- | ------- |
| Windows   | 4 Bytes |
| Linux x64 | 8 Bytes |

---

## `long long`

Very large integer type.

```c
long long money = 1000000000000;
```

**Size:** 8 Bytes

**Range**

```text
±9 Quintillion
```

---

## `unsigned int`
```
Signed   = Number can be positive or negative.
Unsigned = Number can only be zero or positive.
```

Stores only positive values.

```c
unsigned int count = 4000000000;
```

**Size:** 4 Bytes

**Range**

```text
0 to 4,294,967,295
```

**Why use it?**

When negative numbers make no sense.

Examples:

* Packet counts
* Process IDs
* File sizes

---

## `unsigned char`

Unsigned 1-byte value.

```c
unsigned char byte = 0x41;
```

**Size:** 1 Byte

**Range**

```text
0 to 255
```

**Common Uses**

* Shellcode
* Network packets
* Binary files

---

# Windows Data Types

Include:

```c
#include <windows.h>
```

Microsoft created these types for consistency across Windows systems.

---

# BYTE

```c
typedef unsigned char BYTE;
```

**Size:** 1 Byte

**Equivalent To**

```c
unsigned char
```

Example:

```c
BYTE b = 0x41;
```

**Common Uses**

* Shellcode
* Binary data
* Encryption keys
* File parsing

---

# WORD

```c
typedef unsigned short WORD;
```
typedef lets you create a new name (alias) for an existing data type. The biggest difference between a signed and unsigned binary number is that the far left bit is used to denote whether or not the number has a negative sign. The rest of the bits are then used to denote the value normally. This first bit, the sign bit, is used to denote whether it's positive (with a 0) or negative (with a 1)
```
typedef int <new_alias_name>;
```

**Size:** 2 Bytes

Example:

```c
WORD port = 80;
```

**Common Uses**

* Network ports
* PE file structures
* Flags

---

# DWORD

```c
typedef unsigned long DWORD;
```

**Size:** 4 Bytes

Example:

```c
DWORD pid = 1234;
```

**Common Uses**

* Process IDs
* Thread IDs
* Registry values
* PE headers

---

# DWORD64

```c
typedef unsigned long long DWORD64;
```

**Size:** 8 Bytes

Example:

```c
DWORD64 address = 0x7FF6ABCD1234;
```

**Common Uses**

* 64-bit addresses
* Kernel structures
* Debugging

---

# BOOL

```c
typedef int BOOL;
```

Values:

```c
TRUE  = 1
FALSE = 0
```

Example:

```c
BOOL success = TRUE;
```

**Common Uses**

* API return values
* Conditional checks

---

# HANDLE

```c
typedef void* HANDLE;
```

A HANDLE is a reference to a Windows object.

Think of it as:

```text
A ticket that Windows gives you to access an object.
```

Objects can be:

* Process
* Thread
* File
* Token
* Registry Key
* Mutex
* Event

Example:

```c
HANDLE hProcess;
```

Common APIs:

```c
OpenProcess()
CreateFile()
CreateThread()
```

---

# LPVOID

```c
typedef void* LPVOID;
```

Generic pointer.

Can point to any type of data.

Example:

```c
LPVOID buffer;
```

Common APIs:

```c
VirtualAlloc()
HeapAlloc()
ReadProcessMemory()
WriteProcessMemory()
```
```

