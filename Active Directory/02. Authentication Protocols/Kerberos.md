## Kerberos
Kerberos is a network authentication protocol that uses secret-key cryptography and a trusted third party, known as the Key Distribution Center (KDC), to securely authenticate users and services over an insecure network. It enables mutual authentication, allowing both the client and the server to verify each other's identity, and issues time-limited tickets that let users access network resources without repeatedly transmitting their passwords.

### Key Distribution Center:
<p align="justify">Key Distribution Center (KDC) acts as a trusted third-party authority that is responsible for authenticating users and issuing tickets to allow access to services. The KDC contains a database of users (principals) with their username and password-derived keys (hashed passwords). When a user first sets up their password, the password is hashed (using a hashing algorithm) and stored securely in the KDC database.</p>

### The KDC consists of two main parts:
- Authentication Server
- Ticket Granting Service

## Authentication Server (AS)

The Authentication Server is responsible for verifying the identity of users during the initial login process. Below is a detailed breakdown of its operation:

#### 1. **User Authentication Process**:

- When a user attempts to authenticate to the system, the client sends an **Authentication Server Request (AS-REQ)** to the **Authentication Server (AS)**.
- The **AS-REQ** typically contains:
    - Its name (the client principal name)
	- The realm name
	- The desired service, which is in case of `AS-REQ` always `KRBTGT`
	- A randomly generated value (called a _Nonce_)
	- if pre-authentication is configured, an encrypted timestamp "PA-ENC-TIMESTAMP" which is  encrypted with the user's long-term key, which is derived from the password.

#### 2. **Verification of User**:

- Upon receiving the **AS-REQ**, the **AS** performs the following actions:
    - It looks up the password associated with the specific user in the **ntds.dit** file.
    - The **AS** attempts to **decrypt the timestamp** using this hash.
    - If the decryption is successful and the timestamp is valid (not a duplicate), the authentication is considered **successful**.

#### 3. **Issuance of Ticket Granting Ticket (TGT)**:

- If the user is successfully authenticated, the **AS** generates a **Ticket Granting Ticket (TGT)** for the user.
- The **TGT** contains:
     - The client's identity (principal name). 
    - A **TGT session key** which is encrypted with users key.
    - Timestamps, validity period (default ~10 hours).

#### 4. **Encryption of the TGT**:

- The **TGT** is encrypted using a secret key associated with the **krbtgt** account, which is an account known only to the KDC (Key Distribution Center).
- Since the **krbtgt** key is only known to the KDC, it cannot be decrypted by the client.
- The **TGT** provides the client with the ability to request **service tickets** without needing to re-enter credentials, ensuring both convenience and security.

#### 5. **TGT Validity and Renewal**:

- By default, the **TGT** is valid for **ten hours**.
- After this period, the **TGT** will require a **renewal** to extend its validity.


## Ticket Granting Service (TGS):

The **Ticket Granting Service** is responsible for issuing **service tickets**. Once a client has a valid **TGT** (obtained from the AS), they can use it to request access to specific services in the network.

- The client constructs a **Ticket Granting Service Request (TGS-REQ)** packet that consists of the following:
    - The current user
    - A timestamp encrypted with the session key
    - The name of the resource SPN associated with it.
    - The encrypted **TGT**

The **ticket-granting service** on the KDC receives the **TGS-REQ**, and if the resource exists in the domain, the **TGT** is decrypted using the secret key known only to the KDC. The session key is then extracted from the **TGT** and used to decrypt the username and timestamp of the request. 

The KDC performs several checks:
- The **TGT** must have a valid timestamp.
- The username from the **TGS-REQ** has to match the username from the **TGT**.
- The client IP address needs to coincide with the **TGT** IP address.

If this verification process succeeds, the **Ticket Granting Service** responds to the client with a **Ticket Granting Server Reply (TGS-REP)**. This packet contains three parts:
- The name of the service for which access has been granted.
- A session key to be used between the client and the service.
- A **service ticket** containing the username and group memberships along with the newly created session key.

The service ticket’s **service name** and **session key** are encrypted using the original session key associated with the creation of the **TGT**. The service ticket is encrypted using the password hash of the **service account** registered with the service in question. when they send this  Service  ticket to the service, the latter can decrypt the ticket's content and read the user's information.


## PAC
Privilege Attribute Certificate (PAC) is a Microsoft-specific authorization data structure embedded within a Kerberos ticket in Active Directory. It contains the authenticated user's authorization information such as their Security Identifier (SID), group memberships, user account attributes, and other security-related data that Windows uses to determine what resources the user is allowed to access after successful authentication.

The service uses it for authorization without querying the DC. The PAC carries two signatures the Server Signature (keyed with the service's key) and the KDC Signature (keyed with krbtgt). The infamous CVE-2021-42287 / CVE-2021-42278 (sAMAccountName spoofing, "noPac") and CVE-2022-37967 PAC signature flaws both abused weaknesses in how these structures were validated.

Each ticket and key is tagged with an etype number: An encryption type (etype) is a numeric identifier that specifies the encryption algorithm used for Kerberos keys and encrypted data.
<br></br>
| etype | Algorithm               |
| ----- | ----------------------- |
| 23    | RC4-HMAC                |
| 17    | AES128-CTS-HMAC-SHA1-96 |
| 18    | AES256-CTS-HMAC-SHA1-96 |

## Kerberos Authentication

<p align="center">
  <img src="https://i0.wp.com/yunolay.com/wp-content/uploads/2026/06/kerberos-protocol-internals-diagram-1.png?w=1256&ssl=1" alt="Architecture Diagram" width="600">
</p>




Reference:
- https://attl4s.github.io/





