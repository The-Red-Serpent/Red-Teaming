## Components of Cobalt Strike

### Team Server
<p align="justify">
The Team Server is the central coordinating system in Cobalt Strike. It is a server-side application that acts as the authoritative backend for the entire framework. All operational data lives here: session state, configuration, logs, and shared resources. It is the only component that Beacons communicate with, and it is the only component that Clients connect to. The Team Server enforces collaboration, synchronization, and consistency across multiple operators, making sure everyone sees the same environment and interacts with the same data.
</p>

### Client (Cobalt Strike Client)
<p align="justify">
The Client is the operator-facing application used to interact with Cobalt Strike. It is a graphical interface that connects to the Team Server and allows a human operator to view information, issue commands, and manage the operation. The Client does not directly communicate with any compromised systems or agents. Instead, it acts purely as an interface layer, translating operator actions into requests sent to the Team Server and displaying responses received from it.
</p>

### Beacon
<p align="justify">
A Beacon is the agent component of Cobalt Strike that runs on a remote system. It represents the framework’s presence on that system and serves as a communication endpoint back to the Team Server. The Beacon does not know about operators or Clients; it only communicates with the Team Server. Conceptually, it is a persistent, controllable process that allows the Team Server to maintain interaction with a specific host over time.
</p>

## Listener
<p align="justify">
A listener in Cobalt Strike is a communication configuration used to generate payloads and define how Beacons communicate with the Team Server. It specifies parameters such as protocol, host, and port, and may instruct the Team Server to accept incoming connections depending on the listener type. A listener itself is not a session or agent, but a template that enables Beacons to establish and maintain Command and Control (C2) communication.
</p>

### Types of Listeners

### Egress Listener
<p align="justify">
An <b>egress listener</b> is a listener that defines Beacon communication <b>directly from a compromised system to the Team Server across the network boundary</b>. Beacons built from an egress listener establish Command and Control by initiating outbound connections that leave the target environment and reach infrastructure controlled by the operator. The Team Server receives this traffic directly and acts as the central coordination point.
</p>

Conceptually:



```
[ Beacon ]
     |
     |  Outbound C2 traffic
     |
     v
[ Team Server ]
```

DNS and HTTP/HTTPS listeners are egress listeners.


### Peer-to-Peer (P2P) Listener
<p align="justify">
A <b>peer-to-peer listener</b> is a listener that defines Beacon communication <b>between Beacons</b>, rather than directly with the Team Server. A Beacon using a P2P listener does not have direct network access to the Team Server. Instead, its traffic is forwarded through another Beacon that uses an egress listener. The Team Server never communicates with the P2P Beacon directly.
</p>
Conceptually:

```
[ P2P Beacon ]
     |
     |  SMB / TCP
     |
     v
[ Egress Beacon ]
     |
     |  HTTP / DNS
     |
     v
[ Team Server ]
```

SMB and TCP listeners are peer-to-peer listeners.

## HTTP Listener
<p align="justify">
An HTTP listener defines Beacon communication over the HTTP protocol. Beacons using this listener exchange data with the Team Server using standard-looking HTTP requests. The Team Server runs an internal web service to receive and respond to these requests. From a structural standpoint, this listener defines how Beacon traffic is formatted, where it is sent, and how responses are delivered.
</p>

## HTTP Hosts
<p align="justify">
HTTP hosts are the network destinations that a Beacon will send its HTTP requests to. These may be IP addresses or domain names. They may resolve directly to the Team Server or to an intermediate system that forwards traffic onward. The listener does not require that all hosts resolve to the same endpoint, only that traffic ultimately reaches the Team Server.
</p>

## Host rotation strategy
<p align="justify">
If more than one HTTP host is provided, the rotation strategy tells Beacon how it should use each one. These are useful for pushing back against frequency analysis techniques for finding systematic C2 traffic and providing resiliency in cases where one or more HTTP hosts are blocked.
</p>

Types of strategies:

