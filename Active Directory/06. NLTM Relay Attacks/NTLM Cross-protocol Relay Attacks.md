<p align="justify"> A cross-protocol relay is an NTLM relay attack where an attacker captures NTLM authentication from one protocol and reuses (relays) it to authenticate over a different protocol. The NTLM messages are extracted from the HTTP session and inserted into an LDAP session. This works because NTLM is an authentication protocol that is carried inside many application protocols. </p>


<p align="justify">NTLM authentication relaying is not limited to just the SMB protocol. We can relay NTLM authentication from various protocols, including  SMB and HTTP over LDAP , MSSQL , IMAP , 
SMB, HTTP, RPC, or any other application protocol capable of transmitting NTLM authentication messages. Each protocol we relay NTLM authentication over allows us to execute distinct attacks. Hence, it is vital to comprehend these protocols and the
corresponding attack possibilities. Protocols it can relay to (client mode) </p>


## ntlmrelayx can authenticate to these services:

- HTTP / HTTPS
- LDAP / LDAPS
- SMB (v1/v2/v3)
- MSSQL
- IMAP
- SMTP
- RPC

These are the targets.

## Protocols it can receive NTLM from (server mode)
It can pretend to be:

- HTTP / HTTPS server
- SMB server
- WCF server
- RAW NTLM server

These are the sources of captured NTLM authentication.

## Cross Protocol Relay Table


|  From    | To                                            |   Cross-Protocol?   |
| -------- | --------------------------------------------- | ------------------- |
| HTTP     | HTTP                                          | No                  |
| HTTP     | LDAP / SMB / MSSQL / IMAP / SMTP / RPC        | Yes                 |
| SMB      | SMB                                           | No                  |
| SMB      | HTTP / LDAP / MSSQL / IMAP / SMTP / RPC       | Yes                 |
| WCF      | HTTP / LDAP / SMB / MSSQL / IMAP / SMTP / RPC | Yes                 |

Reference :
- https://www.thehacker.recipes/ad/movement/ntlm/relay#theory

- No means the authentication stays within the same protocol.

- Yes means the attacker converts the NTLM authentication into another protocol.
