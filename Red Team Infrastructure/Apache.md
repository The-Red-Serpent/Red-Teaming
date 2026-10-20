# Apache 
 ## mod_rewrite
mod_rewrite is used for URL rewriting and conditional request handling. It allows Apache to examine a request and decide what should happen based on conditions such as the URL, query string, headers, or other request properties. It can perform redirects, internally rewrite a request to another resource, or send a request to a proxy using the [P] flag. Its main directives are RewriteRule, RewriteCond, and RewriteEngine, RewriteBase.

### RewriteEngine
To use mod_rewrite, you must first turn the execution engine On and then use matching patterns (using PCRE regular expressions) to rewrite or redirect incoming web paths.
```
RewriteEngine On
```

### 
The RewriteCond directive acts as a conditional guard clause. A RewriteRule only runs if all the RewriteCond statements immediately preceding it evaluate to true.
Think of it as an if statement in programming: IF the RewriteCond is true, THEN look at the RewriteRule.
```
RewriteCond TestString CondPattern [Flags]
```
  • TestString: The variable you are checking (e.g., Server variables like %{HTTP_HOST}, %{REQUEST_URI}, or %{HTTPS}).

  • CondPattern: The criteria it must meet. This can be a Regular Expression, a String Comparison, or a File/Directory Check (like -f to check if a file exists, or -d for a directory).

  • [Flags]: Optional modifiers that change how the condition is evaluated.

| Flag | Name | Explanation |
| --- | --- | --- |
| `[NC]` | No Case | Forces case-insensitive matching on the condition pattern. This ensures variations in capitalization (e.g., `Example.com` vs. `example.com`) are matched identically. |
| `[OR]` | Or Next Condition | Changes the default logical pairing of sequential condition lines from AND to OR. The rule fires if either the current condition or the immediately following condition evaluates to true. |
| `[NV]` | No Vary | Prevents inspected request header names from being added to the outbound HTTP `Vary` response header. This helps prevent downstream CDNs and proxies from unnecessarily fragmenting the public page cache. |

 ### RewriteRule
 The RewriteRule is the primary workhorse directive. It evaluates the requested URL path sequentially.

 ```
RewriteRule Pattern Substitution [Flags]
```
   • Pattern: A PCRE regular expression matched against the URL-path.
   
   • Substitution: The target location, which can be a local file path, a relative web-path, or an absolute external URL. You can use $1 through $9 back-references to inject capture groups matched in the Pattern.
   
   • [Flags]: Optional comma-separated modifiers that dictate how Apache handles the outcome



