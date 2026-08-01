## Enumerate Domain
```   
ldapsearch (ObjectClass=domain) --attributes name,distinguishedName,objectSid,lockoutThreshold,ms-DS-MachineAccountQuota,lockoutDuration
```

## Enumerate Users
```
ldapsearch (samAccountType=805306368) --attributes name,sAMAccountName,distinguishedName,memberOf
```

## Enumerating Enabled and Disabled User Accounts
```
ldapsearch (samAccountType=805306368) --attributes displayName,sAMAccountName,userAccountControl
```

## Enumerating Users with AdminCount=1
```
ldapsearch (&(objectCategory=person)(objectClass=user)(adminCount=1)) --attributes sAMAccountName
```

## Enumerating Groups and its members
```
ldapsearch (ObjectClass=group) --attributes name,distinguishedName,sAMAccountName,member
```

## Enumerating Computers
```
ldapsearch (samAccountType=805306369) --attributes samAccountName,dNSHostName,cn,servicePrincipalName
```

## Enumerating OU's
```
ldapsearch (objectCategory=organizationalUnit) --attributes ou,distinguishedName,description,gPLink
```

## Enumerating Each OU individually
```
ldapsearch (objectClass=*) --dn "OU=Web,OU=Servers,DC=dublin,DC=contoso,DC=com" --attributes distinguishedName
```

## Enumerating GPO's and where they are stored
```
ldapsearch (objectClass=groupPolicyContainer) --attributes displayName,cn,gPCFileSysPath,flags,versionNumber
```

## Enumerating Containers
```
ldapsearch (objectClass=container) --attributes name,distinguishedName,objectGUID
```

## Enumerating Each Container individually
```
ldapsearch (objectClass=*) --dn "CN=ForeignSecurityPrincipals,DC=dublin,DC=contoso,DC=com" --attributes description,distinguishedName,objectSid
```

## Enumerate ACLS
```
ldapsearch (objectClass=*) --dn "CN=John Doe,OU=Users,DC=contoso,DC=com" --attributes nTSecurityDescriptor
```

## Enumerate Trusts
```
ldapsearch (objectClass=trustedDomain) --attributes cn,trustDirection,trustPartnet,flatname
```

## Enumerating Sites
```
ldapsearch "(objectClass=site)" --dn "CN=Sites,CN=Configuration,DC=contoso,DC=com"
```

## Enumerating Objects with SPN set
```
ldapsearch (servicePrincipalName=*) --attributes cn,objectSid,sAMAccountName,servicePrincipalName
```

## Enumerating Shares
ldapsearch (objectClass=volume) --attributes cn,uNCName,distinguishedName

## Enumerating ASrep roastable Users
```
ldapsearch "(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=4194304)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))"
```

## Check for AD CS
```
ldapsearch "(objectClass=pKIEnrollmentService)" --dn "CN=Enrollment Services,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=com"
```

## List CAs
```
ldapsearch "(objectClass=pKIEnrollmentService)" --dn "CN=Enrollment Services,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=com"
```

## List templates
```
ldapsearch "(objectClass=pKICertificateTemplate)" --dn "CN=Certificate Templates,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=com"
```

## Dump the entire PKI configuration
```
ldapsearch "(objectClass=*)" --dn "CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=com"
```







