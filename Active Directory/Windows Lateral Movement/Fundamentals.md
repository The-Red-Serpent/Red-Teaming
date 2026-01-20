Lateral movement involves transitioning from one system to another within the same network by leveraging valid credentials or authentication material. These credentials can include passwords, password hashes, Kerberos tickets, SSH keys, or session cookies. By using these, an attacker can remotely connect to other systems and continue their attack. Successful lateral movement requires knowledge of network architecture, available services, and protocols that allow remote execution or access.

### Windows Lateral Movement Techniques (MITRE ATT&CK)

| **Technique ID** | **Technique Name**                        | **Description**                                                                        |
| ---------------- | ----------------------------------------- | -------------------------------------------------------------------------------------- |
| T1021            | Remote Services                           | Using legitimate remote services such as RDP, SMB, and SSH to move within a network.   |
| T1021.001        | Remote Desktop Protocol (RDP)             | Using RDP to interact with and control a remote system’s desktop.                      |
| T1021.002        | SMB / Windows Admin Shares                | Exploiting SMB and administrative shares to access files or execute commands remotely. |
| T1021.003        | Distributed Component Object Model (DCOM) | Using DCOM to interact with software components on remote Windows systems.             |
| T1021.004        | SSH                                       | Using Secure Shell (SSH) to remotely access and control systems.                       |
| T1021.005        | VNC                                       | Using Virtual Network Computing (VNC) for remote system control.                       |
| T1077            | Windows Admin Shares                      | Abusing default administrative shares (e.g., C$, ADMIN$) for lateral movement.         |
| T1080            | Taint Shared Content                      | Modifying shared files or content to execute malicious code on other systems.          |
| T1105            | Ingress Tool Transfer                     | Transferring tools or malicious files to remote systems for execution.                 |
| T1210            | Exploitation of Remote Services           | Exploiting vulnerabilities in remote services to gain unauthorized access.             |
| T1550            | Use Alternate Authentication Material     | Using stolen credentials such as tokens, hashes, keys, or certificates.                |
| T1563            | Remote Service Session Hijacking          | Hijacking legitimate remote service sessions to gain access.                           |
| T1563.001        | SSH Hijacking                             | Hijacking active SSH sessions to access remote systems.                                |
| T1569            | System Services                           | Using system services to execute commands or move laterally.                           |
| T1569.001        | Launchctl                                 | Using the launchctl utility to manage launch services (macOS-related).                 |
| T1569.002        | Service Execution                         | Executing commands or scripts via system services on remote machines.                  |
| T1570            | Lateral Tool Transfer                     | Moving tools from one compromised system to another within the network.                |
