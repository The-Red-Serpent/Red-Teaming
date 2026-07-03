## ASN Enumeration
An Autonomous System Number is a unique number assigned to a network that is independently managed and controls its own IP routing policies on the internet, allowing it to exchange routing information with other networks using BGP, also represents a network operated by an organization that owns or manages public IP address ranges and controls how they are routed on the internet. In red team reconnaissance, ASN enumeration is used to identify whether a company owns public IP blocks and runs its own infrastructure, helping map servers and network assets that may be in scope.

  * https://bgp.he.net/
  * https://dnschecker.org/all-dns-records-of-domain.php

## Acquisition Enumeration
Acquisition enumeration is the process of identifying companies, brands, or subsidiaries acquired by a target organization to uncover additional domains, assets, and infrastructure.In red team reconnaissance, it helps expand attack surface and scope by finding newly acquired or loosely integrated systems that may be less secured.


## Email Enumeration
Email enumeration is the process of identifying valid email addresses or users within an organization’s domain  by testing how email systems respond to login attempts, SMTP checks, or error messages. In red team reconnaissance, it helps map real users and email formats, which can be used to assess exposure to phishing, password spraying, or account takeover risks.

Email Scraping:
 * https://snov.io/
 * https://hunter.io/
 * https://www.apollo.io/
 * https://www.signalhire.com/home

Username Forging:
* https://github.com/urbanadventurer/username-anarchy

Email Validation:
* https://github.com/gremwell/o365enum
```
dig MX example.com
```

