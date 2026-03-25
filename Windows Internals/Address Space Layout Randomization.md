### Address Space Layout Randomization
ASLR is a security technique in Windows that randomly arranges the base addresses of a process’s executable, DLLs, heap, and stack each time it runs, preventing attackers from predicting memory locations and making exploits that rely on fixed addresses much harder.

When you run a program in Windows:

You double-click an .exe or call CreateProcess().
The Windows loader in ntdll.dll starts the process.
The loader:
Reads the program headers
Maps the executable into virtual memory
Loads all dependent DLLs
Sets up stack, heap, and other structures
Then the process starts executing at its entry point.

This is the exact moment the base addresses are assigned.
If ASLR is enabled, the loader picks randomized addresses for the executable and DLLs.

![image](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*bqVT5kbo_IVbEMbs1pCl7g.png)


#### Base Address
The starting memory address where a module (EXE or DLL) is loaded.
