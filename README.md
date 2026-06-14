# Documentation & Math

## What is the KV Cache?
In Transformer-based LLMs, the Key-Value (KV) Cache stores the intermediate attention states of previous tokens. Instead of recalculating the mathematical relationships of the entire conversation history every time it generates a single new word, the model stores previous token data in RAM. This vastly speeds up inference latency but acts as a dynamic memory drain that grows rapidly as the conversation gets longer.

## How do Concurrent Users impact sizing?
When deploying an LLM endpoint, the base model weights are loaded into system memory exactly once. All users share those core weights. However, the KV Cache is user-specific. Every concurrent user has their own unique prompt, context window, and chat history. Therefore, the memory footprint of the KV cache scales linearly with the amount of active, simultaneous users querying the model.

## The SRE Sizing Formulas

```bash
Model_Weights (GB) = (Parameters * Quantization_Bits) / 8
```
```bash
Base_Cache_Per_User (GB) = (Parameters * 0.0000012) * Context_Tokens * (Quantization_Bits / 16)
```

```bash
Total_KV_Cache (GB) = Base_Cache_Per_User * Concurrent_Users
```
```bash
Total_Required_RAM = Model_Weights + Total_KV_Cache + 1.5 GB (OS Baseline)
```
