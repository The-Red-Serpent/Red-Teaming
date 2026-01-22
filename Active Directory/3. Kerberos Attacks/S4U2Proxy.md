### S4U2Proxy

`S4U2Proxy` stands for **Service for User to Proxy**. It is part of the **Kerberos Constrained Delegation (KCD)** flow, which allows a service to obtain a ticket **on behalf of a user** to another service **without knowing the user’s password**.

Think of it like this:

* Alice logs in to a web app (Service A).
* Service A needs to call Service B on Alice’s behalf.
* Service A can’t have Alice’s password, but it can request a ticket to Service B **as Alice** if the KCD is properly configured.

`S4U2Proxy` is used **after** `S4U2Self`.


### **Key Steps**

1. **S4U2Self:**

   * Service A asks the KDC for a Ticket-Granting Ticket (TGT) **for a user** (Alice) using only the service account’s credentials.
   * No password is required for the user.

2. **S4U2Proxy:**

   * Service A now has a **service ticket for itself** representing the user (from S4U2Self).
   * Service A wants a **ticket to Service B** on behalf of Alice.
   * It calls the KDC using the S4U2Proxy request, including the ticket obtained from S4U2Self.
   * KDC issues a **service ticket for Service B for Alice**.

```
  Alice                     ServiceA                     KDC                     ServiceB
  |                           |                         |                         |
  |----1. Authenticate------->|                         |                         |
  |     (username/password)   |                         |                         |
  |                           |                         |                         |
  |                           |----2. TGS Req for A---> |                         |
  |                           |                         |                         |
  |                           |<--- TGT_ServiceA -------|                         |
  |                           |                         |                         |
  |                           |                         |                         |
  |----3. Access ServiceA---->|                         |                         |
  |     (presents TGT)        |                         |                         |
  |                           |                         |                         |
  |                           |----4. S4U2Self Req---->|                          |
  |                           |  (Request ticket for Alice)                       |
  |                           |                         |                         |
  |                           |<--- TGS_Alice_for_ServiceA -----------------------|
  |                           |  (ServiceA can now act as Alice locally)          |
  |                           |                         |                         |
  |                           |----5. S4U2Proxy Req------------------------------>|
  |                           |  (Use TGS_Alice_for_ServiceA + request for B)     |
  |                           |                         |                         |
  |                           |<--- TGS_Alice_for_ServiceB -----------------------|
  |                           |  (ServiceA can now act as Alice for ServiceB)     |
  |                           |                         |                         |
  |                           |----6. Service Request --------------------------->|
  |                           |  (Ticket_Alice_for_ServiceB)                      |
  |                           |                         |                         |
  |                           |                         |<---7. Request Accepted -|
  |                           |                         |     as Alice            |


```


