
## **1. Domain and Infrastructure IoCs**

| IoC                          | Why It’s Detected                                                                        | OPSEC Consideration                                                                                                                    |
| ---------------------------- | ---------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| **New domain registration**  | Very new domains are suspicious; often flagged by email security and threat intelligence | Register domains well in advance; age the domain; use reputable domains if possible                                                    |
| **Low domain/IP reputation** | IPs or domains with no reputation are more likely to be blocked or flagged               | Use trusted SMTP relay services; choose reputable hosting providers for phishing infrastructure                                        |
| **Suspicious URLs / TLDs**   | Typosquatting or unusual TLDs raise alerts                                               | Use character substitutions or creative, less suspicious domains; make domains appear legitimate while staying within engagement rules |

---

## **2. Network Traffic and Server-Side IoCs**

|IoC|Why It’s Detected|OPSEC Consideration|
|---|---|---|
|**User-Agent & IP filtering**|Automated scanners and bots can fingerprint servers|Block known scanner IPs; filter suspicious user agents; Evilginx Pro has built-in options for this|
|**SSL certificates**|Self-signed or newly generated certs trigger warnings|Use trusted CAs like Let’s Encrypt; automate certificate issuance and proper management|
|**Default configurations / headers**|Default framework headers or tracking pixels can be fingerprinted|Modify headers, tracking pixel signatures, and default configurations to remove framework-specific fingerprints|
|**Unusual traffic patterns**|Sudden spikes or narrow IP range access can indicate phishing|Stagger campaign delivery; use domain redirects and “safe” landing pages to make traffic appear normal|

---

## **3. Content and Behavioral IoCs**

| IoC                               | Why It’s Detected                                                  | OPSEC Consideration                                                                                                       |
| --------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| **HTML / JavaScript obfuscation** | Certain obfuscation patterns are detectable by security scanners   | Use subtle obfuscation that looks like legitimate site code; Evilginx Pro helps with content obfuscation                  |
| **Behavioral anomalies**          | Requests for credentials or MFA bypass attempts can trigger alerts | Craft highly contextual and personalized phishing emails (spear phishing); mimic legitimate organizational communications |

---
#### Tool IOC's

