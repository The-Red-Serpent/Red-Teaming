## Variable
A variable is a named container used to store data values in a computer's memory. Instead of remembering a complex computer memory address, you give the storage space a friendly, human-readable name. As the name "variable" suggests, the information kept inside this container can change or vary while your program is running.

## Data Type
A data type is an attribute that tells the computer how to interpret, store, and manipulate a specific piece of information. It acts like a label on a container, defining exactly what kind of value a variable can hold and what mathematical or logical operations can be safely performed on it.
<br></br>

## Primitive Data Types

| Data Type  | Description                                  |            Size | Range / Precision                             | Example                      | Common Uses                                          |
| ---------- | -------------------------------------------- | --------------: | --------------------------------------------- | ---------------------------- | ---------------------------------------------------- |
| **char**   | Stores a single character                    |          1 Byte | Signed: `-128 to 127`<br>Unsigned: `0 to 255` | `char grade = 'A';`          | Characters, ASCII values, byte-sized values          |
| **int**    | Stores whole numbers                         | Usually 4 Bytes | `-2,147,483,648 to 2,147,483,647`             | `int age = 25;`              | Counters, process IDs, integer calculations          |
| **float**  | Stores decimal numbers                       |         4 Bytes | ~7 decimal digits                             | `float pi = 3.14;`           | Measurements, sensor values, scientific calculations |
| **double** | Stores decimal numbers with higher precision |         8 Bytes | ~15 decimal digits                            | `double pi = 3.14159265359;` | Scientific applications, high-precision calculations |
<br></br>

## Integer Variants
| Data Type         | Description                               |                                   Size | Range                                                  | Example                            |
| ----------------- | ----------------------------------------- | -------------------------------------: | ------------------------------------------------------ | ---------------------------------- |
| **short**         | Smaller integer type                      |                                2 Bytes | `-32,768 to 32,767`                                    | `short x = 100;`                   |
| **long**          | Larger integer type                       | Windows: 4 Bytes<br>Linux x64: 8 Bytes | Depends on platform                                    | `long population = 10000000;`      |
| **long long**     | Very large integer type                   |                                8 Bytes | Approximately `-9.22 quintillion to +9.22 quintillion` | `long long money = 1000000000000;` |
| **unsigned int**  | Integer that cannot store negative values |                                4 Bytes | `0 to 4,294,967,295`                                   | `unsigned int count = 4000000000;` |
| **unsigned char** | 1-byte unsigned integer                   |                                 1 Byte | `0 to 255`                                             | `unsigned char byte = 0x41;`       |
<br></br>

## Signed vs Unsigned
| Type         | Meaning                                 | Can Store Negative Values? | Example                |
| ------------ | --------------------------------------- | -------------------------- | ---------------------- |
| **Signed**   | Can store positive and negative values  | Yes                        | `int x = -10;`         |
| **Unsigned** | Can store zero and positive values only | No                         | `unsigned int x = 10;` |

<br></br>

# Windows Data Types
typedef lets you create a new name (alias) for an existing data type. The biggest difference between a signed and unsigned binary number is that the far left bit is used to denote whether or not the number has a negative sign. The rest of the bits are then used to denote the value normally. This first bit, the sign bit, is used to denote whether it's positive (with a 0) or negative (with a 1)

```
typedef int <new_alias_name>;
```


| Data Type   | Definition / Equivalent                                        |              Size | Example                             | Common Uses                                          |
| ----------- | -------------------------------------------------------------- | ----------------: | ----------------------------------- | ---------------------------------------------------- |
| **BYTE**    | `typedef unsigned char BYTE;`<br>Equivalent to `unsigned char` |        **1 Byte** | `BYTE b = 0x41;`                    | Binary data, encryption keys, file parsing           |
| **WORD**    | `typedef unsigned short WORD;`                                 |       **2 Bytes** | `WORD port = 80;`                   | Network ports, PE file structures, flags             |
| **DWORD**   | `typedef unsigned long DWORD;`                                 |      **4 Bytes*** | `DWORD pid = 1234;`                 | Process IDs, thread IDs, registry values, PE headers |
| **DWORD64** | `typedef unsigned long long DWORD64;`                          |       **8 Bytes** | `DWORD64 address = 0x7FF6ABCD1234;` | 64-bit addresses, kernel structures, debugging       |
| **BOOL**    | `typedef int BOOL;`                                            |      **4 Bytes*** | `BOOL success = TRUE;`              | API return values, conditional checks                |
| **HANDLE**  | `typedef void* HANDLE;` A HANDLE is a reference to a Windows object.                                       | **Pointer-sized** | `HANDLE hProcess;`                  | Processes, threads, files, tokens, mutexes, events   |
| **LPVOID**  | `typedef void* LPVOID;`                                        | **Pointer-sized** | `LPVOID buffer;`                    | Generic pointers, memory allocation, API buffers     |

## Format Specifier
| Data Type            | `printf()` Format Specifier |
| -------------------- | --------------------------- |
| `char`               | `%c`                        |
| `signed char`        | `%hhd`                      |
| `unsigned char`      | `%hhu`                      |
| `short`              | `%hd`                       |
| `unsigned short`     | `%hu`                       |
| `int`                | `%d`                        |
| `unsigned int`       | `%u`                        |
| `long`               | `%ld`                       |
| `unsigned long`      | `%lu`                       |
| `long long`          | `%lld`                      |
| `unsigned long long` | `%llu`                      |
| `float`              | `%f`                        |
| `double`             | `%f`                        |
| `long double`        | `%Lf`                       |
| `BYTE`               | `%hhu`                      |
| `WORD`               | `%hu`                       |
| `DWORD`              | `%lu`                       |
| `DWORD64`            | `%llu`                      |
| `BOOL`               | `%d`                        |
| `HANDLE`             | `%p`                        |
| `LPVOID`             | `%p`                        |

