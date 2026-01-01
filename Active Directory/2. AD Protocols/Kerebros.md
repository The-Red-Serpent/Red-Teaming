Kerebros is a Network Authentication Protocol used to authenticate users and services on a untrusted network.

Operates on Port :88

#### Features:
1. Passwords are never sent over the network
2. Encryption Keys are never directly exchanged

#### Componenets:

##### Key Distribution Center:
<p align="justify">Key Distribution Center (KDC) acts as a **trusted third-party authority** that is responsible for **authenticating users** and **issuing tickets** to allow access to services.The KDC contains a **database of users** (principals) with their **username and password-derived keys** (hashed passwords). When a user first sets up their password, the password is hashed (using a hashing algorithm) and stored securely in the KDC database.</p>

### The KDC consists of two main parts:
---

### **Authentication Server (AS)**

The **Authentication Server** is responsible for verifying the identity of users during the initial login process. Below is a detailed breakdown of its operation:

#### 1. **User Authentication Process**:

- When a user attempts to authenticate to the system, the client sends an **Authentication Server Request (AS-REQ)** to the **Authentication Server (AS)**.
- The **AS-REQ** typically contains:
    - **Username**: Identifies the user attempting to authenticate.
    - **Timestamp**: This is encrypted using a hash derived from the user's password and username.

#### 2. **Verification of User**:

- Upon receiving the **AS-REQ**, the **AS** performs the following actions:
    - It looks up the **password hash** associated with the specific user in the **ntds.dit** file.
    - The **AS** attempts to **decrypt the timestamp** using this hash.
    - If the decryption is successful and the timestamp is valid (not a duplicate), the authentication is considered **successful**.

#### 3. **Issuance of Ticket Granting Ticket (TGT)**:

- If the user is successfully authenticated, the **AS** generates a **Ticket Granting Ticket (TGT)** for the user.
- The **TGT** contains:
    - A **session key**, which is used for subsequent communication between the client and services.
    - This session key is encrypted using the user's **password hash** and can be decrypted by the client. The client can reuse this session key for later requests.

#### 4. **Encryption of the TGT**:

- The **TGT** is encrypted using a secret key associated with the **krbtgt** account, which is an account known only to the KDC (Key Distribution Center).
- Since the **krbtgt** key is only known to the KDC, it cannot be decrypted by the client.
- The **TGT** provides the client with the ability to request **service tickets** without needing to re-enter credentials, ensuring both convenience and security.

#### 5. **TGT Validity and Renewal**:

- By default, the **TGT** is valid for **ten hours**.
- After this period, the **TGT** will require a **renewal** to extend its validity.


#### 2. **Ticket Granting Service (TGS)**:

- The **Ticket Granting Service** is responsible for issuing **service tickets**. Once a client has a valid **TGT** (obtained from the AS), they can use it to request access to specific services in the network.
- The client constructs a **Ticket Granting Service Request (TGS-REQ)** packet that consists of the following:
    - The current user
    - A timestamp encrypted with the session key
    - The name of the resource
    - The encrypted **TGT**
- The **ticket-granting service** on the KDC receives the **TGS-REQ**, and if the resource exists in the domain, the **TGT** is decrypted using the secret key known only to the KDC. The session key is then extracted from the **TGT** and used to decrypt the username and timestamp of the request. The KDC performs several checks:
    - The **TGT** must have a valid timestamp.
    - The username from the **TGS-REQ** has to match the username from the **TGT**.
    - The client IP address needs to coincide with the **TGT** IP address.
- If this verification process succeeds, the **Ticket Granting Service** responds to the client with a **Ticket Granting Server Reply (TGS-REP)**. This packet contains three parts:
    - The name of the service for which access has been granted.
    - A session key to be used between the client and the service.
    - A **service ticket** containing the username and group memberships along with the newly created session key.
- The service ticket’s **service name** and **session key** are encrypted using the original session key associated with the creation of the **TGT**. The service ticket is encrypted using the password hash of the **service account** registered with the service in question.




### Authentication Flow:
#### Step 1: User Authentication to the Authentication Server (AS)

1. **Login Request**:
    
    - The user enters their username and password into their device.
    - The Kerberos client software (already installed on the device) generates an **authentication request** and sends it to the **Authentication Server (AS)**, part of the **Key Distribution Center (KDC)**.
2. **AS Verifies User**:
    
    - The AS checks if the user is valid in its database.
    - It does **not transmit the user's password** over the network; instead, it uses a hash of the password to secure communication.
3. **AS Issues a Ticket Granting Ticket (TGT)**:
    
    - If authentication is successful, the AS generates a **Ticket Granting Ticket (TGT)**.
    - The TGT contains the user's identity and other metadata (like an expiration time) and is encrypted using the **password-derived key** of the **user**., The **user's password** is hashed. The **hashed password** is used to derive a **key**, which is then used to **encrypt** the **TGT** issued by the **Authentication Server (AS)**.ensuring only the KDC can read it.
    - The TGT is sent to the client.
4. **Client Stores the TGT**:
    
    - The TGT is cached on the user's device.
    - The user doesn't need to reauthenticate with the KDC as long as the TGT is valid.

---

#### Step 2: Requesting Access to a Service

1. **Client Requests Service Ticket**:
    
    - When the user tries to access a specific service (e.g., a file server or database), the client sends the TGT to the **Ticket Granting Service (TGS)**, another part of the KDC.
    - The request also includes the identity of the service the user wants to access.
2. **TGS Issues a Service Ticket**:
    
    - The TGS decrypts the TGT using the KDC's key(This key is shared between the **TGS** and the **Authentication Server**) to verify the user's identity.
    - If the TGT is valid, the TGS issues a **Service Ticket** for the requested service.
    - The Service Ticket is encrypted using the secret key of the target service, ensuring only the service can decrypt and validate it.
3. **Client Stores the Service Ticket**:
    
    - The Service Ticket is sent back to the client.
    - The client caches it and uses it to communicate with the requested service.

---

### Step 3: Accessing the Service

1. **Client Sends Service Ticket to the Target Service**:
    
    - The client presents the Service Ticket to the target service as proof of authentication.
    - The ticket contains the user's identity and is encrypted with the service's secret key.
2. **Service Validates the Ticket**:
    
    - The service decrypts the Service Ticket using its secret key.
    - If the ticket is valid and matches the user and request, the service grants access.
3. **Secure Communication**:
    
    - If mutual authentication is required, the service may also verify its identity to the client.
    - After successful authentication, the client and the service can communicate securely, often using a session key included in the ticket.


### Kerberos Delegation
Kerberos delegation is a feature in the **Kerberos authentication protocol** that allows a service to act **on behalf of a user** to access resources on another service. In simple terms, it lets **Service A** (like a web server) use a user's credentials to authenticate to **Service B** (like a database), as if the user had connected directly to Service B.

**Delegation** means **giving someone else permission to act on your behalf**.

#### Types
##### Unconstrained Delegation
Unconstrained delegation allows a service to impersonate a user to any other service. This type of delegation is risky because if the front-end service is compromised, it can access any resource as the user.

##### Constrained Delegation
Constrained delegation restricts the services to which the front-end service can delegate. This is configured by specifying the services that the front-end service can access on behalf of the user. This type of delegation is more secure as it limits the scope of delegation.

##### Resource-based Constrained Delegation (RBCD)
RBCD allows delegation across domains and puts control in the hands of the resource owner. The resource owner specifies which front-end services can impersonate users to access their resources. 