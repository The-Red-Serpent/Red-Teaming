![image](https://assets.qlik.com/image/upload/w_1600/q_auto/qlik/glossary/augmented-analytics/seo-hero-machine-learning-vs-ai_kls4c0.png)
### AI
Artificial Intelligence (AI) is the class of computational systems designed to perceive, learn from data, reason under uncertainty, and take actions to achieve specified objectives without being explicitly programmed for every scenario.

### NLP 
Natural Language Processing (NLP) is a subfield of artificial intelligence that focuses on enabling computers to understand, interpret, generate, and interact with human language in a meaningful way. 

NLP combines computational linguistics, machine learning, and statistical methods to process and analyze textual or spoken data, allowing machines to perform tasks such as language understanding, translation, summarization, question answering, and conversational interaction.

### ML 
Machine Learning (ML) is a subfield of artificial intelligence that focuses on designing, developing, and analyzing algorithms and statistical models that enable computer systems to automatically learn from and improve with experience, without being explicitly programmed for each specific task. 

ML systems are designed to identify patterns, make predictions, classify information, and make decisions based on data. These systems can adapt their behavior as they are exposed to new data, allowing them to improve performance over time in dynamic environments.

### Types
#### 1. Supervised Learning
Supervised Learning is a type of machine learning in which a model is trained on labeled data, meaning that each input example in the training set is paired with a corresponding correct output (label). The goal of supervised learning is for the model to learn the mapping between inputs and outputs so that it can make accurate predictions on new, unseen data.
#### 2. Unsupervised Learning 
Unsupervised Learning is a type of machine learning in which a model is trained on unlabeled data, meaning that no correct outputs are provided. The system’s goal is to identify hidden patterns, structures, or relationships in the data on its own.
#### 3. Reinforcement Learning (RL)  
Reinforcement Learning is a type of machine learning in which an agent learns to make sequential decisions by interacting with an environment. The agent receives rewards or penalties based on its actions and aims to maximize cumulative rewards over time.

#### Labeled Data
Labeled data is data that comes with clear, correct answers or tags that tell the machine what the expected output is for each input.
#### Unlabeled Data
Unlabeled data is data that has no associated answers or tags. The machine only sees the raw input and must figure out patterns or structure on its own.

| Type                   | Data Type      | Learning Method                | Example Applications                     |
| ---------------------- | -------------- | ------------------------------ | ---------------------------------------- |
| Supervised Learning    | Labeled        | Learn input-output mapping     | Spam detection, disease diagnosis        |
| Unsupervised Learning  | Unlabeled      | Discover patterns or structure | Customer segmentation, anomaly detection |
| Reinforcement Learning | Feedback-based | Learn by trial and error       | Game AI, robotics, autonomous driving    |

### Deep Learning
Deep Learning (DL) is a subfield of machine learning and artificial intelligence that focuses on using artificial neural networks with multiple layers (deep neural networks) to automatically learn hierarchical representations of data. Deep learning models are capable of extracting complex features from raw data, identifying patterns, and performing tasks such as classification, prediction, generation, and decision-making, often achieving human-level or superhuman performance in specific domains.

#### Neural Network
A neural network is a system of connected neurons inspired by the human brain, used in deep learning to learn patterns and make predictions from data.

Structure:
1. Input Layer: Receives raw data (e.g., pixels, text, audio).
2. Hidden Layers: Process the data through neurons using weights, biases, and activation functions. Multiple layers allow learning of complex patterns.
3. Output Layer: Produces the final result (e.g., class label, prediction).
How it works:
- Data flows forward through the network (forward pass).
- The network calculates loss/error comparing predictions to true values.
- Backpropagation adjusts weights and biases to improve accuracy.
- After training, the network can predict or classify new data.

Analogy:

> Input → processed step by step → final output, like a factory turning raw material into a finished product.

![image](https://media.geeksforgeeks.org/wp-content/cdn-uploads/20230602113310/Neural-Networks-Architecture.png)


### Types
#### 1. Feedforward Neural Networks (FNN / MLP)
A neural network where data flows in one direction from the input layer through hidden layers to the output layer. Used for tasks such as classification and regression where the relationship between input and output is modeled directly.
#### 2. Convolutional Neural Networks (CNN)
A type of neural network designed to process grid-like data, especially images, using convolutional layers to automatically detect features such as edges, shapes, and patterns. Widely used in computer vision applications.
#### 3. Recurrent Neural Networks (RNN / LSTM / GRU)
A neural network designed for sequential data, where outputs depend on previous inputs. RNNs maintain memory of past information, making them suitable for time series, speech, and natural language processing. LSTMs and GRUs are variants that handle long-term dependencies effectively.
#### 4. Autoencoders
A neural network that learns to compress (encode) and reconstruct (decode) data, used for tasks such as dimensionality reduction, anomaly detection, and denoising.
#### 5. Generative Models (GANs, VAEs)
Neural networks that generate new data by learning the distribution of existing data. GANs involve two networks competing—one generates data, the other evaluates it—while VAEs learn probabilistic representations. Used for image synthesis, data augmentation, and content creation.
#### 6. Transformers
Transformers are a type of neural network architecture used in AI that processes and understands data by focusing on relationships between all parts of the input at once, rather than step by step. They are especially effective for language tasks and form the foundation of modern large language models.



### Generalization
`Generalization` refers to the model's ability to accurately predict outcomes for new, unseen data not used during training. A model that generalizes well can effectively apply its learned knowledge to real-world scenarios.

### Overfitting
Overfitting is a situation in machine learning where a model learns the training data too closely, including noise and outliers, resulting in high accuracy on training data but poor performance on new, unseen data.
### Underfitting
Underfitting is a situation where a model is too simple to capture the underlying patterns in the data, leading to poor performance on both training and unseen data

### Cross-Validation
Cross-validation is a technique in machine learning used to assess how well a model will generalize to new, unseen data. It involves splitting the dataset into multiple subsets (folds), training the model on some folds, and testing it on the remaining fold. This process is repeated multiple times, and the results are averaged to provide a reliable estimate of the model’s performance.

### Regularization
Regularization is a technique that helps AI models not get too obsessed with the training data. It makes the model focus on the big patterns instead of memorizing every tiny detail, so it can perform well on new, unseen data.
#### Types
- L1 (Lasso): Makes the model ignore unnecessary features—keeps only the important stuff.
- L2 (Ridge): Makes the model play it safe, keeping all features but not letting any one feature dominate.

### Generative AI

Generative AI is a branch of artificial intelligence that learns patterns and structure from existing data and then creates new, original contentsuch as text, images, audio, video, or code that resembles human-generated output.

### Large Language Model (LLM)

A Large Language Model (LLM) is a type of artificial intelligence model that is trained on very large amounts of text data to understand, generate, and respond to human language by learning statistical patterns in how words and sentences are used.

### Features
### Self - Attention
Self-attention is a mechanism in AI (especially in Transformers like GPT) that lets a model look at all parts of an input at once and decide which parts matter most to each other.
### Intuition first
Imagine reading this sentence:
> _“The animal didn’t cross the street because it was tired.”_

To understand what “it” refers to, your brain checks the whole sentence and links _“it”_ to _“the animal”_.  That linking process is basically self-attention.

### Tokenization
Tokenization in LLMs is the essential process of breaking down raw text into smaller, manageable units called tokens (words, subwords, or characters) that the model can understand and process numerically, converting language into a numerical sequence for computation and prediction. It's the first step in preparing text, allowing the LLM to learn patterns, understand context, and generate coherent responses by predicting the next most likely token in a sequence.

### Embeddings
Embeddings are dense numerical vector representations of tokens (words, subwords, or characters) generated after tokenization, which capture the semantic meaning and relationships of these tokens in a high-dimensional space, enabling the model to process language and predict the next token.

Expanded explanation:

1. Tokenizer first: The raw text is split into tokens (words, subwords, or characters).
2. Embeddings second: Each token is converted into a vector of numbers that represents its meaning and context.
3. How embeddings are used:
    - Help the model understand similarity and relationships between tokens.
    - Serve as the input to the transformer, which uses them to compute attention, context, and generate predictions.
4. Outcome: The model can process and generate text mathematically, not just as raw letters or words.

### RAG
Retrieval-Augmented Generation (RAG) is the process of optimizing the output of a large language model, so it references an authoritative knowledge base outside of its training data sources before generating a response. Large Language Models (LLMs) are trained on vast volumes of data and use billions of parameters to generate original output for tasks like answering questions, translating languages, and completing sentences. 

RAG extends the already powerful capabilities of LLMs to specific domains or an organization's internal knowledge base, all without the need to retrain the model. It is a cost-effective approach to improving LLM output so it remains relevant, accurate, and useful in various contexts.

![image](https://cdn.prod.website-files.com/62796ab9647626cbab663f42/681393c14493777902d8fcd2_AD_4nXc0m_PFleutE5CW2s2UM6hArZ5Fq8tsrLHISaHBEUBMAlUYmErvWyMY3ODzQEXTvsmTkKWH14F-DvJfPukNGII5kfIsTZUKMSO-7-6r1wuLxxlgsQt3w8K_V_0f6PosYN9fhcqNmA.png)





### Agentic AI
Agentic AI is an advanced form of artificial intelligence focused on autonomous decision-making and action. Unlike traditional AI, which primarily responds to commands or analyzes data, agentic AI can set goals, plan, and execute tasks with minimal human intervention.

### Working
### 1. Perceive (See and Understand the World)

- The AI gathers information from sensors, databases, websites, or apps.
- Example: A self-driving car looks at cameras, GPS, and traffic data to know where it is and what’s around it.
- Key idea: Extract useful info and recognize important things in the environment.
### 2. Reason (Think and Plan)

- A Large Language Model (LLM) acts as the brain.
- It analyzes the situation, figures out what to do, and plans the steps.
- Can coordinate specialized AI tools: like image recognition, recommendation engines, or writing tools.
- Often uses retrieval-augmented generation (RAG) to get extra info from documents or databases.
- Example: A customer support agentic AI can read a customer email, figure out the problem, and plan a solution.
### 3. Act (Do Things in the Real World)

- The AI uses tools and software via APIs to execute the plan.
- Can automate tasks directly, but with rules (“guardrails”) for safety.
- Example:
    - AI can approve claims under $1,000 automatically.
    - Claims above $1,000 get flagged for human review.
- Key idea: AI is not just thinking—it’s taking controlled action.
### 4. Learn (Get Smarter Over Time)

- The AI collects feedback from its actions and uses it to improve.
- The “data flywheel”: data → improves model → better actions → more data.
- Over time, the AI becomes more accurate and efficient.
- Example: After handling hundreds of support tickets, it learns which solutions work best.

![image](https://blogs.nvidia.com/wp-content/uploads/2024/10/agentic-ai-workflow-1.png)
