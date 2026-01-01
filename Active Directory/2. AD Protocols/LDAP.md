<p align="justify">LDAP stands for light weight directory access protocol is a protocol used to access and manage **directory services** over a network. It provides a systematic and standardized method for querying and modifying directory information. LDAP is primarily used to access directories where information about resources, such as users, groups, devices, and network services, is stored. in a network. In an LDAP directory, devices such as computers, printers, or other networked devices may be listed as objects within the directory, and you can query LDAP to locate those devices by their attributes (like hostname, IP address, or MAC address</p>

- **Port 389**: Default port for **non-secure** LDAP.
- **Port 636**: Default port for **secure** LDAP (LDAPS).

- **Directory**:

	- A directory is a specialized database optimized for read-heavy operations. It stores structured information in a tree-like hierarchy (similar to a file system structure). This structure allows for quick lookups, and it often holds information like user credentials, network devices, groups, permissions, etc.
- **LDAP Server**:
    
    - The **LDAP server** hosts the directory data. It can respond to queries and update requests from clients. A common example is **Active Directory** (AD), which is an LDAP-compliant service by Microsoft.


![[Pasted image 20250210152341.png]]




### **LDAP Operations**:

LDAP supports several operations that allow interaction with the directory service:

- **Bind**: Authenticate to the directory server (similar to a login).
- **Search**: Retrieve specific directory entries based on filters (such as querying user information).
- **Compare**: Check if an attribute value exists in an entry.
- **Add**: Add new entries to the directory.
- **Modify**: Modify existing entries in the directory.
- **Delete**: Remove entries from the directory.
- **Unbind**: Disconnect from the directory server.

- The directory holds information about users, groups, computers, and other network resources. It allows administrators to manage access control and permissions centrally. When an application or user wants to access a resource or authenticate, it queries the AD directory via LDAP to verify credentials or retrieve relevant information.

- LDAP authentication messages are sent in cleartext by default so anyone can sniff out LDAP messages on the internal network. It is recommended to use TLS encryption or similar to safeguard this information in transit.


https://hackviser.com/tactics/pentesting/services/ldap