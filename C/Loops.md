## For Loop
- Syntax
```
for (initialization; condition; update) {
    // code
}
```
- Example
```
for (int i = 0; i < 5; i++) {
    printf("%d\n", i);
}
```

## While loop
- Syntax
```
while (condition) {
    // code
}
```

- Example
```
int i = 0;

while (i < 5) {
    printf("%d\n", i);
    i++;
}
```


## Do While Loop

- Syntax
```
do {
    // code
} while (condition);
```

- Example
```
int i = 0;

do {
    printf("%d\n", i);
    i++;
} while (i < 5);
```

There are two important loop directives that are used in conjunction with all loop types in C - the break and continue directives.

- The break directive halts a loop after ten loops, even though the while loop never finishes
-  the continue directive causes the printf command to be skipped and continue the loop



