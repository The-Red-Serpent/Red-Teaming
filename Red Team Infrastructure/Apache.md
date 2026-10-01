# Apache 
 ## mod_rewrite

 mod_rewrite is used for URL rewriting and conditional request handling. It allows Apache to examine a request and decide what should happen based on conditions such as the URL, query string, headers, or other request properties. It can perform redirects, internally rewrite a request to another resource, or send a request to a proxy using the [P] flag. Its main directives are RewriteRule, RewriteCond, and RewriteEngine.

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
