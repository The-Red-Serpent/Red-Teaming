## Stack
The stack is a special region of computer memory that the CPU uses to store temporary data in a structured, last-in-first-out (LIFO) order. It is fundamental for function calls, returning from functions, storing local variables, and keeping track of execution context.

The stack can store several kinds of temporary information, especially when functions are called:

- Return addresses — where the CPU should continue after a function finishes.
- Local variables — variables created inside a function.
- Saved registers — register values saved so they can be restored later.
- Function arguments — arguments that are passed on the stack when the calling convention requires it.
- Temporary data — values that need to be stored temporarily during calculations.
- Stack frames — the collection of data associated with a particular function call.
<br></br>
![image](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*3M10Yuk0xd6kXSm2k1W77A.png)

## Stack Frame
A stack frame is like a “workspace folder” for a function.Every time a function is called, the CPU creates a stack frame on the stack to keep everything that function needs to run—its local variables, return address, and a link to the previous function’s workspace.When the function finishes, the CPU throws away that folder and goes back to the previous one.

![image](https://miro.medium.com/v2/resize:fit:720/format:webp/1*Fiz_h9O9DTHmC4RtCPWPhA.png)

