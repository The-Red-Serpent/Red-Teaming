On a Windows OS, when a user visits a folder, it automatically attempts to display the files' icons. We can abuse this functionality by placing a file with the icon location
pointing to a remote location UNC path  \\172.16.117.30\fake.ico (our attack host),forcing force the user that opened this folder to authenticate to the specified UNC, trying to
display the contents of the icon.

## Abusing Access to Shared Folders
A common way of farming hashes and forcing users to connect to our attack host is by abusing shared folders. Suppose we find a user with access to a shared folder, or the shared
folder allows anonymous access with read and  write permissions. In that case, we can put our malicious file there and wait for a user to connect to us, capture their NTLM
authentication, and relay it to relay targets

Tools:
- https://github.com/Greenwolf/ntlm_theft
- https://github.com/mdsecactivebreach/Farmer
- https://www.mdsec.co.uk/2021/02/farming-for-red-teams-harvesting-netntlm/


## WebDav Attacks
We previously forced users to authenticate over SMB by abusing shared folders. However, SMB authentication has limitations, especially for attacks like **LDAP cross-protocol relay**. To overcome this, attackers can force **HTTP-based NTLM authentication** by abusing **WebDAV (Web Distributed Authoring and Versioning)**, enabling additional relay attack opportunities.
WebDAV lets you use a web server like a network file share, but over HTTP/HTTPS instead of SMB.

- Enumeration
```
nxc smb <target-ip> -u 'username' -p 'password' -M webdav
```

## Reference
- https://pentestlab.blog/2021/10/20/lateral-movement-webclient/
- https://www.thehacker.recipes/ad/movement/mitm-and-coerced-authentications/webclient
