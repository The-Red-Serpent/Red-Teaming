## Strings
A string in C is a sequence of characters stored in a character array and terminated by the null character '\0'. Since C does not provide a built-in string data type, strings are represented using char arrays.

- The null character '\0' indicates the end of the string and helps string functions determine where the string ends.
- Strings are stored as arrays of char, allowing each character to be accessed and modified using its index.

## Defining an strings
```
char myname[] = "The Red Serpent";
```
```
char myname[17] = "The Red Serpent";
```

The reason that we need to add one, although the string The Red Serpent is exactly 16 characters long, is for the string termination a special character (equal to 0) which indicates the end of the string. The end of the string is marked because the program does not know the length of the string only the compiler knows it according to the code.

