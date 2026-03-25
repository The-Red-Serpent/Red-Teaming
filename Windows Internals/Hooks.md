### Hook
A Windows hook is a mechanism that allows an application to install a callback function into the system’s event processing chain, enabling it to intercept, monitor, and optionally modify or block events (such as messages, keyboard input, or mouse actions) before they reach their intended destination.

### Messages
A Windows message is a structured piece of data sent by the operating system (or another application) to a window procedure, indicating that a specific event or action has occurred and needs to be handled. Windows uses messages for normal actions to provide a standard, asynchronous, and controlled way of delivering events from the operating system to applications.

A Windows message goes through a simple lifecycle that starts when an event occurs, such as a key press or mouse movement. The operating system converts this event into a message (like WM_KEYDOWN) and places it into the message queue of the target application’s thread. The application continuously runs a message loop that retrieves messages from this queue using functions like GetMessage, optionally processes them (for example, TranslateMessage for keyboard input), and then sends them to the window procedure using DispatchMessage. The window procedure (WndProc) examines the message and executes the appropriate code to handle it, such as responding to input or updating the window. If the application does not explicitly handle the message, Windows provides default handling through DefWindowProc. Once processed, the message is discarded, completing its lifecycle.

### Hook Procedure
A hook procedure is a user-defined callback function that is installed by an application into the Windows hook chain and is automatically invoked by the operating system whenever a specified event occurs, allowing the application to examine, modify, or suppress that event before it is passed to the next handler or target window.

### Hook Chain
A hook chain is a sequence (linked list) of hook procedures associated with a particular type of hook, where each procedure receives the event in order and can pass it to the next procedure in the chain.

### Implementation

#### Install a hook
SetWindowsHookEx is used to install a hook and register your hook procedure with Windows.
```
HHOOK SetWindowsHookEx(
    int idHook,        // type of hook
    HOOKPROC lpfn,     // your hook procedure (callback)
    HINSTANCE hMod,    // handle to DLL (or NULL for local)
    DWORD dwThreadId   // thread ID (0 = global)
);
```

#### calling the next hook
```
LRESULT CallNextHookEx(
    HHOOK hhk,     // handle to current hook
    int nCode,     // hook code
    WPARAM wParam, // message parameter
    LPARAM lParam  // message parameter
);
```

#### Removing a hook
```
BOOL UnhookWindowsHookEx(
    HHOOK hhk   // handle to the hook to be removed
);

```

### API Hooking
API hooking is a technique used to intercept and redirect calls to application programming interface (API) functions by modifying function pointers or altering the execution flow, allowing a program to monitor, modify, or control the behavior of those function calls before or after they execute.

### Implementation Techniques

#### **IAT Hooking**
Modify the **Import Address Table (IAT)** in the PE (Portable Executable) file. This involves replacing the function pointers in the IAT with the address of the custom hook function. This redirects the calls of specific API functions to your own functions.

#### 2. **Detours-style Hooking (Inline Hooking)**
Modify the first few bytes of a target function to insert a **JMP instruction** that redirects execution to a custom hook function. The custom function can call the original function if needed (or modify its behavior) before or after executing.

#### 3. **SetWindowsHookEx**
Use the **SetWindowsHookEx** API to install a hook procedure that intercepts specific window messages (like keyboard or mouse events). You can modify, cancel, or forward the messages to other hooks depending on the type of hook (e.g., `WH_KEYBOARD`, `WH_MOUSE`).







### Reference
- https://r3zz.io/posts/windows-hooks/

