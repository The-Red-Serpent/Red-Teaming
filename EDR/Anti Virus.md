## Antivirus
Antivirus is a kind of software used to prevent, scan, detect and delete viruses from a computer. Once installed, most antivirus software runs automatically in the background to provide real-time protection against virus attacks.

## Components of an Antivirus
A modern AV is fueled by signature updates fetched from the vendor's signature database that resides on the internet. Those signature definitions are stored in the local AV signature database, which in turn feeds the more specific engines.

### File Engine
The  File Engine is the antivirus module that inspects and analyzes files for malicious content using signatures, heuristics, and behavioral techniques. The file engine is responsible for bothh scheduled and real time file scans. when the engine perfirms a scheduled scan, it simply parses the entire file system and sends each file metadata/data to signature engine.

### Memory Engine
The Memory engine scans/inspects each processe's memory space at runtime for well known binary signatures or suspicious API calls that might result in memory injection attacks.  It actively monitors your computer's RAM (Random Access Memory) to detect and block stealthy, "fileless" malware that tries to execute in-memory without leaving malicious files on your hard drive

### Network Engine
A network engine monitors, filters, and blocks malicious data packets and network traffic before they ever reach or compromise your device. It acts as a digital traffic guard, analyzing incoming and outgoing connections to stop remote attacks, ransomware, and botnet communications.

### Disassembler
The Disassember is responsible for translating machine code into assembly language, reconstructing the original prpgram code section , and identify any encoding/decoding routine.  The engine reads the disassembled instructions to identify suspicious command sequences, such as attempts to inject code into other processes or unusual memory manipulation, flagging them even if no prior signature exists.  By analyzing the disassembled code, the AV identifies exactly which system functions (APIs) a program is trying to import or call

### Sandbox
A sandbox  is a secure, isolated virtual environment used to safely execute and analyze suspicious files or programs so their behavior can be observed without risking damage to the actual operating system or data.

### Machine Learning Engine
Machine Learning Engine  uses trained machine learning models to detect both known and unknown malware by analyzing patterns and features from files, processes, and system behavior instead of relying only on traditional virus signatures. It works by first extracting features such as code structure, API calls, permissions, and behavioral patterns from a file or running process, and then feeding these features into a model that has been trained on large datasets of both malicious and legitimate software. During runtime, the model evaluates the input and classifies it as safe, suspicious, or malicious by producing a risk score or label. Based on this output, the antivirus decides whether to allow, block, quarantine, or further inspect the file using other engines like sandboxing.


## Detection Mechanisms

### 
