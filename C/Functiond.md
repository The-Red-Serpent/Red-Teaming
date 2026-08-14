## Functions
A function in C is a self-contained, reusable block of code that performs a specific task. Functions allow you to break down large programs into smaller, manageable modules, reducing code duplication and improving overall readability. Every C program must contain at least one function, which is the main() function.
- Functions receive either a fixed or variable amount of arguments.
- Functions can only return one value, or return no value.

- Syntax 
```
return_type function_name(parameters) {
    // code
}
```
In C, functions must be first defined before they are used in the code. They can be either declared first and then implemented later on using a header file or in the beginning of the C file, or they can be implemented in the order they are used (less preferable).

```
/* function declaration */
int foo(int bar);

int main() {
    /* calling foo from main */
    printf("The value of foo is %d", foo(1));
}

int foo(int bar) {
    return bar + 1;
}
```
