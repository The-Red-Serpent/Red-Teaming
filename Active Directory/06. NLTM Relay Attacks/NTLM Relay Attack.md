NTLM relay attack into three phases: Pre-relay , Relay , and Post relay .

## Phase I: Pre-relay
The pre-relay phase focuses on techniques that induce/coerce a client to initiate  authentication for a service on a server

Many techniques are used in the pre-relay phase, including:
- AiTM techniques such as poisoning and spoofing attacks.
    - LLMNR Poisoning
    - NBT-NS Poisoning
    - mDNS Poisoning
    - DNS Poisoning
    - ARP Poisoning
    - DHCPv6 Spoofing
    - ADIDNS Poisoning
    - WPAD Spoofing
    - WSUS Spoofing
- Authentication Coercion attacks.
    - 

## Phase II: Relay
The Relay phase focuses on relaying the  NTLM authentication of the client to a relay target. We must find machines that meet some criteria: if we target 
SMB on the relay targets, we need SMB signing to be disabled. Enumerate SMB Version ang signing Status

| **Host**                     | **SMB1 Client** | **SMB1 Server** | **SMB2 & SMB3 Clients** | **SMB2 & SMB3 Servers** |
| ---------------------------- | --------------- | --------------- | ----------------------- | ----------------------- |
| **Default Signing Setting**  | Disabled        | Enabled         | Not Required            | Not Required            |
| **Domain Controllers (DCs)** | Disabled        | Enabled         | Required                | Required                |


```
netexec smb 192.168.1.0/24 --gen-relay-list targets.txt
```
## Phase III: Post-relay
The post-relay phase takes advantage of the authenticated session we obtained through relaying a victim's 1NTLM authentication. We can conduct specific post-relay attacks depending on the authenticated session's protocol.

HTTP NTLM authentication can be relayed over all protocols without requiring the relay targets to be vulnerable to exploits. However, compared to SMB, certain conditions are required for successful relay attacks. For instance, it is impossible to relay SMB NTLM authentication over LDAP unless the relay target is vulnerable to specific exploits. However, in the case of HTTP NTLM authentication, this restriction does not apply. This difference arises from the fact that HTTP does not support session signing, whereas SMB does support it.

Tools used:
- Responder / pretender - for poisoning the broadcast traffic requests.
- ntlmrelayx - for relaying NTLM authentication.

