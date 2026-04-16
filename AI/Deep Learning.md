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
A Feedforward Neural Network (FNN) is the simplest type of artificial neural network in which information moves in only one direction—from input to output—without any loops or cycles.

In an FNN, the input data is passed through one or more hidden layers, where neurons process the information using weights and activation functions. After processing, the final result is produced at the output layer. Unlike recurrent neural networks, an FNN does not store memory of previous inputs, so each input is treated independently.

Because of this structure, Feedforward Neural Networks are mainly used for basic prediction and classification tasks, such as image classification (simple cases), spam detection in emails, and structured data problems.

#### 2. Convolutional Neural Networks (CNN)
A Convolutional Neural Network (CNN) is a type of deep learning neural network that is mainly used for processing grid-like data, especially images. It is designed to automatically detect and learn important features such as edges, shapes, textures, and patterns without needing manual feature extraction.

A CNN works by using a special mathematical operation called convolution, where small filters (also called kernels) slide over the input image and extract features. These features are then passed through multiple layers, such as convolution layers, pooling layers, and fully connected layers, to gradually understand the image from simple patterns to complex objects.

In simple terms, early layers of a CNN detect basic features like edges and corners, while deeper layers detect more complex features like faces, objects, or scenes. This makes CNNs highly effective for tasks like image recognition, object detection, facial recognition, and medical image analysis.
#### 3. Recurrent Neural Networks (RNN / LSTM / GRU)

A Recurrent Neural Network (RNN) is a type of artificial neural network designed to work with sequential data, where the order of information matters. Unlike regular neural networks that treat each input independently, an RNN has a form of memory, allowing it to remember previous inputs and use them to influence current outputs.

In an RNN, information is passed not only forward through layers but also looped back into the network. This feedback connection enables the model to keep track of what has been processed earlier in the sequence. Because of this property, RNNs are especially useful for tasks where context is important, such as language processing, speech recognition, and time-series prediction.

For example, when predicting the next word in a sentence, an RNN considers the words that came before it. Similarly, in speech recognition, it analyzes sound signals over time to understand meaning. However, basic RNNs can struggle with long-term memory, which is why improved versions like LSTM (Long Short-Term Memory) and GRU (Gated Recurrent Unit) were developed.

#### 4. Autoencoders
A neural network that learns to compress (encode) and reconstruct (decode) data, used for tasks such as dimensionality reduction, anomaly detection, and denoising.

### Weight
A weight is a value that shows how important a particular input is. Each input in a neural network is multiplied by a weight. If a weight is high, that input has more influence on the output; if it is low, the influence is smaller. During training, the network adjusts these weights to improve accuracy.

### Bias
A bias is an additional value added to the weighted sum of inputs. It helps the model make better predictions by allowing the output to shift even when inputs are zero. In simple terms, bias gives the neuron flexibility so it doesn’t always have to depend only on the input values.

Mathematically, a neuron works like this:
Output = (inputs × weights) + bias, followed by an activation function.

