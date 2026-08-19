## CDN
A Content Delivery Network is a geographically distributed network of servers, called edge servers, that sits between users and an application's origin server. Its main purpose is to deliver content faster, improve availability, reduce the load on the origin server, and provide additional security features.

### How a CDN works

1. User requests a resource

   * The user requests a website, image, video, API response, JavaScript file, etc.
   * Example: `https://example.com/image.jpg`

2. DNS directs the request to the CDN

   * The domain is configured to use the CDN.
   * The request is therefore handled by a nearby CDN edge location rather than going directly to the origin.

3. CDN checks its cache

   * If the requested content is already cached at the edge, the CDN can return it immediately.
   * This avoids contacting the origin server.

4. Cache miss → CDN contacts the origin

   * If the content isn't cached, the CDN requests it from the origin server.

5. Origin sends the content to the CDN

   * The CDN receives the response from the origin.

7. CDN delivers it to the user
   * The CDN sends the content back to the user.
   * Depending on the configuration, the CDN may cache the content for subsequent requests.


![image](https://www.cloudns.net/blog/wp-content/uploads/2023/04/CDN.png)


## Redirector
A redirector is an intermediary server or service that receives network traffic from a client and forwards it to a designated backend server or host. It acts as a layer between the client and the backend, allowing traffic to be routed, filtered, or proxied without exposing the backend server directly.

### Dumb Pipe Redirector
Blindly forwards all incoming packets or connections to the backend team server without inspection. Easy to set up using tools like socat, but offers weak defense against active defender analysis.
- Iptables
- Socat

### Smart Filtering Redirector
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

![img](https://bluescreenofjeff.com/assets/attack-infrastructure-design/red-team-attack-infrastructure-diagram.png)