- Round-robin: Beacon cycles through hosts in order, one request per host.
- Random: Beacon selects a host randomly for each request.
- Failover: Beacon uses one host until failures exceed a threshold (count or time), then switches to the next.
- Rotate: Beacon uses each host for a fixed time period before moving to the next.

## HTTP Host Header
<p align="justify">
The HTTP host header setting specifies a value that is embedded into Beacon payloads and used in HTTP requests. This allows the listener to define the host header independently of the rest of the traffic profile.
</p>

## DNS Listener
<p align="justify">
A DNS listener in Cobalt Strike is a specialized listener that allows Beacon payloads to communicate with the Team Server using DNS queries, specifically A, AAAA, or TXT record lookups. Unlike HTTP or HTTPS Beacons, the DNS Beacon exchanges data through the Domain Name System, which can help it bypass typical network restrictions and appear more like legitimate traffic. For a DNS Beacon to function correctly, the Team Server must be authoritative for one or more subdomains, meaning that DNS queries for these subdomains will be directed to the Team Server itself. In most cases, this authority is established through the domain registrar that manages the top-level domain.
</p>

<p align="justify">
When a DNS Beacon checks in, it initially performs a simple A record lookup to register itself with the Team Server. Unlike other Beacons, the DNS Beacon does not immediately transmit its full metadata. As a result, new DNS Beacons initially appear as empty rows in the Team Server interface. The full metadata is only sent once the Beacon receives tasking, although operators can trigger a simple check-in command to transmit metadata without performing any actions.
</p>


```
REQUEST PATH
[ Beacon Process ]
        |
        v
[ OS DNS Client ]
        |
        v
[ DNS Resolver ]
        |
        v
[ Root DNS ]
        |
        v
[ TLD DNS ]
        |
        v
[ Authoritative DNS ]
[ Team Server ]


RESPONSE PATH
[ Team Server ]
        |
        v
[ TLD DNS ]
        |
        v
[ DNS Resolver ]
        |
        v
[ OS DNS Client ]
        |
        v
[ Beacon Process ]
```

## SMB Listener
<p align="justify">
An SMB listener in Cobalt Strike is a peer-to-peer listener that does not make the Team Server listen on any network port. It is used only as a payload configuration template. When an SMB Beacon runs, it creates a Windows SMB named pipe using the pipe name defined in the listener. This Beacon cannot communicate with the Team Server directly, so another Beacon with egress access must connect to the named pipe over SMB (TCP port 445) and relay traffic between the SMB Beacon and the Team Server. By default, Cobalt Strike uses pipe names in the format <code>msagent_##</code>, though custom pipe names can be defined as long as they do not conflict with existing pipes.
</p>

```
[ SMB Beacon ]
     |
     |  SMB Named Pipe (TCP 445)
     |
     v
[ Relay Beacon ]
     |
     |  Egress Listener
     |
     v
[ Team Server ]
```


## TCP Listener
<p align="justify">
A TCP listener is a peer-to-peer listener that does not make the Team Server listen on any network port. It is only used as a configuration template when generating TCP Beacon payloads. When executed, a TCP Beacon binds to a local TCP port specified in the listener and waits for another Beacon to connect. This second Beacon relays all traffic between the TCP Beacon and the Team Server using its own egress listener. The TCP Beacon can bind either to all interfaces (0.0.0.0) or only to the local host (127.0.0.1), and multiple TCP listeners can be created with different ports and bind settings.
</p>

## Profiles
<p align="justify">
Profiles define how Beacon communication looks and behaves at the network level. They shape traffic format and behavior but do not define where communication goes. They can be configured in the <b>Listener Builder</b> or directly in the Cobalt Strike GUI when generating payloads.
</p>

## Guardrails
<p align="justify">
Guardrails restrict Beacon execution to specific environments or conditions. If the conditions are not met, the Beacon exits without running. Guardrails can be configured when generating a payload or in a listener profile to limit execution to certain users, OS versions, domains, or network environments.
</p>
