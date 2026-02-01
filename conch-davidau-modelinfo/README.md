# Conch DavidAU Model Info (RunPod vLLM Worker)

Minimal repo for deploying the Magic Conch model on RunPod Serverless using the vLLM worker image.

## Model
- **Model:** `DavidAU/Llama-3.2-8X3B-MOE-Dark-Champion-Instruct-uncensored-abliterated-18.4B`
- **Tokenizer override:** `mistralai/Mixtral-8x7B-v0.1` (model tokenizer.json is corrupted)
- **GPU:** 48GB VRAM recommended (RTX 6000 Ada / A40 / A6000)

## Docker Image
This image is a thin wrapper around RunPod's vLLM worker.

Build and push:
```bash
docker build -t bigphoot/magic-conch-runpod:v1.4.0 .
docker push bigphoot/magic-conch-runpod:v1.4.0
```

## RunPod Serverless Setup
1. Create a Serverless endpoint with this image.
2. Set the env vars below.
3. Use the OpenAI-compatible endpoint for requests.

### Required envs
```bash
MODEL_NAME=DavidAU/Llama-3.2-8X3B-MOE-Dark-Champion-Instruct-uncensored-abliterated-18.4B
TOKENIZER=mistralai/Mixtral-8x7B-v0.1
HF_TOKEN=YOUR_HF_TOKEN
DTYPE=bfloat16
MAX_MODEL_LEN=4096
GPU_MEMORY_UTILIZATION=0.90
MAX_NUM_SEQS=8
TENSOR_PARALLEL_SIZE=1
```

## Test (OpenAI-compatible)
```bash
curl -X POST "https://api.runpod.ai/v2/<ENDPOINT_ID>/openai/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $RUNPOD_API_KEY" \
  -d '{
    "model": "DavidAU/Llama-3.2-8X3B-MOE-Dark-Champion-Instruct-uncensored-abliterated-18.4B",
    "messages": [
      {"role": "system", "content": "You are the Magic Conch Shell."},
      {"role": "user", "content": "Should I ship my code?"}
    ],
    "max_tokens": 150,
    "temperature": 1.1
  }'
```

## Notes
- This image does **not** include any secrets. Set `HF_TOKEN` in RunPod envs.
- If you see rope_scaling errors, update the RunPod worker tag to a newer release.
