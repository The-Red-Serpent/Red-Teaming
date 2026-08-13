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


## Sample Program
```
#include <stdio.h>

// Windows-style type definitions
typedef unsigned char BYTE;
typedef unsigned short WORD;
typedef unsigned long DWORD;
typedef unsigned long long DWORD64;
typedef int BOOL;
typedef void* HANDLE;
typedef void* LPVOID;

#define TRUE 1
#define FALSE 0

int main(void)
{
    // =========================
    // Primitive Data Types
    // =========================

    char grade = 'A';
    signed char temperature = -20;
    unsigned char byte = 255;

    short smallNumber = -30000;
    unsigned short port = 443;

    int age = 25;
    unsigned int count = 4000000000U;

    long population = 10000000L;
    unsigned long bigNumber = 4000000000UL;

    long long money = 1000000000000LL;
    unsigned long long hugeNumber = 9000000000000ULL;

    float height = 5.9f;
    double pi = 3.14159265359;
    long double precision = 3.141592653589793L;


    // =========================
    // Windows Data Types
    // =========================

    BYTE b = 0x41;
    WORD w = 80;
    DWORD pid = 1234;
    DWORD64 address = 0x7FF6ABCD1234ULL;

    BOOL success = TRUE;

    HANDLE hProcess = NULL;
    LPVOID buffer = NULL;


    // =========================
    // Print Values
    // =========================

    printf("===== Primitive Data Types =====\n\n");

    printf("char:                %c\n", grade);
    printf("signed char:         %hhd\n", temperature);
    printf("unsigned char:       %hhu\n", byte);

    printf("short:               %hd\n", smallNumber);
    printf("unsigned short:      %hu\n", port);

    printf("int:                 %d\n", age);
    printf("unsigned int:        %u\n", count);

    printf("long:                %ld\n", population);
    printf("unsigned long:       %lu\n", bigNumber);

    printf("long long:           %lld\n", money);
    printf("unsigned long long:  %llu\n", hugeNumber);

    printf("float:               %f\n", height);
    printf("double:              %f\n", pi);
    printf("long double:         %Lf\n", precision);


    printf("\n===== Windows Data Types =====\n\n");

    printf("BYTE:                %hhu\n", b);
    printf("WORD:                %hu\n", w);
    printf("DWORD:               %lu\n", pid);
    printf("DWORD64:             %llu\n", address);

    printf("BOOL:                %d\n", success);

    printf("HANDLE:              %p\n", hProcess);
    printf("LPVOID:              %p\n", buffer);


    // =========================
    // Memory Sizes
    // =========================

    printf("\n===== Memory Sizes =====\n\n");

    printf("char:                %zu byte(s)\n", sizeof(char));
    printf("signed char:         %zu byte(s)\n", sizeof(signed char));
    printf("unsigned char:       %zu byte(s)\n", sizeof(unsigned char));

    printf("short:               %zu byte(s)\n", sizeof(short));
    printf("unsigned short:      %zu byte(s)\n", sizeof(unsigned short));

    printf("int:                 %zu byte(s)\n", sizeof(int));
    printf("unsigned int:        %zu byte(s)\n", sizeof(unsigned int));

    printf("long:                %zu byte(s)\n", sizeof(long));
    printf("unsigned long:       %zu byte(s)\n", sizeof(unsigned long));

    printf("long long:           %zu byte(s)\n", sizeof(long long));
    printf("unsigned long long:  %zu byte(s)\n", sizeof(unsigned long long));

    printf("float:               %zu byte(s)\n", sizeof(float));
    printf("double:              %zu byte(s)\n", sizeof(double));
    printf("long double:         %zu byte(s)\n", sizeof(long double));

    printf("BYTE:                %zu byte(s)\n", sizeof(BYTE));
    printf("WORD:                %zu byte(s)\n", sizeof(WORD));
    printf("DWORD:               %zu byte(s)\n", sizeof(DWORD));
    printf("DWORD64:             %zu byte(s)\n", sizeof(DWORD64));

    printf("BOOL:                %zu byte(s)\n", sizeof(BOOL));
    printf("HANDLE:              %zu byte(s)\n", sizeof(HANDLE));
    printf("LPVOID:              %zu byte(s)\n", sizeof(LPVOID));


    return 0;
}
```

