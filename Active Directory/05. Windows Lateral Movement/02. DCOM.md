
### COM
**COM (Component Object Model)** is a Windows system that allows programs written in **different programming languages** and by **different developers** to communicate with each other. It does this by exposing **standardized interfaces** that define **what methods are available and how they can be used**, without revealing how the component is implemented internally.

Each COM component provides an **interface**, which is like a contract. Programs can call the methods exposed by that interface to get work done, without needing to know how the code works behind the scenes.

Instead of every program building everything from scratch, Windows provides **ready-made components**. These components clearly say:

- _“Here’s what I can do”_
- _“Here’s how you can use me”_

Programs don’t need to know **how the component works internally**. They just call the features they need and Windows handles the rest.

Every COM object has a **unique identifier** called a **CLSID** (Class ID). A CLSID is simply a **GUID** that Windows uses to uniquely identify a COM component.
#### CLSID
A **unique GUID** that identifies a COM class and points to its implementation in the Windows Registry, either through **InProcServer32** (DLL‑based) or **LocalServer32** (EXE‑based).
#### ProgID (Programmatic Identifier)
A **human‑readable name** for a COM class that maps to a CLSID; it is optional, not always present, and not guaranteed to be unique.
#### AppID (Application Identifier)
An identifier that groups one or more COM objects within the same executable and defines their **security, identity, and activation permissions**, including local and remote access.
#### DCOM Rights
Permissions that control who can **launch, activate, and access** DCOM objects locally or remotely, typically granted through group membership (e.g., Administrators or Distributed COM Users) and managed via **DCOMCNFG, Group Policy, or the Registry**.


Windows keeps track of COM objects in the **Windows Registry**, specifically under:
```
HKEY_CLASSES_ROOT\CLSID
```
Each CLSID entry represents one COM component. Inside that entry, you will usually find one of the following subkeys:

- **InProcServer32** → points to a **DLL** that runs inside the calling process
- **LocalServer32** → points to an **EXE** that runs as a separate process

These subkeys contain the **file path on disk** to the DLL or EXE that actually implements the COM object’s functionality. When a program requests a COM object by its CLSID, **Windows looks it up in the registry**, finds the associated DLL or EXE, loads it, and allows the program to use the methods exposed by that COM component.

- Enumerating CLSIDS
```
Get-ChildItem Registry::HKEY_CLASSES_ROOT\CLSID | Select-Object -ExpandProperty PSChildName

Get-CimInstance Win32_DCOMApplication
```

Listing all COM Objects that can be used by Users
```
gwmi Win32_COMSetting | ? {$_.progid } | sort | ft ProgId,Caption,InprocServer32
```

- Listing all the methods in a COM
```
$fso = New-Object -ComObject <com.object>
$fso | Get-Member
```


### DCOM
**Distributed Component Object Model (DCOM)** is a Microsoft technology that allows software components to communicate with each other **over a network**, even if they are running on **different computers**. It is essentially the **distributed version of COM (Component Object Model)**. In Order to do lateral movement using DCOM the machine . DCOM uses port 135 RPC and other dynamic ports.

We can use Built in COM Objects which are found out during research to do lateral movement instead of enumerating the COM objects that are exposed on Target machine Those are :
- ShellWindows 
- ShellBrowserWindow 
- MMC20

Impacket Script can be used  in Linux to do lateral Movement using a predefined list of DCOM objects for windows we need to use specific commands to get it working
```
python3 dcomexec.py -object MMC20 test.local/john:password123@10.10.10.1
```

