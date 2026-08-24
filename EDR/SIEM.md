## SIEM
SIEM (Security Information and Event Management) is a security system that collects logs and security events from different devices and systems, analyzes them, and alerts security teams when it detects suspicious or potentially malicious activity.

It can collect data from servers, firewalls, routers, network devices, cloud services, applications, endpoints, and other security tools, and then analyze that data to detect suspicious or potentially malicious activity.

</br></br>
## Components

### Forwarder
A forwarder is a software agent or component that  collects logs/events from a device or system and forwards them to another system, such as a SIEM or log collector.

```
sc query type= service state= all
```

### Aggregator

An aggregator collects logs from multiple devices or sources and consolidates them into one place before sending them to the SIEM

### Normalizer

A normalizer converts logs from different devices and vendors into a consistent, standardized format so the SIEM can understand and analyze them. When data is being collected from various sources, it is usually in many formats. Such diversity of log formats creates a problem with the analysis and correlation of information. During the normalization process, this diverse log format is transformed into a standardized format, which is much easier for the SIEM to process.


### Indexer
This component stores the collected and processed logs so they can be searched and analyzed later. An indexer is a component that processes incoming log/event data, organizes it into an indexed structure, and stores it so that the SIEM can search and retrieve the data quickly. All collected and processed data must be stored, and that responsibility falls to the storage layer. This includes both short-term storage for immediate querying and long-term storage for compliance or forensic analysis. Hot storage is optimized for speed and used for recent data needed in investigations. 

### Correlation Engine
The correlation engine analyzes multiple events and looks for relationships or patterns that may indicate an attack. This engine processes the normalized data in order to identify patterns and relationships that would otherwise point toward a security threat.


### Detection/ Alert Rules Engine
The detection engine uses security rules, signatures, analytics, and other detection logic to identify potentially malicious activity. The alerting component notifies security teams when the SIEM detects activity that may require investigation.

### SIEM Dashboard
A dashboard provides a visual interface where security analysts can see alerts, events, trends, and security activity
<br></br>

## Architecture
```
                                   ┌──────────────────────────────────────────────────────────────────┐
                                   │                         DATA SOURCES                             │
                                   │                                                                  │
                                   │  Endpoints     Servers      Firewalls      Routers/Switches      │
                                   │  Windows/Linux  Apps        VPN             Cloud Services       │
                                   │  EDR/AV         AD/Entra    Databases       Other Security Tools │
                                   └───────┬──────────┬──────────┬──────────┬──────────┬──────────────┘
                                           │          │          │          │          │
                                           │          │          │          │          │
                                           ▼          ▼          ▼          ▼          ▼
                                   ┌──────────────────────────────────────────────────────────────────┐
                                   │                     LOG COLLECTION                               │
                                   │                                                                  │
                                   │  Forwarders / Agents       Syslog       APIs       Connectors    │
                                   │                                                                  │
                                   │  "Collect the logs and send them somewhere."                     │
                                   └──────────────────────────────┬───────────────────────────────────┘
                                                                  │
                                                                  ▼
                                   ┌──────────────────────────────────────────────────────────────────┐
                                   │                         AGGREGATOR                               │
                                   │                                                                  │
                                   │  Receives logs from MANY sources and consolidates them.          │
                                   │                                                                  │
                                   │  Endpoint ───┐                                                   │
                                   │  Firewall ───┤                                                   │
                                   │  Server ─────┼──► Aggregator ─────► SIEM                         │
                                   │  Router ─────┤                                                   │
                                   │  Cloud ──────┘                                                   │
                                   │                                                                  │
                                   │  "Bring all this data together."                                 │
                                   └──────────────────────────────┬───────────────────────────────────┘
                                                                  │
                                                                  ▼
                                   ┌──────────────────────────────────────────────────────────────────┐
                                   │                         NORMALIZER                               │
                                   │                                                                  │
                                   │  Converts different log formats into a common structure.         │
                                   │                                                                  │
                                   │  Firewall:  src=10.1.1.5                                         │
                                   │  Server:    source_ip=10.1.1.5                                   │
                                   │                       │                                          │
                                   │                       ▼                                          │
                                   │                Source IP = 10.1.1.5                              │
                                   │                                                                  │
                                   │  "Make different logs understandable in the same way."           │
                                   └──────────────────────────────┬───────────────────────────────────┘
                                                                  │
                                                                  ▼
                                   ┌──────────────────────────────────────────────────────────────────┐
                                   │                     SIEM PLATFORM                                │
                                   │                                                                  │
                                   │   ┌──────────────────┐       ┌───────────────────────────────┐   │
                                   │   │  LOG STORAGE     │       │     CORRELATION ENGINE        │   │
                                   │   │                  │       │                               │   │
                                   │   │ Stores events    │       │ Connects related events       │   │
                                   │   │ for searching    │       │ from different sources        │   │
                                   │   └────────┬─────────┘       └──────────────┬────────────────┘   │
                                   │            │                                │                    │
                                   │            └───────────────┬────────────────┘                    │
                                   │                            ▼                                     │
                                   │                  ┌──────────────────────┐                        │
                                   │                  │ DETECTION / ANALYSIS │                        │
                                   │                  │                      │                        │
                                   │                  │ Rules + Analytics    │                        │
                                   │                  │ Behavioral Analysis  │                        │
                                   │                  └──────────┬───────────┘                        │
                                   │                             │                                    │
                                   │                             ▼                                    │
                                   │                       🚨 ALERT                                   │
                                   └─────────────────────────────┬────────────────────────────────────┘
                                                                 │
                                                                 ▼
                                                    ┌─────────────────────────┐
                                                    │    SECURITY ANALYST     │
                                                    │                         │
                                                    │  Investigates the alert │
                                                    │  Searches logs          │
                                                    │  Determines what        │
                                                    │  happened               │
                                                    └────────────┬────────────┘
                                                                 │
                                                                 ▼
                                                    ┌─────────────────────────┐
                                                    │ RESPONSE / REMEDIATION  │
                                                    │                         │
                                                    │ Block IP                │
                                                    │ Disable account         │
                                                    │ Isolate endpoint        │
                                                    │ Investigate attacker    │
                                                    └─────────────────────────┘

```
