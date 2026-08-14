## Dynamic Memory Allocation

Dynamic Memory Allocation is the process of allocating memory during program execution (runtime) instead of deciding the memory size before the program runs. In C, dynamic memory is allocated from the heap.
They are declared in:

```c
#include <stdlib.h>
```

## malloc()
`malloc()` is used to **allocate a block of memory of a specified size at runtime**. The allocated memory is **not initialized**, so its contents are indeterminate. The malloc function returns a void* (void pointer) pointing to the beginning of the newly allocated memory block if the request succeeds, or NULL if the allocation fails

```c
ptr = malloc(n * sizeof(*ptr));
```

## Example

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int *p;

    p = malloc(sizeof(*p));

    if (p == NULL) {
        printf("Memory allocation failed");
        return 1;
    }

    *p = 50;

    printf("Value = %d\n", *p);

    free(p);

    return 0;
}
```

Here:

```c
p = malloc(sizeof(*p));
```

allocates enough memory for **one integer**.

## calloc()
`calloc()` is used to **allocate memory for multiple elements at runtime** and initializes the allocated bytes to zero.


```c
ptr = calloc(number_of_elements, size_of_each_element);
```

### Example

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int *arr;

    arr = calloc(5, sizeof(*arr));

    if (arr == NULL) {
        printf("Memory allocation failed");
        return 1;
    }

    for (int i = 0; i < 5; i++) {
        printf("%d ", arr[i]);
    }

    free(arr);

    return 0;
}
```

Output:

```text
0 0 0 0 0
```

So:

```c
calloc(5, sizeof(*arr));
```

means:  Allocate memory for **5 integers** and initialize the allocated bytes to zero.

## realloc()

`realloc()` is used to **change the size of a previously allocated memory block**.


```c
ptr = realloc(ptr, new_size);
```

### Example

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int *arr;

    arr = malloc(5 * sizeof(*arr));

    if (arr == NULL) {
        printf("Memory allocation failed");
        return 1;
    }

    for (int i = 0; i < 5; i++) {
        arr[i] = i + 1;
    }

    int *temp = realloc(arr, 10 * sizeof(*arr));

    if (temp == NULL) {
        printf("Reallocation failed");
        free(arr);
        return 1;
    }

    arr = temp;

    for (int i = 5; i < 10; i++) {
        arr[i] = i + 1;
    }

    for (int i = 0; i < 10; i++) {
        printf("%d ", arr[i]);
    }

    free(arr);

    return 0;
}
```

Output:

```text
1 2 3 4 5 6 7 8 9 10
```



## free()
`free()` is used to **release dynamically allocated memory** when it is no longer needed.

```c
free(ptr);
```

## Example

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int *p;

    p = malloc(sizeof(*p));

    if (p == NULL) {
        return 1;
    }

    *p = 100;

    printf("Value = %d\n", *p);

    free(p);
    p = NULL;

    return 0;
}
```

After:

```c
free(p);
```


## Quick Comparison

| Function    | Purpose                                | Initialization                                        |
| ----------- | -------------------------------------- | ----------------------------------------------------- |
| `malloc()`  | Allocates memory                       | Not initialized                                       |
| `calloc()`  | Allocates memory for multiple elements | Allocated bytes initialized to zero                   |
| `realloc()` | Changes size of existing allocation    | Existing contents preserved up to the applicable size |
| `free()`    | Releases allocated memory              | —                                                     |

