# RunPod vLLM Worker image for Magic Conch (DavidAU Llama 3.2 MOE)
# Uses RunPod's worker image with a recent vLLM that supports Llama 3.1/3.2 rope_type.
# Update the tag as RunPod releases newer workers.
FROM runpod/worker-v1-vllm:v2.11.3

# Model
ENV MODEL_NAME=DavidAU/Llama-3.2-8X3B-MOE-Dark-Champion-Instruct-uncensored-abliterated-18.4B

# Tokenizer override (model tokenizer.json is corrupted)
# Use Mixtral tokenizer which is compatible with the architecture.
ENV TOKENIZER=mistralai/Mixtral-8x7B-v0.1

# Model settings
ENV DTYPE=bfloat16
ENV MAX_MODEL_LEN=4096
ENV GPU_MEMORY_UTILIZATION=0.90
ENV TENSOR_PARALLEL_SIZE=1
ENV TRUST_REMOTE_CODE=1
ENV MAX_NUM_SEQS=8
ENV SWAP_SPACE=4
