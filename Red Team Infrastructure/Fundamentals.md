## CDN



## Redirector
A redirector is an intermediary server or service that receives network traffic from a client and forwards it to a designated backend server or host. It acts as a layer between the client and the backend, allowing traffic to be routed, filtered, or proxied without exposing the backend server directly.

### Dumb Pipe Redirector
Blindly forwards all incoming packets or connections to the backend team server without inspection. Easy to set up using tools like socat, but offers weak defense against active defender analysis.
- Iptables
- Socat

### Smart Filtering
Uses routing logic via tools like Nginx or Apache to inspect request attributes (User-Agents, URIs, IP ranges) and filter out non-malicious or scanner traffic.
- Apache
- Ngnix
- Azure Functions
- AWS Lambda
- Cloudflare Tunnels
- Amazon Cloudfront
- Azure Frontdoor
- Azure Relay


### OpSec Guidelines
- Clone TLS certificates from legitimate services (e.g., Microsoft Azure, Cloudflare CDN)
- Vary JA3 hash using uTLS or TLS proxies
- Do not reuse certs across operations
- Use separate domains for each cert
- Avoid Let’s Encrypt unless spoofed correctly; its logs are public
- Deploy redirectors that terminate TLS and rewrite headers before proxying to C2
- Randomize headers: User-Agent, Accept, Content-Type.
- c2concealer: Automates domain fronting infrastructure
- Custom HTTP clients with TLS stack modification (e.g., uTLS, Golang tls.Config) gimme defintion of Redirector


