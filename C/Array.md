## Array
An array is a collection of elements of the same data type stored in contiguous memory locations, where each element is identified and accessed using an index.

## Array Initilazation
- creating an integer array of size 5
```
int arrayname[5];
```
- initializing an array with values
```
int array[5] = {10,20,30,40,50}
```

- This will create something like this
```
numbers
┌─────┬─────┬─────┬─────┬─────┐
│  10 │  20 │  30 │  40 │  50 │
└─────┴─────┴─────┴─────┴─────┘
   0     1     2     3     4
   ↑
 index
```

- You can also let C determine the size:
```
int numbers[] = {10, 20, 30, 40, 50};
```

## Accessing Array Elements
Array elements are accessed using their index. The index starts from 0, so the first element is at index 0, the second element is at index 1, and so on.

```
int numbers[10];

/* populate the array */
numbers[0] = 10;
numbers[1] = 20;
numbers[2] = 30;
numbers[3] = 40;
numbers[4] = 50;
numbers[5] = 60;
numbers[6] = 70;

/* print the 7th number from the array, which has an index of 6 */
printf("The 7th number in the array is %d", numbers[6]);
```


## Finding the Size of an Array
Sizeof is an operator used to find the amount of memory occupied by a variable, data type, or array. The result of sizeof is measured in bytes.

```
int numbers[5];

printf("%zu\n", sizeof(numbers));

```
- output
```
20
```

## Multidimensional Array's
A multidimensional array is an array that contains other arrays as its elements. The most common type is a 2D array, which is organized into rows and columns, like a table or matrix.

- Declaring a 2D Array
```
data_type array_name[rows][columns];
```
```
int matrix[2][3];
```

- You can Visualize it as
```
             Columns
             0    1    2
          ┌────┬────┬────┐
Row 0     │ 10 │ 20 │ 30 │
          ├────┼────┼────┤
Row 1     │ 40 │ 50 │ 60 │
          └────┴────┴────┘

```

