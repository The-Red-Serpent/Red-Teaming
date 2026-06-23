## Access Token
An Access Token is a security object created by the operating system after successful user authentication.LSASS (Local Security Authority Subsystem Service) creates the access token after successful authentication. Each user logged onto the system holds an access token with security information for that logon session. Every process executed on behalf of the user has a copy of the access token. The token identifies the user, the user’s groups, and the user’s privileges. A token also contains a logon SID (Security Identifier) that identifies the current logon session.

![Windows Architecture](https://media.licdn.com/dms/image/v2/D5622AQEoGoY6v2AIKg/feedshare-shrink_1280/B56Zku4dPzKwBk-/0/1757428176533?e=2147483647&v=beta&t=m_fzkQlHi6HBWrmUqGdRm4lhTu2-Ctt4UxS_AM4Rcj4)

## Structure of Access Token
```
                                  +------------------------------------------------+
                                  |                    TOKEN                       |
                                  +------------------------------------------------+
                                  | User SID                                       |
                                  | S-1-5-21-...-1001                              |
                                  +------------------------------------------------+
                                  | Group SIDs                                     |
                                  | Administrators                                 |
                                  | Users                                          |
                                  | Remote Desktop Users                           |
                                  +------------------------------------------------+
                                  | Privileges                                     |
                                  | SeDebugPrivilege                               |
                                  | SeBackupPrivilege                              |
                                  | SeShutdownPrivilege                            |
                                  +------------------------------------------------+
                                  | Integrity Level                                |
                                  | High                                           |
                                  +------------------------------------------------+
                                  | Logon SID                                      |
                                  | S-1-5-5-X-Y                                    |
                                  +------------------------------------------------+
                                  | Default DACL                                   |
                                  +------------------------------------------------+
                                  | Session ID                                     |
                                  +------------------------------------------------+

```
##  Types of Access Token

### Primary Token
A Primary Token is an access token associated with a process that represents the process's security context. It contains the user identity, group memberships, privileges, and other security attributes under which the process executes. New processes typically inherit the primary token of their parent process.

### Impersonation Token
An Impersonation Token is an access token associated with a thread that allows the thread to temporarily operate using the security context of another user. It is commonly used by server applications to perform access checks and resource access on behalf of a client.


