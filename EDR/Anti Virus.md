## Antivirus
Antivirus is a kind of software used to prevent, scan, detect and delete viruses from a computer. Once installed, most antivirus software runs automatically in the background to provide real-time protection against virus attacks.

## Components of an Antivirus
A modern AV is fueled by signature updates fetched from the vendor's signature database that resides on the internet. Those signature definitions are stored in the local AV signature database, which in turn feeds the more specific engines.

### File Engine
The  File Engine is the antivirus module that inspects and analyzes files for malicious content using signatures, heuristics, and behavioral techniques. The file engine is responsible for bothh scheduled and real time file scans. when the engine performs a scheduled scan, it simply parses the entire file system and sends each file metadata/data to signature engine.

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

### Signature-based Detection
Signature-based detection identifies malware by comparing files, programs, or data against a database of known malware signatures, which are unique patterns such as byte sequences or hashes of previously identified viruses. If a match is found, the antivirus flags the file as malicious and takes action like blocking, quarantining, or removing it.

### Integrity Based Detection
Integrity Based Detection establishes a  baseline of critical system files. The AV continuousy monitors for unauthorized change to those files. Any modification triggers an alert.

### Heuristic-based detection
Heuristic-based detection identifies new or unknown malware  by analyzing a program’s code structure, patterns, and suspicious characteristics  instead of relying on known virus signatures. It looks for behaviors or coding traits commonly found in malware (like self-modifying code, suspicious API calls, or packing/encryption techniques) and flags files as suspicious even if they are not in the virus database.

### Behavior-based detection

Behavior-based detection identifies malware by monitoring and analyzing the real-time actions and activities of programs, users, or systems to detect suspicious or abnormal behavior patterns. Instead of relying on known signatures or static code analysis, it focuses on what a program does during execution such as modifying system files, encrypting large amounts of data, injecting code into other processes, or making unusual network connections and flags it as malicious if the behavior matches known attack patterns or deviates significantly from normal activity.

### Anomaly-based Detection 

Anomaly-based detection works by first learning and establishing a baseline of normal behavior for a system, network, or user, using historical data such as login patterns, file access, network traffic, and system activity. Once this baseline is       created, the system continuously monitors real-time activity and compares it against the normal profile. If it detects significant deviations—such as unusual login times, unexpected data transfers, abnormal resource usage, or unfamiliar system 
actions—it flags them as potential threats for further analysis or alerts.

### Sandbox-based Detection

Sandbox-based detection is a technique where suspicious files or programs are executed in a safe, isolated virtual environment (called a sandbox) to observe their behavior without risking damage to the real system. The system monitors actions like file modifications, registry changes, process creation, and network activity; if the program behaves maliciously (such as attempting encryption, self-replication, or unauthorized access), it is flagged as malware.

### Machine Learning–based Detection

Machine learning–based detection identifies malware by using algorithms trained on large datasets of both malicious and legitimate files. These models learn patterns from features such as file structure, API calls, behavior sequences, permissions, and network activity. Once trained, the model analyzes new or unknown files and classifies them as safe or malicious based on how closely their features match learned patterns. This approach helps detect new or modified malware that may not have known signatures.

### Cloud-based Detection

Cloud-based detection works by sending file information, metadata, or behavioral data from a local device to cloud servers, where powerful computing resources and up-to-date threat intelligence databases analyze it. The cloud system compares the data against global threat information, machine learning models, and millions of known samples to quickly identify threats. This allows faster detection, better accuracy, and real-time updates without relying heavily on the local device’s resources.


## Evasion Techniques
- Obfuscation
- Encoding
- packing
- Compression
- String obfuscation
- Character substitution
- LOTL
- In memory Execution techniques




