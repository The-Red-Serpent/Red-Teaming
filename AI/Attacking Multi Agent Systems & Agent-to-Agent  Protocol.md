## Multi Agent System
Multi-agent systems represent an evolution in AI deployment where multiple specialized agents collaborate to accomplish complex tasks. Rather than relying on a single monolithic model, these systems distribute responsibilities across agents with distinct roles, capabilities, and access permissions. This architectural pattern introduces unique security challenges that differ significantly from single-agent deployments.
While single-agent systems expose interfaces for user input and external tools, multi-agent architectures introduce inter-agent trust boundaries as a critical new attack surface.

## Multi agent System Architecture Topologies
Multi-agent systems employ various coordination patterns, each with distinct security implications. The patterns described below are common architectural topologies found in distributed systems and multi-agent research, and they are not A2A-specific terminology, but represent how A2A agents are typically deployed in practice.

### Orchestrator Pattern
The Orchestrator Pattern (also called hub-and-spoke) uses a central agent that manages task distribution to sub-agents. This creates a single point of failure where compromising the orchestrator means controlling the entire system. Attackers can also target sub-agents to inject malicious outputs that influence orchestrator decisions.

### Peer to Peer Pattern
The Peer-to-Peer Pattern (mesh topology) allows agents to communicate directly without a central coordinator. The primary security risk here is trust propagation, where one compromised agent can influence all peers. Attackers can abuse peer discovery mechanisms to inject rogue agents into the network.

### Hierarchial Pattern
The Hierarchical Pattern (tree topology) uses layered agents with supervisory relationships. This enables vertical privilege escalation through crafted subordinate outputs. Attackers can impersonate higher-level agents to issue unauthorized commands to lower-level agents.

### Pipe Line Pattern
The Pipeline Pattern (chain topology) involves sequential processing where each agent's output feeds the next agent in the chain. This allows payloads to persist through the entire chain and enables capability jumping, where a payload injected at a low-privilege stage executes at a high-privilege stage later.

## Trust Boundary in Multi Agent Systems
In a multi-agent system, a trust boundary refers to the point where information, instructions, or permissions move from one agent, tool, or system component to another with a different level of trust. Unlike single-agent systems where most operations happen internally, multi-agent architectures rely on continuous communication between independent agents over APIs or network requests. This creates new security risks because agents often assume that data received from other agents has already been validated or sanitized. As a result, downstream agents may blindly trust upstream outputs, execute actions without verification, or inherit permissions they should not have. Attackers can exploit these trust relationships to inject malicious instructions, escalate privileges, or move laterally across agents. Trust boundaries also exist between agents and external tools or backend systems, where unsafe tool outputs, malicious prompts, or excessive system permissions can lead to vulnerabilities such as prompt injection, SQL injection, unauthorized file access, or misuse of elevated API keys. Therefore, in multi-agent systems, every interaction between agents, tools, and infrastructure must be treated as untrusted and secured through authentication, authorization, validation, and least-privilege access controls.


## Enumerating A2A Workflows

### Agent Card
A2A agents advertise their capabilities through Agent Cards served at the well-known endpoint /.well-known/agent.json. The Agent Card reveals valuable information: the agent's purpose, its URL, protocol version, and most importantly, its advertised skills.
The Agent Card discovery endpoint is similar to other well-known endpoints like /.well-known/security.txt or /.well-known/openid-configuration. During reconnaissance, always check for A2A endpoints alongside traditional web enumeration or Directory Bruteforcing


