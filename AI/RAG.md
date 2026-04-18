
## RAG
RAG stands for Retrieval Augmented Generation. It is a technique that connects an LLM to an external knowledge base so the model can answer questions using up-to-date, domain-specific, or private information that was never in its training data. A plain LLM only knows what it was trained on  a snapshot of the internet up to a cutoff date. It cannot access your company's internal documents, last week's news, a private database, or any information that changes over time. RAG solves this by retrieving relevant information at query time and injecting it into the context window before the LLM generates a response.

## Architecture

<img width="1440" height="1720" alt="image" src="https://github.com/user-attachments/assets/0f61559c-7b9a-4d49-bac7-39239f88944f"/>


## Step 1

You have a collection of documents. Could be anything — your company handbook, product documentation, customer support tickets, research papers, emails, a database. Hundreds or thousands of files.

## Step 2

Each document is split into small chunks — paragraphs or sections. Each chunk is converted into a vector (a list of numbers that represents its meaning) using an embedding model. All these vectors are stored in a vector database. Think of this as building the index of the book. This happens once upfront, not at query time.

## Step 3

"What is our refund policy for digital products?"

## Step 4

The same embedding model converts the question into a vector. Now both the question and all the document chunks exist in the same mathematical space.

## Step 5 

The system compares the question vector against all the stored chunk vectors and finds the most similar ones — say the top 3 or 5 chunks. Similarity here means semantic similarity — it finds chunks that are about the same topic as the question, even if they don't use the exact same words.

## Step 6

Those retrieved chunks are inserted into the LLM's prompt:

```
System: Answer the user's question using only 
        the context provided below.

Context:
[Chunk 1]: Refunds for digital products are 
           processed within 7 business days...
[Chunk 2]: To request a refund, contact support 
           at refunds@company.com...
[Chunk 3]: Digital product refunds are only 
           eligible within 30 days of purchase...

User: What is our refund policy for digital products?
```

## Step 7

The LLM reads the retrieved chunks and answers the question based on that content. It is not using training data — it is reading what was just handed to it and synthesizing an answer.

```
Assistant: Our refund policy for digital products 
allows refunds within 30 days of purchase. 
Refunds are processed within 7 business days. 
To request one, contact refunds@company.com.
```


RAG converts your documents into searchable vectors, finds the most relevant ones when a user asks a question, and hands them to the LLM to read before it answers — so the LLM can answer questions about information it was never trained on.