|**Challenge**|**Description**|**Mitigation**|
|---|---|---|
|Evilginx Header Exposure|`X-Evilginx` header in HTTP requests can alert defenders|Modify source code or use pre-built scripts to remove the header|
|Server IP Leaks to Origin|Origin server can detect Evilginx server’s IP|Use VPN for all traffic OR configure proxy in Evilginx (rotate proxies/IPs if needed)|
|Server IP Leaks via DNS|Using Evilginx as DNS resolver exposes IP for subdomains|Block UDP port 53; configure correct `external_ipv4` and `domain` in Evilginx|
|SSL / Certificate Transparency Leaks|Let’s Encrypt requests can reveal IPs and subdomain patterns|Use redirectors (Apache/Nginx); proxy via Cloudflare with TLS/wildcard certs; debug mode with self-signed certs|
[Device Code Phishing tutorial ](https://medium.com/sud0root/mastering-modern-red-teaming-infrastructure-part-7-advanced-phishing-techniques-for-2fa-bypass-85f9adc4dc3b)
- cloudflare edge servers

#### OPSEC  Tactics
## **1. Anonymous Infrastructure Setup**

- Use crypto-based domain registrars requiring no identity verification
- Prefer neutral domains to avoid brand/typo-squatting detection
- Domains often appear as **newly registered** (NRDs)
## **2. SSL & Certificate Transparency Evasion**

- Use wildcard certificates from CDNs (e.g., Cloudflare)
- Avoid generating suspicious SSL entries in CT logs
- Security tools like Certstream monitor these patterns in real time
## **3. Code Obfuscation & Anti-Analysis**

- Malicious HTML embedded inside obfuscated JavaScript
- Evades hashing & signature-based detection
- Anti-crawler techniques serve blank or altered pages to bots
## **4. Crawler & Bot Detection Methods**

- Hidden links (display:none) used to detect automated scanners\
- Dynamic color/layout changes to evade visual similarity analysis
- Use of bot challenges (e.g., Cloudflare Turnstile)
## **5. Origin Hiding via CDNs**

- CDNs (Cloudflare, Fastly, Incapsula) mask real server IP
- Reverse proxy setups complicate attribution
- Useful for attackers to avoid scanning and direct blocking
## **6. TLS & Header Manipulation**

- Customize server headers (Server, X-Powered-By)
- Modify TLS fingerprints to mimic legitimate services
- Helps evade tools like Shodan, Censys, JA3 fingerprinting
## **7. File Delivery Tactics**

- Neutral filenames to evade suspicion
- Fake digital signatures added to binaries
- blob: URLs used for ephemeral file hosting
## **8. Credential Form Obfuscation**

- Avoid explicit HTML field names like “password”
- Use CSS or Web Components to mask sensitive input fields
## **9. Stealthy Data Exfiltration**

- Temporary webhooks or messaging APIs (e.g., Telegram)
- Data quickly deleted to reduce forensic traces
- No local storage to limit evidence

### Tools of the Trade
- Evilngnix
- Gophish
- Evilpanel (if possible)
- 
#### Cloudflare Tunnel 


```
 Victim/User
      |
      v
 +------------------+
 |  login.yourdomain.com
 |     (DNS → Cloudflare)
 +------------------+
      |
      v
 +----------------------------+
 |      Cloudflare Edge       |
 |  • WAF / DDoS / TLS Term   |
 |  • Filters all traffic     |
 |  • Mask origin IP          |
 +----------------------------+
      |
      | Secure outbound-only tunnel
      | (initiated from your server)
      v
 +----------------------------+
 |   cloudflared Tunnel      |
 |  (Outbound connection)     |
 +----------------------------+
      |
      v
 +----------------------------+
 |   Your Internal Server     |
 |  (Evilginx / Web App /     |
 |    Test Infra / etc.)      |
 +----------------------------+

```


#### Microsoft Cloud Phishing detection

 Before the email reaches the mailbox_
### **Exchange Online Protection (EOP)**

Extracts all URLs (even hidden ones)  
Checks them against:
- known bad URLs
- malware links
- phishing URL lists
- tenant block lists
- Microsoft’s global reputation system

Also  Looks for:
- lookalike domains
- suspicious TLDs
- URL encoding tricks
- domain age / hosting anomalies

If malicious → email is rejected or quarantined.
If unknown → passes to Defender.

#### Stage 2 — _Advanced Phishing Analysis_
### **Microsoft Defender for Office 365**
##### **Heuristic analysis of the email + URL**
- checks message body
- inspects HTML structure
- valuates URL patterns
- checks for spoofing (via SPF, DKIM, DMARC)
- ML models scan the message context
#### **Detonates URLs in a cloud sandbox**

Opens the link _inside Microsoft’s cloud_ to see:
- if it loads credential forms
- if it uses phishing kit JavaScript
- if it redirects multiple time
- if it imitates brands
- if it behaves differently for different IPs

If suspicious → Defender flags it as phish/malware.

---

####  Stage 3 — _Safe Links (Time-of-Click Protection)_

Even if a URL is unknown or looks safe, Microsoft rewrites it.
####  **Microsoft rewrites EVERY clickable URL**
Example:
`https://example.com/login`  
→  
`https://nam01.safelinks.protection.outlook.com/?url=<encoded>`

When the user clicks:
#### Microsoft scans the URL _again_ in real time

- checks reputation
- evaluates redirects
- opens the page in virtual sandbox
- compares layout to Microsoft/Google/bank login pages
- checks JS behavior
#### Stage 4 — _Continuous Re-Scanning After Delivery_

Microsoft continues scanning URLs **after the email is in the inbox**.
This is called:
#### Zero-Hour Auto Purge (ZAP)

If a URL becomes malicious 10 minutes or 5 days later:
- email is automatically removed from the mailbox
- admin receives an alert
- block is applied to the URL

### Bypass Techniques

1. **Benign → Malicious Redirect Chains*
2. **Over-Encoded or Obfuscated URLs (multiple percent-encoding layers)**
3. **Phishing hosted on trusted/compromised cloud services**
4. **Dynamic / per-user URLs (unique links per email)**
5. **IP-based or geo-based cloaking to hide malicious content from scanners**
6. **QR code phishing (URL hidden inside an image)**
7. **Password-protected or encrypted attachments hiding the link**
8. **HTML or JavaScript smuggling (payload reconstructed at runtime)**
9. **Multi-stage delivery (initial clean email → later infected asset)**
10. **Brand impersonation on legitimate SaaS platforms (e.g., forms, storage)**
11. **Time-delayed activation (URL becomes malicious hours later)**


#### Deceptive Site Ahead Bypass tactics
 These Often get detected because security scanners already know their **static HTML, JavaScript, and asset signatures**. This is similar to how antivirus products detect malware with signatures.
 
Attackers try to evade this by:
- **obfuscating HTML/JS**, [Html Obfuscator](https://github.com/BinBashBanana/html-obfuscator)
- **decrypting content at runtime**,
- or **dynamically generating pages**,  
    which defeats simple pattern-based scanners.


#### Some New Techniques i found along the way

- Dns  Fast Flux technique
- Salty 2fa phish kit
