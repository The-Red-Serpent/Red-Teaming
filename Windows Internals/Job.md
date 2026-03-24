### Job
A Job is a kernel object that acts as a container for a group of processes, allowing the OS to manage and apply limits to all of them collectively as a single unit. Think of it as a process group instead of managing each process individually you manage the job and every process inside it inherits those rules.Jobs are shareable, securable and nameable. Any change to the job will affect all the processes in the job. Jobs are used to impose limits on a set of processes, for example if you want to limit the number of processes of an application that can be running at the same time.

```
JOB OBJECT
  ┌─────────────────────────────────────────┐
  │  Limits and policies                    │
  │                                         │
  │  ┌──────────┐ ┌──────────┐ ┌─────────┐  │
  │  │ Process 1│ │ Process 2│ │Process 3│  │
  │  └──────────┘ └──────────┘ └─────────┘  │
  └─────────────────────────────────────────┘
```
### What a Job Can Control
Jobs can enforce limits across all their processes:

```
Resource Limits:
  ├── Maximum CPU time per process
  ├── Maximum CPU time for entire job
  ├── Maximum memory usage per process
  ├── Maximum memory for entire job
  └── Maximum number of active processes

  Security Limits:
  ├── Restrict which desktop processes can access
  ├── Prevent processes from accessing clipboard
  ├── Block processes from creating child processes
  └── Restrict which system calls are allowed

  UI Limits:
  ├── Block access to user input (keyboard/mouse)
  ├── Prevent reading clipboard
  └── Restrict window management

  Network Limits:
  └── Block outbound network connections
```

### API functions for working with Jobs
The Windows API provides us all the important functions that are required to manage and work with job objects. Here are few of the important functions:

```
    CreateJobObject: Used to create a job object. It can also be used to open a job object.
    OpenJobObject: Used to open an already existing job object.
    AssignProcessToJobObject: Used to assign a process to a job object.
    SetInformationJobObject: Used to set limits for the processes inside a job object.
    QueryInformationJobObject: Used to retrieve information about the a job object.
    TerminateJobObject: Used to terminate all the processes inside a job object.
    IsProcessInJob: Used to check if a process is a member of a job object.
```
