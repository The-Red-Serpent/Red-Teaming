## Evilginx

Evilginx is an open-source Adversary-in-the-Middle (AiTM) phishing framework that operates as a reverse proxy between a victim's browser and a legitimate website. It relays HTTP/HTTPS requests and responses between the two parties and is designed to intercept authentication traffic, potentially capturing login credentials and authenticated session cookies.


A reverse proxy is an intermediary server that sits in front of one or more backend web servers, intercepting incoming requests from clients (such as web browsers) and forwarding them to the appropriate origin server


## How Evilginx Works

Evilginx leverages the concept of a reverse proxy, but configured specifically to capture a user’s credentials and session cookies once they are tricked into accessing the Evilginx URL instead of the legitimate target server.

### 1. Phishing Lure

The attacker tricks a victim into clicking a phishing link sent through email, SMS, or another communication channel. The link directs the victim to a domain configured to route traffic to the server running Evilginx.

<p align="center">   
	<img src="https://www.hypr.com/hs-fs/hubfs/Blog/Evilginx-blog-Diagram5x.jpg?width=600\&height=139\&name=Evilginx-blog-Diagram5x.jpg" alt="Phishing email lure diagram" width="600"/> 
</p>

### 2. Fraudulent Website and Reverse Proxy

The victim visits the phishing domain, which presents the target website through Evilginx's reverse-proxy functionality. The domain may have a valid TLS certificate, indicated by HTTPS and a padlock icon. However, HTTPS alone does not guarantee that a website is legitimate. Evilginx relays requests to the genuine website and returns its responses to the victim's browser, allowing the real authentication flow to appear to work normally.

<p align="center">  
	<img src="https://www.hypr.com/hs-fs/hubfs/Blog/Evilginx-blog-Diagram6x.jpg" alt="Evilginx reverse proxy communication diagram" width="800"/> 
</p>

### 3. Credential and Authentication Interception

When the victim submits their username and password, the authentication request passes through the proxy to the legitimate service. Depending on the authentication flow, Evilginx may also relay MFA interactions, including one-time passwords (OTPs). This can expose authentication information to the attacker.

### 4. Session Hijacking

If authentication succeeds, the legitimate service may issue a session cookie or other authentication token. If Evilginx captures a reusable session credential, the attacker may be able to replay it to access the victim's account without repeating the original authentication process.

<p align="center">   
	<img src="https://www.hypr.com/hs-fs/hubfs/Blog/Evilginx-blog-Diagram1x.jpg" alt="Evilginx credential and session interception diagram" width="800"/>
</p>

### 5. Account Takeover

If the attacker gains access to the authenticated account, they may attempt further unauthorized actions, such as accessing sensitive information, changing account settings, or modifying recovery details. Whether they can change the password or lock out the victim depends on the account's permissions and security controls.


## Session
A session is a way to maintain user authentication by storing session data on the server. When a user logs in, the server creates a session and assigns it a unique Session ID. This ID is stored in a cookie and sent with each request, allowing the server to recognize the user.

## Session Token
A session token is a unique identifier that is generated and assigned to a user's session when they log into an application or a website, enabling the system to recognize and manage the state of interaction with that user.

Workflow:
- You log in → server verifies your username/password
- Server creates a session → generates a session token
- Browser stores session token in a cookie
- Each time you load a new page, your browser sends the session token
- Server checks the token → allows access
- Session ends when you log out or it times out



## Cookie
A cookie (also known as a web cookie or browser cookie) is a small piece of data a server sends to a user's web browser. The browser may store cookies, create new cookies, modify existing ones, and send them back to the same server with later requests. Cookies are stored locally on your device inside your web browser's data directory or profile folders, typically as structured SQLite database files rather than plain text files. JavaScript cannot directly read it, Browser sends it automatically when cookie rules match

Where Cookie Files Are Stored on Disk
- Google Chrome (Windows): C:\Users\<Your_Username>\AppData\Local\Google\Chrome\User Data\Default\Network
- Google Chrome (macOS): ~/Library/Application Support/Google/Chrome/Default/Cookies
- Mozilla Firefox (Windows): C:\Users\<Your_Username>\AppData\Roaming\Mozilla\Firefox\Profiles\<profile_folder>\cookies.sqlite
- Microsoft Edge (Windows): C:\Users\<Your_Username>\AppData\Local\Microsoft\Edge\User Data\Default\Network
- Android Browsers: Inside the application data directory of each individual browser under the device's internal storage


## Local Storage
Local Storage is a built-in web feature that allows websites to store data directly inside your web browser. It saves information as key-value pairs (like theme: "dark") as strings, and this data persists indefinitely—meaning it stays saved even if you refresh the page, close the tab, or shut down your device entirely.
Unlike cookies, Local Storage provides a much larger capacity (typically around 5MB to 10MB per website) and its data is never automatically transmitted to the web server with your internet requests, making it faster and more private from network interception. While easy to use, JavaScript running on the page can read this storage, making it highly vulnerable to XSS

Local Storage is saved locally on your physical device's hard drive. The specific path depends on the web browser and operating system you are using. Web browsers usually save this data inside dedicated SQLite database files within your user profile directory:

- Google Chrome	Windows	%LocalAppData%\Google\Chrome\User Data\Default\Local Storage\
- Google Chrome	macOS	~/Library/Application Support/Google/Chrome/Default/Local Storage/
- Mozilla Firefox	Windows	%AppData%\Mozilla\Firefox\Profiles\[profile_id]\webappsstore.sqlite
- Mozilla Firefox	macOS	~/Library/Application Support/Firefox/Profiles/[profile_id]/webappsstore.sqlite


Cookies and localStorage both store data locally on your computer, usually within your browser's profile directory. However, they differ in how the browser manages and uses that data. Cookies can be sent automatically to the server with matching HTTP requests, whereas localStorage data is not automatically transmitted and must be explicitly read and sent by JavaScript. To identify which method a website uses, open the browser's Developer Tools by pressing `F12`. In the Application tab in Chrome or Edge, navigate to Storage → Cookies to view cookies and their attributes, or Storage → Local Storage to view key-value pairs stored by the website. To understand how the website uses authentication, open the Network tab, reload the page, log in, and inspect requests to protected endpoints. Look for the `Cookie` request header, the `Set-Cookie` response header, or an `Authorization: Bearer` header containing a token. You can also inspect localStorage using `Object.keys(localStorage)` in the browser console. Remember that a website can use both cookies and localStorage simultaneously, so checking storage alone does not prove which method is responsible for authentication.



