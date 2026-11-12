# Public Key Infrastructure
Public Key Infrastructure (PKI) is a foundational cybersecurity framework that uses asymmetric cryptography and digital certificates to verify identities, secure network communication, and protect data integrity. Think of PKI like a digital passport system: a trusted government agency (the Certificate Authority) stamps your identity document so everyone else knows you are who you claim to be without needing to personally check your background.

## Core Components of PKI

A complete PKI deployment relies on several interconnected parts working together:
- Certificate Authority (CA): The trusted entity that issues, signs, and revokes digital certificates. It contains a Root CA (the top-level anchor of trust) and subordinate/intermediate CAs that handle day-to-day issuance.

- Registration Authority (RA): An optional or integrated side-vettor that verifies the identity of users, devices, or services before the CA issues a certificate.
  
- Digital Certificates (X.509): The electronic credentials that bind a public key to an entity's identity (such as a domain name, user, or server) along with validity dates and a CA signature.
  
- Certificate Signing Request (CSR): A standard message sent by an applicant to a CA to apply for a digital certificate, containing their public key and identity info.
  
- Repositories & Directories: Centralized storage (such as LDAP directories) where certificates and revocation lists are published for public lookup.
  
- Hardware Security Modules (HSMs): Physical, tamper-resistant hardware devices used to safely generate, store, and protect high-value CA private keys.
  
- Revocation Mechanisms: Tools like Certificate Revocation Lists (CRLs) or Online Certificate Status Protocol (OCSP) that check if a certificate has been invalidated before its official expiration.


# How PKI (Public Key Infrastructure) Works 

## 1. Key Pair Generation

The first step in PKI is generating an asymmetric cryptographic key pair.

An entity (user, web server, organization, or IoT device) generates two mathematically related keys:

- Private Key: A secret key that is stored securely by its owner and must never be shared.
- Public Key: A key that can be shared openly with other systems.

Both keys are mathematically related, but it is computationally impractical to calculate the private key from the public key.

Example:

Suppose a company wants to secure its website, `www.example.com`.

1. The web server generates a public-private key pair.
2. The private key is stored securely on the web server.
3. The public key will be shared with the Certificate Authority (CA) through a Certificate Signing Request (CSR).

Purpose: The key pair enables digital signatures, authentication, and cryptographic key establishment.

## 2. CSR (Certificate Signing Request) Submission

After generating the key pair, the entity creates a Certificate Signing Request (CSR) and sends it to a Certificate Authority (CA).

A CSR is a request for a digital certificate. It contains information such as:

- Domain name (e.g., www.example.com).
- Organization name.
- Country and location.
- Public key of the web server.
- Other identifying information.

The CSR is digitally signed using the entity's private key to demonstrate possession of the corresponding private key.

Example:

1. The web server generates its public-private key pair.
2. It creates a CSR containing its domain name and public key.
3. It signs the CSR using its private key.
4. It sends the CSR to the CA.

Important: The private key is never sent to the CA. Only the public key and other requested information are included in the CSR.

Purpose: The CSR provides the CA with the public key and identity information that must be included in the digital certificate.

## 3. Identity Verification

After receiving the CSR, the Certificate Authority (CA) verifies the identity of the requester before issuing a digital certificate.

This verification ensures that the certificate is issued to the correct person, organization, or domain owner.

The verification may be performed by a Registration Authority (RA) or directly by the CA.

Common verification methods include:

- Domain Validation (DV): Checks whether the requester controls the domain.
- Organization Validation (OV): Verifies the organization's legal identity and details.
- Extended Validation (EV): Performs more extensive checks on the organization's identity.

Example:

Suppose a company requests a certificate for `www.example.com`.

1. The CA asks the company to prove ownership or control of the domain.
2. The company completes a DNS-based or HTTP-based verification.
3. The CA verifies the submitted information.
4. If verification succeeds, the CA approves the request.

Purpose: This prevents unauthorized individuals from obtaining certificates for domains or identities they do not control.

## 4. Digital Certificate Issuance

Once the identity is verified, the CA issues a digital certificate.

A digital certificate is an electronic document that connects an entity's identity with its public key.

The certificate contains:

- Subject name or domain name.
- Subject's public key.
- Certificate issuer (CA name).
- Serial number.
- Validity period.
- Certificate usage information.
- CA's digital signature.

How does the CA sign the certificate?

This is one of the most important steps in PKI.

1. The CA prepares the X.509 certificate containing the verified identity information and the web server's public key.
2. The CA calculates a hash of the certificate's information.
3. The CA signs this hash using its own private signing key.
4. The resulting digital signature is attached to the certificate.
5. The signed certificate is sent to the web server.

Important concept:

- The CA uses its private key to digitally sign the certificate.
- The corresponding CA public key is used to verify the certificate's digital signature.

The CA's private key is kept secret and is never shared with the web server.

The CA public key is available through trusted CA certificates distributed in operating systems and browser trust stores.

Purpose: The CA's digital signature proves that the certificate was issued by the CA and that its signed contents have not been modified.

## 5. Certificate Verification and Trust Establishment

After receiving the certificate, the web server installs it and presents it to clients (such as web browsers) during secure connections.

Suppose a user opens `https://www.example.com`.

The following process takes place:

Step 1: Connection Request

The browser sends a request to establish a secure connection with the web server.

Step 2: Certificate Presentation

The web server sends its digital certificate to the browser. It may also send intermediate CA certificates.

Step 3: Certificate Signature Verification

The browser checks the CA's digital signature on the certificate using the CA's public key.

For example:

- The CA signed the certificate using its private key.
- The browser obtains the corresponding CA public key from its trusted certificate store.
- The browser uses that public key to verify the CA's digital signature.

If the signature is valid, it confirms that the certificate was signed by the corresponding CA private key and its signed contents have not been altered.

Important clarification: The web server does not normally use the CA public key to verify its own certificate. The client browser performs this verification using its trusted CA certificates.

Step 4: Additional Certificate Checks

The browser also checks:

- Whether the certificate is within its validity period.
- Whether the domain name matches the certificate.
- Whether the certificate chain leads to a trusted root CA.
- Whether the certificate has been revoked, where revocation checking is performed.
- Whether the certificate is being used for an appropriate purpose.

Step 5: Trust Establishment

If all required checks succeed, the browser accepts the server's identity as authenticated.

If verification fails, the browser may display a security warning.

Purpose: This process helps ensure that the browser is communicating with the intended website rather than an impersonating server.

## 6. Secure Session Establishment and Data Encryption

After successfully verifying the certificate, the browser and web server establish a secure connection using TLS (Transport Layer Security).

The process works as follows:

1. The browser and web server perform a TLS handshake.
2. They use cryptographic key exchange to establish shared session keys.
3. These session keys are used for symmetric encryption.
4. Data is encrypted before being transmitted.
5. The receiving system decrypts the data using the appropriate session keys.
6. Integrity protection helps detect unauthorized modifications.
