
A static local variable is a local variable that keeps its value between function calls. The variable is initialized only once and retains its value between function calls, while its scope remains limited to the block where it is declared. By default, variables are local to the scope in which they are defined. Static variables have a property of preserving their value even after they are out of their scope! Hence, static variables preserve their previous value in their previous scope and are not initialized again in the new scope.

### Example

```c
#include <stdio.h>

void counter()
{
    static int count = 0;

    count++;

    printf("Count = %d\n", count);
}

int main()
{
    counter();
    counter();
    counter();

    return 0;
}
```

### Output

```text
Count = 1
Count = 2
Count = 3
```

### Why?

Normally:

```c
int count = 0;
```

is created when the function starts, so every call starts from `0`.

But:

```c
static int count = 0;
```

is initialized **only once**. Its value is preserved after the function finishes.

```text
Call 1:  count = 0 → 1
                 ↓
             remembers 1

Call 2:  count = 1 → 2
                 ↓
             remembers 2

Call 3:  count = 2 → 3
```

The important thing is that `count` is **still local**:

```c
void counter()
{
    static int count = 0;
}
```

You cannot do this from `main()`:

```c
printf("%d", count);  // ❌ count is not accessible here
```

## Static function
By default, functions are global in C. If we declare a function with static, the scope of that function is reduced to the file containing it. Static functions are restricted to the files where they are declared.

```
static void fun(void) {
   printf("I am a static function.");
}
```