| Flag | Name | Mechanics & Explanation |
| --- | --- | --- |
| `[B]` | Escape Backreferences | Escapes non-alphanumeric characters in backreferences before applying the substitution. This helps safely handle spaces and special characters in URLs and query parameters. |
| `[BNP]` | Backreferences No Plus | Forces spaces to be encoded as `%20` instead of `+` when used with `[B]`. This improves compatibility with backends that expect URL-style space encoding. |
| `[C]` | Chain | Chains the current rule to the immediately following rule. If the current rule fails, the remaining chained rules are skipped. |
| `[CO]` | Cookie | Sets a cookie when the rule matches and executes. Uses syntax such as `[CO=NAME:VALUE:DOMAIN:LIFETIME:PATH:SECURE:HTTPONLY]`. |
| `[DPI]` | Discard Path Info | Discards path information associated with the current request during rewriting. This prevents trailing path information from being carried into subsequent rewrite processing. |
| `[END]` | End Processing | Stops further per-directory rewrite processing for the current request. Unlike `[L]`, it also prevents subsequent per-directory rewrite passes. |
| `[ENV]` | Environment Variable | Sets an environment variable using syntax such as `[E=VAR:VALUE]`. The variable can be used by other Apache modules or application logic. |
| `[F]` | Forbidden | Returns an HTTP `403 Forbidden` response and stops rewrite processing. Useful for blocking requests that match specified conditions. |
| `[G]` | Gone | Returns an HTTP `410 Gone` response and stops rewrite processing. Indicates that a resource is permanently unavailable. |
| `[H]` | Handler | Forces the request to use a specified handler. For example, `[H=application/x-httpd-php]` selects a PHP handler when properly configured. |
| `[L]` | Last | Stops processing subsequent rewrite rules in the current pass. In `.htaccess`, another internal rewrite pass may still occur. |
| `[N]` | Next | Restarts rewrite processing from the first rule. Repeated execution can cause loops if the rules are not carefully controlled. |
| `[NC]` | No Case | Makes pattern matching case-insensitive. For example, `/Products` and `/products` can match the same rule. |
| `[NE]` | No Escape | Prevents Apache from escaping certain special characters in the redirect or substitution output. Useful when the output must preserve characters such as `#`. |
| `[NS]` | No Subrequests | Skips the rule when the request is an internal subrequest. This can avoid unnecessary rewriting during operations such as SSI processing. |
| `[P]` | Proxy | Passes the rewritten request to `mod_proxy` for proxy handling. This allows remote content to be served through your server, typically requiring `[L]` as well. |
| `[PT]` | Pass Through | Passes the rewritten URI back through Apache's URL-to-filename mapping process. Useful when other modules, such as `mod_alias`, need to process the rewritten URI. |
| `[QSA]` | Query String Append | Appends the original query string to the query string in the substitution. This preserves existing parameters when adding new ones. |
| `[QSD]` | Query String Discard | Discards the original query string when the substitution does not specify a new query string. Useful for removing unwanted tracking parameters. |
| `[QSH]` | Query String Hash | Allows the query string to be taken from the URL fragment in applicable rewrite contexts. This flag is intended for special rewrite scenarios, not general preservation of browser `#` fragments. |
| `[R]` | Redirect | Sends an external HTTP redirect to the browser. For example, `[R=301,L]` issues a permanent redirect, while `[R=302,L]` issues a temporary redirect. |
| `[T]` | Type | Sets the MIME content type of the resulting response using syntax such as `[T=text/html]`. Useful when the destination's file extension does not determine the intended content type. |


 
 
 
 ## mod_alias

 mod_alias is used for simple URL redirects and URL-to-file/directory mappings. It is useful when you need straightforward operations such as redirecting /old-page to /new-page or mapping a URL path to a directory on the filesystem. Common directives include Redirect and Alias. For complicated conditional redirects, mod_rewrite is generally more appropriate.

 ## mod_proxy

 mod_proxy provides Apache's core proxy and reverse-proxy functionality. It allows Apache to receive a request from a client and forward that request to another server, such as an internal application server. It provides directives such as ProxyPass, ProxyPassReverse, and ProxyPreserveHost. It is the main module you learn when using Apache as a reverse proxy.

 ## mod_proxy_http

 mod_proxy_http provides HTTP protocol support for mod_proxy. When Apache needs to reverse proxy a request to an HTTP backend such as http://10.0.0.20:8080, this module handles the HTTP communication with that backend. In simple terms, mod_proxy provides the proxy framework, while mod_proxy_http allows that framework to communicate with HTTP servers.

 ## mod_setenvif

 mod_setenvif is used to set Apache environment variables based on properties of an incoming request. You can use it to detect things such as specific HTTP headers, User-Agent values, client IP addresses, or other request attributes and then set a variable when a condition matches. These variables can subsequently be used by other Apache modules, particularly when implementing conditional behavior.

 ## mod_headers

 mod_headers is used to inspect, add, modify, or remove HTTP headers in requests and responses. It is particularly useful when configuring reverse proxies because backend applications often need information such as the original host, protocol, or client IP. For example, you can use the Header directive to add or modify headers sent by Apache.

 ## mod_dir

 mod_dir handles directory-related behavior in Apache. It is responsible for things such as determining which index file should be served when a directory is requested, using directives such as DirectoryIndex. It also handles certain directory URL behaviors, such as adding a trailing slash when required. You will commonly encounter it when Apache is serving normal websites and static files.

 ## mod_ssl

 mod_ssl provides SSL/TLS and HTTPS support for Apache. It allows Apache to accept encrypted HTTPS connections and configure certificates, private keys, TLS versions, and related security settings. It is also relevant in reverse-proxy setups when Apache terminates HTTPS connections from clients or needs to communicate with an HTTPS backend.
