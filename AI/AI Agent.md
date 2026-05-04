## AI Agent 
Ai agent is a software program that uses large language model as its reasoning engine to perceive its environment, make decisions and take actions through  tools in order to complete a goal.

```
AI Agent = LLM + Knowledge Base + Memory + Tools
```

  ![image](https://architecture.learning.sap.com/assets/images/Agent_Flow-22a5c002429b8cf7781c962bd4d12a88.svg)
## Components

### LLM 
The LLM serves as the core for understanding and generating human-like language. It allows the agent to process and respond to natural language input, making it capable of handling tasks such as conversation, summarization, translation, and answering questions.

### Knowedge Base
A knowledge base is a structured repository of facts, rules, or domain-specific information. This could be stored in databases, ontologies, or even just plain documents, and it provides factual grounding for the AI agent.

### Tools
Tools extend the functionality of the AI agent by allowing it to perform specific tasks or access external systems, such as running code, interacting with APIs, fetching data, or even performing real-world actions like sending emails or controlling devices.

### Interaction/Console (The User Interface)
This is how you talk to the agent, see what it's doing, and approve its actions. It could be a plugin in your code editor, a website, or a command-line tool. Its main job is for you to interact with and review the agent's work.

### Orchestration (The Workflow Engine)
This layer is the brain of the operation. It plans the steps, executes them, and then critiques the results. It manages the tools the agent can use and handles errors or retries. Think of it as a sophisticated workflow manager like LangGraph.

### Runtime/Sandboxing (The Secure Execution Environment)
This is a safe, isolated space where the agent performs its tasks, often using containers like Docker. It ensures the agent only has the permissions it absolutely needs (a concept called "least-privilege") and can run for a long time even if you close the user interface.

### Memory & Knowledge (The Brain's Database)
Memory allows the AI agent to store and recall information across different interactions or sessions. It can either be short-term memory (context within a conversation) or long-term memory (persistent knowledge between sessions).

### Agent Loop
The agent loop is the continuous cycle in which the AI agent performs its tasks. It involves the agent receiving input, processing that input, deciding on an appropriate action, and executing that action. This loop repeats until the goal is achieved or the agent is instructed to stop.

### System Prompt
System prompts are pre-programmed instructions or guidelines that shape the agent’s behavior and responses. These prompts can include rules, constraints, or patterns that the system uses to interpret and manage the user’s queries or tasks.

### Guard rails
Guardrails are mechanisms that ensure the AI agent behaves in a safe, ethical, and reliable manner. They act as constraints that limit the agent’s actions and responses to prevent harmful, biased, or undesirable outcomes.
