## Comparison Operators

* `>` : Greater than
* `<` : Less than
* `>=` : Greater than or equal to
* `<=` : Less than or equal to
* `==` : Equal to
* `!=` : Not equal to

## Logical Operators

* `&&` : AND — all conditions must be true
* `||` : OR — at least one condition must be true
* `!` : NOT — reverses the true/false result


## IF Statement
The if statement allows us to check if an expression is true or false, and execute different code according to the result.

```
#include <stdio.h>

int main()
{
    int x = 10;
    int y = 20;

    if (x < y)
    {
        printf("x is smaller\n");
    }
    else if (x == y)
    {
        printf("x is equal to y\n");
    }
    else
    {
        printf("x is greater\n");
    }

    if (x < y && y > 15)
    {
        printf("AND condition is true\n");
    }

    if (x < 5 || y > 15)
    {
        printf("OR condition is true\n");
    }

    if (x != 20)
    {
        printf("x is not 20\n");
    }

    return 0;
}

```

## Terenary Operator
The ternary operator is a conditional operator in C that provides a shorter way to write a simple if-else statement.
## Syntax
```
condition ? expression_if_true : expression_if_false;
```

## Sample Code
```
int a = 10, b = 20;
int max = (a > b) ? a : b; // max will be assigned 20
```

## Switch Statement
A switch statement in C evaluates an expression and executes the block of code associated with the matching case value. If no case matches, the optional default block is executed.

## Syntax
```
switch (expression)
{
    case value1:
        // code
        break;

    case value2:
        // code
        break;

    case value3:
        // code
        break;

    default:
        // code
        break;
}
```

### Sample Code
```
#include <stdio.h>

int main()
{
    int day = 2;

    switch (day)
    {
        case 1:
            printf("Monday");
            break;

        case 2:
            printf("Tuesday");
            break;

        case 3:
            printf("Wednesday");
            break;

        default:
            printf("Invalid day");
    }

    return 0;
}
```



