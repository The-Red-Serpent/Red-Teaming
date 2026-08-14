## Structure
A structure in C is a user-defined data type that allows us to group different types of related data under a single name.
- The struct keyword is used to define a structure. The items in the structure are called its members and they can be of any valid data type.
- Applications of structures involve creating data structures Linked List and Tree. Structures are also used to represent real world objects in a software like Students and Faculty in a college management software.

## Syntax
```
struct structureName {
  dataType member1;
  dataType member2;
  ...
};
```

## Example
```
struct Student {
    char name[50];
    int age;
    float marks;
};
```
Here:
- struct → keyword used to define a structure
- Student → name of the structure
- name, age, marks → structure members
- char, int, float → different data types of the members


## Declaring an structure
```
struct Student s1;
```

Sure. Here’s the **proper exam-style definition, syntax, and example**.

### Definition

A **structure in C** is a **user-defined data type** that allows us to group **different types of related data** under a single name.

For example, a student has a name, age, and marks. These can be grouped into one `Student` structure.

### Syntax

```c
struct structure_name {
    data_type member1;
    data_type member2;
    data_type member3;
};
```

### Example

```c
struct Student {
    char name[50];
    int age;
    float marks;
};
```

Here:

* `struct` → keyword used to define a structure
* `Student` → name of the structure
* `name`, `age`, `marks` → structure members
* `char`, `int`, `float` → different data types of the members

### Declaring a structure variable

```c
struct Student s1;
```

Now `s1` is a variable of type `struct Student`.

### Accessing members

We use the **dot (`.`) operator**:

```c
s1.age = 20;
s1.marks = 85.5;
```

## Complete example:

```c
#include <stdio.h>
#include <string.h>

// create struct with person1 variable
struct Person {
  char name[50];
  int citNo;
  float salary;
} person1;

int main() {

  // assign value to name of person1
  strcpy(person1.name, "George Orwell");

  // assign values to other person1 variables
  person1.citNo = 1984;
  person1. salary = 2500;

  // print struct variables
  printf("Name: %s\n", person1.name);
  printf("Citizenship No.: %d\n", person1.citNo);
  printf("Salary: %.2f", person1.salary);

  return 0;
}
```
