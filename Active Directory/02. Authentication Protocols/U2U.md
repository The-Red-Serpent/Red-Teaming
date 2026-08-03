## U2U Authentication
<p aligin"center">User-to-User (U2U) authentication is a Kerberos extension that allows a client to obtain a service ticket encrypted with another user's Ticket Granting Ticket (TGT) session key instead of a service account's password. It is designed for situations where the "service" is running under a regular user account that does not have a Service Principal Name (SPN) and therefore has no service account  password that the KDC can use to encrypt a normal service ticket.</p>

imagine a scenario where user A hosts a service on a server, and another user B wants to access that service. User B can use U2U, which is just a variation of TGS-REQ to request access to that service. This is needed because user A (the service) doesn’t have a long-term secret.
Instead of issuing a service ticket encrypted with the service’s long-term secret, the KDC issues a ticket encrypted with the target user’s TGT session key.

## Authentication Flow

I’m defining Alice’s TGT as TGT_A and Bob’s TGT as TGT_B

Alice wants to access a service that Bob is hosting. Alice builds a TGS-REQ to the KDC asking for a service ticket to access the service hosted by Bob.Inside the TGS-REQ, a new flag ENC-TKT-IN-SKEY is set to indicate this is a U2U authentication.
There’s also an additional-tickets structure containing TGT_B.

The KDC proceeds the following way:

- It decrypts TGT_A and extracts the session key.
- It decrypts the authenticator of TGT_A and verifies her identity.
- It decrypts the TGT_B.
- It builds a service ticket but encrypts it with the session key of TGT_B.
- It builds the enc-part for Alice and encrypts it the session key of TGT_A and returns a TGS-REP.
- Alice now holds a service ticket that only Bob can decrypt.

The client first sends a ``KERB-TGT-REQUEST`` message directly to the target service. The service responds with a ``KERB-TGT-REPLY`` containing its own TGT. The client then submits this TGT to the KDC in the additional-tickets field of a modified TGS-REQ with the ``ENC-TKT-IN-SKEY`` flag set. The KDC decrypts the additional TGT using the KRBTGT key, extracts the session key, and uses it to encrypt the new U2U service ticket. The ENC-TKT-IN-SKEY flag tells the KDC to encrypt the service ticket using a session key rather than the service account Password.


