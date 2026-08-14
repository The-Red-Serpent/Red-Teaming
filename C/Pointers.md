## Pointers
A pointer is simply a variable that stores the memory address of another variable. The computer's memory is a sequential store of data, and a pointer points to a specific part of the memory. Our program can use pointers in such a way that the pointers point to a large amount of memory - depending on how much we decide to read from that point on.
![image](https://codeforwin.org/wp-content/uploads/2017/10/pointer-to-pointer.png)
```
int x = 42;
int *p = &x;
```
- x contains the value 42.
- x lives at memory address 1000 (illustrative).
- p contains 1000, so p points to x.

## Visual Diagram
```
                    MEMORY
              ┌─────────────────┐
Address 1000  │       42        │
              └─────────────────┘
                       ▲
                       │
                       │ points to
                       │
              ┌─────────────────┐
Address 2000  │      1000       │
              └─────────────────┘
                    p
```

## Dereferecing
Dereferencing is the operation of accessing or modifying the value stored at the memory address held by a pointer. Dereferencing a pointer is done using the asterisk operator *.

Example:

```c
int x = 10;
int *p = &x;

printf("%d", *p);  // 10
```

Here, `p` stores the address of `x`, and `*p` **dereferences `p`**, meaning it accesses the value stored at that address.

```text
p
│
│ stores address of x
▼
┌───────────┐
│  address  │
└─────┬─────┘
      │
      │ dereference (*p)
      ▼
┌───────────┐
│    10     │  ← value of x
└───────────┘
```

## Pointer arithmetic

Pointer arithmetic is the process of performing arithmetic operations on a pointer to move it between elements of a data structure, typically an array.

```c
int arr[] = {10, 20, 30};
int *p = arr;

p++;
```

Here, `p++` moves the pointer from `arr[0]` to `arr[1]`.

```text
Before p++:

 p
 ↓
┌────┬────┬────┐
│ 10 │ 20 │ 30 │
└────┴────┴────┘
  0    1    2


After p++:

      p
      ↓
┌────┬────┬────┐
│ 10 │ 20 │ 30 │
└────┴────┴────┘
  0    1    2
```

Common pointer arithmetic operations are:

```c
p + 1
p - 1
p++
p--
```

You can also use:

```c
*(p + 2)
```


