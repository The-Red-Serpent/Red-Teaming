## Pointers
A pointer is simply a variable that stores the memory address of another variable. The computer's memory is a sequential store of data, and a pointer points to a specific part of the memory. Our program can use pointers in such a way that the pointers point to a large amount of memory - depending on how much we decide to read from that point on.
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

