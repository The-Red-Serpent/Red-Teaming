## ASN Enumeration
An Autonomous System Number is a unique number assigned to a network that is independently managed and controls its own IP routing policies on the internet, allowing it to exchange routing information with other networks using BGP, also represents a network operated by an organization that owns or manages public IP address ranges and controls how they are routed on the internet. In red team reconnaissance, ASN enumeration is used to identify whether a company owns public IP blocks and runs its own infrastructure, helping map servers and network assets that may be in scope.

  * https://bgp.he.net/
  * https://dnschecker.org/all-dns-records-of-domain.php

## Acquisition Enumeration
Acquisition enumeration is the process of identifying companies, brands, or subsidiaries acquired by a target organization to uncover additional domains, assets, and infrastructure.In red team reconnaissance, it helps expand attack surface and scope by finding newly acquired or loosely integrated systems that may be less secured.

* https://tracxn.com/
* https://www.crunchbase.com/

## Cloud Enumeration
Cloud enumeration is the process of identifying a company’s cloud usage and assets**—such as cloud providers, storage, compute services, and exposed endpoints.In red team reconnaissance, it helps discover cloud infrastructure (AWS, Azure, GCP), misconfigurations, and publicly accessible services that may expand the attack surface.

* https://kaeferjaeger.gay/

```
python3 cloud_enum.py -k examplecompany.com
```

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

## Subdomain Enumeration
Subdomain enumeration is the process of discovering subdomains associated with a target domain. In red team reconnaissance, it helps identify additional applications, environments (dev/test/stage), and exposed services that may be less secured and expand the attack surface.
```
# Subfinder – passive subdomain enumeration
subfinder -d example.com -all -silent

# Sublist3r – search-engine based enumeration
sublist3r -d example.com -o sublist3r.txt

# PureDNS – fast DNS brute-force & resolution
puredns bruteforce wordlist.txt example.com \
  --resolvers resolvers.txt \
  --write puredns.txt

# Assetfinder
assetfinder --subs-only example.com

```

* https://github.com/gotr00t0day/crt.sh
```
python3 crtsh_enum.py -d example.com
```


## IP Address Enumeration
IP address reconnaissance is the process of identifying, mapping, and analyzing public IP addresses associated with a target organization. In red team reconnaissance, it helps determine hosting location, cloud or on-prem infrastructure, exposed services, and network boundaries, expanding the visible attack surface.

```
dnsx -l domains.txt -a -aaaa -cname -resp -retry 3 -threads 200 -o resolved.txt
```

## Google Dorking
Google dorking is the technique of using advanced Google search operators to discover publicly exposed information related to a target, such as sensitive files, credentials, admin panels, or misconfigured pages. In red team reconnaissance, it helps uncover unintended data exposure and weak security hygiene without directly interacting with the target systems.
* https://dorkengine.github.io/
```
python3 dorks_hunter.py -d domain.com -o output.txt
```

## Credential Leak
Credential leak reconnaissance is the process of identifying exposed usernames, passwords, API keys, or tokens that have been leaked through data breaches, public repositories, paste sites, or misconfigurations. In red team reconnaissance, it helps assess account takeover risk and identity exposure caused by leaked credentials.
* https://leak.sx/
* https://link-base.ms/index.php

## Github Enumeration
GitHub enumeration is the process of searching GitHub for code, repositories, commits, and issues related to a target organization to identify exposed credentials, internal domains, API keys, secrets, or infrastructure details. In red team reconnaissance, it helps uncover accidental leaks and developer mistakes that may expose sensitive information publicly.

```
gitleaks detect --source https://github.com/org/repo.git --report-path gitleaks-remote.json --report-format json

trufflehog git https://github.com/org/repo.git --json > trufflehog-report.json
```
